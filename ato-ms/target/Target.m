%
% Target.m          : Abstract interface for target definition.
%
% This class is the superclass for any kind of target definition. Therefore
% some methods are defined as abstract.
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef Target < handle
    
    properties (SetAccess = protected, GetAccess = protected)
        harmonicFilters          % Set of (optional) harmonic filters
        spectralFeatures         % Set of symbolic parameters
        symbolicFeatures         % Set of spectral features 
        analysisParameters       % Parameters of spectral analysis
        sSession                 % Session object
    end
    
    properties (GetAccess = public)
        isComputed               % Flag for computation of the target
    end
    
    methods (Abstract)
       
        %
        % Launch computation of the target features
        %
        success = computeFeatures(this)
       
        %
        % Modify the value of a target feature
        %
        modifyFeature(this, fName, fValue)
       
        %
        % Add a specfic feature to the target
        %
        addFeature(this, fName, fValue)
       
        %
        % Retrieve the value of a specific feature
        %
        feature = getFeature(this, fName)
        
        %
        % Retrieve the names of all features 
        %
        featLis = getFeaturesNames(this)
        
        %
        % Retrieve the names of all features 
        %
        featLis = getFeaturesList(this)
       
        %
        % Set parameters for the features analysis
        %
        success = setAnalysisParameter(this, paramName, paramValue)
       
    end
   
    methods
        
        function tI = Target(sessionObj)
            tI.isComputed = 0;
            tI.sSession = sessionObj;
            tI.analysisParameters = struct;
            tI.harmonicFilters = [];
        end
        
        function params = getTargetParameters(this)
            params = this.analysisParameters;
        end
        
        function emptyHarmonicFilters(this)
            this.harmonicFilters = [];
        end
        
        function [filters cFilter] = getHarmonicFilters(this)
            if isfield(this.spectralFeatures, 'PartialsFrequency')
                result = this.spectralFeatures.PartialsFrequency;
                resolution = this.sSession.getProduction().microtonicResolution;
                this.harmonicFilters = cell(size(result, 2) * 2, size(result, 1));
                for i = 1:size(result, 2)
                    mtmidi = round(hz2midi(result(:, i))*resolution)/resolution;
                    finalNoteValues = midi2mtnotes(mtmidi);
                    this.harmonicFilters((2 * (i - 1)) + 1, 1:length(finalNoteValues)) = finalNoteValues;
                    this.harmonicFilters((2 * i), 1:length(finalNoteValues)) = finalNoteValues;
                end
                this.harmonicFilters(cellfun(@isempty,this.harmonicFilters)) = {''};
            end
            filters = this.harmonicFilters;
            cFilter = unique(this.harmonicFilters);
        end
        
	end
   
end 
