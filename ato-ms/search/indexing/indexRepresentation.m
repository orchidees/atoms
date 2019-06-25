function [binaryWord] = indexRepresentation(rawData, winLen, wordLen, cardinality, cut_points)

if cardinality > 16
    disp('Cardinality cannot exceed 16');
    return;
end

winSize = winLen / wordLen;
binaryWord = cell(1, wordLen);

% Scan accross the time series extract sub sequences, and converting them to strings.
for i = 1 : length(rawData) - (winLen - 1)
    % Remove the current subsection.
    subSection = rawData(i:(i + winLen - 1));
    % Z normalize it.
    subSection = (subSection - mean(subSection))/max(abs(subSection));
    % take care of the special case where there is no dimensionality reduction
    if winLen == wordLen
        PAA = subSection;
    % Convert to PAA.    
    else
        % winLen is not dividable by wordLen
        if (winSize - floor(winSize) > 0)           
            expandedSubSection = resample(subSection, wordLen, 1);
            PAA = mean(reshape(expandedSubSection, winLen, wordLen));
        else
            PAA = mean(reshape(subSection, winSize, wordLen));
        end
    end
    binaryWord = zeros(length(PAA), cardinality);
    for j = 1 : length(PAA)
		binaryWord(j,:) = bitget(uint8(sum((cut_points <= PAA(j)), 2)), cardinality:-1:1);
    end;
    %if ~all(currentBinary == binaryWord{end,:})             % If the string differs from its leftmost neighbor...
        %binaryWord       = [binaryWord; currentBinary];     % ... add it to the set...
        %pointers         = [pointers ; i];                      % ... and add a new pointer.
    %end;
end;

