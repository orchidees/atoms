%
% Features.m        : Abstract definition for the features system
%
% This class defines the abstract behavior required for the definition of
% any optimizable feature.
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef Features < handle

    properties
        weights          % Weights used in the feature relevance feedback
        featureName      % Name of optimization feature
        sSession         % Current orchestration session
    end

    methods (Abstract)
       
        %
        % This function allows to obtain a list of dependancy for the
        % feature. Each item on the list is needed for subsequent operation
        %
        dList = dependancy(this)
       
        %
        % Function for computing the value of the features.
        % The proposed source could be a soundfile or straight signal
        %
        fValue = analysis(this, source)
       
        %
        % Function for computing the addition of values for this feature
        % over a set of solutions.
        %
        sFeatures = addition(this, feature_structure, soundset)
       
        %
        % Function for computing the distances between a set of possible
        % solutions features and the features of a target
        %
        fDistance = compare(this, soundsetFeatures, targetFeatures)
       
        %
        % This function allows to obtain the transposition of a features
        % value. This is particularly useful for microtonic resolutions
        %
        tValue = transpose(this, originalValue, tFactor)
       
        %
        % This function returns the neutral element value for this feature
        %
        nValue = neutral(this)

    end
   
    methods
        
        %
        % Main constructor for Features object
        %
        function fI = Features(sessObj, name)
            fI.weights = 0;
            fI.featureName = name;
            fI.sSession = sessObj;
        end
       
        %
        % Retrieve the name of current feature
        % This function is useful for generic features
        %
        function name = getFeatureName(this)
            name = this.featureName;
        end
        
        %
        % Function for debuging addition plot verification
        %
        function debugPlotAddition(this, cMatrix, addMatrix, soundsets, onsets, nCombs, nSounds)
            time = datestr(rem(now, 1));
            scrsz = get(0,'ScreenSize');
            for i = 1:nCombs
                figH = figure(1);
                set(figH,'OuterPosition',[scrsz(1),scrsz(2),1024,768]);
                for j = 1:nSounds
                    tmpVal = cMatrix(i, j, :);
                    tmpVal = tmpVal(:);
                    subplot(nSounds + 1,1,j);
                    plot(tmpVal);
                    title([num2str(soundsets(i,j)) ' - on : ' num2str(onsets(i,j))]);
                end
                tmpVal = addMatrix(i,1,:);
                tmpVal = tmpVal(:);
                tmpVal(isnan(tmpVal)) = min(tmpVal);
                subplot(nSounds + 1, 1, nSounds + 1);
                plot(tmpVal);
                title(this.featureName);
                saveas(figH, ['debug/addition_' this.featureName '_' time '_' num2str(i) '.jpg'], 'jpg');
            end
        end
        
        %
        % Function for debuging comparison plot verification
        %
        function debugPlotComparison(this, str2, soundsetMat, temporalCriteria)
            time = datestr(rem(now, 1));
            scrsz = get(0,'ScreenSize');
            for i = 1:size(soundsetMat, 1)
                str1 = soundsetMat(i, :);
                figH = figure(1);
                set(figH,'OuterPosition',[scrsz(1),scrsz(2),1024,768]);
                subplot(2,1,1);
                plot(str1);
                subplot(2,1,2);
                plot(str2);
                title(['DISTANCE : ' num2str(temporalCriteria(i))]);
                saveas(figH, ['debug/comparison_' this.featureName '_' time '_' num2str(i) '.jpg'], 'jpg');
            end
        end
        
        %
        % Function for debuging mean addition
        %
        function outputMeanAddition(this, descriptor, sFeatures)
            time = datestr(rem(now, 1));
            file = ['debug/addition_' this.featureName '_' time '.txt'];
            fid = fopen(file, 'w');
            for i = 1:size(descriptor, 1)
                cInd = sprintf('%f ', descriptor(i, :));
                cMix = sFeatures(i);
                fprintf(fid,'%s \n => %f \n', cInd, cMix);
            end
            fclose(fid);
        end
        
        %
        % Function for debuging mean comparison 
        %
        function outputMeanComparison(this, sFeatures, tFeatures, fDistance)
            time = datestr(rem(now, 1));
            file = ['debug/comparison_' this.featureName '_' time '.txt'];
            fid = fopen(file, 'w');
            fprintf(fid, 'Target : %f \n', tFeatures(:));
            for i = 1:length(fDistance)
                fprintf(fid, ' - %f => %f \n', sFeatures(i), fDistance(i));
            end
            fclose(fid);
        end
       
    end
end 
