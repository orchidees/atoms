%
% getDescriptorMultipleValues.m	: Retrieving the value of multiple descriptors
%
% connecDB						: Pointer to the SQL connection
% soundID						: ID of the sound to retrieve
% descriptor					: Cell with names of the descriptors
%
% Version						: 1.0 / 2010
%
% Author						: Philippe ESLING
%								 <esling@ircam.fr>
%
function dValue = getDescriptorMultipleValues(connecDB, soundID, descriptorsCell)
sqlQ = ['SELECT ' descriptorsCell{1}];
for i = 2:length(descriptorsCell)
    sqlQ = strcat(sqlQ, ', ');
	sqlQ = strcat(sqlQ, descriptorsCell{i});
end
sqlQ = [sqlQ ' from Sounds where soundID = ' num2str(soundID)];
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
dValue = cursor.Data;
end
