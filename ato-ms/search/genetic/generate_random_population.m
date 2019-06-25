% GENERATE_RANDOM_POPULATION - Draw a random population where each
% line is an individual and each column an instrument od the orchestra.
%
% Usage: population = generate_random_population(variable_domains,popsize)
%
function population = generate_random_population(variable_domains, variableTable, popsize, maxOnsets)
% Get neutral element
ntr_elem = max(variable_domains{1});
% Define sparsity level (average ratio of neutral elements in population)
sparsity = 0.3;
% Get size of each variable domain
for k = 1:length(variable_domains)
    dsize(1,k) = length(variable_domains{k});
end
% Decrement dsize of 1 to account for neutral element
dsize = dsize-1;
% Check that search space is not empty
if max(dsize)==0
    error('orchidee:genetic:generate_random_population:ImpossibleOperation', ...
        'Search space is empty. Check filters, orchestra ans database.');
end
% Draw random indices within dsize range
dsize = repmat(dsize,popsize,1);
population = struct;
population.onsets = zeros(popsize,length(variable_domains));
population.instruments = rand(popsize,length(variable_domains));
population.instruments = ceil(population.instruments .* dsize);
population.instruments(population.instruments == 0) = 1;
% Replace indices by actual variable values
for k = 1:length(variable_domains)
    this_domain = variable_domains{k};
    population.instruments(:,k) = this_domain(population.instruments(:,k));
    for l = 1:size(population.instruments, 1)
        index = find(variableTable == population.instruments(l,k));
        population.onsets(l,k) = floor(rand .* maxOnsets(index(1)));
    end
end
% Introduce neutral elements in population
n_elements = numel(population.instruments);
I = randsample(n_elements,round(n_elements*sparsity));
population.instruments(I) = ntr_elem;
population.onsets(I) = 0;

