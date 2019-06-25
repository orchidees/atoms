function fitness = scalarize(criteria,weights,ideal,ranges)

% Fitness computation. First scale the population in the unit
% hypercube (thanks to current ideal point and ranges info), then
% apply a weighted Chebychev norm.

n = size(criteria,1);
criteria = criteria-repmat(ideal,n,1);
criteria = criteria./repmat(ranges,n,1);
fitness = max(criteria.*repmat(weights,n,1),[],2);
end