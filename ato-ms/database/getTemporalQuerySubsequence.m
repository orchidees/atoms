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
function orderListID = getTemporalQuerySubsequence(connecDB, descValue, descName, soundID, maxN, minS, stepS, nbSubSeq)
pStrVal = (descValue - mean(descValue)) ./ max(abs(descValue));
descriptors = [descName 'TString,' descName 'Mean,' descName 'StdDev'];
sqlQ = ['SELECT soundID, ' descriptors ' from Sounds'];
soundIDStr = [ '(' regexprep(num2str(cell2mat(soundID)'), ' +', ',') ')'];
sqlQ = [sqlQ ' where soundID IN ' soundIDStr];
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
dValue = cursor.Data;
orderListID = zeros(size(dValue, 1) * nbSubSeq, 4);
curSub = 1;
BSF = inf;
for i = 1:size(dValue, 1)
    disp(['Processing sound n.' num2str(i)]);
    for stretch = minS:stepS:128
        % Preparing descriptor value for string comparison
        str2 = timeseries2symbol(pStrVal, length(pStrVal), stretch, 20);
        reach = floor((0.0625 * stretch) / 2);
        U = zeros(1, length(str2));
        L = zeros(1, length(str2));
        for j = 1:length(str2)
            U(1, j) = max(str2(max(j - reach, 1)), str2(min(j + reach, length(str2))));
            L(1, j) = min(str2(max(j - reach, 1)), str2(min(j + reach, length(str2))));
        end
        for onset = 1:(128 - stretch + 1)
            dataValue = dValue{i, 2};
            dataValue = dataValue(onset:(onset + stretch - 1));
            [dMin BSF] = min_distDTWBSFSub(dataValue, U, L, 20, 1, BSF, 5);
            orderListID(curSub, :) = [dValue{i, 1} dMin onset stretch];
            curSub = curSub + 1;
        end
    end
end
clear dValue;
end