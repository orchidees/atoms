%
% getDescriptorComplexValue.m   : Retrieving the value of a specific descriptor
% Use an external joint if the value is complex to retrieve whole values
%   - int(32) = Gaussian mixture modeling
%   - int(33) = Array of atomic values
%   - int(34) = Array of Gaussian mixtures
%
% connecDB                      : Pointer to the SQL connection
% soundID                       : ID of the sound to retrieve
% descriptor                    : Name of the descriptor
%
% Version                       : 1.0 / 2009
%
% Author                    : Philippe ESLING
%                            <esling@ircam.fr>
%
function dValue = getDescriptorMultipleComplex(connecDB, descriptor, soundID)
sqlQ = ['Show Columns From Sounds Where field = ''' descriptor ''''];
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
dType = cursor.Data(:, 2);
if (strcmp(dType, 'int(32)'))
	descCell{1} = [descriptor 'TString'];
	descCell{2} = [descriptor 'Mean'];
	descCell{3} = [descriptor 'StdDev'];
	descVal = getDescriptorMultipleID(connecDB, descCell, soundID);
    dValue = cell(size(descVal, 1));
    for i = 1:size(descVal, 1)
    	dTString = descVal{i, 1};
        tValue = invertScaleRepresentation(dTString(1:128), 64, descVal{i, 2}, descVal{i, 3});
        tValue = filter([1 1], 1, tValue) ./ 2;
        tValue = tValue(~isinf(tValue));
        if (tValue(1) < ((tValue(2) / 2) + 1))
            tValue = tValue(2:end);
        end
        dValue{i} = tValue;
    end
elseif (strcmp(dType, 'longblob'))
    soundID = cell2mat(soundID);
    soundIDStr = [ '(' regexprep(num2str(soundID), ' +', ',') ')'];
    sqlQ = ['SELECT ' descriptor ', ' [descriptor 'Dimension'] ' FROM Sounds'];
    sqlQ = [sqlQ ' where soundID IN ' soundIDStr];
	cursor = exec(connecDB, sqlQ);
    cursor = fetch(cursor);
    descVals = cursor.Data;
    dValue = cell(length(soundID), 1);
    for i = 1:length(soundID)
       finalValue = typecast(descVals{i, 1}, 'double');
       finalValue = reshape(finalValue, descVals{i, 2}, []);
       dValue{i} = finalValue;
    end
elseif (strcmp(dType, 'blob'))
    soundID = cell2mat(soundID);
    soundIDStr = [ '(' regexprep(num2str(soundID), ' +', ',') ')'];
    sqlQ = ['SELECT ' descriptor ' FROM Sounds'];
    sqlQ = [sqlQ ' where soundID IN ' soundIDStr];
	cursor = exec(connecDB, sqlQ);
    cursor = fetch(cursor);
    descVals = cursor.Data;
    dValue = cell(length(soundID), 1);
    for i = 1:length(soundID)
        dValue{i} = typecast(descVals{i}, 'double');
    end
elseif (strcmp(dType, 'int(34)'))
    soundID = cell2mat(soundID);
    soundIDStr = [ '(' regexprep(num2str(soundID), ' +', ',') ')'];
    sqlQ = ['SELECT ' descriptor ', ' [descriptor 'Dimension'] ' FROM Arrays'];
    sqlQ = [sqlQ ' where soundID IN ' soundIDStr];
	cursor = exec(connecDB, sqlQ);
    cursor = fetch(cursor);
    descVals = cursor.Data;
    dValue = cell(length(soundID), 1);
    for i = 1:length(soundID)
       finalValue = typecast(descVals{i, 1}, 'double');
       finalValue = reshape(finalValue, descVals{i, 2}, []);
       dValue{i} = finalValue;
    end
elseif (strcmp(dType, 'int(33)'))
    soundID = cell2mat(soundID);
    soundIDStr = [ '(' regexprep(num2str(soundID), ' +', ',') ')'];
    sqlQ = ['SELECT ' descriptor ' FROM Arrays'];
    sqlQ = [sqlQ ' where soundID IN ' soundIDStr];
	cursor = exec(connecDB, sqlQ);
    cursor = fetch(cursor);
    descVals = cursor.Data;
    dValue = cell(length(soundID), 1);
    for i = 1:length(soundID)
        dValue{i} = typecast(descVals{i}, 'double');
    end
else
	dValue = getDescriptorMultipleID(connecDB, {descriptor}, soundID);
end
end
