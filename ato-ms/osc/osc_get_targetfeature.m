% OSC_GET_TARGETPARAMETERS - Get target analysis parameters
%
% Usage: handles = osc_get_targetparameters(osc_message,handles)
%
function handles = osc_get_targetfeature(osc_message,handles)
% Check that a session is opened
if isempty(handles.session)
    error('osc_get_targetfeature:UexpectedMessage', 'First open a session.');
end
if length(osc_message.data) < 2
    error('osc_get_targetfeature:MissingArgument', 'Must specify a feature name.');
end
if ~handles.session.getTarget().getComputed()
    error('osc_get_targetfeature:NotComputed', 'Feature has not been computed yet.');
end
descriptor = osc_message.data{2};
dValue = handles.session.getTarget().getFeature(descriptor);
message.path = '/gettargetfeature';
message.tt = 'i';
message.data{1} = osc_message.data{1};
i = 1;
if (iscell(dValue))
    [valIndex message] = export_cellMessage(message, i, dValue);
elseif (isvector(dValue) && ~ischar(dValue))
	[valIndex message] = export_arrayMessage(message, i, dValue);
else
	message.data{i + 1} = dValue;
	if (ischar(dValue))
        message.tt = [ message.tt 's' ];
    else
        message.tt = [ message.tt 'f' ];
    end
end
flux{1} = message;
osc_send(handles.osc.addressOut,flux);