function [freqo_F,ampo_F] = FChordSeqOptimized(soundfile,analysedir,sr_hz,f0min,numpartialsin,debut,fin,nbSteps,pm2command)

if nargin < 9
    pm2command = 'pm2';
end

debut_asc = num2str(debut);
fin_asc = num2str(fin);

fmin = f0min;

winsize = max(4/fmin * sr_hz, 1024);
winsize_asc = num2str(winsize);


%%% ATTENTION corriger pm2
fftsize = min(2^(ceil(log2(winsize))+2), 16384);
fftsize_asc = num2str(fftsize);

numpartials = numpartialsin;
numpartials_asc = num2str(numpartials);

step = winsize/4;
step_asc = num2str(step);

devFr = 0.03526492;
devFr_asc = num2str(devFr);

Ct = 0.1;
Ct_asc = num2str(Ct);

Cfcent = 70;
Cf = 2^(Cfcent/1200)-1;
Cf_asc = num2str(Cf);

minPartialsLength = .05; % en sec
minPartialsLength_asc = num2str(minPartialsLength);

chorddur = .01; %% en pourcentage
chorddur_asc = num2str(chorddur);

ch1start_asc = debut_asc;
ch1end_asc = fin_asc;

soundfileRep = strrep(soundfile, ' ', '\ ');

outSdifFile = [analysedir 'tmpPartialsAnalysis.cs.sdif'];
disp([ 'Output SDIF file: ' outSdifFile ]);

if fin == 0,
    command = [pm2command ' -S' soundfileRep ' -Aseqp -Wblackman -p1 -q' numpartials_asc ...
	       ' -M' winsize_asc ' -N'  fftsize_asc ' -I' step_asc ' -a0 -r0 -Ct' Ct_asc ' -Cf' Cf_asc  ...
	       ' --devFR=' devFr_asc ' --devFC=0.0 --devM=1 --devK=3 -L' minPartialsLength_asc ...
	       ' -B' debut_asc ' -l' chorddur_asc ' --chords=' ch1start_asc ',' ch1end_asc ... 
	       ' ' outSdifFile];
       command = [pm2command ' -S' soundfileRep ' -Aseqp -Wblackman -q' numpartials_asc ...
           ' ' outSdifFile ];
else
    command = [pm2command ' -S' soundfileRep ' -Apar -q' numpartials_asc ...
	       ' -M' winsize_asc ' -N'  fftsize_asc ' -I' step_asc ' -a0 -r0 -Ct' Ct_asc ' -Cf' Cf_asc  ...
	       ' --devFR=' devFr_asc ' --devFC=0.0 --devM=1 --devK=3 -L' minPartialsLength_asc ... 
	       ' ' outSdifFile];
       
      command = [pm2command ' -S' soundfileRep ' -Apar -q' numpartials_asc ...
           ' ' outSdifFile];
end

disp(command);
unix(command);

%[snd_v, sr_hz] = FreadSoundFile(soundfile);
%if size(snd_v, 2) >= 2
%    snd_v = mean(snd_v, 2);
%end
%[mel_s] = melBandsSound(snd_v, sr_hz, Ffreq2note2(f0min));

sdiffid = Fsdifopen(outSdifFile);
trc_s = Fsdifread(sdiffid, []);
part_s = [trc_s.data];
Fsdifclose(sdiffid);

fs=1./median(diff([trc_s.time]));

%ld_v = sum(mel_s.value.^.6, 1);
%ldpart_v =  Fevalbp([mel_s.time; ld_v]', (0:length(part_s)-1)./fs+debut);

[ampM] = FtrcToMat(part_s);
[freqM] = FtrcToMat(part_s,[],2);

if isempty(ampM)
    error('orchidee:analysis:damien:FchordSeq:MissingData', ...
        'Analysis window is to small for chordseq analysis.');
end

stepDur = ((size(ampM, 1) * 2) / nbSteps) * 2;
stepLen = (size(ampM, 1) - stepDur) / nbSteps;
freqo_F = zeros(numpartialsin, nbSteps);
ampo_F = zeros(numpartialsin, nbSteps);
%ampStdo_F = zeros(numpartialsin, nbSteps);
pos_v=find(sum(freqM ~= 0,1));
freqM = freqM(:, pos_v);
ampM = ampM(:, pos_v);
for i = 1:nbSteps
    tDeb = ceil(((i - 1) * stepLen) + 1);
    tFin = floor(min(tDeb + stepDur, size(ampM, 1)));
    amp_m = ampM(tDeb:tFin, :);
    freq_m = freqM(tDeb:tFin, :);

    pos_v=find(sum(freq_m ~= 0,1)./size(freq_m,1) > chorddur);
    
    amp1_v = FpartialsMeanStd(amp_m(:,pos_v),[],fs);
    freq1_v = median(freq_m(:,pos_v),1);
    [freqo_v, sp_v] = sort(freq1_v);
    ampo_v = amp1_v(sp_v)';
    %ampStdo_v = ampStd1_v(sp_v)';
    freqo_F(1:length(freqo_v), i) = freqo_v;
    ampo_F(1:length(freqo_v), i) = ampo_v;
    %ampStdo_F(1:length(freqo_v), i) = ampStdo_v;
end
cmd = ['rm -f ' outSdifFile];
%disp(cmd);
unix(cmd);






