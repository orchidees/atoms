% OSC_ORCHESTRATE - Run the orchestration algorithm
%
% Usage: handles = osc_orchestrate(osc_message,handles)
%
function handles = osc_orchestrate(osc_message, handles)
% Check that a session is opened
if isempty(handles.session)
    error('osc_orchestrate:UexpectedMessage', 'First open a session.');
end
% Run the orchestration algorithm
handles.session.getSearch().initialize();
handles.session.launchSearch(1);