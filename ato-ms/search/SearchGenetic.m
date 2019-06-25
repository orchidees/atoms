%
% SearchGenetic.m   : Class for the multiobjective genetic search algorithm
%
% This class allows to define a multiobjective genetic search.
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef SearchGenetic < Search
    
    properties
        initPopSize         % Initial population size
        maxPopSize          % Maximal population size
        matingPoolSize      % Size of mating pool
        paretoMaxSize       % Maximum size of pareto front
        nIter               % Number of evolution iterations
    end

    methods
       
        %
        % Main constructor for genetic search algorithm
        %
        function sG = SearchGenetic(sessionObj)
            sG = sG@Search(sessionObj);
            setDefaultParameters(sG);
        end
       
        %
        % Fill the search parameters with default values
        %
        function setDefaultParameters(this)
            this.searchParameters = struct;
            this.initPopSize = 200;
            this.maxPopSize = 400;
            this.matingPoolSize = 50;
            this.nIter = 100;
            this.paretoMaxSize = 50;
        end
        
        function setParameter(this, name, param)
            this.(name) = param;
        end
        
        %
        % Fill the search parameters with default values
        %
        function params = getSearchParameters(this)
            params = cell(10, 1);
            params{1} = 'initPopSize';
            params{2} = this.initPopSize;
            params{3} = 'maxPopSize';
            params{4} = this.maxPopSize;
            params{5} = 'matingPoolSize';
            params{6} = this.matingPoolSize;
            params{7} = 'paretoMaxSize';
            params{8} = this.paretoMaxSize;
            params{9} = 'nIter';
            params{10} = this.nIter;
        end
        
        %
        % Set the parameters of the search
        %
        function setSearchParameters(this, params)
            if ~isstruct(params)
                error('SearchGenetic:setSearchParameters:Invalid', 'Parameters must be a structure');
            end
            fName = fieldNames(params);
            for i = 1:length(fName)
                curParam = fName(i);
                if ~isfield(this, curParam)
                    error('SearchGenetic:setSearchParameters:Unknown', ['Parameter ' curParam ' is unknown']);
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
            generateRandomPopulation(initPop, this.initPopSize);
            % Evaluate the initial population
            updatePopulationFeatures(initPop);
            eval_population(initPop, targetFeatures, optFeatures);
            % Debugging population
            % initPop.dumpPopulation('debug/initPopulation/', 1);
            % Remove NaN values from population
            discardNaN(initPop);
            pop_critr = initPop.criteriaSet; 
            % Extract the initial Pareto set
            [n,pop_critr_sampled] = sample_criteria_space(pop_critr,100);
            %pareto_critr = extract_pareto_set(pop_critr_sampled);
            %[t,loc] = ismember(pareto_critr,pop_critr,'rows');
            % Create a population only from Pareto solutions
            paretoPop = extractPopulation(initPop, paretoGroup(pop_critr_sampled) ~= 0);
            % Debugging population
            % paretoPop.dumpPopulation('debug/initParetoPop/', 1);
            % Ideal and nadir estimations
            nadir_estimate = max(pop_critr,[],1);
            ideal_estimate = min(pop_critr,[],1);
            critr_ranges = nadir_estimate-ideal_estimate;
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
                % offspringPop.dumpPopulation(['debug/' num2str(iter) '_offspringPop_Term/'], 1);
                discardNaN(offspringPop);
                offspring_critr = offspringPop.criteriaSet;
                % update ideal and nadir
                nadir_estimate = max([offspring_critr ; nadir_estimate],[],1);
                ideal_estimate = min([offspring_critr ; ideal_estimate],[],1);
                critr_ranges = nadir_estimate-ideal_estimate;
                % ***** Insert offspring in population *****
                combinePopulations(initPop, offspringPop);
                % ***** Update pareto set *****
                combinePopulations(paretoPop, offspringPop);
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
                % paretoPop.dumpPopulation(['debug/' num2str(iter) '_paretoPop/'], 1);
                % Preserve density for dominated individuals
                if size(dominated_critr,1) > this.maxPopSize-size(pareto_critr,1)
                    smoothPopulation(dominatedPop,this.maxPopSize - size(pareto_critr,1));
                end
                if isServer == 1 && mod(iter, 5) == 1
                    this.sSession.sendTmpSolutions(((iter - 1) / 5) + 1, paretoPop);
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
            %paretoPop.dumpPopulation();
            % paretoPop.dumpPopulation('debug/initPopulation/', 1);
            solutions = this.solutionSet;
        end



        


       
   end
   
end 
