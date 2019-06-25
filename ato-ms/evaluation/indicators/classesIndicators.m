function lM = classesIndicators(class, maxPoint)
%[ONVG PNS] = cardinalityIndicators(class, fullClass);
%ONVG = 0;
%PNS = 0;
%[GD ADRS MPFE GDF] = distanceIndicators(class, paretoF);
%[SP DeltaP] = spreadIndicators(class);
%SP = 0;
%DeltaP = 0;
%epsAdd = epsilonIndicator(class, paretoF, 1);
%epsilonIndicator(class, paretoF, 1);
lM = Hypervolume_MEX(class, maxPoint);
%epsMul = lebesgueMeasure(class', max(fullClass)');
%unPareto = ismember(paretoF, class, 'rows');
%unPareto = paretoF(~unPareto, :);
%if ~isempty(unPareto)
%    hVCao = lebesgueMeasure(unPareto', maxPoint');
%else
%    hVCao = Inf;
%end
%epsMul = lM / epsMul;
%epsMul = 0;
%hVCao = 0;
%rId = rIndicator(class, paretoF, [0 0], maxPoint);
%rId = 0;
end