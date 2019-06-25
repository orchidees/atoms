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
function orderListID = getDanieleQuery(connecDB, descValue, descName, objList, sortAlg)
if (nargin < 4)
    objList = [2 3 4];
    sortAlg = 0;
end
% Preparing descriptor value for string comparison
pStrVal = (descValue - mean(descValue)) ./ max(abs(descValue));
disp(pStrVal);
descStr = timeseries2symbol(pStrVal, length(pStrVal), 128, 20);
disp(descStr);
descriptors = [descName 'TString,' descName 'Mean,' descName 'StdDev'];
sqlQ = ['SELECT soundID, ' descriptors ' from Sounds'];
%soundIDStr = [ '(' regexprep(num2str(cell2mat(soundID)'), ' +', ',') ')'];
%sqlQ = [sqlQ ' where soundID IN ' soundIDStr];
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
dValue = cursor.Data;
orderListID = zeros(size(dValue, 1), 4);
str2 = descStr;
reach = floor((0.0625 * 128) / 2);
U = zeros(1, length(str2));
L = zeros(1, length(str2));
for i = 1:length(str2)
	U(1, i) = max(str2(max(i - reach, 1)), str2(min(i + reach, length(str2))));
	L(1, i) = min(str2(max(i - reach, 1)), str2(min(i + reach, length(str2))));
end
BSF = inf;
MObj = [];
MObjID = [];
for i = 1:size(dValue, 1)
    dataValue = dValue{i, 2};
    [dMin BSF] = min_distDTWBSF(dataValue(1:128), U, L, BSF, size(dValue, 1));
    orderListID(i, 1) = dValue{i, 1};
    orderListID(i, 2) = dMin;
    orderListID(i, 3) = abs(dValue{i, 3} - mean(descValue));
    orderListID(i, 4) = abs(dValue{i, 4} - std(descValue));
    objectivesID = objList;
    if (isPareto(orderListID(i, objectivesID), MObj))
        MObj = [MObj; orderListID(i, objectivesID)];
        MObjID = [MObjID, dValue{i, 1}];
        nBSF = [];
        nBSFi = [];
        for j = 1:length(MObjID)
            if (isPareto(MObj(j, :), MObj) == 1)
                nBSF = [nBSF; MObj(j, :)];
                nBSFi = [nBSFi, MObjID(j)];
            end
        end
        MObj = nBSF;
        MObjID = nBSFi;
    end
end
disp(MObj);
disp(MObjID);
IX = 1:length(MObjID);
% 1st objective sorting
if (sortAlg == 1)
    [B,IX] = sort(MObj(:, 1));
end
% "Spherical" sorting
if (sortAlg == 2)
    [B,IX] = sort(sum(MObj(:, :), 2));
end
orderListID = MObjID(IX);
end

function paretoB = isPareto(distMatrix, paretoFront)
paretoB = 1;
if (isempty(paretoFront))
    return;
end
nbFront = size(paretoFront, 1);
nbObjec = size(paretoFront, 2);
for i = 1:nbFront;
    pareto = nbObjec;
    for j = 1:nbObjec
        if distMatrix(j) > paretoFront(i, j)
            pareto = pareto - 1;
        end
    end
    if pareto == 0;
        paretoB = 0;
        break;
    end
end
end