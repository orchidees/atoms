%
% addSoundXMLDirectory.m    : Adding XML directories in the database
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
function soundIDS = addSoundXMLDirectory(connecDB, dir, sqlStruct, dirPos)
if (nargin < 4)
    dirPos = '';
end
if (nargin < 3)
    sqlStruct = getSQLStructureTemplate();
end
finalDir = strcat(dir, '/**/*.xml');
xmlListing = rdir(finalDir);
disp(['* Processing directory ' dir '.']);
soundIDS = [];
for i = 1:length(xmlListing)
    % Retrieving xml filename
    inputFile = xmlListing(i).name;
    % Printing processing status
    disp(sprintf('  - Processing file %s.\t', inputFile));
    % Adding specific XML sound description
    soundIDS = [soundIDS addSoundXML(connecDB, inputFile, sqlStruct, dirPos)];
end
end
