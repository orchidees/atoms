%
% getAllDescriptorsValuesFast.m : Retrieving the descriptors list.
% Complex types are replaced by string for fast querying.
%
% connecDB                  : Pointer to the SQL connection
% soundID                   : ID of the sound to retrieve
%
% Version                   : 1.0 / 2009
%
% Author                    : Philippe ESLING
%                            <esling@ircam.fr>
%
function dValue = getAllDescriptorsValuesFast(connecDB, soundID)
[dList dType] = getDescriptorList(connecDB);
dValue = cell(length(dList), 1);
for i = 1:length(dList)
    if (strcmp(dType(i), 'int(32)'))
        dValue{i} = 'Temporal shape';
    elseif (strcmp(dType(i), 'blob') || strcmp(dType(i), 'int(33)'))
        dValue{i} = 'Vector of values';
    elseif (strcmp(dType(i), 'longblob') || strcmp(dType(i), 'int(34)'))
        dValue{i} = 'Bi-dimensional Array';
    else
        dValue{i} = getDescriptorValue(connecDB, soundID, dList{i});
    end
end
end
