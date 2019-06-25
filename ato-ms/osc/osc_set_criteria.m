function handles = osc_set_criteria(osc_message,handles)

% OSC_SET_CRITERIA - Define optimization current criteria
%
% Usage: handles = osc_set_criteria(osc_message,handles)
%

% Open session if necessary
if isempty(handles.session)
    handles.session = OSession();
    handles.session.constructDefaultSession();
    handles.session.setHandles(handles);
    handles = osc_get_targetparameters(osc_message,handles);
end
% Check input args
if length(osc_message.data) < 2
    error('osc_set_filter:BadArgumentNumber', 'At least one critierion is needed.');
end
for i = 2:length(osc_message.data)
    if strcmp(osc_message.data{i}, 'PartialsAmplitudeMean')
        osc_message.data{i} = 'PartialsMeanAmplitude';
        break;
    end
end
% Get criteria list from OSC message
criteria_list = osc_message.data(2:length(osc_message.data));
% Set criteria
handles.session.setCriteriaList(criteria_list);