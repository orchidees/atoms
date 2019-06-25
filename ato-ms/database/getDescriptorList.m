%
% getDescriptorList.m   : Retrieving the list of available descriptors
%
% connecDB              : Pointer to the SQL connection
%
% Version               : 1.0 / 2009
%
% Author                : Philippe ESLING
%                        <esling@ircam.fr>
%
function [dList dType] = getDescriptorList(connecDB)
sqlQ = ' SHOW Columns From Sounds Where Field NOT LIKE ''%TString%'' AND Field NOT LIKE ''%Dimension%''';
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
dList = cursor.Data(:, 1);
dType = cursor.Data(:, 2);
end
