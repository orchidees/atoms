%
% FeaturesPartialsAmplitudeBandsMean.m     : Feature definition
%
% This class defines the behavior of the mean values for partials
% amplitude structure
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef FeaturesPartialsMeanAmplitude < Features
    
	methods
    
        %
        % Main constructor for mean partials amplitude feature
        %
        function fI = FeaturesPartialsMeanAmplitude(sessObj, name)
            fI = fI@Features(sessObj, name);
        end
        
        %
        % This function allows to obtain a list of dependancy for the
        % feature. Each item on the list is needed for subsequent operation
        %
        function dList = dependancy(this)
            dList = {'PartialsMeanEnergy', this.featureName};
        end
        
        %
        % Function for computing the addition of values for this feature
        % over a set of solutions.
        %
        function sFeatures = addition(this, population)
            n_PMA = length(this.sSession.getTarget().getFeature(this.featureName));
            solutions = getSolutions(population);
            sFeatures = zeros(getNbSolutions(population), n_PMA);
            for i = 1:size(sFeatures, 1)
                if (solutions(i).isComputed)
                    sFeatures(i, :) = solutions(i).getSolutionFeature(this.featureName);
                    continue;
                end
                PMA_matrix = solutions(i).getIndividualFeature('PartialsMeanAmplitude');
                PME_matrix = solutions(i).getIndividualFeature('PartialsMeanEnergy');
                PMA_matrix = (PMA_matrix .^ 2) .* repmat(PME_matrix,n_PMA,1);
                PMA_matrix = sum(PMA_matrix, 2);
                sFeatures(i, :) = PMA_matrix;
                solutions(i).setSolutionFeature(this.featureName, sFeatures(i, :));
            end
        end
        
        %
        % Function for computing the distances between a set of possible
        % solutions features and the features of a target
        %
        function fDistance = compare(this, soundsetFeatures, targetFeatures)
            PMA_vector_T = targetFeatures.PartialsMeanAmplitude';
            PMA_matrix_T = repmat(PMA_vector_T, size(soundsetFeatures.PartialsMeanAmplitude, 1), 1);
            C = (soundsetFeatures.PartialsMeanAmplitude) .* PMA_matrix_T;
            C = sum(C, 2);
            C = C ./ sqrt(sum(soundsetFeatures.PartialsMeanAmplitude .* soundsetFeatures.PartialsMeanAmplitude,2));
            C = C ./ sqrt(sum(PMA_matrix_T .* PMA_matrix_T,2));
            fDistance = 1 - C;
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
           nValue = zeros(25, 1);
       end
       
   end
   
end 
