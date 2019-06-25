function [target_s] = launchSoundAnalysis(soundFile, minf0, nMIPs, t_begin, t_end, pm2command, sqlStruct, handles)
if (nargin < 7)
    sqlStruct = getSQLStructureTemplate();
end
if (nargin < 8)
    handles = [];
end
% Import signal from filename
[data_v, sr_hz] = importSignal(soundFile);
% Checking if end time is before end of file
%eof = size(data_v,1)/sr_hz;
%if t_end > eof
%    t_end = eof*0.999;
%end
% Computing begin and end index
% i_begin = max(floor(t_begin*sr_hz),1);
% i_end = floor(t_end*sr_hz);
% data_v = data_v(i_begin:i_end,1);
% Writing segment to temporary analysis file
%if sr_hz ~= 44100
%    data_v = resample(data_v, 44100, sr_hz);
%    sr_hz = 44100;
%end
%wavwrite(data_v, sr_hz, 24, [filename '.wav']);
% Computing new begin and end time
% t_begin = 0;
% t_end = (i_end-i_begin)/sr_hz;
server_says(handles,'Analysis', 0.05);
%server_says(handles,'Analysis : pm2.', 0.15);
%pm2Analysis(soundFile, sr_hz, minf0, nMIPs, pm2command);
%server_says(handles,'Analysis : pm2.', 0.25);
%server_says(handles,'Analysis', 0.3);
server_says(handles,'Analysis : IRCAMDescriptor.', 0.2);
%ircamdescriptor('-a', 'readlist');
%ircamdescriptor('-a', 'extraction', '-iadd', [filename '.par.sdif'], '-if0', [filename '.f0.sdif'], '-i', soundFile, '-omat', [filename '.desc.mat']);
target_s = struct;
target_s.D  = ircamDescriptors(soundFile);
server_says(handles,'Analysis : IRCAMDescriptor.', 0.4);
%load([filename '.desc.mat']);

server_says(handles,'Analysis : Main partials analysis.', 0.55);
[partF, partA, partFM, partAM] = partialsOptimized(soundFile, '/tmp/', minf0, nMIPs, pm2command);
partialStruct = partialAnalysisStruct(partF, partA, partFM, partAM);
target_s.Pa = partialStruct;
server_says(handles,'Analysis : Main partials analysis.', 0.7);
server_says(handles,'Analysis', 0.75);
server_says(handles,'Analysis : Mel band analysis.', 0.8);
if (exist('/tmp/filtreMel.mat', 'file'))
    load('/tmp/filtreMel.mat');
    [meln_s] = melBandsSoundFix(data_v, sr_hz, filtre_m);
else
    [meln_s, filtre_m] = melBandsSoundFix(data_v, sr_hz);
    save('/tmp/filtreMel.mat', 'filtre_m');
end
posVirg = find(sqlStruct.note == ',', 1);
if ~isempty(posVirg)
    tmpNote = sqlStruct.note(1:(posVirg(1) - 1));
else
    tmpNote = sqlStruct.note;
    if strcmp(tmpNote, 'NA')
        tmpNote = 'A4';
    end
end
mel_s = melBandsSound(data_v, sr_hz, tmpNote);
[melStruct partEner partMeanEner] = melBandsStruct(meln_s, mel_s, sqlStruct.dynamics, partA, partAM);
target_s.Me = melStruct;
target_s.Pa.PartialsEnergy = partEner;
target_s.Pa.PartialsMeanEnergy = partMeanEner;
server_says(handles,'Analysis : Mel band analysis.', 0.9);
server_says(handles,'Analysis', 1);

% [f0_hz, f0_amp] = modulationF0(data_v, sr_hz);

% Specific call to compute MIPs
% TO FIX :
% - Only mean partials, need to modify MIPs3 (for temporal)
% - Restart from filename ? why not from extracted signal ?
% - Analysis for target MIPs is different from DB (because delta shit !)
% - WARNING ! Subsequent call FBAnalyseDB erase the MIPS !!!!!
% if compute.mips
%     server_says(handles,'Main partials analysis',0);
%     [F,A, Astd] = extractMIPs3(filename,DIR,minf0,nMIPs,t_begin,t_end,pm2command);
%     server_says(handles,'Main partials analysis',1);
%     target_s.freqMIPs_v = reshape(F,1,[]);
%     target_s.ampMIPs_v = reshape(A,1,[]);
%     ampMeanNorm = norm(A);
%     target.freqMean_v = F(:);
%     target.ampMean_v = A(:) ./ ampMeanNorm;
%     target.ampMeanEner = ampMeanNorm^2;    
% end

