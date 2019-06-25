% OSC_SET_TARGETPARAMETERS - Set target analysis parameters
%
% Usage: handles = osc_set_targetparameters(osc_message,handles)
%

function handles = osc_set_targetduration(osc_message,handles)
% Check that a session is opened
if isempty(handles.session)
    error('osc_set_targetduration:EmptySession', 'No session has been opened');
end
% 
if length(osc_message.data) < 2
    error('osc_set_targetfeature:BadArgumentNumber', 'Too few arguments for /settargetfeature.');
end
targetDuration = osc_message.data{2};
% Applying the feature modification
handles.session.getTarget().modifyFeature('duration', targetDuration);
