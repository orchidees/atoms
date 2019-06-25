function features = ircamDescriptorModel(user, filesRoot, modifParams)
pathHandler('load');
workDir = 'tmpDesc';
iDescDir = '/net/inavouable/u.anasynth.share/share/bin/x86_64-Linux-rh50/ircamdescriptor';
disp('* Creating distant directory');
iDescCmd = ['ssh ' user '@muscade "mkdir ' workDir ' ; exit"'];
system(iDescCmd);
disp('* Preparing configuration file');
if nargin < 4
	modifParams = struct;
	modifParams.parameters.ResampleTo = 22050;
	modifParams.parameters.NormalizeSignal = 0;
	modifParams.standard.WindowSize = 0.06;
	modifParams.standard.HopSize = 0.01;
end
ircamConfiguration(1, modifParams);
disp('* Sending configuration file');
iDescCmd = ['scp ircamDescriptor.cfg ' user '@muscade:~/' workDir '/'];
system(iDescCmd);
if isdir(filesRoot)
    finalDir = strcat(filesRoot, '/**/*');
    fileListing = rdir(finalDir);
    files = cell(length(fileListing));
    for i = 1:length(files)
        [pathstr name ext] = fileparts(fileListing(i).name);
        if strcmp(ext, '.wav') || strcmp(ext, '.wave') || strcmp(ext, '.aiff') || strcmp(ext, '.aif')
            files{i} = fileListing(i).name;
        end
    end
else
    files = {filesRoot};
