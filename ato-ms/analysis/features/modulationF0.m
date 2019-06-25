%function [f0_hz, f0_amp, f0_paramTemps, xMean_v, msqError_v] = FmodulationMB(x, fs)
%
%  Estimation de la modulation de x
%  de la forme x(t) = E(x(t)) + mt + p + E(x(t))*f0_amp*cos(2*pi*f0_hz*t + f0_ph)
%  Donc le résultat f0_amp est normalisé par rapport a la moyenne
%  du signal
%
%  INPUT  : 
%
%  OUTPUT :
%
%
%
function [f0_hz, f0_amp] = modulationF0(snd_v, fs)
x = energyFilter(snd_v, fs, 60);
oldfs = fs;
freqBandHz_v = [4, 50];
fmax = freqBandHz_v(end);
fmin = freqBandHz_v(1);
if fs > 4*fmax && fs > 100,
    nfs = max(4*fmax, 100);
    dfsrate = ceil(fs/nfs);
    nfs = fs / dfsrate;
    x = downsample(x, dfsrate);
    fs  = nfs;
end
windowsize = ceil(3/fmin * fs);
hopsize = floor(1/4*windowsize);
mlag = ceil(2/fmin * fs);
fenetre_v = blackman(windowsize);
norma = sum(fenetre_v);
fftsize = 2^(nextpow2(windowsize)+1);
fmin_bin = fmin * fftsize / fs;
fmax_bin = fmax * fftsize / fs;
freqBand_v = freqBandHz_v  * fftsize / fs;
xframed = frames(x, windowsize, hopsize);
xframed1 = xframed;
xMean_v = mean(xframed);
xframed = xframed - repmat(xMean_v, size(xframed, 1), 1);
polyval_m = [];
for k = 1:size(xframed, 2),
    p = polyfit((1:windowsize)', xframed(:,k), 1);
    polyval_m(:,k) = polyval(p, 1:windowsize)';
    xframed(:,k) = xframed(:,k) - polyval_m(:,k);
end
f0_paramTemps = windowsize/(2*fs) + ((0:size(xframed, 2)-1) * hopsize/fs);
xframed = xframed.*repmat(fenetre_v, 1,size(xframed,2));
xfft = fft(xframed*2/norma, fftsize);
xfft = xfft(1:ceil(end/2), :);
xFramedSyn_m = zeros(size(xframed));
for k = 1:size(xframed, 2),
    pos_v = Fcomparepics2(abs(xfft(:,k)), 2);
    xFramedSyn = 0;
    for b = 1:length(freqBand_v)-1,
        pos2_v = find(pos_v >= freqBand_v(b) & pos_v <= freqBand_v(b+1));
        if ~isempty(pos2_v)
            pos3_v = pos_v(pos2_v);
            [max_value, max_pos] = max(abs(xfft(pos3_v,k)));
            f0_hz(k,b) = (pos3_v(max_pos)-1) * fs / (fftsize) ;
            f0_amp(k,b)  = max_value / xMean_v(k);
            f0_ph(k,b) = angle(xfft(pos3_v(max_pos),k));
            % Resynthèse
            t = (0:windowsize-1)./fs;
            xFramedSyn = xFramedSyn + f0_amp(k,b) * cos(2*pi*f0_hz(k,b)*t + f0_ph(k,b));
            xFramedSyn = xFramedSyn.* fenetre_v';
        else
            f0_hz(k,b) = 0;
            f0_amp(k,b)  = 0;
        end
    end
    msqError_v(k) = 1/windowsize*sum((xframed(:,k)./xMean_v(k)-xFramedSyn').^2)./norm(xframed(:,k));
end
if ~nargout
    % plot waveform
    t=(0:length(x)-1)/fs;
    subplot(3,1,1);
    plot(t,x);
    legend('Waveform');
    xlabel('Time (s)');
    ylabel('Amplitude');    
    t=f0_paramTemps;
    subplot(3,1,2);
    plot(t,f0_hz);
    legend('FO');
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    subplot(3,1,3);
    plot(t,f0_amp*100);
    legend('Mod amp');
    xlabel('Time (s)');
    ylabel('%');
end