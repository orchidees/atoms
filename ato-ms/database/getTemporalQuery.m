%
% getTemporalQuery.m  : Query based on the temporal shape of a descriptor
%
% connecDB          : Pointer to the SQL connection
% descValue         : Desired shape of the descriptor
% descName          : Name of the descriptor
%
% Version           : 1.0 / 2010
%
% Author            : Philippe ESLING
%                    <esling@ircam.fr>
%
function [orderListID resultFuncs] = getTemporalQuery(connecDB, descValue, descName, maxN)
dIndex = constructIndexesFromDB([], descName, [], 1);
idList = [];
if ~isempty(dIndex)
    idList = dIndex.approximateQuery(descValue, 1:60000, 6);
end
% Preparing descriptor value for string comparison
pStrVal = (descValue - mean(descValue)) ./ max(abs(descValue));
descStr = timeseries2symbol(pStrVal, length(pStrVal), 128, 64);
descriptors = [descName 'TString,' descName 'Mean,' descName 'StdDev'];
sqlQ = ['SELECT soundID, ' descriptors ' from Sounds'];
if ~isempty(idList)
    sqlQ = [sqlQ ' WHERE soundID IN (' regexprep(num2str(idList), ' +', ',') ')'];
end
disp(sqlQ);
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
dValue = cursor.Data;
orderListID = zeros(size(dValue, 1), 2);
resultFuncs = zeros(size(dValue, 1), 128);
str2 = descStr;
reach = floor((0.0625 * 128) / 2);
U = zeros(1, length(str2));
L = zeros(1, length(str2));
for i = 1:length(str2)
	U(1, i) = max(str2(max(i - reach, 1)), str2(min(i + reach, length(str2))));
	L(1, i) = min(str2(max(i - reach, 1)), str2(min(i + reach, length(str2))));
end
BSF = inf;
for i = 1:size(dValue, 1)
    dataValue = dValue{i, 2};
    [dMin BSF] = min_distDTWBSF(dataValue(1:128), U, L, BSF, maxN);
	resultFuncs(i, :) = invertScaleRepresentation(dataValue(1:128), 64, dValue{i, 3}, dValue{i, 4});
    resultFuncs(i, :) = filter([1 1], 1, resultFuncs(i, :));
    orderListID(i, 1) = dValue{i, 1};
    orderListID(i, 2) = dMin;
end
[orderListID index] = sortrows(orderListID, 2);
resultFuncs = resultFuncs(index, :);
end
