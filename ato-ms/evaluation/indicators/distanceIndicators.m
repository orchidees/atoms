function [GD ADRS MPFE GDF] = distanceIndicators(paretoF1, paretoOpt)
pF2 = paretoOpt';
pF1 = repmat(paretoF1, 1, size(paretoOpt, 1));
pF2 = repmat(pF2(:)', size(paretoF1, 1), 1);
pF1 = reshape(pF1', size(paretoF1, 2), []);
pF2 = reshape(pF2', size(paretoF1, 2), []);
distF1 = pF1 - pF2;
distSum = sum(distF1 .^ 2, 1);
distEuc = sqrt(distSum);
GDF = sum(sqrt(sum(paretoF1 .^ 2, 2))) ./ size(paretoF1, 1);
GD = sum(min(reshape(distEuc, size(paretoOpt, 1), []))) ./ size(paretoF1, 1);
ADRS = max(min(reshape(distEuc, size(paretoOpt, 1), [])));
MPFE = max(sqrt(min(reshape(distSum, size(paretoOpt, 1), []))));
end

