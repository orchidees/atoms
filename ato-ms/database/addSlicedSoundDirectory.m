%
% addSoundDirectory.m   : Adding directories in the database
%
% The directory is specified as a seed for a recursive search trough all
% sub-directories. All found files are then added to the database, the
% function addSound ensuring that the specified files are sound files.
%
% connecDB              : Pointer to the SQL connection
% inputFile             : Complete pathname of the starting directory
% sqlStruct             : The base structure to fill with descriptors
%
% Version               : 1.0 / 2009
%
% Author                : Philippe ESLING
%                        <esling@ircam.fr>
%
function soundIDS = addSlicedSoundDirectory(connecDB, dir, sqlStruct, minS, maxS, stepS, stepO)
if (nargin < 3)
    sqlStruct = getSQLStructureTemplate();
end
soundIDS = [];
finalDir = strcat(dir, '/**/*');
fileListing = rdir(finalDir);
disp(['* Processing directory ' dir '.']);
for i = 1:length(fileListing)
    % Retrieving xml filename
    inputFile = fileListing(i).name;
    % Printing processing status
    disp(sprintf('  - Processing file %s.\t', inputFile));
    % Adding sound description to database
    soundIDS = [soundIDS addSlicedSound(connecDB, inputFile, sqlStruct, minS, maxS, stepS, stepO)];
end
end
