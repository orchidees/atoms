% OSC_SETSOUNDFILE - Define a sound file as the new sound target
%
% Usage: handles = osc_set_soundfile(osc_message,handles)
%

function handles = osc_set_soundfile(osc_message,handles)
% Open a new session if necessary
if isempty(handles.session)
    handles.session = OSession();
    handles.session.setHandles(handles);
    handles.session.constructDefaultSession();
end
% Check input arguments
if length(osc_message.data) < 2
    error('osc_set_soundfile:MissingOutput', 'Input soundfile is missing.');
end
if ~ischar(osc_message.data{2})
    error('osc_set_soundfile:BadArgumentType', 'Input soundfile must be a string.');
end
handles.session.getProduction().needInit();
% Set sound file as the new sound target
targ = TargetSound(handles.session, osc_message.data{2});
targ.computeFeatures();
handles.session.setTarget(targ);
[fields types] = handles.session.getKnowledge.getFieldsList();
targFeatNames = targ.getFeaturesList();
message.path = '/targetduration';
message.tt = 'if';
message.data{1} = 679;
message.data{2} = targ.getFeature('duration');
% Add to OSC buffer
flux{1} = message;
% Send message
osc_send(handles.osc.address,flux);
for i = 1:length(types)
    curFeature = fields{i};
    if strcmp(curFeature, 'FundamentalFrequency') || strcmp(curFeature, 'PartialsFrequency') || strcmp(curFeature, 'PartialsMeanFrequency') || strcmp(curFeature, 'PartialsEnergy') || strcmp(curFeature, 'soundID') || strcmp(curFeature, 'TimeFrame')
        continue;
    end
    if strncmp(types{i}, 'Complex', 7)
        if ~isfield(targFeatNames, curFeature)
            continue;
        end
        curMean = targ.getFeature([curFeature 'Mean']);
        curStdDev = targ.getFeature([curFeature 'StdDev']);
        curTValue = targ.getFeature(curFeature);
    elseif strcmp(types{i}, 'Array') || strcmp(types{i}, 'Array2D')
        curMean = 0;
        curStdDev = 0;
        curTValue = [0 0 0 0 0];
    else
        continue;
    end
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
%handles.session.getProduction().computeVariableDomains();
