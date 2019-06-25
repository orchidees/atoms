% OSC_DBGETFIELDVALUES - Return the values of a database field
% (eventually filtered by an additional input index file)
%
% Usage: handles = osc_dbgetfieldvalues(osc_message,handles)
%
function handles = osc_dbgetfieldvalues(osc_message,handles)

% Check arguments number
if length(osc_message.data) < 3
    error('orchidee:osc:osc_dbgetfieldvalues:IncompleteOscMessage', ...
        '/dbgetfieldvalues requires at least 3 arguemnts.')
end

% If a 4th argument is specified, take it as an input index file
% and read it
if length(osc_message.data) == 4
    idx = read_index_file(osc_message.data{4});
else
    idx = [];
end
fName = osc_message.data{3};
values = handles.session.getKnowledge().getFieldsValues({fName}, cell2mat(idx));
% Write knowledge data in text file
write_data_file(osc_message.data{2},values,handles)
% Build OSC messgae
message.path = '/dbfieldvalues';
message.tt = 'is';
message.data{1} = osc_message.data{1};
message.data{2} = osc_message.data{2};
% Add message to OSC buffer
flux{1} = message;
% Send message
osc_send(handles.osc.address,flux);
