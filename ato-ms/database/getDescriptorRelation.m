%
% getDescriptorsRelation.m  : Retrieving the relation for a descriptor
%
% connecDB                  : Pointer to the SQL connection
% descriptor                : Name of the descriptor
%
% Version                   : 1.0 / 2009
%
% Author                    : Philippe ESLING
%                            <esling@ircam.fr>
%
function dRelation = getDescriptorRelation(connecDB, descriptor)
dRelation = {};
sqlQ = ['Show Columns From Sounds Where field = ''' descriptor ''''];
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
dType = cursor.Data(:, 2);
if (strncmp(dType, 'varchar', 6))
    dRelation = {'is', 'contains'};
end
if (strncmp(dType, 'int', 3))
    dRelation = {'equals', 'under', 'over', 'between'};
end
if (strncmp(dType, 'float', 5))
    dRelation = {'equals', 'under', 'over', 'between', 'approx'};
end
end
