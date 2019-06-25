%
% SearchOptimalFactor.m   : Class for the multiobjective optimal warping
%
% This class allows to define a multiobjective optimal warping search.
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef SearchOptimalWarping < Search
    
    properties
        rndFactor           % Percentage of randomness
        nbSegBase           % Number of basis segments
        initPopSize         % Initial population size
        maxPopSize          % Maximal population size
        matingPoolSize      % Size of the mating pool
        paretoMaxSize       % Size of Pareto front
        descIndexes         % Indexes to descriptor
        nIter               % Number of evolution iterations
    end

    methods
       
        %
        % Main constructor for search algorithm
        %
        function sG = SearchOptimalWarping(sessionObj)
            sG = sG@Search(sessionObj);
            setDefaultParameters(sG);
        end
       
        %
        % Fill the search parameters with default values
        %
        function setDefaultParameters(this)
            this.searchParameters = struct;
            this.rndFactor = 0.5;
            this.nbSegBase = 12;
            this.initPopSize = 200;
            this.maxPopSize = 400;
            this.matingPoolSize = 200;
            this.paretoMaxSize = 100;
            this.nIter = 50;
        end
        
        function setParameter(this, name, param)
            this.(name) = param;
        end
        
        %
        % Fill the search parameters with default values
        %
        function params = getSearchParameters(this)
            params = cell(10, 1);
            params{5} = 'rndFactor';
            params{6} = this.rndFactor;
            params{7} = 'nbSegBase';
            params{8} = this.nbSegBase;
            params{1} = 'initPopSize';
            params{2} = this.initPopSize;
            params{3} = 'maxPopSize';
            params{4} = this.maxPopSize;
            params{9} = 'nIter';
            params{10} = this.nIter;
        end
        
        %
        % Set the parameters of the search
        %
        function setSearchParameters(this, params)
            if ~isstruct(params)
                error('SearchOptimalWarping:setSearchParameters:Invalid', 'Parameters must be a structure');
            end
            fName = fieldNames(params);
            for i = 1:length(fName)
                curParam = fName(i);
                if ~isfield(this, curParam)
                    error('SearchOptimalWarping:setSearchParameters:Unknown', ['Parameter ' curParam ' is unknown']);
                end
                this.(curParam) = params.(curParam);
            end
        end
              
        %
        % Initialize the search algorithm
        %
        function initialize(this)
            this.sSession.getTarget().getFeaturesList();
            % Retrieve the domains in which instruments can be chosen
            this.sSession.getProduction().getVariableDomains();
        end
       
        %
        % Launch the search algorithm and return the solution set
        %
        function solutions = launchSearch(this, isServer)
            if nargin < 2
                isServer = 0;
            end
            % Get the target features
            targetFeatures = getFeaturesList(getTarget(this.sSession));
            % Retrieve the domains in which instruments can be chosen
            sProduction = getProduction(this.sSession);
            variableDomains = getVariableDomains(sProduction);
            % Retrieve the variable table of indexes
            variableTable = getVariableTable(sProduction);
            % Retrieve the list of optimization features
            optFeatures = getFeatures(this.sSession);
            % Draw weights (Jaszkiewicz's method)
            if length(optFeatures) > 1
                weights = draw_jaszkiewicz_weights(this.nIter, length(optFeatures));
            else
                weights = ones(this.nIter,1);
            end
            % Instantiate random initial population
            initPop = Population(this.sSession);
            onsetsList = [];
            disp(variableDomains);
            onsetsProposals = cell(size(variableDomains, 2), 1);
            targetDuration = this.sSession.getTarget().getFeature('duration');
            for i = 1:length(optFeatures)
                curFeature = targetFeatures.(optFeatures{i}.getFeatureName());
                if (length(curFeature) > 1 && ~strcmp(optFeatures{i}.getFeatureName(), 'PartialsAmplitude') && ~strcmp(optFeatures{i}.getFeatureName(), 'PartialsMeanAmplitude'))
                    % Using Time Series indexing technique to retrieve
                    % segmented best propositions on different warping scales
                    indexDesc = constructIndexesFromDB(this.sSession.getKnowledge(), optFeatures{i}.getFeatureName(), this.sSession.getHandles(), 0);
                    server_says(this.sSession.getHandles(), ['Performing segmentation on ' optFeatures{i}.getFeatureName()], 0);
                    [resultSegments tmpOn] = tsMultiLevelSegment(curFeature, this.nbSegBase);
                    onsetsList = [onsetsList ; tmpOn];
                    for j = 1:length(resultSegments)
                        server_says(this.sSession.getHandles(), ['Performing segmentation on ' optFeatures{i}.getFeatureName()], j / size(resultSegments, 1));
                        sDuration = ((targetDuration) * (length(resultSegments{j}) / 128));
                        [results, resNode] = indexDesc.approximateQueryConstrained(resultSegments{j}, variableTable, 5, sDuration);
                        for inst = 1:length(onsetsProposals)
                            tmpProposals = intersect(results, variableDomains{inst});
                            if ~isempty(tmpProposals)
                                onsets = repmat(tmpOn(j), 1, length(tmpProposals));
                                proposals = [tmpProposals ; onsets];
                                onsetsProposals{inst} = [onsetsProposals{inst} proposals];
                            end
                        end
                    end
                    clear descIndex;
                end
            end
%              for i = 1:length(onsetsProposals)
%                  tmpProposals = onsetsProposals{i};
%                  if isempty(tmpProposals)
%                      continue;
%                  end
%                  tmpProposals = unique(tmpProposals', 'rows')';
%                  [~, newix] = sort(tmpProposals(2, :));
%                  tmpProposals = tmpProposals(:, newix);
%                  nc = histc(tmpProposals(2, :), unique(tmpProposals(2, :)));
%                  nbOnsets = length(nc);
%                  nbTotalOn = sum(nc);
%                  orDev = (nc / nbTotalOn) - (1 / nbOnsets);
%                  finalProposals = [];
%                  fiDev = min(orDev(orDev > 0));
%                  for j = 1:nbOnsets
%                      if j > 1
%                          idDep = sum(nc(1:(j - 1))) + 1;
%                      else
%                          idDep = 1;
%                      end
%                      idEnd = idDep + (nc(j) - 1);
%                      if orDev(j) < 0
%                          nbRep = fiDev * nbTotalOn * nbOnsets;
%                          optProposals = repmat(tmpProposals(:, idDep:idEnd), 1, round(nbRep));
%                      else
%                          optProposals = tmpProposals(:, idDep:idEnd);
%                      end
%                      finalProposals = [finalProposals optProposals];
%                  end
%                  onsetsProposals{i} = finalProposals;
%              end
            onsetsList = unique(onsetsList);
            server_says(getHandles(this.sSession), 'Generating constrained population ...', 0);
            generateConstrainedPopulation(initPop, this.initPopSize, onsetsProposals, onsetsList);
            server_says(getHandles(this.sSession), 'Generating constrained population ...', 0.2);
            % Evaluate the initial population
            % updatePopulationFeatures(initPop);
            eval_population(initPop, targetFeatures, optFeatures);
            server_says(getHandles(this.sSession), 'Generating constrained population ...', 0.7);
            % Debugging population
            % initPop.dumpPopulation('debug/initPopulation/', 0);
            % Remove NaN values from population
            discardNaN(initPop);
            pop_critr = initPop.criteriaSet; 
            % Extract the initial Pareto set
            [n,pop_critr_sampled] = sample_criteria_space(pop_critr,100);
            pareto_critr = extract_pareto_set(pop_critr_sampled);
            [t,loc] = ismember(pareto_critr,pop_critr,'rows');
            % Create a population only from Pareto solutions
            paretoPop = extractPopulation(initPop, loc);
            % Debugging population
            % paretoPop.dumpPopulation('debug/initParetoPop/', 0);
            % Ideal and nadir estimations
            nadir_estimate = max(pop_critr,[],1);
            ideal_estimate = min(pop_critr,[],1);
            critr_ranges = nadir_estimate-ideal_estimate;
            server_says(getHandles(this.sSession), 'Generating constrained population ...', 1.0);
            for iter = 1:this.nIter    
                server_says(getHandles(this.sSession),'Exploring search space ...', iter / this.nIter);
                % ***** Compute fitness *****
                pop_fitness = scalarize(pop_critr, weights(iter,:), ideal_estimate, critr_ranges);
                % ***** Selection *****
                selectedID = select_population(pop_fitness, this.matingPoolSize);
                offspringPop = extractPopulation(initPop, selectedID);
                % offspringPop.dumpPopulation(['debug/' num2str(iter) '_offspringPop/'], 0);
                % ***** Crossover *****
                crossover(offspringPop);
                % offspringPop.dumpPopulation(['debug/' num2str(iter) '_offspringPop_Cross/'], 0);
                % ***** Mutation *****
                mutation(offspringPop);
                % offspringPop.dumpPopulation(['debug/' num2str(iter) '_offspringPop_Mut/'], 0);
                % ***** Compute offspring criteria and audio fitness *****
                updatePopulationFeatures(offspringPop);
                eval_population(offspringPop, targetFeatures, optFeatures);
                if mod(iter, 15) == 0;
                    [~,I] = preserveDiversity(pareto_critr, 15, 'pareto');
                    tmpPareto = extractPopulation(paretoPop, I);
                    newPop = adaptiveOptimization(tmpPareto);
                    if ~isempty(newPop.solutionIDs)
                        updatePopulationFeatures(newPop);
                        eval_population(newPop, targetFeatures, optFeatures);
                        combinePopulations(offspringPop, newPop);
                    end
                end
                % offspringPop.dumpPopulation(['debug/' num2str(iter) '_offspringPop_Term/'], 0);
                discardNaN(offspringPop);
                offspring_critr = offspringPop.criteriaSet;
                % update ideal and nadir
                nadir_estimate = max([offspring_critr ; nadir_estimate],[],1);
                ideal_estimate = min([offspring_critr ; ideal_estimate],[],1);
                critr_ranges = nadir_estimate-ideal_estimate;
                % ***** Insert offspring in population *****
                combinePopulations(initPop, offspringPop);
                % ***** Update pareto set *****
                combinePopulations(paretoPop, initPop);
                % ***** Keep only the unique solutions *****
                pareto_critr_tmp = uniqueSolutions(paretoPop);
                %[pareto_critr idSet] = extract_pareto_set(pareto_critr_tmp);
                paretoPop = extractPopulation(paretoPop, paretoGroup(pareto_critr_tmp) ~= 0);
                pareto_critr = paretoPop.criteriaSet;
                pop_critr = initPop.criteriaSet;
                % ***** Population size handling *****
                J = ismember(pop_critr,pareto_critr,'rows');
                dominated_critr = pop_critr(~J,:);
                % Retriving dominated solutions
                dominatedPop = extractPopulation(initPop, ~J);
                % Reduce pareto set size if too large
                if paretoPop.getNbSolutions() > this.paretoMaxSize
                    [pareto_critr,I] = preserveDiversity(pareto_critr, this.paretoMaxSize, 'random');
                    paretoPop = extractPopulation(paretoPop, I);
                end
                % paretoPop.dumpPopulation(['debug/' num2str(iter) '_paretoPop/'], 0);
                % Preserve density for dominated individuals
                if size(dominated_critr,1) > this.maxPopSize-size(pareto_critr,1)
                    smoothPopulation(dominatedPop,this.maxPopSize - size(pareto_critr,1));
                end
                if mod(iter, 5) == 1
                    %exportObj = ExportSound(this.sSession, ['/tmp/solutions_wave_' num2str(iter) '.wav']);
                    %exportObj.exportSolutionSet(paretoPop, ['/tmp/solutions_wave_' num2str(iter)]);
                    if isServer == 1 
                        this.sSession.sendTmpSolutions(((iter - 1) / 5) + 1, paretoPop);
                    end
                    % paretoPop.dumpPopulation(['debug/' num2str(iter) '_paretoPop/'], 1);
                end
                % Mix reduced Pareto set and individuals of homogeneous density into
                % next generation
                combinePopulations(dominatedPop, paretoPop);
                % dominatedPop.dumpPopulation(['debug/' num2str(iter) '_terminalPop/'], 0);
                initPop = dominatedPop;
                pop_critr = initPop.criteriaSet;
                if this.sSession.isDebug()
                    break;
                end
            end
            if isServer == 1
                this.sSession.sendTmpSolutions(21, paretoPop);
            end
            % Build output structure
            this.solutionSet = paretoPop;
            % paretoPop.checkupPopulation();
            solutions = this.solutionSet;
            % paretoPop.dumpPopulation('debug/', 1);
            % paretoPop.dumpPopulation('debug/initPopulation/', 1);
        end



        


       
   end
   
end 
