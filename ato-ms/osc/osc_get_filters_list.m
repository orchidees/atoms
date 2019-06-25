% OSC_GET_FILTERS_LIST - Return the list of available optimization
% criteria
%
% Usage: handles = osc_get_criteria_list(osc_message,handles)
%

function handles = osc_get_filters_list(osc_message,handles)
% Check that a session is opened
if isempty(handles.session)
    error('osc_get_criteria_list:UexpectedMessage', 'First open a session.');
end
% Get filters structure
sFilters = handles.session.getProduction().filtersSet;
fNames = fieldnames(sFilters);
% Build OSC message
message.path = '/filterslist';
% Add criteria to message data
for k = 1:length(fNames)
    if isa(sFilters.(fNames{k}), 'FiltersTemporal') || strcmp(fNames{k}, 'name') || strcmp(fNames{k}, 'file') || strcmp(fNames{k}, 'pitchClass') || strcmp(fNames{k}, 'octave')
        continue;
    end
    message.data = {};
    message.tt = 'iss';
    message.data{1} = osc_message.data{1};
    message.data{2} = fNames{k};
    if isa(sFilters.(fNames{k}), 'FiltersSymbolic')
        message.data{3} = 'Symbolic';
        vals = unique(sFilters.(fNames{k}).includeList);
        message.data{4} = length(vals);
        message.tt = [message.tt 'i'];
        if length(vals) < 64
            for v = 1:length(vals)
                message.tt = [ message.tt 's' ];
                message.data{v + 4} = vals{v};
            end
            % Add to OSC buffer
            flux{1} = message;
            % Send message
            osc_send(handles.osc.address,flux);
        else
            for n = 1:64:length(vals)
                message.data = {};
                message.tt = 'issi';
                message.data{1} = osc_message.data{1};
                message.data{2} = fNames{k};
                message.data{3} = 'Symbolic';
                message.data{4} = length(vals);
                for v = n:min(n + 63, length(vals))
                    message.tt = [ message.tt 's' ];
                    message.data{(v - n) + 5} = vals{v};
                end
                flux{1} = message;
                disp(message);
                disp(message.data);
                % Send message
                osc_send(handles.osc.address,flux);   
            end
        end
    else
        message.data{3} = 'Spectral';
        vals = sFilters.(fNames{k}).filterRange;
        message.tt = [message.tt 'ff'];
        message.data{4} = vals(1);
        message.data{5} = vals(2);
        % Add to OSC buffer
        flux{1} = message;
        % Send message
        osc_send(handles.osc.address,flux);
    end
    disp(fNames{k});
    disp(message.tt);
    disp(message.data);
end