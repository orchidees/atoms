function [SP DeltaP] = spreadIndicators(paretoF1)
pF2 = paretoF1';
pF1 = repmat(paretoF1, 1, size(paretoF1, 1));
pF2 = repmat(pF2(:)', size(paretoF1, 1), 1);
pF1 = reshape(pF1', size(paretoF1, 2), []);
pF2 = reshape(pF2', size(paretoF1, 2), []);
distF1 = abs(pF1 - pF2);
distSum = sum(distF1, 1);
distSum = distSum(distSum ~= 0);
closeDists = min(reshape(distSum, size(paretoF1, 1) - 1, []));
meanDist = mean(closeDists);
SP = sqrt(sum((closeDists - meanDist) .^ 2) ./ (size(paretoF1, 1) - 1));
DeltaP = sum(abs(closeDists - meanDist) ./ (size(paretoF1, 1) - 1));
end

