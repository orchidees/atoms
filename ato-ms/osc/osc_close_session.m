% OSC_CLOSE_SESSION - Close current orchestration session
%
% Usage: handles = osc_close_session(osc_message,handles)
%
function handles = osc_close_session(osc_message,handles)
server_says(handles,'Close session ...',0);
% Clear session instance
delete(handles.session);
handles.session = [];
server_says(handles,'Close session ...',1);