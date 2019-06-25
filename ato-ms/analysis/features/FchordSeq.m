function [freqo_v,ampo_v,ampStdo_v] = FchordSeq(soundfile,analysedir,sr_hz,f0min,numpartialsin,debut,fin,pm2command)


if nargin < 8
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

outSdifFile = [analysedir '' Ffiletodirroot(soundfile)];
disp([ 'Output SDIF file: ' outSdifFile ]);
options = ['-Wblackman -p1 -q' numpartials_asc ' --f0min=50' ...
	       ' -M' winsize_asc ' -N'  fftsize_asc ' -I' step_asc ...
           ' -a0 -r0 -Ct' Ct_asc ' -Cf' Cf_asc  ' --devFR=' devFr_asc ...
           '--devFC=0.0 --devM=1 --devK=3 -L' minPartialsLength_asc ' -l' chorddur_asc ' '];

system([pm2command ' -S' soundfile ' -Apar ' options outSdifFile '.par.sdif']);
system([pm2command ' -S' soundfile ' -Af0  ' options outSdifFile '.f0.sdif']);

[snd_v, sr_hz] = FreadSoundFile(soundfile);
[mel_s, filtre_s] = melBandsSound(snd_v, sr_hz, hzToNote(f0min));

sdiffid = Fsdifopen([outSdifFile '.par.sdif']);
trc_s = Fsdifread(sdiffid, []);
part_s = [trc_s.data];
Fsdifclose(sdiffid);

fs=1./median(diff([trc_s.time]));

ld_v = sum(mel_s.value.^.6, 1);
ldpart_v =  Fevalbp([mel_s.time; ld_v]', (0:length(part_s)-1)./fs+debut);
[amp_m] = FtrcToMat(part_s);
[freq_m] = FtrcToMat(part_s,[],2);

if isempty(amp_m)
    error('orchidee:analysis:damien:FchordSeq:MissingData', ...
        'Analysis window is to small for chordseq analysis.');
end


pos_v=find(sum(freq_m ~= 0,1)./size(freq_m,1) > chorddur);

[amp1_v, ampStd1_v, stdN_v] = FpartialsMeanStd(amp_m(:,pos_v),ldpart_v,fs);
freq1_v = median(freq_m(:,pos_v),1);
[freqo_v, sp_v] = sort(freq1_v');
ampo_v = amp1_v(sp_v)';
ampStdo_v = ampStd1_v(sp_v)';


cmd = ['rm -f ' outSdifFile];
%disp(cmd);
unix(cmd);






