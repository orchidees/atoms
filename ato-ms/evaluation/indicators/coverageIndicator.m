function [c1 c2] = coverageIndicator(pFront1, pFront2)
nbPointsC1 = size(pFront1, 1);
completeFront = [pFront1 ; pFront2];
finalFront = paretoFront(completeFront);
dominateF1 = finalFront(1:nbPointsC1);
dominateF2 = finalFront((nbPointsC1 + 1):end);
c1 = length(dominateF2(dominateF2 == 0));
c2 = length(dominateF1(dominateF1 == 0));
end

