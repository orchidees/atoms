% OSC_DBQUERY - Instrument knowledge database query
%
% Usage: handles = osc_dbquery(osc_message,handles)
%
function handles = osc_databasequery(osc_message,handles)
% Check input arguments
if length(osc_message.data) < 4
    error('osc_dbgetfieldvalues:IncompleteOscMessage', 'At least 4 argument required for /dbquery.');
end
descriptor = osc_message.data{2};
dFunc = cell2mat(osc_message.data(3:end));
% get query args from OSC message
[resultsID resultsFuncs] = getTemporalQuery(handles.session.getKnowledge().connecDB, dFunc, descriptor, 7);
resultsID = resultsID(1:7, 1);
[resultsID sortID] = sort(resultsID);
resultsFuncs = resultsFuncs(sortID, :);
switch descriptor
    case 'SpectralCentroid'
        descNames = {'SpectralCentroid', 'EnergyEnvelope', 'SpectralSpread'};
        descriptors = {'name', 'family', 'instrument', 'source', 'file', 'note', 'dynamics', 'playingStyle', 'EnergyEnvelopeTString', 'EnergyEnvelopeMean', 'EnergyEnvelopeStdDev', 'SpectralSpreadTString', 'SpectralSpreadMean', 'SpectralSpreadStdDev'};
    case 'EnergyEnvelope'
        descNames = {'EnergyEnvelope', 'SpectralCentroid', 'SpectralSpread'};
        descriptors = {'name', 'family', 'instrument', 'source', 'file', 'note', 'dynamics', 'playingStyle', 'SpectralCentroidTString', 'SpectralCentroidMean', 'SpectralCentroidStdDev', 'NoisinessTString', 'NoisinessMean', 'NoisinessStdDev'};
    otherwise
        descNames = {descriptor, 'SpectralCentroid', 'EnergyEnvelope'};
        descriptors = {'name', 'family', 'instrument', 'source', 'file', 'note', 'dynamics', 'playingStyle', 'SpectralCentroidTString', 'SpectralCentroidMean', 'SpectralCentroidStdDev', 'EnergyEnvelopeTString', 'EnergyEnvelopeMean', 'EnergyEnvelopeStdDev'};
end
symboValues = handles.session.getKnowledge().getFieldsValues(descriptors, resultsID);
message.path = '/databasequery';
message.tt = 'isss';
message.data{1} = 2399;
message.data{2} = descNames{1};
message.data{3} = descNames{2};
message.data{4} = descNames{3};
% Add to OSC buffer
flux{1} = message;
% Send message
osc_send(handles.osc.address,flux);
for i = 1:7
    baseID = 2300 + (i * 10);
    % Build response OSC message
    message.path = '/databasequery';
    message.tt = 'issssssss';
    message.data{1} = baseID;
    message.data{2} = symboValues{i, 1};
    message.data{3} = symboValues{i, 2};
    message.data{4} = symboValues{i, 3};
    message.data{5} = symboValues{i, 4};
    message.data{6} = symboValues{i, 5};
    message.data{7} = symboValues{i, 6};
    message.data{8} = symboValues{i, 7};
    message.data{9} = symboValues{i, 8};
    % Add to OSC buffer
    flux{1} = message;
    % Send message
    osc_send(handles.osc.address,flux);
    % Build response OSC message
    message.path = '/databasequery';
    message.tt = 'i';
    message.data{1} = baseID + 1;
    funcSend = resultsFuncs(i, :);
    tmpFunc = funcSend(~isinf(funcSend));
    funcSend(isinf(funcSend)) = min(tmpFunc);
    [id message] = export_arrayMessage_space(message, 1, funcSend);
    % Add to OSC buffer
    flux{1} = message;
    % Send message
    osc_send(handles.osc.address,flux);
    % Build response OSC message
    message.path = '/databasequery';
    message.tt = 'i';
    message.data{1} = baseID + 2;
    funcSend = invertScaleRepresentation(symboValues{i, 9}, 64, symboValues{i, 10}, symboValues{i, 11});
    tmpFunc = funcSend(~isinf(funcSend));
    funcSend(isinf(funcSend)) = min(tmpFunc);
    [id message] = export_arrayMessage_space(message, 1, funcSend);
    % Add to OSC buffer
    flux{1} = message;
    % Send message
    osc_send(handles.osc.address,flux);
    % Build response OSC message
    message.path = '/databasequery';
    message.tt = 'i';
    message.data{1} = baseID + 3;
    funcSend = invertScaleRepresentation(symboValues{i, 12}, 64, symboValues{i, 13}, symboValues{i, 14});
    tmpFunc = funcSend(~isinf(funcSend));
    funcSend(isinf(funcSend)) = min(tmpFunc);
    [id message] = export_arrayMessage_space(message, 1, funcSend);
    % Add to OSC buffer
    flux{1} = message;
    % Send message
    osc_send(handles.osc.address,flux);
end