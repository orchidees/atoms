%
% getValueList.m    : Retrieve the list of possible values for a descriptor
%
% connecDB          : Pointer to the SQL connection
% descriptor        : Name of the descriptor
%
% Version           : 1.0 / 2009
%
% Author            : Philippe ESLING
%                    <esling@ircam.fr>
%
function vList = getValuesListID(connecDB, descriptor, idList)
if nargin < 3
    idList = [];
end
sqlQ = ['SELECT DISTINCT ' descriptor ' from Sounds'];
if ~isempty(idList)
    soundIDStr = [ '(' regexprep(num2str(cell2mat(idList)'), ' +', ',') ')'];
    sqlQ = [sqlQ ' where soundID IN ' soundIDStr];
end
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
vList = cursor.Data;
end
