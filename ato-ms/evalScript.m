%% Init problem specific values
clear all;
mainDirectory = '.';
orchResolution = 1;
pathHandler('load');
addpath(genpath('./evaluation/'));
tRoot = '../soutenance/targets/';
sRoot = '../soutenance/segments/';
feature accel on;
% Constructing the result structure
load('resultsOrchestration.mat');
targets = {'Brown_Feel_Good_A', 'ACDC_Big_Gun', 'Brown_Sex_Machine'}
for targs = 1:length(targets)
	curTargets = rdir([tRoot targets{targs} '/**/*.wav']);
	if ~exist([sRoot targets{targs}], 'dir')
		mkdir([sRoot targets{targs}]);
	end
	for i = 1:length(curTargets)
		% Create an empty session
		clear orchSession;
		orchSession = OSession();
		% Fill it with default session values
		orchSession.constructDefaultSession();
		% Get available optimization criteria
		possibleCriteria = orchSession.getKnowledge().getCriteriaList();
		targetSound = curTargets(i).name;
		orchestra = {'Bn','BTbn','Cb','CbTb','ClBb','EH','Hn','Ob','Picc','TpC','TTbn','Va','Vc'};
		criterLists = {{'EnergyEnvelope' 'SpectralCentroid' 'PartialsAmplitude' 'SpectralCentroidMean'}};
		% Set Orchestra and microtonic resolution
		productionType = ProductionOrchestra(orchSession, orchestra, orchResolution);
		orchSession.setProduction(productionType);
		criterList = criterLists{1};
		% Set target and analyze it
		orchSession.setTarget(TargetSound(orchSession, targetSound));
		orchSession.computeTargetFeatures();
		orchSession.getTarget().getHarmonicFilters();
		% Perform Optimal Warping
        searchAlgo = SearchOptimalWarping(orchSession);
		searchAlgo.setParameter('paretoMaxSize', 25);
		searchAlgo.setParameter('nIter', 50);
		% Set optimization criteria 
		orchSession.setCriteriaList(criterList);
        orchSession.setSearch(searchAlgo);
		orchSession.getSearch().initialize();
		% Launch orchestration search
		solutions = orchSession.launchSearch();
		%try
		exportObj = ExportScore(orchSession, [sRoot targets{targs} '/' targets{targs} '_' num2str(i) '.pdf']);
		exportObj.exportSolutionSet(solutions);
		exportObj = ExportSound(orchSession, [sRoot targets{targs} '/' targets{targs} '_' num2str(i) '.wav']);
		exportObj.exportSolutionSet(solutions, [sRoot targets{targs} '/' targets{targs} '_' num2str(i)]);
		%catch
		%	i = i - 1;
		%end
		orchSession.emptyThis();
	end
end