%
% analyzeSound.m    : Spectral analysis of a sound to add in the database
%
% The input file is specified as a complete pathname. This file is then
% analysed with the descriptors obtained using IRCAMDescriptor.
% Each descriptor is stored in a structure using its mean and standard
% deviation values as well as two temporal modelisations. The first is a
% precise GMMFV modelisation, the second is a string serialization.
% The resulting structure may also be based on a previously filled
% structure in order to keep informations. If no structure is specified,
% the SQL template is used instead. 
%
% soundfile         : Complete pathname of the file to add
% parameters        : Parameters structure for IRCAMDescriptor analysis
% sqlFeatures       : The base structure to fill with descriptors values
%
% Version           : 1.0 / 2010
%
% Author            : Philippe ESLING
%                    <esling@ircam.fr>
%
function [sqlFeatures] = analyzeTarget(soundfile, parameters, handles, sqlFeatures)
if nargin < 4
    sqlFeatures = struct;
    sqlFeatures.note = 'A4';
    sqlFeatures.dynamics = 'mf';
end
if nargin < 3
    handles = [];
end
pm2path = findPm2Pathes;
if isempty(pm2path)
    error('analysis:analyze_sound:MissingComponent', ...
        'pm2 or AudioSculpt missing in your /Applications/ folder.');
end
pm2command = pm2path{1};
% Computing duration of the target signal
[signal sRate] = importSignal(soundfile);
if size(signal, 2) > 1
	signal = mean(signal, 2);
end
sqlFeatures.duration = length(signal) / sRate;
wavwrite(signal, sRate, 16, '/tmp/analysisFile.wav');
% Compute features through IRCAMDescriptor
features = launchSoundAnalysis('/tmp/analysisFile.wav',50,25,parameters.t1,parameters.t2,pm2command,sqlFeatures,handles);
% Number of analysis steps used for resampling
% nbSteps = floor((sqlFeatures.duration) * 20);
nbSteps = 128;
% Retrieve each name of the structure fields
fName = fieldnames(features);
server_says(handles, 'Analysis : Temporal modelisation', 0);
% Create an appropriate column for each field
for i = 1:size(fName)
   curField = fName{i};
    fieldVal = features.(curField);
    if (isstruct(fieldVal))
        % Retrieve each feature of the sub-structure
        fNameF = fieldnames(fieldVal);
        for j = 1:size(fNameF)
            curFieldF = fNameF{j};
            fieldValF = features.(curField).(curFieldF);
            if (isstruct(fieldValF))
                computed = 0;
                % Descriptor is a sub-band type
                if (size(fieldValF.value, 2) > 1)
                    if (size(fieldValF.value, 2) == 6 || size(fieldValF.value, 2) == 3)
                        fieldValF.value = fieldValF.value(:, 2);
                    else
                        disp(['Modelising ' fieldValF.name 'Bands']);
                        fprintf('  o Dimensions : .\n');
                        sqlFeatures.([fieldValF.name 'Dimension']) = size(fieldValF.value, 2);
                        fprintf('  o Temporal Evolution : ');
                        fieldVal = fieldValF.value';
                        fprintf('.\n');
                        computed = 1;
                    end
                end
                if (size(fieldValF.value, 2) == 1) && computed == 0
                    % Retrieving descriptor modelisation
                    if (size(fieldValF.value, 1) > 1)
                        disp(['Modelising ' fieldValF.name]);
                        fprintf('  o Mean : .\n');
                        sqlFeatures.([fieldValF.name 'Mean']) = mean(fieldValF.value)';
                        fprintf('  o Standard Deviation : .\n');
                        sqlFeatures.([fieldValF.name 'StdDev']) = std(fieldValF.value)';
                        fprintf('  o Temporal Evolution : ');
                        fieldVal = [1 1];
                        fprintf('.\n');
                        pStrVal = (fieldValF.value - mean(fieldValF.value)) / std(fieldValF.value);
                        sL = resample(pStrVal, 128, length(fieldValF.value));
                        fieldVal = sL;
                    else
                        fieldVal = fieldValF.value';
                    end
                end
                % Creating associated field in result
                sqlFeatures.(fieldValF.name) = fieldVal;
            end
        end
    end
end
server_says(handles, 'Analysis : Temporal modelisation', 1);
clear Fsdif_read_handler;