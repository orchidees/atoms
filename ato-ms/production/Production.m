%
% Production.m      : Abstract interface for defining a production mean
%
% This class allows to define an abstract production
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef Production < handle
    
    properties (SetAccess = protected, GetAccess = public)
        variableTable               % Full table of variable domains
        variableIndividuals         % Table of all allowed individuals
        variableDomains             % Domains of allowed variable
        filteredOnsets              % Table of onset depending on harmonics
        maxOnsetValues              % Maximum value of instrument onset
        attributeDomains            % Domains of allowed attributes
        allowedInstruments          % Instruments used for production
        microtonicResolution        % Microtonic production resolution
        harmonicFiltering           % Flag for harmonic filtering
        allowedResolutions          % List of allowed resolutions
        filtersSet                  % Set of available filters
        isInited                    % Flag for server mode
        sSession                    % Current session
    end

    methods (Abstract)
       
        %
        % Initializing the knowledge source
        %
        initialize(this)
       
        %
        % Set the list of allowed instruments
        %
        setInstruments(this, instList)
        
        %
        % Retrieving the instruments order for score export
        %
        scoreOrder = getScoreOrder(this)
        
        %
        % Nomenclature of the given production mode
        %
        nomenclature(this)
       
    end
    
    methods
        
        %
        % Main constructor for production
        %
        function pI = Production(sessObj, instrus, resolution)
            pI.variableTable = [];
            pI.variableDomains = [];
            pI.attributeDomains = [];
            pI.maxOnsetValues = [];
            pI.filteredOnsets = [];
            pI.filtersSet = [];
            pI.allowedInstruments = instrus;
            pI.microtonicResolution = resolution;
            pI.allowedResolutions = [1 2 4 8];
            pI.harmonicFiltering = 1;
            pI.sSession = sessObj;
            pI.isInited = 0;
        end
        
        %
        % Retrieve the list of allowed instruments
        %
        function instru = getInstruments(this)
            instru = this.allowedInstruments;
        end
        
        %
        % Retrieve the current resolution
        %
        function resol = getResolution(this)
            resol = this.microtonicResolution;
        end
        
        %
        % Retrieve the maximal onsets
        %
        function mOn = getMaxOnsetValues(this)
            mOn = this.maxOnsetValues;
        end
        
        %
        % Retrieve the harmonic filtered onset values
        %
        function mOn = getFilteredOnsets(this)
            mOn = this.filteredOnsets;
        end
        
        %
        % Empty all domains
        %
        function emptyVariableDomains(this)
            this.variableDomains = [];
            this.variableTable = [];
            this.variableIndividuals = [];
        end
        
        %
        % Retrieve organized variable domains
        %
        function domains = getVariableDomains(this)
            if isempty(this.variableDomains) || this.isInited == 0;
                this.computeVariableDomains();
            end
            domains = this.variableDomains;
        end
        
        %
        % Get the variable table
        %
        function varTable = getVariableTable(this)
            if isempty(this.variableTable) || this.isInited == 0;
                this.computeVariableDomains();
            end
            varTable = this.variableTable;
        end
        
        %
        % Get the variable individuals
        %
        function varInd = getVariableIndividuals(this)
            if isempty(this.variableIndividuals) || this.isInited == 0
                this.computeVariableDomains();
            end
            varInd = this.variableIndividuals;
        end
        
        function needInit(this)
            this.isInited = 0;
        end
        
        %
        % Set activation of harmonic filtering
        %
        function setHarmonicFiltering(this, hFilt)
            this.harmonicFiltering = hFilt;
        end
        
        %
        % Modify the microtonic resolution of production
        %
        function setResolution(this, resolution)
            % Check the validity of the new resolution value
            if ~ismember(resolution, this.allowedResolutions)
                error('Production:setResolution:BadResolution', [ 'Allowed values for microtonic resolution: ' mat2str(this.allowedResolutions) ' (fractions of semitones).']);
            end
            this.microtonicResolution = resolution;
        end
        
        %
        % Create the set of empty filters and compute their original values
        %
        function constructBaseFilters(this)
            if ~isempty(this.filtersSet)
                return;
            end
            knowledge = getKnowledge(this.sSession);
            this.attributeDomains = getAttributeDomains(knowledge);
            [fields types] = getFieldsList(knowledge);
            this.filtersSet = struct;
            for i = 1:length(fields)
                switch types{i}
                    case 'Symbolic'
                        if ~isfield(this.attributeDomains, fields{i})
                            continue;
                        end
                        nFilter = FiltersSymbolic(this.sSession, types{i});
                        nFilter.setValuesList(unique(this.attributeDomains.(fields{i})));
                        nFilter.setMode('bypass');
                    case 'Float'
                        if ~isfield(this.attributeDomains, fields{i})
                            continue;
                        end
                        nFilter = FiltersSpectral(this.sSession, types{i});
                        nFilter.setValuesRange(cell2mat(this.attributeDomains.(fields{i})));
                        nFilter.setMode('bypass');
                    case 'Complex'
                        nFilter = FiltersTemporal(this.sSession, types{i});
                        nFilter.setMode('bypass');
                    otherwise
                        continue;
                end
                this.filtersSet.(fields{i}) = nFilter;
            end
        end
        
        % Compute possible values for every instruments group
        function computeVariableDomains(this)
            knowledge = getKnowledge(this.sSession);
            handles = getHandles(this.sSession);
            if isempty(this.filtersSet)
                this.constructBaseFilters();
            end
            this.variableTable = [];
            ntrElem = (knowledge.getNeutralID() - 1) * this.microtonicResolution + 1;
            % Get filter names
            filters = fieldnames(this.filtersSet);
            % Initialize output
            this.variableDomains = cell(1,length(this.allowedInstruments));
            queries = cell(length(filters) * 3, 1);
            % Iterate on instruments (or instrument groups)
            for k = 1:length(this.allowedInstruments)
                server_says(handles, 'Preparing search spaces.', k / length(this.allowedInstruments));
                domain = [];
                instruments = this.allowedInstruments{k};
                % Add all instrument (or instrument group) sounds to domain
                % Iterate on filters
                for j = 1:length(filters)
                    switch filters{j}
                        case 'instrument'
                            if iscell(instruments)
                                instr_allowed = regexprep(sprintf('%s ', instruments{:}), ' +', '/');
                            else
                                instr_allowed = instruments;
                            end
                                queries{3 * (j - 1) + 1} = 'instrument';
                                queries{3 * (j - 1) + 2} = 'in';
                                queries{3 * j} = instr_allowed;
                        case 'note'
                            % Do nothing: the 'note' filter is separatedly
                                queries{3 * (j - 1) + 1} = 'note';
                                queries{3 * (j - 1) + 2} = 'regexp';
                                if (this.harmonicFiltering)
                                    [dC, hFilter] = this.sSession.getTarget().getHarmonicFilters();
                                    queries{3 * j} = regexprep(sprintf('%s ', hFilter{2:end}), ' +', '/');
                                else
                                    valList = this.filtersSet.note.apply();
                                    queries{3 * j} = regexprep(sprintf('%s ', valList{:}), ' +', '/');
                                end
                        otherwise
                            if strcmp(this.filtersSet.(filters{j}).fMode, 'bypass')
                                continue;
                            end
                            if isa(this.filtersSet.(filters{j}), 'FiltersSymbolic')
                                % Query knowledge for matching items and reduce the variable domain
                                queries{3 * (j - 1) + 1} = filters{j};
                                queries{3 * (j - 1) + 2} = 'in';
                                valList = this.filtersSet.(filters{j}).apply();
                                queries{3 * j} = regexprep(sprintf('%s ', valList{:}), ' +', '/');
                            end
                            if isa(this.filtersSet.(filters{j}), 'FiltersSpectral')
                                queries{3 * (j - 1) + 1} = filters{j};
                                queries{3 * (j - 1) + 2} = this.filtersSet.(filters{j}).fMode;
                                queries{3 * j} = this.filtersSet.(filters{j}).apply();
                            end
                                
                    end
                end
                % Query knowledge for matching items
                domain = cell2mat(knowledge.query(queries));
                % ADD-ON : Add microtonic pitches to variable domain
                % Add neutral element
                domain = [ domain ; ntrElem ];
                % Add domain to structure
                this.variableDomains{k} = domain;
                this.variableTable = [this.variableTable ; domain];
            end
            % Final variable table
            this.variableTable = sort(unique(this.variableTable(:)));
            if (isempty(this.variableTable))
                error('Production:emptySearchSpace', 'Search space is empty ! Check filters and orchestra.');
            end
            server_says(handles, 'Evaluating search sub-spaces.', 0);
            % Retrieve the duration of features to know the max onset value
            feats = this.sSession.getKnowledge().getFieldsValues({'duration', 'note'}, this.variableTable);
            server_says(handles, 'Evaluating search sub-spaces.', 0.1);
            % Obtain the durations
            durationFeatures = feats(:, 1);
            % Obtain the related notes
            noteFeatures = feats(:, 2);
            % Obtain related notes
            % Retrieving duration of the target for relative onsets
            targetDuration = this.sSession.getTarget().getFeaturesList().duration;
            % Constructing array of individuals
            tmpArray(length(this.variableTable)) = Individual(this.sSession, this.variableTable(end), 0);
            this.variableIndividuals = tmpArray;
            % Constructing array of maximal onsets
            this.maxOnsetValues = zeros(length(this.variableTable), 1);
            this.filteredOnsets = cell(length(this.variableTable), 1);
            if this.harmonicFiltering
                hmFilters = this.sSession.getTarget().getHarmonicFilters;
                hmNotes = unique(hmFilters);
                hmNotes = hmNotes(2:end);
                hmOnsets = struct;
                for i = 1:length(hmNotes)
                    membNotes = ismember(hmFilters, hmNotes{i});
                    hmOnsets.(regexprep(hmNotes{i}, '#', 'd')) = mod(find(membNotes ~= 0), size(hmFilters, 1));
                end
            end
            nbSteps = floor((cell2mat(durationFeatures) / targetDuration) * 128) + 1;
            this.maxOnsetValues = max(0, 128 - nbSteps);
            this.maxOnsetValues(end + 1) = 0;
            for i = 1:(length(this.variableTable) - 1)
                if mod(i, 100) == 0
                    server_says(handles, 'Evaluating search sub-spaces.', 0.1 + (i / (length(this.variableTable) * 1.1)));
                end
                if this.harmonicFiltering
                    instNotes = regexp(regexprep(noteFeatures{i}, '#', 'd'), ',', 'split');
                    tmpArray = [];
                    for j = 1:length(instNotes)
                        curNote = instNotes{j};
                        if isfield(hmOnsets, curNote)
                            tmpArray = [tmpArray ; hmOnsets.(curNote)];
                        end
                    end
                    this.filteredOnsets{i} = tmpArray;
                else
                    this.filteredOnsets{i} = (0:(this.maxOnsetValues(i)))';
                end
                %this.variableIndividuals(i) = Individual(this.sSession, this.variableTable(i), 0);
                %setSession(this.variableIndividuals(i), this.sSession);
                %setInstrument(this.variableIndividuals(i), this.variableTable(i));
            end
            server_says(handles, 'Evaluating search sub-spaces.', 1.0);
            % Computing neutral element values
            neutralInd = this.variableIndividuals(length(this.variableTable));
            % Retrieve the optimization features
            optFeatures = this.sSession.getFeatures();
            % Retrieving each neutral value
            for i = 1:length(optFeatures)
                fName = optFeatures{i}.getFeatureName();
                fValue = optFeatures{i}.neutral();
                neutralInd.setFeature(fName, fValue);
            end
            % Adding the neutral generic features
            neutralInd.setFeature('duration', 0);
            neutralInd.setFeature('EnergyEnvelope', zeros(1, 128));
            neutralInd.setFeature('EnergyEnvelopeMean', 0);
            neutralInd.setFeature('SpectralCentroid', zeros(1, 128));
            neutralInd.setFeature('SpectralCentroidMean', 0);
            neutralInd.setFeature('PartialsFrequency', zeros(25, 64));
            neutralInd.setFeature('PartialsMeanEnergy', 0);
            neutralInd.setFeature('PartialsEnergy', zeros(1, 64));
            this.maxOnsetValues(end) = 0;
            neutralInd.setComputed();
            this.isInited = 1;
        end
        
        %
        % Fill the feature structure given a set of indexes
        %
        function [uInds idSet] = updateIndividualFeatures(this, idSet)
            % Sorting ids and keeping uniques
            idSet = sort(unique(idSet(:)));
            % Result array of individuals
            % uInds(length(idSet), 1) = Individual;
            % Individuals which need update
            needUpdate = zeros(length(idSet), 1);
            updateIDs = zeros(length(idSet), 1);
            % Retrieving features
            targetFeatures = this.sSession.getTarget().getFeaturesList();
            compFeatures = this.sSession.getTotalFeaturesList();
            targetDuration = targetFeatures.duration;
            % Checking which individuals need update
            [~, curID] = ismember(idSet, this.variableTable);
            uInds = this.variableIndividuals(curID);
            for i = 1:length(idSet)
                %curID = find(this.variableTable == idSet(i));
                %tmpIndiv = this.variableIndividuals(curID(1));
                %uInds(i) = tmpIndiv;
                if this.variableIndividuals(curID(i)).isFilled == 0;
                    needUpdate(i) = idSet(i);
                    updateIDs(i) = curID(i);
                end
            end
            if sum(needUpdate) == 0
                return;
            end
            needUpdate = needUpdate(needUpdate > 0);
            updateIDs = updateIDs(updateIDs > 0);
            [aField aTypes] = this.sSession.getKnowledge().getFieldsList();
            [~, fId] = ismember(compFeatures, aField);
            % Retrieve the whole set of features for the allowed instruments
            [feature_tmp features] = getDescriptorMultipleFinal(this.sSession.getKnowledge().connecDB, compFeatures, needUpdate, aTypes(fId));
            [~, idDuration] = ismember('duration', features);
            for j = 1:length(updateIDs)
                curIndividual = this.variableIndividuals(updateIDs(j));
                curDuration = feature_tmp{idDuration(1)}{j};
                for i = 1:length(features)
                    if (size(feature_tmp{i}{j}, 2) > 1)
                        if (size(feature_tmp{i}{j}, 1) == 1)
                            curSeries = feature_tmp{i}{j};
                            curSeries(isnan(curSeries)) = 0;
                            curSeries(isinf(curSeries)) = 0;
                            nbSteps = floor((curDuration / targetDuration) * 128) + 1;
                            curSeries = resample(curSeries, nbSteps, 128, 0);
                            if (curDuration >= targetDuration || length(curSeries) > 128)
                                curSeries = curSeries(1:128);
                            else
                                curSeries = [curSeries zeros(1, 128 - nbSteps)];
                            end
                            curIndividual.setFeature(features{i}, curSeries);
                        else
                            curArray = feature_tmp{i}{j};
                            dimArray = size(curArray, 1);
                            originalSteps = size(curArray, 2);
                            nbSteps = floor((curDuration / targetDuration) * originalSteps) + 1;
                            arrayFeatures = resample(curArray', nbSteps, originalSteps, 0)';
                            if (curDuration >= targetDuration || size(arrayFeatures, 2) > originalSteps)
                                arrayFeatures = arrayFeatures(:, 1:originalSteps);
                            else
                                arrayFeatures = [arrayFeatures zeros(dimArray, originalSteps - nbSteps)];
                            end
                            curIndividual.setFeature(features{i}, arrayFeatures);
                        end
                    else
                        curIndividual.setFeature(features{i}, feature_tmp{i}{j});
                    end
                end
            end
        end
        
    end
    
end 
