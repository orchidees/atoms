function [db_s] = FputAmpMeanInDBstruct(db_s, pos_v, handles,descFile)
if nargin < 3
    handles = [];
end
fid = -1;
loudnessExp = .6;
check_interruption();
server_says(handles,'Processing mean partial amplitudes',0);
if nargin < 2
    pos_v = 1:length(db_s.data_s);
end
if nargin < 4
    descFile = '/tmp/mel/analysisFile.mel.mat';
    descPart = '/tmp/analysisFile.part.sdif';
end
lastwarn('')
for k = pos_v
    if exist(descPart, 'file')
        sdiffid = Fsdifopen(descPart);
        trc_s = Fsdifread(sdiffid, []);
        part_s = [trc_s.data];
        Fsdifclose(sdiffid);
        amp_m = FtrcToMat(part_s, 100);
    end
    mel_s = Fload(descFile,1);
    %targetLoudness =  dynLoudness_c{...
    %    strmatch(db_s.data_s(k).dynamique,dynLoudness_c(:,1), ...
    %    'exact'), 2};
    targetLoudness = dynamicsToLoudness(db_s.data_s(k).dynamique);
    N6source  = FcalcN6(mel_s);
    %N6cible =  dynLoudness_c{...
    %    strmatch(db_s.data_s(k).dynamique,dynLoudness_c(:,1), ...
    %    'exact'), 2};
    N6cible = dynamicsToLoudness(db_s.data_s(k).dynamique);    
    L6source = 2^(N6source/10);
    L6cible = 2^(N6cible/10);
    ld_v = sum(mel_s.value.^.6, 1);
    Lfacteur = L6cible^(1/loudnessExp) ./ ...
        L6source^(1/loudnessExp);
    if exist('sdiffid')
        amp_m = amp_m .* Lfacteur;
        fs=1./median(diff([trc_s.time]));
        [ampMean_v, ampStd_v, ampStdN_v] = FpartialsMeanStd(amp_m,ld_v,fs);
        ampMeanNorm = norm(ampMean_v);
        fs=100;
        clear fs;
        db_s.data_s(k).ampMean_v = ampMean_v ./ ampMeanNorm;
        db_s.data_s(k).ampMeanEner = ampMeanNorm^2;
    else
        db_s.data_s(k).ampMean_v = ones(100,1)*NaN;
        db_s.data_s(k).ampMeanEner = NaN;
    end
    db_s.data_s(k).Lfacteur = Lfacteur;
    lastMsg = lastwarn;
    if ~isempty(lastMsg)
        fprintf(fid, '%s   %s\n', db_s.data_s(k).file, ...
            lastMsg);
        lastwarn('');
    end
    check_interruption();
    server_says(handles,'Processing mean partial amplitudes',k/length(db_s.data_s));
end
logClose(fid);

