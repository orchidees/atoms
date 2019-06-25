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
function vList = getValuesList(connecDB, descriptor)
sqlQ = ['SELECT DISTINCT ' descriptor ' from Sounds'];
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
vList = cursor.Data;
end
