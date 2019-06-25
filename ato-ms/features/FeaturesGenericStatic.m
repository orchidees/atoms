%
% FeaturesGenericStatic.m     : Class definition for any mean feature
%
% This class defines the generic behavior for mean spectral features
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef FeaturesGenericStatic < Features
    
    methods
       
        %
        % Main constructor for generic static features
        %
        function fI = FeaturesGenericStatic(sessObj, name)
            fI = fI@Features(sessObj, name);
        end
       
        %
        % This function allows to obtain a list of dependancy for the
        % feature. Each item on the list is needed for subsequent operation
        %
        function dList = dependancy(this)
            dList = {'EnergyEnvelopeMean', this.featureName};
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
                ener_matrix = solutions(i).getIndividualFeature('EnergyEnvelopeMean');
                sFeatures(i) = sum(descriptor .* ener_matrix, 2) ./ sum(ener_matrix, 2);
                solutions(i).setSolutionFeature(this.featureName, sFeatures(i))
            end
        end
       
        %
        % Function for computing the distances between a set of possible
        % solutions features and the features of a target
        %
        function fDistance = compare(this, soundsetFeatures, targetFeatures)
            sc_vector_T = targetFeatures.(this.featureName);
            sc_matrix_T = repmat(sc_vector_T,size(soundsetFeatures.(this.featureName),1),1);
            fDistance = abs(soundsetFeatures.(this.featureName)-sc_matrix_T)./sc_matrix_T;
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
