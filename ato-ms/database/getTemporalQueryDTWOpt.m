%
% getTemporalQuery.m  : Query based on the temporal shape of a descriptor
% constrained to a particular subset of sound ID
%
% connecDB          : Pointer to the SQL connection
% descValue         : Desired shape of the descriptor
% descName          : Name of the descriptor
% soundID           : Set of sound ID
%
% Version           : 1.0 / 2010
%
% Author            : Philippe ESLING
%                    <esling@ircam.fr>
%
function orderListID = getTemporalQueryDTWOpt(connecDB, descValue, descName, soundID, maxN)
% Preparing descriptor value for string comparison
pStrVal = (descValue - mean(descValue)) ./ max(abs(descValue));
descStr = timeseries2symbol(pStrVal, length(pStrVal), 128, 20);
descriptors = [descName 'TString,' descName 'Mean,' descName 'StdDev'];
sqlQ = ['SELECT soundID, ' descriptors ' from Sounds'];
soundIDStr = [ '(' regexprep(num2str(cell2mat(soundID)'), ' +', ',') ')'];
sqlQ = [sqlQ ' where soundID IN ' soundIDStr];
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
dValue = cursor.Data;
orderListID = zeros(size(dValue, 1), 2);
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
    if (length(dataValue) < 128)
        disp(size(dataValue));
        disp(dValue{i,1});
        continue;
    end
    [dMin BSF] = min_distDTWBSF(dataValue(1:128), U, L, BSF, maxN);
    orderListID(i, 1) = dValue{i, 1};
    orderListID(i, 2) = dMin;
end
%clear dValue;
end