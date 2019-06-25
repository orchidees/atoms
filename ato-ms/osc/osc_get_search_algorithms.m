function handles = osc_get_search_algorithms(osc_message, handles)
% Build OSC message
message.path = '/searchalgorithms';
message.tt = 'i';
message.data{1} = osc_message.data{1};
% Available search algorithms
algorithms = Search.availableAlgorithms();
for i = 1:length(algorithms)
    message.data{i + 1} = algorithms{i};
    message.tt = [message.tt 's'];
end
% Add message to OSC buffer
flux{1} = message;
% Send message
osc_send(handles.osc.address,flux)