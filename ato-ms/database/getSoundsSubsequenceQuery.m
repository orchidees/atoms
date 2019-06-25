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
function queryValues = getSoundsSubsequenceQuery(connecDB, queries, maxNum, minS, stepS)
sqlQ = 'SELECT soundID from Sounds WHERE soundID > 0 ';
nbTQueries = 0;
for i = 1:length(queries)
    curQuery = queries(i);
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
        if (i == 1)
            sqlQ = [sqlQ, ' AND '];            
        else
            sqlQ = [sqlQ, ' ', curQuery.connector, ' '];
        end
        sqlQ = strcat(sqlQ, ' ', sqlAddQ);
    end
end
disp(sqlQ);
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
staticQ = cursor.Data;
disp(cursor);
disp(staticQ);
disp(cursor.Data);
if (strcmp(staticQ, 'No Data') == 1)
    queryValues = 0;
    return;
end
if (nbTQueries > 0)
    nbSubSeq = 0;
    for stretch = minS:stepS:128
        for onset = 1:(128 - stretch + 1)
            nbSubSeq = nbSubSeq + 1;
        end
    end
    resultsCell = zeros(length(staticQ) * nbSubSeq, 2);
    for i = 1:nbTQueries
        disp(nbTQueries);
        dName = tQueries{i}.descriptor;
        dShape = str2double(regexp(tQueries{i}.value{1}, ' ', 'split'));
        dShape = dShape(1:(end - 1));
        dWeight = tQueries{i}.value{2};
        tmpResults = getTemporalQuerySubsequence(connecDB, dShape, dName, staticQ, ceil(maxNum / 5), minS, stepS, nbSubSeq);
        disp(tmpResults)
        tmpResults(:, 2) = tmpResults(:, 2) ./ max(tmpResults(:, 2));
        resultsCell(:, 2) = resultsCell(:, 2) + (tmpResults(:, 2) .* dWeight);
        resultsCell(:, 1) = tmpResults(:, 1);
        resultsCell(:, 3) = tmpResults(:, 3);
        resultsCell(:, 4) = tmpResults(:, 4);
    end
    queryValues = sortrows(resultsCell, 2);
    queryValues = queryValues(1:(min(maxNum, length(queryValues))), :);
else
    queryValues = staticQ(1:(min(maxNum, length(staticQ))));
end
end
