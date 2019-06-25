% OSC_DBANALYZESAMPLES - Extract symbolic attributes and perceptual
% features from sound files and store them in SQL database.
%
% Usage: handles = osc_dbanalyzesamples(osc_message,handles)
%
function handles = osc_dbanalyzesamples(osc_message,handles)  
% Check input arguments number
if length(osc_message.data) < 2
    error('osc_dbanalyzesamples:BadArgumentNumber', '/dbanalyzesamples requires one argument');
end
% Check input arguments type
if ~ischar(osc_message.data{2})
    error('osc_dbanalyzesamples:BadArgumentType', 'Samples DB root must be a string.');
end

% The sound files root directory
soundfileroot = osc_message.data{2};        
% Call the knowledge adding procedure
handles.session.getKnowledge().addKnowledge(soundfileroot);