%
% addSound.m        : Adding a sound in the database
%
% The input file is specified as a complete pathname. This file is then
% analysed with the descriptors obtained using IRCAMDescriptor.
% The resulting structure may also be based on a previously filled
% structure in order to keep informations. If no structure is specified,
% the SQL template is used instead.
%
% connecDB          : Pointer to the SQL connection
% inputFile         : Complete pathname of the file to add
% sqlStruct         : The base structure to fill with descriptors
%
% Version           : 1.0 / 2009
%
% Author            : Philippe ESLING
%                    <esling@ircam.fr>
%
function soundID = addSlicedSound(connecDB, inputFile, sqlStruct, minS, maxS, stepS, stepO)
if (nargin < 3)
    sqlStruct = getSQLStructureTemplate();
end
% Retrieving sound signal
[signalI sRate] = importSignal(inputFile);
if isempty(signalI)
    soundID = 0;
    return;
end
[pathstr, name, ext] = fileparts(inputFile);
sqlStruct.name = name;
sqlStruct.file = [pathstr '/' name ext];
duration = length(signalI) / sRate;
pm2path = findPm2Pathes;
if isempty(pm2path)
    error('analysis:analyze_sound:MissingComponent', ...
        'pm2 or AudioSculpt missing in your /Applications/ folder.');
end
pm2command = pm2path{1};
parameters = defaultAnalysisParams();
handles = [];
% Compute features through IRCAMDescriptor
features = launchSoundAnalysis(inputFile,parameters.fmin,parameters.npartials,parameters.t1,parameters.t2,pm2command,handles);
nbAnalysisPts = length(features.DE.i_tot_v.value);
mldySys = mldytrk(inputFile);
mldySys = resample(mldySys', nbAnalysisPts, length(mldySys));
features.Pa.mldyTrk = struct;
features.Pa.mldyTrk.name = 'MelodyTracking';
features.Pa.mldyTrk.value =  mldySys;
analysisRatio = nbAnalysisPts / length(signalI);
disp(nbAnalysisPts);
disp(analysisRatio);
for stretch = minS:stepS:maxS
    % stepProp = stepO * stretch;
    stepProp = stepO;
    for onset = 0:stepProp:(duration - stretch)
        disp(' ');
        disp('*******************************');
        disp(' Processing :');
        disp(['Name    : ' name]);
        disp(['Onset   : ' num2str(onset)]);
        disp(['Stretch : ' num2str(stretch)]);
        disp('*******************************');
        disp(' ');
        sqlStruct.onset = onset;
        sqlStruct.stretch = stretch;
        stretchPt = floor(stretch * sRate);
        onsetPt = floor(onset * sRate + 1);
        startPt = floor(onsetPt * analysisRatio) + 1;
        endPt = min(floor((onsetPt + stretchPt) * analysisRatio), nbAnalysisPts);
        disp(startPt);
        disp(endPt);
        %wavwrite(signalI(onsetPt:(onsetPt + stretchPt)), sRate, 32, 'tmpSlicedFile.wav');
        disp('    o Launching sound analysis.');
        % Sound analysis
        %try
            sqlStruct = analyzeSlicedSound(features, startPt, endPt, sqlStruct);
        %catch
        %    continue;
        %end
        disp('    o Adding sound to database.');
        % Retrieve current max index
        sqlQ = 'Select MAX(soundID) From Sounds';
        cursor = exec(connecDB, sqlQ);
        cursor = fetch(cursor);
        if (isnan(cursor.Data{1}))
            sqlStruct.soundID = 1;
        else
            sqlStruct.soundID = cursor.Data{1} + 1;
        end
        sqlQ = 'Select MAX(ArrayID) From Arrays';
        cursor = exec(connecDB, sqlQ);
        cursor = fetch(cursor);
        if (isnan(cursor.Data{1}))
            aFID = 1;
        else
            aFID = cursor.Data{1} + 1;
        end
        curArrayID = aFID;
        sqlQ = 'Select MAX(ArrayID) From StringArrays';
        cursor = exec(connecDB, sqlQ);
        cursor = fetch(cursor);
        if (isnan(cursor.Data{1}))
            aSFID = 1;
        else
            aSFID = cursor.Data{1} + 1;
        end
        curSArrayID = aSFID;
        colNames = fieldnames(sqlStruct);
        % Parsing each field to vectorize arrays
        for i = 1:length(colNames)
            fieldVal = sqlStruct.(colNames{i});
            fClass = class(fieldVal);
            if (ischar(fClass))
                sqlStruct.(colNames{i}) = {fieldVal};
            end
            if (strcmp(fClass, 'double') && length(fieldVal) > 1)
                % int(32) = Gaussian mixture
                % int(33) = Array of simple values
                % int(34) = Array of Gaussian mixtures
                if (size(fieldVal, 1) == 1)
                    if (size(fieldVal, 2) == 1)
                        sqlStruct.(colNames{i}) = {fieldVal};
                    else
                        % gaussID = addStructGaussian(connecDB, sqlStruct.soundID, fieldVal);
                        sqlStruct.(colNames{i}) = 0;
                    end
                else
                    if (size(fieldVal, 2) == 1)
                        arraysVals{curArrayID - aFID + 1} = fieldVal;
                        sqlStruct.(colNames{i}) = curArrayID;
                        curArrayID = curArrayID + 1;
                    else
                        gaussArrayID = addStructGaussArray(connecDB, sqlStruct.soundID, fieldVal);
                        sqlStruct.(colNames{i}) = gaussArrayID;
                    end
                end
            end
            if (iscell(fieldVal) && ischar(fieldVal{1}) && length(fieldVal) > 1)
                sArraysVals{curSArrayID - aSFID + 1} = fieldVal;
                sqlStruct.(colNames{i}) = curSArrayID;
                curSArrayID = curSArrayID + 1;
            end
        end
        % Adding arrays to database
        addStructArrayMultiple(connecDB, sqlStruct.soundID{1}, arraysVals, aFID);
        addStructStringArrayMultiple(connecDB, sqlStruct.soundID{1}, sArraysVals, aSFID);
        %clear arraysVals;
        %clear sArraysVals;
        % Adding sound to database
        fastinsert(connecDB, 'Sounds', colNames, sqlStruct);
        soundID = sqlStruct.soundID;
        clear sqlStruct;
    end
end
end
