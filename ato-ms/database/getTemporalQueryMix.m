%
% getTemporalQueryDTW.m  : Query based on the temporal shape of a descriptor
% based on a Dynamic Time Warping (DTW) measure
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
function [orderListID resultFuncs] = getTemporalQueryMix(connecDB, descValue, descName, ratioDTW, reach)
% Preparing descriptor value for string comparison
pStrVal = (descValue - mean(descValue)) ./ max(abs(descValue));
descStr = timeseries2symbol(pStrVal, length(pStrVal), 128, 20);
descriptors = [descName 'TString,' descName 'Mean,' descName 'StdDev'];
sqlQ = ['SELECT soundID, ' descriptors ' from Sounds'];
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
dValue = cursor.Data;
orderListID = zeros(size(dValue, 1), 2);
resultFuncs = zeros(size(dValue, 1), 128);
str2 = descStr;
U = zeros(1, length(str2));
L = zeros(1, length(str2));
for i = 1:length(str2)
	U(1, i) = max(str2(max(i - reach, 1)), str2(min(i + reach, length(str2))));
	L(1, i) = max(str2(max(i - reach, 1)), str2(min(i + reach, length(str2))));
end
for i = 1:size(dValue, 1)
    dataValue = dValue{i, 2};
    dMinN = min_dist(dataValue(1:128), descStr(1:128), 20, 1);
    dMinDTW = min_distDTWOptim(dataValue(1:128), U, L, 20, 1);
    dMin = (ratioDTW * dMinDTW) + ((1 - ratioDTW) * dMinN);
    resultFuncs(i, :) = invertScaleRepresentation(dataValue(1:128), 20, dValue{i, 3}, dValue{i, 4});
    resultFuncs(i, :) = filter([1 1], 1, resultFuncs(i, :));
    orderListID(i, 1) = dValue{i, 1};
    orderListID(i, 2) = dMin;
end
[orderListID index] = sortrows(orderListID, 2);
resultFuncs = resultFuncs(index, :);
end
