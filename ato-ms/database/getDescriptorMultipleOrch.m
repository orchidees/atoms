%
% getDescriptorMultipleID.m     : Retrieving the value of multiple
% descriptors for multiple sounds, passed by cell values
%
% connecDB						: Pointer to the SQL connection
% soundID						: Cell with ID of the sounds to retrieve
% descriptor					: Cell with names of the descriptors
%
% Version						: 1.0 / 2010
%
% Author						: Philippe ESLING
%								 <esling@ircam.fr>
%
function dValue = getDescriptorMultipleOrch(connecDB, descriptorsCell, soundID)
if nargin < 3
    soundID = [];
end
sqlQ = ['SELECT ' descriptorsCell{1}];
for i = 2:length(descriptorsCell)
    sqlQ = strcat(sqlQ, ', ');
	sqlQ = strcat(sqlQ, descriptorsCell{i});
end
sqlQ = [sqlQ ' from Sounds'];
if ~isempty(soundID)
    setID = regexprep(strcat(char(num2str(soundID'))), '\s+', ',');
    setID = strcat('(', setID, ')');
    sqlQ = [sqlQ ' where soundID IN ' setID];
end
disp(sqlQ);
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
dValue = cursor.Data;
end

