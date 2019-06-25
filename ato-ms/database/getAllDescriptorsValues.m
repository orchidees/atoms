%
% getAllDescriptorsValues.m : Retrieving the complete descriptors list
%
% connecDB                  : Pointer to the SQL connection
% soundID                   : ID of the sound to retrieve
%
% Version                   : 1.0 / 2009
%
% Author                    : Philippe ESLING
%                            <esling@ircam.fr>
%
function dValue = getAllDescriptorsValues(connecDB, soundID)
[dList dType] = getDescriptorList(connecDB);
dValue = cell(length(dList), 1);
for i = 1:length(dList)
    if strcmp(dType(i), 'int(32)')
        % Temporal shapes
        descVal = getDescriptorValue(connecDB, soundID, dList{i});
        dValue{i} = descVal;
    elseif strcmp(dType(i), 'blob') || strcmp(dType, 'int(33)')
        % Vector of values
        descVal = getDescriptorValue(connecDB, soundID, dList{i});
        dValue{i} = typecast(cell2mat(descVal), 'double');
    elseif strcmp(dType(i), 'longblob')  || strcmp(dType, 'int(34)')
        % Bi-dimensional array of values
        %descVal = getDescriptorValue(connecDB, soundID, dList{i});
        descVal = getDescriptorMultipleValues(connecDB, soundID, {dList{i}, [dList{i} 'Dimension']});
        dValue{i} = typecast(descVal{1}, 'double');
        dValue{i} = reshape(dValue{i}, descVal{2}, []);
    else
        dValue{i} = getDescriptorValue(connecDB, soundID, dList{i});
    end
end
end
