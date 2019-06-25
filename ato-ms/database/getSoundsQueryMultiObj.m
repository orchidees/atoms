%
% getSoundsQuery.m  : Complex query builder on the database
%
% The queries parameter is an array of structures which are organized
%       - type          = type of relation used
%       - descriptor    = name of the descriptor
%       - connector     = logical connector (and / or)
%       - value         = values to use (array)
%
% connecDB          : Pointer to the SQL connection
% queries           : Array of queries following the structure
% maxNum            : Maximum number of results desired
%
% Version           : 1.0 / 2009
%
% Author            : Philippe ESLING
%                    <esling@ircam.fr>
%
function queryValues = getSoundsQueryMultiObj(connecDB, queries, maxNum, handles)
sqlQ = 'SELECT soundID from Sounds WHERE soundID > 0 ';
nbTQueries = 0;
for i = 1:length(queries)
    curQuery = queries(i);
    disp(['Parsing query n. ' num2str(i)]);
    switch curQuery.type
        case 'in'
            sqlAddQ = [' ' curQuery.descriptor ' IN ' curQuery.value{1}];
        case 'is'
            sqlAddQ = [' ' curQuery.descriptor ' = "' curQuery.value{1} '" '];
        case 'contains'
            sqlAddQ = [' ' curQuery.descriptor ' LIKE "%' curQuery.value{1} '%"'];
        case 'equals'
            valStr = num2str(curQuery.value{1});
            sqlAddQ = [' ' curQuery.descriptor ' = ' valStr];
        case 'under'
            valStr = num2str(curQuery.value{1});
            sqlAddQ = [' ' curQuery.descriptor ' < ' valStr];
        case 'over'
            valStr = num2str(curQuery.value{1});
            sqlAddQ = [' ' curQuery.descriptor ' > ' valStr];
        case 'between'
            valStr1 = num2str(curQuery.value{1});
            valStr2 = num2str(curQuery.value{2});
            sqlAddQ1 = [' (' curQuery.descriptor ' > ' valStr1];
            sqlAddQ2 = [' ' curQuery.descriptor ' < ' valStr2 ') '];
            sqlAddQ = strcat(sqlAddQ1, ' AND ', sqlAddQ2);
        case 'approx'
            approxValue = curQuery.value{1};
            approxFactor = (curQuery.value{2} * approxValue);
            valStr1 = num2str(approxValue - approxFactor);
            valStr2 = num2str(approxValue + approxFactor);
            sqlAddQ1 = [' (' curQuery.descriptor ' > ' valStr1];
            sqlAddQ2 = [' ' curQuery.descriptor ' < ' valStr2 ') '];
            sqlAddQ = strcat(sqlAddQ1, ' AND ', sqlAddQ2);
        case 'follows'
            nbTQueries = nbTQueries + 1;
            tQueries{nbTQueries} = curQuery;
    end
    if (strcmp(curQuery.type, 'follows') ~= 1)
        sqlQ = [sqlQ, ' ', curQuery.connector, ' '];
        sqlQ = strcat(sqlQ, ' ', sqlAddQ);
    end
end
disp(sqlQ);
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
staticQ = cursor.Data;
resultsCell = zeros(length(staticQ), 2);
if (nbTQueries > 0)
    disp('Fetching query functions values');
    for i = 1:nbTQueries
        dName{i} = tQueries{i}.descriptor;
        tmpShape = str2double(regexp(tQueries{i}.value{1}, ' ', 'split'));
        dShape(i, :) = tmpShape;
    end
    disp('Starting temporal queries');
	if (nargin > 3)
		resultCell = getTemporalQueryDTWMultiObj(connecDB, dShape, dName, staticQ, ceil(maxNum / 5), handles);
	else
		resultCell = getTemporalQueryDTWMultiObj(connecDB, dShape, dName, staticQ, ceil(maxNum / 5));
	end
    %disp(tmpResults);
    %tmpResults
    %tmpResults(:, 2) = tmpResults(:, 2) ./ max(tmpResults(:, 2));
    %resultsCell(:, 2) = tmpResults(:, 2);
    %resultsCell(:, 1) = tmpResults(:, 1);
    %queryValues = sortrows(resultsCell, 2);
    %queryValues = queryValues(:, 1);
    %queryValues = queryValues(1:(min(maxNum, length(queryValues))));
    queryValues = resultCell;
else
    queryValues = staticQ(1:(min(maxNum, length(staticQ))));
end
end
