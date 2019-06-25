%
% getFamilyList.m   : Retrieve the list of instrumental families
%
% connecDB          : Pointer to the SQL connection
%
% Version           : 1.0 / 2009
%
% Author            : Philippe ESLING
%                    <esling@ircam.fr>
%
function fList = getFamilyList(connecDB)
fList = getValuesList(connecDB, 'family');
end
