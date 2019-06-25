% OSC_SET_RESOLUTION - Set the microtonic resolution of the
% orchestra (1/2 tone, 1/4 tone, 1/8 tone or 1/16 tone).
%
% Usage: handles = osc_set_resolution(osc_message,handles)
%
function handles = osc_set_resolution(osc_message,handles)
% Open a new session if necessary
if isempty(handles.session)
    handles.session = OSession();
    handles.session.constructDefaultSession();
    handles.session.setHandles(handles);
end
% Check input arguments
if length(osc_message.data) < 2
    error('osc_set_resolution:BadArgumentNumber', 'Two few arguments for /setresolution.');
end
% Set resolution
handles.session.getProduction().setResolution(osc_message.data{2});
