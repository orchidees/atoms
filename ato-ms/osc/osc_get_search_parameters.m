function handles = osc_get_search_parameters(osc_message, handles)
% Build OSC message
message.path = '/searchparameters';
message.tt = 'i';
message.data{1} = osc_message.data{1};
% Construct algorithm given the second parameter
sAlg = Search.constructSearch(osc_message.data{2}, handles.session);
handles.session.setSearch(sAlg);
% Available search parameters
params = handles.session.getSearch().getSearchParameters();
for i = 1:length(params)
    message.data{i + 1} = params{i};
    if (ischar(params{i}))
        message.tt = [message.tt 's'];
    else
        message.tt = [message.tt 'f'];
    end
end
% Add message to OSC buffer
flux{1} = message;
% Send message
osc_send(handles.osc.address,flux);