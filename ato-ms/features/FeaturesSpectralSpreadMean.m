%
% FeaturesSpectralSpreadMean.m     : Definition of mean spectral spread
%
% This class defines the behavior of the mean values for spectral
% spread value
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef FeaturesSpectralSpreadMean < Features
    
	methods
    
        %
        % Main constructor for mean spectral spread feature
        %
        function fI = FeaturesSpectralSpreadMean(sessObj, name)
            fI = fI@Features(sessObj, name);
        end
        
        %
        % This function allows to obtain a list of dependancy for the
        % feature. Each item on the list is needed for subsequent operation
        %
        function dList = dependancy(this)
            dList = {'EnergyEnvelopeMean', 'SpectralCentroidMean', this.featureName};
        end
        
        %
        % Function for computing the addition of values for this feature
        % over a set of solutions.
        %
        function sFeatures = addition(this, population)
            sFeatures = zeros(population.getNbSolutions(), 1);
            solutions = population.getSolutions();
            for i = 1:size(sFeatures, 1)
                if (solutions(i).isComputed)
                    sFeatures(i) = solutions(i).getSolutionFeature(this.featureName);
                    continue;
                end
                descriptor = solutions(i).getIndividualFeature(this.featureName);
                spec_centro = solutions(i).getIndividualFeature('SpectralCentroidMean');
                ener_matrix = solutions(i).getIndividualFeature('EnergyEnvelopeMean');
                scFeature = sum(spec_centro .* ener_matrix, 2) ./ sum(ener_matrix, 2);
                m2Matrix = (descriptor .^ 2) + (repmat(scFeature .^ 2, 1, size(descriptor, 2)));
                sFeatures(i) = sqrt(sum(m2Matrix .* ener_matrix, 2) ./ sum(ener_matrix, 2) - scFeature .^ 2);
                solutions(i).setSolutionFeature(this.featureName, sFeatures(i))
            end
        end
        
        %
        % Function for computing the distances between a set of possible
        % solutions features and the features of a target
        %
        function fDistance = compare(this, soundsetFeatures, targetFeatures)
            ss_vector_T = targetFeatures.SpectralSpreadMean;
            ss_matrix_T = repmat(ss_vector_T,size(soundsetFeatures.SpectralSpreadMean, 1), 1);
            fDistance = abs(soundsetFeatures.SpectralSpreadMean - ss_matrix_T) ./ ss_matrix_T;
        end
       
       %
       % Function for computing the value of the features.
       % The proposed source could be a soundfile or straight signal
       %
       function fValue = analysis(this, source)
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
           nValue = 0;
       end
       
   end
   
end 
