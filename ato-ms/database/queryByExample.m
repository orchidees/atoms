function [orderListID] = queryByExample(connecDB, inputFile, chosenD, maxN)
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
durQuery.value{1} = sqlStruct.duration;
durQuery.value{2} = 2.25;
durQuery.connector = 'AND';
queries(1) = durQuery;
for i = 1:length(chosenD)
    curQuery.descriptor = chosenD{i};
    curQuery.type = 'follows';
    curQuery.value{1} = sqlStruct.([chosenD{i} 'TString']);
    curQuery.value{2} = 1;
    curQuery.connector = 'AND';
    queries(i + 1) = curQuery;
end
disp('    o Querying sound database.');
profile on;
orderListID = getSoundsQueryMultiObjStr(connecDB, queries, maxN);
end
