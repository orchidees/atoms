%% Init problem specific values
function mainScript()
clear all;
mainDirectory = '.';
orchResolution = 1;
targetSound = '../target_voice00a.wav';
orchestras = { {'Picc' 'Fl' 'CbClBb' 'BFl' 'CbFl' 'Ob' 'EH' 'ClEb' 'BClBb' 'ClBb' 'Bn' 'Hn' 'ASax' 'Cb' 'Va'} {'Picc' 'Fl' 'CbClBb' 'BFl' 'CbFl' 'Ob' 'EH' 'ClEb' 'BClBb' 'ClBb' 'Bn' 'Hn' 'ASax' 'Cb' 'Va' 'Picc' 'Fl' 'CbClBb' 'BFl' 'CbFl' 'Ob' 'EH' 'ClEb' 'BClBb' 'ClBb' 'Bn' 'Hn' 'ASax' 'Cb' 'Va'}};
%solutionFile =  ['./results/solutions_' num2str(j) '_' num2str(i) '."txt'];
criterLists = {{'PartialsAmplitude' 'NoiseEnergy' 'SpectralSpread'}};
pathHandler('load');
feature accel on;
profile on;
orchestra = orchestras{1};
criterList = criterLists{1};
% Create an empty session
orchSession = OSession();
% Fill it with default session values
orchSession.constructDefaultSession();
% Set Orchestra and microtonic resolution
productionType = ProductionOrchestra(orchSession, orchestra, orchResolution);
orchSession.setProduction(productionType);
disp(orchSession.getProduction().getScoreOrder());
% Set target and analyze it
orchSession.setTarget(TargetSound(orchSession, targetSound));
orchSession.computeTargetFeatures();
% Prepare target's harmonic filters
orchSession.getTarget().getHarmonicFilters();
% Get available optimization criteria
possibleCriteria = orchSession.getKnowledge().getCriteriaList();
%tic;
%searchAlgo = SearchGenetic(orchSession);
% searchAlgo = SearchOptimalWarping(orchSession);
% Set optimization criteria 
%orchSession.setCriteriaList(criterList);
% disp(orchSession.getFeatures());
% Initialize search
%orchSession.setSearch(searchAlgo);
%orchSession.getSearch().initialize();
% Launch orchestration search
%solutions = orchSession.launchSearch();
searchAlgo = SearchGenetic(orchSession);
%searchAlgo = SearchOptimalWarping(orchSession);
% Set optimization criteria 
orchSession.setCriteriaList(criterList);
% disp(orchSession.getFeatures());
% Initialize search
orchSession.setSearch(searchAlgo);
orchSession.getSearch().initialize();
% Launch orchestration search
solutions = orchSession.launchSearch();
profile viewer;
exportObj = ExportSound(orchSession, ['/tmp/solutions_wave_' num2str(timeExec) '.wav']);
exportObj.exportSolutionSet(solutions, ['/tmp/solutions_wave_' num2str(timeExec)]);
disp('*************');
disp('*************');
disp('*************');
disp('*************');
disp('');
disp('EXECUTION TIME :');
disp('');
%disp(timeExec);
disp('');
disp('*************');
disp('*************');
disp('*************');
disp('*************');
%profile viewer;
%% Just check features
disp(orchSession.getTarget().getFeaturesList());
% Modify a value of the target
orchSession.getTarget().modifyFeature('Loudness', 1:10);
plot(orchSession.getTarget().getFeature('Loudness'));
%
%%
exportObj = ExportRaw(orchSession, '/tmp/deepshit.txt');
solutions = orchSession.getSolution();
exportObj.exportSolutionSetLight(solutions, '/tmp/deep_map.txt');
%% Export solution file
export_solution_set(handles.session, handles.instrument_knowledge, SOLUTION_FILE, handles);
% Export sound and score files
solutionsExport(SOLUTION_FILE, ['results/orchidResults_' num2str(j) '_' num2str(i) '_']);

