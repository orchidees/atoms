function handles = osc_set_search_parameter(osc_message, handles)
% Build OSC message
handles.session.getSearch().setParameter(osc_message.data{2}, osc_message.data{3});