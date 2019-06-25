function filteredQuery = isRefinedQuery(newQuery, oldQuery, temporal)
filteredQuery = -1;
existingIndex = [];
for i = 1:length(oldQuery)
    if (temporal == 1 && strcmp(oldQuery(i).type, 'follows') == 1)
        continue;
    end
    index = eltIsIncludedInQuery(oldQuery(i), newQuery);
    if (index == -1)
        return;
    end
    existingIndex = [existingIndex index];
end
filteredQuery = [];
existingIndex = sort(existingIndex);
curIndex = 1;
for i = 1:length(newQuery)
    if (curIndex > length(existingIndex) || i ~= existingIndex(curIndex))
        filteredQuery = [filteredQuery newQuery(i)];
    else
        curIndex = curIndex + 1;
    end
end
end

function indexPos = eltIsIncludedInQuery(elt, query)
indexPos = -1;
    for i = 1:length(query)
        curElt = query(i);
        if (strcmp(curElt.descriptor,elt.descriptor) ~= 1 ...
            || strcmp(curElt.connector,elt.connector) ~= 1 ...
            || strcmp(curElt.type,elt.type) ~= 1)
            continue;
        end
        if (ischar(curElt.value{1}))
            if (strcmp(curElt.value{1},elt.value{1}) ~= 1)
                continue;
            end
        else
            if (curElt.value{1} ~= elt.value{1})
                continue;
            end
        end
        if (ischar(curElt.value{2}))
            if (strcmp(curElt.value{2},elt.value{2}) ~= 1)
                continue;
            end
        else
            if (curElt.value{2} ~= elt.value{2})
                continue;
            end
        end
        indexPos = i;
        return;
    end
end