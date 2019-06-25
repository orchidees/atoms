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
function orderListID = getTemporalQueryDTWMultiObj(connecDB, descValue, descName, soundID, maxN, handle)
% Preparing descriptor value for string comparison
descStr = zeros(size(descValue, 1), 128);
disp('Preparing representation transformation');
descValue = descValue(:, 1:(end-1));
for i = 1:size(descValue, 1)
	tmpVal = descValue(i,:);
    tmpVal(isnan(tmpVal)) = 0;
    descValue(i, :) = tmpVal;
    pStrVal = (descValue(i, :) - mean(descValue(i, :))) ./ max(abs(descValue(i, :)));
    disp(pStrVal);
    descStr(i, :) = timeseries2symbol(pStrVal, length(pStrVal), 128, 20);
    disp(descStr(i,:));
end
disp('Starting SQL fetching');
sqlQ = 'SELECT soundID';
for i = 1:length(descName)
    descriptors = [',' descName{i} 'TString'];
    sqlQ = strcat(sqlQ, descriptors);
end
disp('Finishied strcating');
sqlQ = [sqlQ ' from Sounds'];
soundIDStr = [ '(' regexprep(num2str(cell2mat(soundID)'), ' +', ',') ')'];
sqlQ = [sqlQ ' where soundID IN ' soundIDStr];
disp(sqlQ);
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
dValue = cursor.Data;
%orderListID = zeros(size(dValue, 1), 2);
reach = floor((0.0625 * 128) / 2);
%reach = floor((0.0025 * 128) / 2);
%reach = 1;
disp('Starting preparing envelopes');
U = zeros(size(descStr, 1), size(descStr, 2));
L = zeros(size(descStr, 1), size(descStr, 2));
for j = 1:size(descStr, 1)
    str2 = descStr(j, :);
    for i = 1:length(str2)
    	U(j, i) = max(str2(max(i - reach, 1)), str2(min(i + reach, length(str2))));
        L(j, i) = min(str2(max(i - reach, 1)), str2(min(i + reach, length(str2))));
    end
end
BSF = [];
BSFi = [];
disp('Starting point by point search');
for i = 1:size(dValue, 1)
    disp(i);
    dataValue = dValue(i, 2:end);
	if (nargin > 5)
		[BSF BSFi] = min_distDTWBSF_MultiObj(dataValue, U, L, BSF, BSFi, i, handle);
	else
		[BSF BSFi] = min_distDTWBSF_MultiObj(dataValue, U, L, BSF, BSFi, i);
	end
    disp(size(BSF));
    %disp(size(BSFi));
end
disp(BSF);
disp(BSFi);
orderListID{1} = BSFi;
orderListID{2} = BSF;
clear dValue;
end