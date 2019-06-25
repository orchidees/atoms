% OSC_DBGETFIELDS - Return queryable fields of instrument knowledge
% database
%
% Usage: handles = osc_dbgetqueryfields(osc_message,handles)
%
function handles = osc_dbgettemporalfields(osc_message,handles)
% Get DB query able fields
[dbfields dbtype dbquery] = handles.session.getKnowledge().getFieldsList();
% Check if output is specified
if length(osc_message.data) < 2
    error('osc_dbgetqueryfields:MissingOutput', 'Output (''message'' or filename) is missing.');
end
% Check that output is a string
if ~ischar(osc_message.data{2})
    error('osc_dbgetqueryfields:BadArgumentType', 'Output (''message'' or filename) must be a string.');
end
% If output is the 'message' keyword, send back the field list in the OSC message
if strcmp(osc_message.data{2},'message')
    % Build OSC message
    message.path = '/dbtemporalfields';
    message.tt = 'i';
    message.data{1} = osc_message.data{1};
    % Append BD fields to message data
    j = 2;
    for i = 1:length(dbfields)
        if strcmp(dbtype{i}, 'Complex')
            message.data{j} = dbfields{i};
            message.tt = [ message.tt 's' ];
            j = j + 1;
        end
    end
    % Add to OSC buffer
    flux{1} = message;
    % Send message
    osc_send(handles.osc.address,flux);
else
    nbQuery = sum(dbquery);
    queryfields = cell(nbQuery, 1);
    j = 1;
    for i = 1:length(dbfields)
        if strcmp(dbtype{i}, 'Complex')
            queryfields{j} = dbfields{i};
            j = j + 1;
        end
    end
    % Write DB fields in output file
    write_data_file(osc_message.data{2},queryfields,handles);
    % Send back the OSC message
    message.path = '/dbtemporalfields';
    message.tt = 'is';
    message.data{1} = osc_message.data{1};
    message.data{2} = osc_message.data{2};    
    % Add to OSC buffer
    flux{1} = message;
    % Send message
    osc_send(handles.osc.address,flux);
end