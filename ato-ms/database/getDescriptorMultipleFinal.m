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
function [fValue fFeatures] = getDescriptorMultipleFinal(connecDB, descriptor, soundID, dType)
if nargin < 4
    desList = '(';
    for i = 1:length(descriptor)
        desList = strcat(desList, '"', descriptor{i}, '",');
    end
    desList(end) = ')';
    sqlQ = ['Show Columns From Sounds Where field IN ' desList];
    cursor = exec(connecDB, sqlQ);
    cursor = fetch(cursor);
    descriptor = cursor.data(:, 1);
    dType = cursor.Data(:,2);
end
staticDesc = {};
tempoName = {};
tempoDesc = {};
arrayDesc = {};
arrayName = {};
vectoDesc = {};
for i = 1:length(descriptor)
    if (strcmp(dType{i}, 'int(32)') || strcmp(dType{i}, 'Complex'))
        tempoDesc{end + 1} = [descriptor{i} 'TString'];
    	tempoDesc{end + 1} = [descriptor{i} 'Mean'];
    	tempoDesc{end + 1} = [descriptor{i} 'StdDev'];
        tempoName{end + 1} = descriptor{i};
    elseif (strcmp(dType{i}, 'int(34)') || strcmp(dType{i}, 'Array2D'))
        arrayDesc{end + 1} = descriptor{i};
        arrayName{end + 1} = descriptor{i};
    elseif (strcmp(dType{i}, 'int(33)') || strcmp(dType{i}, 'Array'))   
        vectoDesc{end + 1} = descriptor{i};
    else
        staticDesc{end + 1} = descriptor{i};
    end
end
featCpt = 1;
%tmpValues = getDescriptorMultipleOrch(connecDB, [staticDesc vectoDesc tempoDesc arrayDesc], soundID);
tmpValues = getDescriptorMultipleOrch(connecDB, [staticDesc tempoDesc], soundID);
descriptorsCell = [vectoDesc arrayDesc];
if ~isempty(descriptorsCell)
    sqlQ = ['SELECT ' descriptorsCell{1}];
    for i = 2:length(descriptorsCell)
        sqlQ = strcat(sqlQ, ', ');
        sqlQ = strcat(sqlQ, descriptorsCell{i});
    end
    sqlQ = [sqlQ ' from Arrays'];
    if ~isempty(soundID)
        setID = regexprep(strcat(char(num2str(soundID'))), '\s+', ',');
        setID = strcat('(', setID, ')');
        sqlQ = [sqlQ ' where soundID IN ' setID];
    end
    disp(sqlQ);
    cursor = exec(connecDB, sqlQ);
    cursor = fetch(cursor);
    arrValues = cursor.Data;
end
fValue = cell(length(descriptor), 1);
fFeatures = cell(length(descriptor), 1);
for i = 1:length(staticDesc)
    fFeatures{featCpt} = staticDesc{i};
    fValue{featCpt} = tmpValues(:, featCpt);
    featCpt = featCpt + 1;
end
nbPrevious = featCpt - 1;
tmpNbPrev = nbPrevious;
for i = 1:length(tempoName)
    fFeatures{featCpt} = tempoName{i};
    descVal = tmpValues(:, ((3 * (i - 1)) + nbPrevious + 1):((3 * i) + nbPrevious));
    for k = 1:size(descVal, 1)
        dTString = descVal{k, 1};
        if isnan(descVal{k, 2})
            descVal{k, 2} = 1;
            descVal{k, 3} = 0;
            dTString = ones(1, 128);
        end
        dValue = invertScaleRepresentation(dTString(1:128), 64, descVal{k,2}, descVal{k,3});
        dValue = filter([1 1], 1, dValue) ./ 2;
        tmpDValue = dValue(~isinf(dValue));
        dValue(isinf(dValue)) = min(tmpDValue);
        if (dValue(1) < ((dValue(2) / 2) + 1))
            dValue(1) = dValue(2);
        end
        fValue{featCpt}{k} = dValue;
    end
    featCpt = featCpt + 1;
    tmpNbPrev = tmpNbPrev + 3;
end
arrayCpt = 1;
for i = 1:length(vectoDesc)
    fFeatures{featCpt} = vectoDesc{i};
    descVal = arrValues(:, arrayCpt);
    for k = 1:size(descVal, 1)
        fValue{featCpt}{k} = typecast(descVal{k}, 'double');
    end
    featCpt = featCpt + 1;
    arrayCpt = arrayCpt + 1;
end
arrayCpt = arrayCpt - 1;
for i = 1:length(arrayName)
    fFeatures{featCpt} = arrayName{i};
    descVal = arrValues(:, (i + arrayCpt));
    for k = 1:size(descVal, 1)
        arrayVal = typecast(descVal{k, 1}, 'double');
        arrayVal = reshape(arrayVal, 25, []);
        fValue{featCpt}{k} = arrayVal;
    end
    featCpt = featCpt + 1;
end