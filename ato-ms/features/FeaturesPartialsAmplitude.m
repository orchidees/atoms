%
% FeaturesPartialsAmplitudeBands.m     : Feature definition
%
% This class defines the behavior of the temporal evolution for partials
% amplitude structure
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef FeaturesPartialsAmplitude < Features
    
	methods
        
        %
        % Main constructor for partials amplitude features
        %
        function fI = FeaturesPartialsAmplitude(sessObj, name)
            fI = fI@Features(sessObj, name);
        end
       
        %
        % This function allows to obtain a list of dependancy for the
        % feature. Each item on the list is needed for subsequent operation
        %
        function dList = dependancy(this)
            dList = {'PartialsFrequency', this.featureName};
        end
       
        
        %
        % Function for computing the addition of values for this feature
        % over a set of solutions.
        %
        function partialStructure = addition(this, population)
            partialStructure = cell(getNbSolutions(population), 1);
            solutions = getSolutions(population);
            for i = 1:length(solutions)
                if (solutions(i).isComputed)
                    partialStructure{i} = solutions(i).getSolutionFeature('PartialsAmplitude');
                    continue;
                end
                curFreq = solutions(i).getIndividualFeature('PartialsAmplitude');
                curAmps = solutions(i).getIndividualFeature('PartialsFrequency');
                solSpec = zeros(max(max(floor(sqrt(curFreq) + 1))), 64);
                for k = 1:64
                     sliceFreqs = floor(sqrt(curFreq(:, k:64:size(curFreq, 2))) + 1);
                     sliceAmpls = curAmps(:, k:64:size(curFreq, 2));
                     solSpec(sliceFreqs(:), k) = sliceAmpls(:);
                end
                solutions(i).setSolutionFeature('PartialsAmplitude', solSpec);
                partialStructure{i} = solSpec;
            end
            %partialStructure.amplitude = amplitude{i};
            %partialStructure.amplitude = amplitude{i};
        end
        
        %
        % Function for computing the distances between a set of possible
        % solutions features and the features of a target
        %
        function criteria = compare(this, soundsetFeatures, targetFeatures)
            if ~isfield(targetFeatures, 'targetSpec')
                target_amp = targetFeatures.PartialsAmplitude;
                target_freq = targetFeatures.PartialsFrequency;
                target_freq(target_freq < 0) = 0;
                targetSpec = zeros(max(max(floor(sqrt(target_freq) + 1))), size(target_freq, 2));
                for i = 1:size(target_freq, 2)
                    targetSpec(floor(sqrt(target_freq(:, i)) + 1), i) = target_amp(:, i);
                end
                targetFeatures.targetSpec = targetSpec;
            else
                targetSpec = targetFeatures.targetSpec;
            end
            sSetFeat = soundsetFeatures.PartialsAmplitude;
            criteria = zeros(length(sSetFeat), 1);
            for j = 1:length(sSetFeat)
                solSpec = sSetFeat{j};
                tmpSlice_S_B = [solSpec ; zeros(size(targetSpec, 1) - size(solSpec, 1), size(target_freq, 2))];
                tmpSlice_T_B = [targetSpec ; zeros(size(solSpec, 1) - size(targetSpec, 1), size(target_freq, 2))];
                criteria(j) = sum(sqrt(sum((tmpSlice_S_B - tmpSlice_T_B) .^ 2)));
            end
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
           nValue = zeros(25, 64);
       end
       
   end
   
end 
