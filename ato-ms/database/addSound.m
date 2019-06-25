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
function soundID = addSound(connecDB, inputFile, sqlStruct, analysisDir)
if (nargin < 4)
    analysisDir = [];
end
if (nargin < 3)
    sqlStruct = getSQLStructureTemplate();
end
soundID = 0;
% Retrieving sound signal
[signalI sRate] = importSignal(inputFile);
if isempty(signalI)
    return;
end
[pathstr, name, ext] = fileparts(inputFile);
sqlStruct.name = name;
sqlStruct.file = [pathstr '/' name ext];
disp('    o Launching sound analysis.');
% Sound analysis
%nbErrors = 0;
%while nbErrors ~= -1
%    try
        sqlStruct = extractSymbolicInfos(name, inputFile, 'SOL', sqlStruct);
        % Launch spectral analysis on the sound
        sqlStruct = analyzeSound(inputFile, defaultAnalysisParams(), sqlStruct);
        if ~isempty(analysisDir)
            [subPath, subName] = fileparts(sqlStruct.file);
            if ~exist([analysisDir '/' subPath], 'dir')
                mkdir(analysisDir, subPath);
            end
            save([analysisDir '/' subPath '/' subName '.mat'], 'sqlStruct');
        end
%        nbErrors = -1;
%    catch
%         if nbErrors > 2
%             [fid] = logOpen;
%             logWrite(fid, ['Analysis failed : ' inputFile]);
%             logClose(fid);
%             return;
%         else
%             if (sRate ~= 44100)
%                 signalI = resample(signalI, 44100, sRate);
%                 sRate = 44100;
%             end
%             wavwrite(signalI, sRate, 32, [pathstr '/' name '.wav']);
%             inputFile = [pathstr '/' name '.wav'];
%             nbErrors = nbErrors + 1;
%         end
%     end
% end
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
colNames = fieldnames(sqlStruct);
data = cell(1, length(colNames));
% Parsing each field to vectorize arrays
for i = 1:length(colNames)
    fieldVal = sqlStruct.(colNames{i});
    fClass = class(fieldVal);
    if (ischar(fClass))
        sqlStruct.(colNames{i}) = fieldVal;
    end
	% int(32) = Gaussian mixture
	% int(33) = Array of simple values
	% int(34) = Array of Gaussian mixtures
    if (strcmp(fClass, 'double') && length(fieldVal) > 1)
        if (size(fieldVal, 1) == 1)
            if (size(fieldVal, 2) == 1)
                % Single value (static or symbolic descriptors)
                sqlStruct.(colNames{i}) = fieldVal;
            else
                % Single temporal shape of descriptor
                sqlStruct.(colNames{i}) = 0;
            end
        else
            % Arrays handling 
            sqlStruct.(colNames{i}) = typecast(fieldVal(:), 'uint8');
        end
    end
%    if (iscell(fieldVal) && ischar(fieldVal{1}) && length(fieldVal) > 1)
%        sqlStruct.(colNames{i}) = typecast(fieldVal(:), 'uint8');
%    end
    data{i} = sqlStruct.(colNames{i});
end
% Adding sound to database
fastinsert(connecDB, 'Sounds', colNames, data);
soundID = sqlStruct.soundID;
clear sqlStruct;
end
