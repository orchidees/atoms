% OSC_DBSAVE - Save an insturment knowledge object in an external
% mat file.
%
% Usage: handles = osc_dbsave(osc_message,handles)
%

function handles = osc_session_load(osc_message,handles)
% Check input arguments
if length(osc_message.data) < 2
    error('osc_saveSession:IncompleteOscMessage', '/dbsave requires 2 arguemnts.')
end
if ~ischar(osc_message.data{2})
    error('osc_saveSession:BadArgument', 'filename should be a string.');
end
filename = osc_message.data{2};
idDot = find(filename == ':', 1, 'first');
filename = filename((idDot + 1):end);
% Save knowledge object on disk
server_says(handles,[ 'Loading session from file : ' filename ],0);
handles.session = OSession.loadSession(filename);
handles.session.setHandles(handles);
%handles.session.getKnowledge().fillFeatureStructure();
server_says(handles,[ 'Loading session from file : ' filename ],1);
server_says(handles,'Sending target information.', 0);
targ = handles.session.getTarget();
if ~isempty(targ)
    [fields types] = handles.session.getKnowledge.getFieldsList();
    targFeatNames = targ.getFeaturesList();
    for i = 1:length(types)
    server_says(handles, 'Sending target information.', i / length(types));
    if strncmp(types{i}, 'Complex', 7)
        curFeature = fields{i};
        disp(curFeature);
        if ~isfield(targFeatNames, curFeature)
            continue;
        end
        if ~strncmp(curFeature((end - 4):end), 'Bands', 5)
            curMean = targ.getFeature([curFeature 'Mean']);
            curStdDev = targ.getFeature([curFeature 'StdDev']);
            curTValue = targ.getFeature(curFeature);
        else
            curMean = 0;
            curStdDev = 0;
            curTValue = [0 0 0 0 0];
        end
        message.path = '/targetfeature';
    	message.tt = 'isff';
        message.data{1} = osc_message.data{1};
        message.data{2} = curFeature;
        message.data{3} = curMean;
        message.data{4} = curStdDev;
        [valID message] = export_arrayMessage_space(message, 4, curTValue);
        % Add to OSC buffer
        flux{1} = message;
        % Send message
        osc_send(handles.osc.address,flux);
    end
    end
end
server_says(handles, 'Sending target information.', 1);
server_says(handles, 'Sending solutions.', 0);
sols = handles.session.getSolution();
if ~isempty(sols)
    message.path = '/solutionsnotempty';
    message.tt = 'i';
    message.data{1} = 101;
    flux{1} = message;
    osc_send(handles.osc.address,flux);
    handles.session.sendTmpSolutions(100, sols);
end
server_says(handles, 'Sending solutions.', 1);
server_says(handles, 'Sending production information.', 0);
message.path = '/clearorchestra';
message.tt = 'i';
message.data{1} = 101;
flux{1} = message;
osc_send(handles.osc.address,flux);
prod = handles.session.getProduction();
instrus = prod.getInstruments();
if ~isempty(instrus)
    for i = 1:length(instrus)
        disp(instrus{i});
        message.path = '/allowedinstrument';
    	message.tt = 'is';
        message.data{1} = 372;
        message.data{2} = instrus{i};
        % Add to OSC buffer
        flux{1} = message;
        % Send message
        osc_send(handles.osc.address,flux);
    end
end
server_says(handles, 'Sending production information.', 1);