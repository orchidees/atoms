function [ONVG PNS] = cardinalityIndicators(paretoFront, classElements)
ONVG = size(paretoFront, 1);
PNS = ONVG / size(classElements, 1);
end

