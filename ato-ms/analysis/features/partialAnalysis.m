% FchordSeq2        : Main function for partials analysis
%
%
function [freqo_v, ampo_v, freq_m, amp_m] = partialAnalysis(sdifFile, snd_v, sr_hz, f0min, nMIPs)
freqo_v = [];
chorddur = .06;
iter = .01;
while (size(freqo_v, 2) == 0 && chorddur >= 0)
    % Required chord duration
    chorddur = chorddur - iter;
    % Compute mel bands
    [mel_s] = melBandsSound(snd_v, sr_hz, hzToNote(f0min));
    % Open SDIF file obtained from pm2 partials
    sdiffid = Fsdifopen(sdifFile);
    % Retrieve partials data
    trc_s = Fsdifread(sdiffid, []);
    part_s = [trc_s.data];
    Fsdifclose(sdiffid);
    % Find sampling frequency
    fs = 1./median(diff([trc_s.time]));
    % Evalute loudness values
    ld_v = sum(mel_s.value.^.6, 1);
    % ??? Evaluate band partials ???
    ldpart_v =  Fevalbp([mel_s.time; ld_v]', (0:length(part_s)-1)./fs);
    % Transform SDIF structure into amplitude and frequency matrix
    [amp_m] = FtrcToMat(part_s);
    [freq_m] = FtrcToMat(part_s,[],2);
    % Check if no amplitude data
    if isempty(amp_m)
        error('orchidee:analysis:damien:FchordSeq:MissingData', ...
            'Analysis window is to small for chordseq analysis.');
    end
    %
    % Test to discriminate too small partials
    %
    % TO FIX :
    % - Is this test really worth for temporal case.
    % - Real test should maximize partial continuity
    % - No real peak picking ?
    % - MAYBE NEED TO PRE-SORT PARTIALS VECTOR
    % - THAT WAY WE COULD OBTAIN GOOD CONTINUITY ?
    % - NEED TO PLOT / DISP VALUES AT EACH LINE !
    %
    pos_v=find(sum(freq_m > f0min) ./ size(freq_m,1) > chorddur);
    % Get selected partials
    freqo_v = freq_m(:, pos_v);
    ampo_v = amp_m(:, pos_v);
    if (isempty(ampo_v))
        continue;
    end
    % Get partials mean and standard deviations from amplitude
    [amp2_m, ampStd1_v, stdN_v] = FpartialsMeanStd(amp_m(:,pos_v),ldpart_v,fs);
    % Retrieve corresponding mean frequencies
    freq1_v = mean(freq_m(:,pos_v),1);
    % Sort partials in ascending frequency order
    [freq_m, sp_v] = sort(freq1_v);
    amp_m = amp2_m(sp_v);
    %
    % Temporal partials information
    %
    % TO FIX :
    % - Maybe the discriminative test for positions (in partMeanStd) is not
    % accountable for the temporal information ! Will have to be tested.
    %
    freqo_v = freqo_v(:, sp_v);
    ampo_v = ampo_v(:, sp_v);
    lenMat = sum(freqo_v > f0min) ./ size(freqo_v,1);
    [lenMat, lenID] = sort(lenMat);
    lenID = lenID((end-min(length(lenID), nMIPs)):end);
    freq_m = freq_m(lenID);
    amp_m = amp_m(lenID);
    freqo_v = freqo_v(:, lenID);
    ampo_v = ampo_v(:, lenID);
    
end






