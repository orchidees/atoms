%
% Individual.m      : Class definition for an individual
%
% An individual is a single component of a solution. It defines all
% properties of an instrument or synthesizer with every possible attribute
% that will modify its rendering.
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef Individual < handle

    properties (GetAccess = public, SetAccess = private)
        sSession                % Current orchestration session
        sInstrument             % Index of the related instrument
        originalFeatures        % Original features value (unshifted)
        finalFeatures           % Shifted features values
        symbolicFeatures        % Symbolic features of individual
        isComputed              % Does the features have been computed ?
        isFilled                % Does the features have been filled ?
        sOnset                  % Onset value for individual
    end

    methods
       
        %
        % Main constructor for an individual object
        %
        function sI = Individual(sessObj, id, maxOn)
            if nargin > 0
                sI.sSession = sessObj;
                sI.sInstrument = id;
                sI.sOnset = maxOn;
                sI.originalFeatures = struct;
                sI.finalFeatures = struct;
                sI.symbolicFeatures = struct;
            else
                sI.sOnset = 0;
                sI.sInstrument = 0;
            end
            sI.isFilled = 0;
            sI.isComputed = 0;
        end
        
        %
        % Set the current instrument
        %
        function setInstrument(this, idInstru)
            this.sInstrument = idInstru;
        end
        
        %
        % Set the current onset
        %
        function setOnset(this, onset)
            this.sOnset = onset;
        end
        
        %
        % Set the current session
        %
        function setSession(this, sessObj)
            this.sSession = sessObj;
            this.originalFeatures = struct;
            this.finalFeatures = struct;
            this.symbolicFeatures = struct;
        end
        
        %
        % Compute the final version of the features
        %
        function computeFinalFeatures(this)
            if this.isComputed
                return;
            end
            this.finalFeatures = struct;
            featureNames = fieldnames(this.originalFeatures);
            for i = 1:length(featureNames)
                curName = featureNames{i};
                curFeat = this.originalFeatures.(curName);
                nbTimePts = size(curFeat, 2);
                if (nbTimePts == 1 && ~iscell(curFeat))
                    this.finalFeatures.(curName) = curFeat;
                else
                    if (size(curFeat, 1) == 1)
                        idShifter = mod((0:(nbTimePts - 1)) - this.sOnset, nbTimePts) + 1;
                        if (this.sOnset > 0)
                            curFeat((129 - this.sOnset):end) = 0;
                        end
                        this.finalFeatures.(curName) = curFeat(idShifter);
                    else
                        idShifter = mod((0:(nbTimePts - 1)) - this.sOnset, nbTimePts) + 1;
                        %tmpFeats = zeros(size(curFeat, 1), size(curFeat, 2));
                        %for j = 1:size(curFeat, 1)
                        %    curSubFeat = curFeat(j, :);
                        %    tmpFeats(j, :) = curSubFeat(idShifter);
                        %end
                        this.finalFeatures.(curName) = curFeat(:, idShifter);
                    end
                end
            end
            this.isComputed = 1;
        end
        
        %
        % Set one of the feature from knowledge
        %
        function setFeature(this, fName, fValue)
            this.originalFeatures.(fName) = fValue;
            this.isFilled = 1;
            this.isComputed = 0;
        end
        
        %
        % Set the original features drawn from knowledge
        %
        function setFeatures(this, featSet)
            this.originalFeatures = featSet;
            this.isFilled = 1;
            this.isComputed = 0;
        end
        
        %
        % Set this individual as computed and shifted
        %
        function setComputed(this)
            this.isFilled = 1;
            this.isComputed = 1;
        end
        
        %
        % Get one feature from the final set
        %
        function oFeat = getFeature(this, fName)
            oFeat = this.finalFeatures.(fName);
        end
        
        %
        % Get the original unmodified features
        %
        function oFeat = getOriginalFeatures(this)
            oFeat = this.originalFeatures;
        end
        
        %
        % Get the set of symbolic features
        %
        function sFeat = getSymbolicFeatures(this)
            sFeat = this.symbolicFeatures;
        end
        
        %
        % Debug function for individuals
        %
        function dumpIndividuals(this, filename, id)
            filename = [filename '_Individual_' num2str(id) '_' num2str(this.sInstrument)];
            fNames = fieldnames(this.finalFeatures);
            for i = 1:length(fNames)
                str1 = this.finalFeatures.(fNames{i});
                if (size(str1, 2) < 2)
                    continue;
                end
                figH = figure(1);
                set(figH,'OuterPosition',[0,0,1024,768]);
                plot(str1);
                title(['Onset : ' num2str(this.sOnset)]);
                saveas(figH, [filename '_' fNames{i} '.jpg'], 'jpg');
            end
        end
       
    end
end 
