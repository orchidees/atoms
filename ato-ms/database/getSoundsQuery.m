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
function queryValues = getSoundsQuery(connecDB, queries, maxNum)
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
            valStr = sprintf('%.10f', curQuery.value{1});
            sqlAddQ = [' ' curQuery.descriptor ' = ' valStr];
        case 'under'
            valStr = sprintf('%.10f', curQuery.value{1});
            sqlAddQ = [' ' curQuery.descriptor ' <= ' valStr];
        case 'over'
            valStr = sprintf('%.10f', curQuery.value{1});
            sqlAddQ = [' ' curQuery.descriptor ' >= ' valStr];
        case 'between'
            valStr1 = sprintf('%.10f', (curQuery.value{1} - (curQuery.value{1} * 0.01)));
            valStr2 = sprintf('%.10f', (curQuery.value{2} + (curQuery.value{2} * 0.01)));
            sqlAddQ1 = [' (' curQuery.descriptor ' >= ' valStr1];
            sqlAddQ2 = [' ' curQuery.descriptor ' <= ' valStr2 ') '];
            sqlAddQ = strcat(sqlAddQ1, ' AND ', sqlAddQ2);
        case 'approx'
            approxValue = curQuery.value{1};
            approxFactor = (curQuery.value{2} * approxValue);
            valStr1 = sprintf('%.10f', approxValue - approxFactor);
            valStr2 = sprintf('%.10f', approxValue + approxFactor);
            sqlAddQ1 = [' (' curQuery.descriptor ' >= ' valStr1];
            sqlAddQ2 = [' ' curQuery.descriptor ' <= ' valStr2 ') '];
            sqlAddQ = strcat(sqlAddQ1, ' AND ', sqlAddQ2);
        case 'follows'
            nbTQueries = nbTQueries + 1;
            tQueries{nbTQueries} = curQuery;
        case 'regexp'
            queryList = curQuery.value{1};
            queryList = queryList(2:(end-2));
            queryList = [ '"' queryList '"'];
            sqlAddQ = [' ' curQuery.descriptor ' REGEXP ' queryList];
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
if (strcmp(staticQ, 'No Data') == 1)
    queryValues = 0;
    return;
end
resultsCell = zeros(length(staticQ), 2);
if (nbTQueries > 0)
    for i = 1:nbTQueries
        dName = tQueries{i}.descriptor;
        dShape = str2double(regexp(tQueries{i}.value{1}, ' ', 'split'));
        dShape = dShape(1:(end - 1));
        dWeight = tQueries{i}.value{2};
        tmpResults = getTemporalQueryDTWOpt(connecDB, dShape, dName, staticQ, ceil(maxNum / 5));
        tmpResults(:, 2) = tmpResults(:, 2) ./ max(tmpResults(:, 2));
        resultsCell(:, 2) = resultsCell(:, 2) + (tmpResults(:, 2) .* dWeight);
        resultsCell(:, 1) = tmpResults(:, 1);
    end
    queryValues = sortrows(resultsCell, 2);
    queryValues = queryValues(:, 1);
    queryValues = queryValues(1:(min(maxNum, length(queryValues))));
else
    queryValues = staticQ(1:(min(maxNum, length(staticQ))));
end
disp(size(queryValues));
end
