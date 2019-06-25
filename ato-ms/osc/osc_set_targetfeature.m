% OSC_SET_TARGETPARAMETERS - Set target analysis parameters
%
% Usage: handles = osc_set_targetparameters(osc_message,handles)
%

function handles = osc_set_targetfeature(osc_message,handles)
% Check that a session is opened
if isempty(handles.session)
    error('osc_set_targetfeature:EmptySession', 'No session has been opened');
end
% 
if length(osc_message.data) < 5
    error('osc_set_targetfeature:BadArgumentNumber', 'Too few arguments for /settargetfeature.');
end
featureName = osc_message.data{2};
featureMean = osc_message.data{3};
featureDev = osc_message.data{4};
featureFunc = osc_message.data(5:end);
% Applying the feature modification
handles.session.getTarget().modifyFeature(featureName, cell2mat(featureFunc)');
handles.session.getTarget().modifyFeature([featureName 'Mean'], featureMean);
handles.session.getTarget().modifyFeature([featureName 'StdDev'], featureDev);
