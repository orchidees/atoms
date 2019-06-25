% OSC_DBLOAD - Load an instrument knowledge database from disk
%
% Usage: handles = osc_dbload(osc_message,handles)
%
function handles = osc_dbload(osc_message,handles)
% Check argument number
if length(osc_message.data) < 4
    error('orchidee:osc:osc_dbload:IncompleteOscMessage', '/load requires 3 arguemnts.')
end
% Load database
server_says(handles,[ 'Load user instrument knowledge: ' osc_message.data{2} ],0);
dbName = osc_message.data{2};
dbUser = osc_message.data{3};
dbPass = osc_message.data{4};
instrument_knowledge = KnowledgeSQL(dbName, dbUser, dbPass);
handles.session.setKnowledge(instrument_knowledge);
server_says(handles,[ 'Load user instrument knowledge: ' osc_message.data{2} ],1);
