%
% Population.m      : Class definition for a population of solutions
%
% The population object encapsulates a whole set of solutions. It allows to
% perform group-based operations as well as modifications and verifications
% of structures.
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef Population < handle

    properties (GetAccess = public, SetAccess = private)
        sSession             % Current orchestration session
        criteriaSet          % Set of criteria for optimization objectives
        featuresSet          % Set of features for the solutions
        solutionSet          % Set of found solutions
        solutionIDs          % Array of instrument ID
    end

    methods
       
        %
        % Main constructor for the population object
        %
        function sP = Population(sessObj)
            if nargin > 0
                sP.sSession = sessObj;
                sP.solutionSet = [];
                sP.criteriaSet = [];
                sP.featuresSet = [];
                sP.solutionIDs = [];
            end
        end
        
        function setSession(this, sessObj)
            this.sSession = sessObj;
        end
       
        %
        % Retrieve the number of solutions in the population
        %
        function nSolutions = getNbSolutions(this)
            nSolutions = length(this.solutionSet);
        end
       
        %
        % Retrieve the current solution set
        %
        function solutions = getSolutions(this)
            solutions = this.solutionSet;
        end
       
        %
        % Retrieve the criteria set for current solutions
        %
        function solutions = getCriteria(this)
            solutions = this.criteriaSet;
        end
        
        %
        % Set the solutions contained in the population
        %
        function setSolutions(this, solSet)
            this.solutionSet = solSet;
        end
        
        %
        % Set the optimization criteria
        %
        function setCriteria(this, critSet)
            this.criteriaSet = critSet;
        end
        
        function setFeatures(this, fSet)
            this.featuresSet = fSet;
        end
        
        %
        % Set the solutions ID array
        %
        function setSolutionID(this, idSet)
            this.solutionIDs = idSet;
        end
        
        %
        % Extract a population given a set of indices
        %
        function newPop = extractPopulation(this, loc)
            t = Population();
            setSession(t, this.sSession);
            setSolutions(t, this.solutionSet(loc));
            setSolutionID(t, this.solutionIDs(loc, :));
            setCriteria(t, this.criteriaSet(loc, :));
            tmpFeatures = struct;
            fNames = fieldnames(this.featuresSet);
            for i = 1:length(fNames)
                curFeat = this.featuresSet.(fNames{i});
                tmpFeatures.(fNames{i}) = curFeat(loc, :);
            end
            setFeatures(t, tmpFeatures);
            newPop = t;
        end
        
        %
        % Combine this population with another population
        %
        function combinePopulations(this, newPop)
            this.solutionSet((end + 1):(end + length(newPop.solutionSet))) = newPop.solutionSet;
            this.solutionIDs = [this.solutionIDs ; newPop.solutionIDs];
            this.criteriaSet = [this.criteriaSet ; newPop.criteriaSet];
            fNames = fieldnames(this.featuresSet);
            for i = 1:length(fNames)
                this.featuresSet.(fNames{i}) = [this.featuresSet.(fNames{i}) ; newPop.featuresSet.(fNames{i})];
            end
        end
       
        %
        % Retrieve the features of the solution set
        %
        function solutions = getFeatures(this)
            solutions = this.featuresSet;
        end
        
        %
        % Draw a random population where each line is an individual and 
        % each column an instrument od the orchestra.
        %
        function generateRandomPopulation(this, popsize)
            variableDomains = getVariableDomains(getProduction(this.sSession));
            % Get neutral element
            ntrElem = max(variableDomains{1});
            % Define sparsity level
            sparsity = 0.2;
            dSize = zeros(1, length(variableDomains));
            % Get size of each variable domain
            for k = 1:length(variableDomains)
                dSize(1,k) = length(variableDomains{k});
            end
            % Decrement dsize of 1 to account for neutral element
            dSize = dSize - 1;
            % Check that search space is not empty
            if max(dSize) == 0
                error('Population:generateRandomPopulation:ImpossibleOperation', 'Search space is empty !');
            end
            % Draw random indices within dsize range
            dSize = repmat(dSize, popsize, 1);
            tmpInstru = ceil(rand(popsize, length(variableDomains)) .* dSize);
            tmpInstru(tmpInstru == 0) = 1;
            % Replace indices by actual variable values
            for k = 1:length(variableDomains)
                thisDomain = variableDomains{k};
                tmpInstru(:,k) = thisDomain(tmpInstru(:,k));
            end
            % Introduce neutral elements in population
            nElements = numel(tmpInstru);
            I = randsample(nElements, round(nElements * sparsity));
            tmpInstru(I) = ntrElem;
            this.solutionIDs = tmpInstru;
        end
        
        %
        % Draw a random population where each line is an individual and 
        % each column an instrument od the orchestra.
        %
        function generateConstrainedPopulation(this, popsize, proposals, onsets)
            variableDomains = getVariableDomains(getProduction(this.sSession));
            % Get neutral element
            ntrElem = max(variableDomains{1});
            % Preparing production for onsets and features
            production = getProduction(this.sSession);
            filteredOnsets = getFilteredOnsets(production);
            variableTable = getVariableTable(production);
            maxOnsets = getMaxOnsetValues(production);
            % Define constrained level
            constrained = 0.6;
            % Define sparsity level
            sparsity = 0.15;
            dSize = zeros(1, length(variableDomains));
            % Get size of each variable domain
            for k = 1:length(variableDomains)
                dSize(1,k) = length(variableDomains{k});
            end
            % Decrement dsize of 1 to account for neutral element
            dSize = dSize - 1;
            % Check that search space is not empty
            if max(dSize) == 0
                error('Population:generateRandomPopulation:ImpossibleOperation', 'Search space is empty !');
            end
            % Draw random indices within dsize range
            dSize = repmat(dSize, popsize, 1);
            tmpInstru = ceil(rand(popsize, length(variableDomains)) .* dSize);
            tmpOnsets = zeros(popsize, length(variableDomains));
            tmpInstru(tmpInstru == 0) = 1;
            % Replace indices by actual variable values
            for k = 1:length(variableDomains)
                thisDomain = variableDomains{k};
                tmpInstru(:,k) = thisDomain(tmpInstru(:,k));
                % Now introduce our constrained 
                nElems = numel(tmpInstru(:, k));
                if ~isempty(proposals{k})
                    consDomain = proposals{k};
                    cEL = randsample(nElems, round(nElems * constrained));
                    cChoice = randsample(size(consDomain, 2), round(nElems * constrained), true);
                    tmpInstru(cEL, k) = consDomain(1, cChoice);
                    tmpOnsets(cEL, k) = consDomain(2, cChoice);
                end
            end
            % Introduce neutral elements in population
            nElements = numel(tmpInstru);
            I = randsample(nElements, round(nElements * sparsity));
            tmpInstru(I) = ntrElem;
            this.solutionIDs = tmpInstru;
            [uInds idSet] = updateIndividualFeatures(production, this.solutionIDs);
            if isempty(this.solutionSet)
                tmpSolutionSet(size(this.solutionIDs, 1)) = Solution(this.sSession, length(variableDomains));
                for i = 1:size(this.solutionIDs, 1)
                    setSession(tmpSolutionSet(i), this.sSession);
                    setSize(tmpSolutionSet(i), length(variableDomains));
                    for j = 1:length(variableDomains)
                        index = find(variableTable == this.solutionIDs(i, j));
                        if (tmpOnsets(i, j) == 0)
                            onProp = [onsets ; filteredOnsets{index(1)}];
                            if isempty(onProp)
                                onProp = floor(rand .* maxOnsets(index(1)));
                            end
                            tmpOnset = onProp(ceil(rand .* length(onProp)));
                        else
                            tmpOnset = tmpOnsets(i, j);
                        end
                        newIndiv = Individual(this.sSession, this.solutionIDs(i, j), tmpOnset);
                        setFeatures(newIndiv, uInds(idSet == this.solutionIDs(i, j)).originalFeatures);
                        computeFinalFeatures(newIndiv);
                        setIndividual(tmpSolutionSet(i), newIndiv, j, this.solutionIDs(i, j));
                    end
                end
                this.solutionSet = tmpSolutionSet;
            else
                for i = 1:size(this.solutionIDs, 1)
                    curSol = this.solutionSet(i);
                    for j = 1:length(variableDomains)
                        curIndiv = curSol.individualsSet(j);
                        if (curIndiv.isComputed == 1)
                            continue;
                        end
                        index = find(variableTable == this.solutionIDs(i, j));
                        onProp = filteredOnsets{index(1)};
                        if isempty(onProp)
                            onProp = floor(rand .* maxOnsets(index(1)));
                        end
                        tmpOnset = onProp(ceil(rand .* length(onProp)));
                        newIndiv = Individual(this.sSession, this.solutionIDs(i, j), tmpOnset);
                        setFeatures(newIndiv, uInds(idSet == this.solutionIDs(i, j)).originalFeatures);
                        computeFinalFeatures(newIndiv);
                        setIndividual(curSol, newIndiv, j, this.solutionIDs(i, j));
                    end
                end
            end
        end
        
        %
        % Update the current features of the population
        %
        function updatePopulationFeatures(this)
            production = getProduction(this.sSession);
            variableTable = getVariableTable(production);
            variableDomains = getVariableDomains(production);
            filteredOnsets = getFilteredOnsets(production);
            [uInds idSet] = updateIndividualFeatures(production, this.solutionIDs);
            if isempty(this.solutionSet)
                tmpSolutionSet(size(this.solutionIDs, 1)) = Solution(this.sSession, length(variableDomains));
                for i = 1:size(this.solutionIDs, 1)
                    setSession(tmpSolutionSet(i), this.sSession);
                    setSize(tmpSolutionSet(i), length(variableDomains));
                    for j = 1:length(variableDomains)
                        index = find(variableTable == this.solutionIDs(i, j));
                        onsetsVals = filteredOnsets{index(1)};
                        if ~isempty(onsetsVals)
                            tmpOnset = onsetsVals(floor((rand .* length(onsetsVals)) + 1));
                        else
                            tmpOnset = 1;
                        end
                        newIndiv = Individual(this.sSession, this.solutionIDs(i, j), tmpOnset);
                        setFeatures(newIndiv, uInds(idSet == this.solutionIDs(i, j)).originalFeatures);
                        computeFinalFeatures(newIndiv);
                        setIndividual(tmpSolutionSet(i), newIndiv, j, this.solutionIDs(i, j));
                    end
                end
                this.solutionSet = tmpSolutionSet;
            else
                for i = 1:size(this.solutionIDs, 1)
                    curSol = this.solutionSet(i);
                    for j = 1:length(variableDomains)
                        curIndiv = curSol.individualsSet(j);
                        if (curIndiv.isComputed == 1)
                            continue;
                        end
                        index = find(variableTable == this.solutionIDs(i, j));
                        if curIndiv.sOnset == 0
                            onsetsVals = filteredOnsets{index(1)};
                            if ~isempty(onsetsVals)
                                tmpOnset = onsetsVals(floor((rand .* length(onsetsVals)) + 1));
                            else
                                tmpOnset = 0;
                            end
                        else
                            tmpOnset = curIndiv.sOnset;
                        end
                        newIndiv = Individual(this.sSession, this.solutionIDs(i, j), tmpOnset);
                        setFeatures(newIndiv, uInds(idSet == this.solutionIDs(i, j)).originalFeatures);
                        computeFinalFeatures(newIndiv);
                        setIndividual(curSol, newIndiv, j, this.solutionIDs(i, j));
                    end
                end
            end
        end
       
        %
        % Remove from population every individual for which at least one
        % criterion as a NaN value.
        %
        function discardNaN(this)
            critr_nan = max(isnan(this.criteriaSet),[],2);
            critr_ok = find(~critr_nan);
            this.criteriaSet = this.criteriaSet(critr_ok,:);
            this.solutionIDs = this.solutionIDs(critr_ok,:);
            this.solutionSet = this.solutionSet(critr_ok);
        end
        
        function checkupPopulation(this)
            disp('Population :');
            for i = 1:length(this.solutionSet)
                strTmp = 'P : ';
                for j = 1:size(this.solutionIDs, 2)
                    strTmp = [strTmp num2str(this.solutionIDs(i, j)) ' '];
                end
                disp(strTmp);
                strTmp = 'S : ';
                for j = 1:length(this.solutionSet(i).individualsID)
                    strTmp = [strTmp num2str(this.solutionSet(i).individualsID(j)) ' '];
                end
                disp(strTmp);
                strTmp = 'I : ';
                for j = 1:length(this.solutionSet(i).individualsSet)
                    strTmp = [strTmp num2str(this.solutionSet(i).individualsSet(j).sInstrument) ' '];
                end
                disp(strTmp);
            end
        end
        
        %
        % Adaptive optimization of the population
        %
        function newPop = adaptiveOptimization(this)
            t = Population(this.sSession);
            % Get the target features
            targetFeatures = getFeaturesList(getTarget(this.sSession));
            % Retrieve the domains in which instruments can be chosen
            sProduction = getProduction(this.sSession);
            variableDomains = getVariableDomains(sProduction);
            % Retrieve the variable table of indexes
            variableTable = getVariableTable(sProduction);
            % Retrieve the list of optimization features
            optFeatures = getFeatures(this.sSession);
            targetDuration = this.sSession.getTarget().getFeature('duration');
            newSolutions = [];
            newSolutionIDs = [];
            for i = 1:length(optFeatures)
                curFName = optFeatures{i}.getFeatureName();
                curFeature = targetFeatures.(curFName);
                if (length(curFeature) > 1 && ~(size(curFeature, 2) > 1) && ~strcmp(curFName, 'PartialsMeanAmplitude'))
                    curFeat = this.featuresSet.(curFName);
                    curFeature = (curFeature - mean(curFeature)) ./ std(curFeature);
                    indexDesc = constructIndexesFromDB(this.sSession.getKnowledge(), curFName);
                    for k = 1:length(this.solutionSet);
                        curFeat(1:5) = repmat(curFeat(5), 5, 1);
                        tmpFeat = (curFeat(k, :) - mean(curFeat(k, :))) ./ std(curFeat(k, :));
                        %tmpFeat = curFeat(k, :);
                        modifCurve = resample(curFeature - tmpFeat', 1, 8);
                        %modifCurve = filter([1 1], 1, modifCurve) ./ 2;
                        [resultSegments tmpOn] = tsMultiLevelSegment(modifCurve, 8);
                        for j = 1:length(resultSegments)
                            server_says(this.sSession.getHandles(), ['Performing segmentation on ' optFeatures{i}.getFeatureName()], j / size(resultSegments, 1));
                            sDuration = ((targetDuration) * (length(resultSegments{j}) / 128));
                            results = indexDesc.approximateQueryConstrained(resultSegments{j}, variableTable, 5, sDuration);
                            for inst = 1:size(this.solutionIDs, 2)
                                tmpProposals = intersect(results, variableDomains{inst});
                                if ~isempty(tmpProposals)
                                    %selectedProp = ceil(rand() * length(tmpProposals));
                                    for h = 1:length(tmpProposals)
                                        newSol = Solution();
                                        newSol.setSession(this.sSession);
                                        newSol.setSize(size(this.solutionIDs, 2));
                                        newIndiv = Individual();
                                        newIndiv.setSession(this.sSession);
                                        newIndiv.setInstrument(tmpProposals(h));
                                        newIndiv.setOnset(tmpOn(j) * 8);
                                        setIndividuals(newSol, this.solutionSet(k).individualsSet, this.solutionIDs(k, :));
                                        setIndividual(newSol, newIndiv, inst);
                                        newSolutions = [newSolutions; newSol];
                                        newSolutionIDs = [newSolutionIDs; newSol.individualsID];
                                    end
                                end
                            end
                        end
                    end
                    clear indexDesc;
                end
            end
            setSolutions(t, newSolutions);
            setSolutionID(t, newSolutionIDs);
            newPop = t;
        end
            
        
        %
        % 1-point mutation operator. Input population is
        % a double matrix where each row is an individual and each column
        % is an instrument of the orchestra. Ouput population has the
        % size of the input population.
        %
        function mutation(this, onsetProposals, onsets)
            % Generate a random population (same size as population_in)
            randomPop = Population(this.sSession);
            if nargin < 2
                generateRandomPopulation(randomPop, length(this.solutionSet));
            else
                variableTable = getVariableTable(getProduction(this.sSession));
                variableDomains = getVariableDomains(getProduction(this.sSession));
                maxOnsets = getMaxOnsetValues(getProduction(this.sSession));
            end
            % Randomly insert elements of the randomPop matrix
            % randAct = round(rand(length(this.solutionSet), 1));
            mutaID = randsample(this.solutionSet(1).getNbInstruments, length(this.solutionSet), 1);
            for i = 1:length(mutaID)
                if (mutaID(i) == 0)
                    continue;
                end
                if nargin < 2
                    setIndividual(this.solutionSet(i), Individual(this.sSession, randomPop.solutionIDs(i, mutaID(i)), 0), mutaID(i));
                    this.solutionIDs(i, mutaID(i)) = randomPop.solutionIDs(i, mutaID(i));
                else
                    if ~isempty(onsetProposals{mutaID(i)})
                        consDomain = onsetProposals{mutaID(i)};
                        cChoice = randsample(size(consDomain, 2), 1, true);
                        tmpOnset = consDomain(2, cChoice);
                        cChoice = consDomain(1, cChoice);
                    else
                        curDom = variableDomains{mutaID(i)};
                        cChoice = floor(rand() * length(curDom) + 1);
                        cChoice = curDom(cChoice);
                        tmpOnset = 0;
                    end
                    index = find(variableTable == cChoice);
                    if tmpOnset == 0
                        onProp = [onsets(onsets < maxOnsets(index(1))) ; (floor(rand(length(onsets), 1) .* maxOnsets(index(1))))];
                        if isempty(onProp)
                            onProp = floor(rand .* maxOnsets(index(1)));
                        end
                        tmpOnset = onProp(ceil(rand .* length(onProp)));
                    end
                    newIndiv = Individual();
                    newIndiv.setSession(this.sSession);
                    newIndiv.setInstrument(cChoice);
                    newIndiv.setOnset(tmpOnset);
                    setIndividual(this.solutionSet(i), newIndiv, mutaID(i));
                    this.solutionIDs(i, mutaID(i)) = cChoice;
                end
            end
            %this.solutionIDs(:, mutaID) = randomPop.solutionIDs(:, mutaID);
            %end
        end
       
        %
        % CROSSOVER - Uniform crossover operator. Input population is
        % a double matrix where each row is an individual and each column
        % is an instrument of the orchestra. Ouput population has the
        % size of the input population.
        %
        function crossover(this)
            % Discard last element if population size is an odd number
            nbSol = length(this.solutionSet);
            nbIns = getNbInstruments(this.solutionSet(1));
            if mod(nbSol, 2)
                this.solutionSet = this.solutionSet(1:(nbSol - 1));
                this.solutionIDs = this.solutionIDs(1:(nbSol - 1), :);
                nbSol = nbSol - 1;
            end
            % Shuffle rows
            I = rand(nbSol, 1);
            [o, I] = sort(I);
            this.solutionSet = this.solutionSet(I);
            this.solutionIDs = this.solutionIDs(I, :);
            % Build crossover index vector
            nbSol = length(this.solutionSet);
            i1 = (1:(nbSol / 2)) * 2 - 1;
            i2 = i1 + 1;
            I1 = (rand(nbSol / 2, nbIns) > 0.5);
            I2 = 1 - I1;
            I = zeros(nbSol, nbIns);
            I(i1,:) = I1;
            I(i2,:) = I2;
            % Re-arrange instruments
            instVector = repmat(1:nbIns, nbSol, 1);
            A = instVector .* I;
            B = instVector .* (1 - I);
            newSolSet = Solution();
            newSolSet = repmat(newSolSet, nbSol, 1);
            for i = 1:(nbSol / 2)
                tmpIDSSet = zeros(2, nbIns);
                tmpSolSet = Individual();
                tmpSolSet = repmat(tmpSolSet, 2, nbIns);
                for j = 1:2
                    if j == 1
                        idA = A;
                        idF = i1;
                    else
                        idA = B;
                        idF = i2;
                    end
                    instruA = idA(i1(i), :);
                    instruA = instruA(instruA > 0);
                    instruB = idA(i2(i), :);
                    instruB = instruB(instruB > 0);
                    tmpSolSet(j, instruA) = this.solutionSet(i1(i)).individualsSet(instruA);
                    tmpSolSet(j, instruB) = this.solutionSet(i2(i)).individualsSet(instruB);
                    tmpIDSSet(j, instruA) = this.solutionIDs(i1(i), instruA);
                    tmpIDSSet(j, instruB) = this.solutionIDs(i2(i), instruB);
                end
                newSolSet(i1(i)) = Solution();
                newSolSet(i1(i)).setSession(this.sSession);
                newSolSet(i2(i)) = Solution();
                newSolSet(i2(i)).setSession(this.sSession);
                setIndividuals(newSolSet(i1(i)), tmpSolSet(1, :), tmpIDSSet(1, :));
                this.solutionIDs(i1(i), :) = tmpIDSSet(1, :);
                setIndividuals(newSolSet(i2(i)), tmpSolSet(2, :), tmpIDSSet(2, :));
                this.solutionIDs(i2(i), :) = tmpIDSSet(2, :);
            end
            this.solutionSet = newSolSet;
        end
        
        %
        % Keep only the unique solutions in the solution set
        %
        function criteria = uniqueSolutions(this)
            [this.solutionIDs, I] = unique(this.solutionIDs,'rows');
            this.solutionSet = this.solutionSet(I);
            this.criteriaSet = this.criteriaSet(I, :);
            fNames = fieldnames(this.featuresSet);
            for k = 1:length(fNames)
                curFeat = this.featuresSet.(fNames{k});
                this.featuresSet.(fNames{k}) = curFeat(I, :);
            end
            criteria = this.criteriaSet;
        end
        
        %
        % Function to preserve density and reduce size of the population
        %
        function smoothPopulation(this, popSize)
            if length(this.solutionSet) > popSize
                % Compute local density
                [density,cell_idx] = density_PADE(this.criteriaSet);
                tmpSolIDX = 1:length(this.solutionSet);
                % Remove elements with higher local density
                while length(tmpSolIDX) > popSize
                    % Pick the first element with highest density
                    denser_cell = find(density == max(density),1);
                    remID = find(cell_idx == denser_cell,1);
                    % Decrement the local density in the cell
                    density(denser_cell) = density(denser_cell) - 1;
                    % Remove individual
                    tmpSolIDX = [tmpSolIDX(1:(remID - 1)) tmpSolIDX((remID + 1):end)];
                    cell_idx = [ cell_idx(1:remID-1) cell_idx(remID+1:length(cell_idx)) ];
                end
                this.criteriaSet = this.criteriaSet(tmpSolIDX, :);
                this.solutionIDs = this.solutionIDs(tmpSolIDX, :);
                this.solutionSet = this.solutionSet(tmpSolIDX);
            end
        end
        
        %
        % Debug function to dump population to files
        %
        function dumpPopulation(this, dirname, doFig)
            if nargin < 3
                doFig = 1;
            end
            if ~exist(dirname, 'dir')
                mkdir(dirname);
            end
            filename = [dirname 'Population.txt'];
            myfile = fopen(filename ,'w');
            fList = getFeatures(this.sSession);
            fprintf(myfile, 'Solutions :\n------------\n\n');
            for i = 1:size(this.solutionIDs, 1)
                fprintf(myfile, 'P : ');
                for j = 1:size(this.solutionIDs, 2)
                    fprintf(myfile, '%i\t', this.solutionIDs(i, j));
                end
                fprintf(myfile, '\nS : ');
                for j = 1:size(this.solutionIDs, 2)
                    fprintf(myfile, '%i\t', this.solutionSet(i).individualsID(j));
                end
                fprintf(myfile, '\nI : ');
                for j = 1:size(this.solutionIDs, 2)
                    fprintf(myfile, '%i\t', this.solutionSet(i).individualsSet(j).sInstrument);
                end
                fprintf(myfile, '\nO : ');
                for j = 1:size(this.solutionIDs, 2)
                    fprintf(myfile, '%i\t', this.solutionSet(i).individualsSet(j).sOnset);
                end
                fprintf(myfile, '\n');
            end
            fprintf(myfile, '\nCriteria :\n-----------\n\n');
            for i = 1:length(fList)
                fprintf(myfile, '%s\t', getFeatureName(fList{i}));
            end
            for i = 1:size(this.criteriaSet, 1)
                for j = 1:size(this.criteriaSet, 2)
                    fprintf(myfile, '%f\t', this.criteriaSet(i, j));
                end
                fprintf(myfile, '\n');
            end
            fclose(myfile);
            if (doFig == 0)
                return;
            end
            for i = 1:length(this.solutionSet)
                dumpSolution(this.solutionSet(i), dirname, i);
            end
        end
    
    end
   
end 
