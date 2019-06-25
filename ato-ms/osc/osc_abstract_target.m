% OSC_SETSOUNDFILE - Define a sound file as the new sound target
%
% Usage: handles = osc_set_soundfile(osc_message,handles)
%

function handles = osc_abstract_target(osc_message,handles)
% Open a new session if necessary
if isempty(handles.session)
    handles.session = OSession();
    handles.session.constructDefaultSession();
    handles.session.setHandles(handles);
    handles = osc_get_targetparameters(osc_message,handles);
end
% Set sound file as the new sound target
targ = TargetSound(handles.session, 'emptyTarget.wav');
targ.computeFeatures();
handles.session.setTarget(targ);
[fields types] = handles.session.getKnowledge.getFieldsList();
targFeatNames = targ.getFeaturesList();
for i = 1:length(types)
    if strncmp(types{i}, 'Complex', 7)
        curFeature = fields{i};
        disp(curFeature);
        if strncmp(curFeature((end - 5):end), 'Bands', 5) || strncmp(curFeature, 'Partials', 8) || ~isfield(targFeatNames, curFeature)
            continue;
        end
        curMean = targ.getFeature([curFeature 'Mean']);
        curStdDev = targ.getFeature([curFeature 'StdDev']);
        curTValue = targ.getFeature(curFeature);
        message.path = '/targetfeature';
    	message.tt = 'isff';
        message.data{1} = osc_message.data{1};
        message.data{2} = curFeature;
        message.data{3} = curMean;
        message.data{4} = curStdDev;
        [valID message] = export_arrayMessage_space(message, 4, curTValue);
        disp(message);
        % Add to OSC buffer
        flux{1} = message;
        % Send message
        osc_send(handles.osc.address,flux);
    end
end
handles.session.getProduction().setHarmonicFiltering(0);
