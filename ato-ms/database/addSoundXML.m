%
% addSoundXML.m     : Adding a sound from XML description in the database
%
% The input XML file is specified as a complete pathname. The XML
% informations are parsed in order to fill the corresponding SQL structure
% and then the original sound file is analysed with the descriptors
% obtained using IRCAMDescriptor.
% The resulting structure may also be based on a previously filled
% structure in order to keep informations. If no structure is specified,
% the SQL template is used instead. 
%
% connecDB          : Pointer to the SQL connection
% inputFile         : Complete pathname of the XML file to add
% sqlStruct         : The base structure to fill with descriptors
%
% Version           : 1.0 / 2009
%
% Author            : Philippe ESLING
%                    <esling@ircam.fr>
%
function soundID = addSoundXML(connecDB, inputFile, sqlStruct, dirPos)
if (nargin < 3)
    sqlStruct = getSQLStructureTemplate();
end
if (nargin < 4)
    dirPos = '';
end
domFile = xmlread(inputFile);
% Retrieving current filename
currentFile = retrieveSoundFile(inputFile);
currentFile = [dirPos currentFile];
disp('    o Adding XML values to structure.');
% Add XML Definitions
sqlStruct.file = currentFile;
sqlStruct.name = domFile.getElementsByTagName('uri').item(0).getChildNodes.item(0).getData;
fNames = fieldnames(sqlStruct);
for i = 3:length(fNames)
    if (strcmp(class(domFile.getElementsByTagName(fNames{i}).item(0).getChildNodes.item(0)), 'double') == 1)
        continue;
    end
    sqlStruct.(fNames{i}) = char(domFile.getElementsByTagName(fNames{i}).item(0).getChildNodes.item(0).getData);
end
soundID = addSound(connecDB, currentFile, sqlStruct);
end
