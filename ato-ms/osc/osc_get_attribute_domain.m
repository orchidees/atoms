function handles = osc_get_attribute_domain(osc_message,handles)

% OSC_GET_ATTRIBUTE_DOMAIN - For a given attribute (or a queryable
% field of the database), return the list of allowed values in the
% search for orchestrations.
%
% Usage: handles = osc_get_attribute_domain(osc_message,handles)
%


server_says(handles,'Get attribute domain ...',0);
% Check that output is specified
if length(osc_message.data) < 2
    error('osc_dbgetfieldvaluelist:MissingOutput', 'Output (''message'' or filename) is missing.');
end
% Check output type
if ~ischar(osc_message.data{2})
    error('osc_dbgetfieldvaluelist:BadArgumentType', 'Output (''message'' or filename) must be a string.');
end
% Check database field is specified
if length(osc_message.data) < 3
    error('osc_dbgetfieldvaluelist:IncompleteOscMessage', 'Field name missing.')
end
fName = osc_message.data{3};
% Get DB queryable fields
[dbfields dbtypes] = handles.session.getKnowledge().getFieldsList();
% Get values in database
id = ismember(dbfields, fName);
if ~id
    error('osc_dbgetfieldvaluelist:UnknownField', ['Field ' fName ' is unknown.']);
end
if strncmp(dbtypes(id), 'Complex', 7)
    error('osc_dbgetfieldvaluelist:BadField', ['Field ' fName ' is a complex type.']);
end
% If a 4th argument is specified, take it as an input index file and read it
if length(osc_message.data) == 4
    idx = read_index_file(osc_message.data{4});
else
    idx = [];
end
values = handles.session.getKnowledge().getFieldsValueList(fName, idx);
% If output is the 'message' keyword, send back the field list in
if strcmp(osc_message.data{2},'message')
	% Build OSC message
	message.path = '/dbfieldvaluelist';
	message.tt = 'is';
	message.data{1} = osc_message.data{1};
	message.data{2} = osc_message.data{3};    
	% Append field values to OSC message
	for i = 1:length(values)
        if isnumeric(values)
            message.data{i+2} = values(i);
            message.tt = [ message.tt 'f' ];
        else
            message.data{i+2} = values{i};
            message.tt = [ message.tt 's' ];
        end
    end
	% Add to OSC buffer
	flux{1} = message;
	% Send message
	osc_send(handles.osc.address,flux);
else        
	% Write DB fields in output file
	write_data_file(osc_message.data{2},values,handles);
	% Send back the OSC message
	message.path = '/dbfieldvaluelist';
	message.tt = 'is';
	message.data{1} = osc_message.data{1};
	message.data{2} = osc_message.data{2};    
	% Add to OSC buffer
	flux{1} = message;
	% Send message
	osc_send(handles.osc.address,flux);
end
server_says(handles,'Get attribute domain ...',1);
end