%%
% Save session
orchSession.saveSession('currentOrch');
delete(orchSession);
%% Load session
%pathHandler('load');
orchSession = OSession.loadSession('currentOrch.orch');
orchSession.getKnowledge().fillFeatureStructure();
%disp(orchSession.getTarget().getFeaturesList());


%%
qry = 'SELECT partialsFrequency from Bloby WHERE SoundID = 1';
result = get(fetch(exec(connecDB, qry)), 'Data');
result = reshape(typecast(cell2mat(result), 'double'), 25, 64);
% plot(result');
resolution = 1;
harmonicFilters = cell(size(result, 2), 1);
for i = 1:size(result, 2)
    mtmidi = round(hz2midi(result(:, i))*resolution)/resolution;
    harmonicFilters{i} = midi2mtnotes(mtmidi);
    % if not, take, take only pitches that contribute to at least
    % one target partial
    % contribs = midinotes_partial_contributions(knowledge_instance,mtmidi,target_features.partialsMeanFrequency,get_target_parameter(session_instance,'delta'));
    % contribs = sum(contribs,2);
    % mtmidi = mtmidi(find(contribs>0));
    % value_list = midi2mtnotes(mtmidi);
end
disp(harmonicFilters);

%%
dbQuery = 'SELECT soundID, note FROM Sounds WHERE note REGEXP "A#3|A4|C3|C4';
result = get(fetch(exec(connecDB, dbQuery)), 'Data');
disp(result);

%% Construct indexes
pathHandler('load');
orchSession = OSession();
% Fill it with default session values
orchSession.constructDefaultSession();
% Construct indexes for every possible descriptor
[descName compValue] = textread('list_descriptors.txt', '%[^\t]%[^\n]');
compValue = str2double(compValue);
for i = 1:length(descName)
    if compValue(i) == 1
        constructIndexesFromDB(orchSession.getKnowledge(), descName{i});
    end
end


%% Init problem specific values
clear all;
mainDirectory = '.';
orchResolution = 1;
targetSound = '../target_voice00a.wav';
orchestras = { {'Picc' 'Fl' 'CbClBb' 'BFl' 'CbFl' 'Ob' 'EH' 'ClEb' 'BClBb' 'ClBb' 'Bn' 'Hn' 'ASax' 'Cb' 'Va'} {'Picc' 'Fl' 'CbClBb' 'BFl' 'CbFl' 'Ob' 'EH' 'ClEb' 'BClBb' 'ClBb' 'Bn' 'Hn' 'ASax' 'Cb' 'Va' 'Picc' 'Fl' 'CbClBb' 'BFl' 'CbFl' 'Ob' 'EH' 'ClEb' 'BClBb' 'ClBb' 'Bn' 'Hn' 'ASax' 'Cb' 'Va'}};
pathHandler('load');
feature accel on;
profile on;
orchestra = orchestras{1};
% Create an empty session
orchSession = OSession();
% Fill it with default session values
orchSession.constructDefaultSession();
% Set target and analyze it
orchSession.setTarget(TargetSound(orchSession, targetSound));
orchSession.computeTargetFeatures();
% Prepare target's harmonic filters
disp(orchSession.getTarget().spectralFeatures);
% Test segmentation procedure
enEnv = orchSession.getTarget().getFeature('Loudness');
specC = orchSession.getTarget().getFeature('SpectralSlope');
specS = orchSession.getTarget().getFeature('Spread');
inHar = orchSession.getTarget().getFeature('Inharmonicity');
noise = orchSession.getTarget().getFeature('Noisiness');
tsMultiLevelSegment(enEnv, 64);
%tsMultiLevelSegment(specC, 16);
%tsMultiLevelSegment(specS, 16);
%tsMultiLevelSegment(inHar, 16);
%tsMultiLevelSegment(noise, 16);
end