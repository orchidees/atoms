function features = ircamDescriptors(filesRoot, modifParams)
iDescDir = './ircamdescriptor';
disp('* Preparing configuration file');
if nargin < 2
 	modifParams = struct;
 	modifParams.parameters.ResampleTo = 22050;
 	modifParams.parameters.NormalizeSignal = 0;
 	modifParams.standard.WindowSize = 0.06;
 	modifParams.standard.HopSize = 0.01;
end
ircamConfiguration(1, modifParams);
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
    disp(['* Processing ' files{i}]);
    iDescCmd = [iDescDir ' ' files{i} ' ircamDescriptor.cfg'];
    disp(iDescCmd);
    system(iDescCmd);
    [fHandle, head] = Fsdifopen([files{i} '.descr.sdif'], 'r');
%[head] = loadsdif([files{i} '.descr.sdif']);
    infos = struct;
    features = struct;
    frametypes = struct;
    disp('* Reading SDIF descriptors headers');
	disp(head);
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
    frames = Fsdifread(fHandle);
    disp('* Parsing through analysis frames');
    while ~isempty(frames)
        frameNames = fieldnames(frames.data);
        if strcmp(char(frames.fsig), '1DSC')
            for k = 1:length(frameNames)
                if isfield(infos, frameNames{k})
                    finalName = infos.(frameNames{k}).name;
                    if size(frames.data.(frameNames{k}), 1) > 1
                        features.(finalName).value = [features.(finalName).value frames.data.(frameNames{k})];
                    else
                        features.(finalName).value = [features.(finalName).value ; frames.data.(frameNames{k})];
                    end
                    features.(finalName).times = [features.(finalName).times frames.time];
                end
            end
%         elseif isfield(frametypes, char(frames.fsig(2:end)))
%             tempMod = frametypes.(char(frames.fsig(2:end))).name;
%             for k = 1:length(frameNames)
%                 if isfield(frameNames{k}, infos)
%                     finalName = infos.(frameNames{k}).name;
%                     if ~isfield(features.(finalName), tempMod)
%                         features.(finalName).(tempMod) = [];
%                     end
%                     if size(frames.data.(frameNames{k}), 1) > 1
%                         features.(finalName).(tempMod) = [features.(finalName).(tempMod) frames.data.(frameNames{k})];
%                     else
%                         features.(finalName).(tempMod) = [features.(finalName).(tempMod) ; frames.data.(frameNames{k})];
%                     end
%                 end
%             end
        end
		frames = Fsdifread(fHandle);
    end
%    loadsdif('close');
    featNames = fieldnames(features);
	Fsdifclose(fHandle);
    disp('* Modifying descriptors structure');
    for f = 1:length(featNames)
        switch size(features.(featNames{f}).value, 2)
            case 9
                features.(featNames{f}).value = features.(featNames{f}).value(:, 7:9);
            case 6
                features.(featNames{f}).value = features.(featNames{f}).value(:, 6);
            case 3
                features.(featNames{f}).value = features.(featNames{f}).value(:, 3);
            otherwise
        end
    end
    if isempty(features.EnergyEnvelope.value)
        features.EnergyEnvelope.value = features.TotalEnergy.value;
    end
    system(['rm ' files{i} '.descr.sdif']);
end