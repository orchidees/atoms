% OSC_DBRESET - Reset knowledge instance to default knowledge
%
% Usage: handles = osc_dbreset(osc_message,handles)
%
function handles = osc_dbreset(osc_message,handles)
% Load default knowledge
server_says(handles,'Load default instrument knowledge',0);
knowledge = KnowledgeSQL('orchestrationDB', 'root', '');
handles.session.setKnowledge(knowledge);
server_says(handles,'Load default instrument knowledge',1);