end
for i = 1:length(files)
    if isempty(files{i})
        continue;
    end
    [pathstr name ext] = fileparts(files{i});
    disp(['* Processing ' files{i}]);
    iDescCmd = ['scp ' files{i} ' ' user '@muscade:~/' workDir '/'];
    system(iDescCmd);
    files{i} = [name ext];
    iDescCmd = ['ssh ' user '@muscade "cd ' workDir ' ; ' iDescDir ' ' files{i} ' ircamDescriptor.cfg ; exit"'];
    system(iDescCmd);
    iDescCmd = ['scp ' user '@muscade:~/' workDir '/'  files{i} '.descr.sdif .'];
    system(iDescCmd);
    iDescCmd = ['ssh ' user '@muscade "rm -f ' workDir '/' files{i} ' ; exit"'];
    system(iDescCmd);
    [fHandle, head] = Fsdifopen([files{i} '.descr.sdif'], 'r');
    infos = struct;
    features = struct;
    frametypes = struct;
    disp('* Reading SDIF descriptors headers');
    for j = 1:length(head.TYP.FTD(1).msig)
        if head.TYP.FTD(1).msig(j, 1) ~= 'I'
            signal = ['MD_' char(head.TYP.FTD(1).msig(j, :))];
            infos.(signal) = struct;
            infos.(signal).name = char(head.TYP.FTD(1).mname{j});
            featName = char(head.TYP.FTD(1).mname{j});
            features.(featName) = struct;
            features.(featName).name = featName;
            features.(featName).value = [];
            features.(featName).times = [];
        else
            signal = char(head.TYP.FTD(1).msig(j, :));
            infos.(signal) = struct;
            infos.(signal).name = char(head.TYP.FTD(1).mname{j});
            tempName = char(head.TYP.FTD(1).mname{j});
            frameType = char(head.TYP.FTD(1).msig(j, 2:end));
            frametypes.(frameType) = struct;
            frametypes.(frameType).name = tempName(1:(end - 4));
        end
    end
    descNames = fieldnames(infos);
    frames = Fsdifread(fHandle);
    disp('* Parsing through analysis frames');
    while ~isempty(frames)
        frameNames = fieldnames(frames.data);
        if strcmp(char(frames.fsig), '1DSC')
            for k = 1:length(frameNames)
                if ismember(frameNames{k}, descNames)
                    finalName = infos.(frameNames{k}).name;
                    if size(frames.data.(frameNames{k}), 1) > 1
                        features.(finalName).value = [features.(finalName).value frames.data.(frameNames{k})];
                    else
                        features.(finalName).value = [features.(finalName).value ; frames.data.(frameNames{k})];
                    end
                    features.(finalName).times = [features.(finalName).times frames.time];
                end
            end
        elseif isfield(frametypes, char(frames.fsig(2:end)))
            tempMod = frametypes.(char(frames.fsig(2:end))).name;
            if ~isempty(regexp(tempMod, 'Filter', 'ONCE')) || ~isempty(regexp(tempMod, 'Mean', 'ONCE')) || ~isempty(regexp(tempMod, 'Deviation', 'ONCE'))
                frames = Fsdifread(fHandle);
                continue;
            end
            for k = 1:length(frameNames)
                if ismember(frameNames{k}, descNames)
                    finalName = infos.(frameNames{k}).name;
                    if ~isfield(features, [finalName tempMod])
                        features.([finalName tempMod]).name = [finalName tempMod];
                        features.([finalName tempMod]).value = [];
                    end
                    if size(frames.data.(frameNames{k}), 1) > 1
                        features.([finalName tempMod]).value = [features.([finalName tempMod]).value frames.data.(frameNames{k})];
                    else
                        features.([finalName tempMod]).value = [features.([finalName tempMod]).value ; frames.data.(frameNames{k})];
                    end
                end
            end
        end
        frames = Fsdifread(fHandle);
    end
    Fsdifclose(fHandle);
    featNames = fieldnames(features);
    disp('* Modifying descriptors structure');
    for f = 1:length(featNames)
        disp(featNames{f});
        switch size(features.(featNames{f}).value, 2)
            case 9
                features.([featNames{f} 'linamp1']).name = [featNames{f} 'linamp1'];
                features.([featNames{f} 'linamp2']).name = [featNames{f} 'linamp2'];
                features.([featNames{f} 'linamp3']).name = [featNames{f} 'linamp3'];
                features.([featNames{f} 'powamp1']).name = [featNames{f} 'powamp1'];
                features.([featNames{f} 'powamp2']).name = [featNames{f} 'powamp2'];
                features.([featNames{f} 'powamp3']).name = [featNames{f} 'powamp3'];
                features.([featNames{f} 'logamp1']).name = [featNames{f} 'logamp1'];
                features.([featNames{f} 'logamp2']).name = [featNames{f} 'logamp2'];
                features.([featNames{f} 'logamp3']).name = [featNames{f} 'logamp3'];
                features.([featNames{f} 'linamp1']).value = features.(featNames{f}).value(:, 1);
                features.([featNames{f} 'linamp2']).value = features.(featNames{f}).value(:, 2);
                features.([featNames{f} 'linamp3']).value = features.(featNames{f}).value(:, 3);
                features.([featNames{f} 'powamp1']).value = features.(featNames{f}).value(:, 4);
                features.([featNames{f} 'powamp2']).value = features.(featNames{f}).value(:, 5);
                features.([featNames{f} 'powamp3']).value = features.(featNames{f}).value(:, 6);
                features.([featNames{f} 'logamp1']).value = features.(featNames{f}).value(:, 7);
                features.([featNames{f} 'logamp2']).value = features.(featNames{f}).value(:, 8);
                features.([featNames{f} 'logamp3']).value = features.(featNames{f}).value(:, 9);
            case 6
                features.([featNames{f} 'linlin']).name = [featNames{f} 'linlin'];
                features.([featNames{f} 'powlin']).name = [featNames{f} 'powlin'];
                features.([featNames{f} 'loglin']).name = [featNames{f} 'loglin'];
                features.([featNames{f} 'linlog']).name = [featNames{f} 'linlog'];
                features.([featNames{f} 'powlog']).name = [featNames{f} 'powlog'];
                features.([featNames{f} 'loglog']).name = [featNames{f} 'loglog'];
                features.([featNames{f} 'linlin']).value = features.(featNames{f}).value(:, 1);
                features.([featNames{f} 'powlin']).value = features.(featNames{f}).value(:, 2);
                features.([featNames{f} 'loglin']).value = features.(featNames{f}).value(:, 3);
                features.([featNames{f} 'linlog']).value = features.(featNames{f}).value(:, 4);
                features.([featNames{f} 'powlog']).value = features.(featNames{f}).value(:, 5);
                features.([featNames{f} 'loglog']).value = features.(featNames{f}).value(:, 6);
            case 3
                features.([featNames{f} 'lin']).name = [featNames{f} 'lin'];
                features.([featNames{f} 'pow']).name = [featNames{f} 'pow'];
                features.([featNames{f} 'log']).name = [featNames{f} 'log'];
                features.([featNames{f} 'lin']).value = features.(featNames{f}).value(:, 1);
                features.([featNames{f} 'pow']).value = features.(featNames{f}).value(:, 2);
                features.([featNames{f} 'log']).value = features.(featNames{f}).value(:, 3);
            otherwise
        end
    end
    system(['rm ' files{i} '.descr.sdif']);
%    save([destRoot '/' name '.mat'], 'features');
end
iDescCmd = ['ssh ' user '@muscade "rm -rf ' workDir ' ; exit"'];
system(iDescCmd);