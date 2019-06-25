%
% FeaturesSpectralSpread.m     : Definition of spectral spread
%
% This class defines the behavior of the temporal evolution for spectral
% spread value
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef FeaturesSpectralSpread < Features
    
	methods
    
        %
        % Main constructor for spectral spread feature
        %
        function fI = FeaturesSpectralSpread(sessObj, name)
            fI = fI@Features(sessObj, name);
        end
        
        %
        % This function allows to obtain a list of dependancy for the
        % feature. Each item on the list is needed for subsequent operation
        %
        function dList = dependancy(this)
            dList = {'EnergyEnvelope', 'SpectralCentroid', this.featureName};
        end
       
       %
       % Function for computing the value of the features.
       % The proposed source could be a soundfile or straight signal
       %
       function fValue = analysis(this, source)
       end
       
       %
       % Function for computing the addition of values for this feature
       % over a set of solutions.
       %
       function sFeatures = addition(this, population)
            nbTime = length(this.sSession.getTarget().getFeature(this.featureName));
            sFeatures = zeros(getNbSolutions(population), nbTime);
            solutions = getSolutions(population);
            for i = 1:size(sFeatures, 1)
                if (solutions(i).isComputed)
                    sFeatures(i, :) = solutions(i).getSolutionFeature(this.featureName);
                    continue;
                end
                descriptor = solutions(i).getIndividualFeature(this.featureName);
                specCentro = solutions(i).getIndividualFeature('SpectralCentroid');
                energyMatrix = solutions(i).getIndividualFeature('EnergyEnvelope');
                temporalMatrix = sum(specCentro .* energyMatrix, 2) ./ sum(energyMatrix, 2);
                temporalMatrix(isnan(temporalMatrix)) = 0;
                moment2Matrix = (descriptor .^ 2) + (repmat(temporalMatrix, 1, size(descriptor, 2)) .^ 2);
                tmpFeat = sqrt(sum(moment2Matrix .* energyMatrix, 2) ./ sum(energyMatrix, 2) - temporalMatrix .^ 2);
                tmpFeat(isnan(tmpFeat)) = min(tmpFeat);
                sFeatures(i, :) = tmpFeat;
                solutions(i).setSolutionFeature(this.featureName, sFeatures(i, :));
            end
       end
       
       %
       % Function for computing the distances between a set of possible
       % solutions features and the features of a target
       %
       function fDistance = compare(this, soundsetFeatures, targetFeatures)
            str2 = targetFeatures.SpectralSpread.';
            soundsetMat = soundsetFeatures.SpectralSpread;
            tmpstr2 = str2(~isinf(str2));
            str2(isinf(str2)) = min(tmpstr2);
            str2(isnan(str2)) = min(tmpstr2);
            str2 = (str2 - mean(str2)) ./ max(str2);
            U = zeros(1, length(str2));
            L = zeros(1, length(str2));
            reach = floor(0.1 * 128);
            for i = 1:length(str2)
                U(1, i) = max(str2(max(i - reach, 1)), str2(min(i + reach, length(str2))));
                L(1, i) = min(str2(max(i - reach, 1)), str2(min(i + reach, length(str2))));
            end
            temporalCriteria = zeros(1, size(soundsetMat, 1));
            for i = 1:size(soundsetMat, 1)
                str1 = soundsetMat(i, :);
                str1(isnan(str1)) = min(str1);
                str1 = (str1 - mean(str1)) ./ max(str1);
                temporalCriteria(i) = mean(sqrt(sum([(str1 > U) .* (str1 - U); (str1 < L) .* (L - str1)] .^ 2)));
            end
            if this.sSession.isDebug()
                this.debugPlotComparison(str2, soundsetMat, temporalCriteria);
            end
            fDistance = temporalCriteria';
       end
       
       %
       % This function allows to obtain the transposition of a features
       % value. This is particularly useful for microtonic resolutions
       %
       function tValue = transpose(this, originalValue, tFactor)
       end
       
       %
       % This function returns the neutral element value for this feature
       %
       function nValue = neutral(this)
           nValue = zeros(1, 128);
       end
       
   end
   
end 
