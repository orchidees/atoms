%
% retrieveWaveform.m
%
%
% Version               : 1.0 / 2009
%
% Author                : Philippe ESLING
%                        <esling@ircam.fr>
%
function [signal sRate] = retrieveWaveform(connecDB, soundID)
soundFile = getDescriptorValue(connecDB, soundID, 'file');
soundFile = soundFile{1};
if (exist(soundFile, 'file') ~= 2)
	disp([' ! ' soundFile ' not found']);
	return;
end
[signal, sRate] = importSignal(char(soundFile));
end
