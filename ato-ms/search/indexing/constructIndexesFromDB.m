%
%
% Creating indexes for a particular descriptors list
%
%
function descIndex = constructIndexesFromDB(knowledge, descName, handles, force)
if nargin < 3
    handles = [];
    force = 0;
end
index = [];
server_says(handles, ['Creating index for ' descName], 0);
if ~exist('~/Library/Preferences/IRCAM/descriptorsIndexes', 'dir')
    !mkdir ~/Library/Preferences/IRCAM/descriptorsIndexes
end
if exist(['~/Library/Preferences/IRCAM/descriptorsIndexes/' descName '.mat'], 'file')
    load(['~/Library/Preferences/IRCAM/descriptorsIndexes/' descName '.mat']);
    descIndex = index;
    return;
end
if force == 1
    descIndex = [];
    return;
end
userDir = getenv('HOME'); 
index = indexTree(8, 8, 100, 8);
nbSounds = knowledge.getNbEntries();
maxThous = floor(nbSounds / 1000);
for i = 0:maxThous
    listIDs = ((i * 1000) + 1):((i + 1) * 1000);
    values = knowledge.getFieldsValues({'duration', [descName 'TString'], [descName 'Mean'], [descName 'StdDev'], 'soundID'}, listIDs');
    server_says(handles, ['Creating index for ' descName], i / maxThous);
    for j = 1:size(values, 1)
        if ~iscell(values)
            continue;
        end
        dTString = values{j, 2};
        if (length(dTString) < 128)
            continue;
        end
        dValue = invertScaleRepresentation(dTString(1:128), 64, values{j, 3}, values{j, 4});
        %dValue = filter([1 1], 1, dValue);
        tmpDValue = dValue(~isinf(dValue));
        dValue(isinf(dValue)) = min(tmpDValue);
        if (dValue(1) < ((dValue(2) / 2) + 1))
            dValue(1) = dValue(2);
        end
        index.insertSeries(dValue, values{j, 5}, values{j, 1});
    end
end
%descIndex.dumpTree();
save([userDir '/Library/Preferences/IRCAM/descriptorsIndexes/' descName '.mat'], 'index');
descIndex = index;
end

