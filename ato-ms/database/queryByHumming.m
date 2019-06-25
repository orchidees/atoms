function [orderListID] = queryByHumming(connecDB, inputFile, chosenD, maxN)
sqlStruct = getSQLStructureTemplate();
% Retrieving sound signal
signalI = importSignal(inputFile);
if isempty(signalI)
    return;
end
disp([' - Query by humming on file : ' inputFile]);
disp('    o Launching sound analysis.');
sqlStruct = analyzeSound(inputFile, defaultAnalysisParams(), sqlStruct);
durQuery.descriptor = 'duration';
durQuery.type = 'approx';
durQuery.value{1} = sqlstruct.duration;
durQuery.value{2} = 0.4;
queries(1) = durQuery;
durQuery.connector = 'AND';
curQuery.type = 'follows';
curQuery.connector = 'AND';
curIndex = 2;
for i = 1:length(chosenDescriptors)
    curQuery.descriptor = chosenD(i).name;
    curQuery.value{1} = sqlStruct.(chosenD(i).name);
    curQuery.value{2} = chosenD(i).weight;
    if (curQuery.value{2} == 0)
        continue;
    end
    queries(curIndex) = curQuery;
    curIndex = curIndex + 1;
end
disp('    o Querying sound database.');
orderListID = getSoundsQuery(connecDB, queries, maxN);
end
