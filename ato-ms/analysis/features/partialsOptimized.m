function [freqMIPs,ampMIPs, freqMEANs, ampMEANs, ampDevMIPs] = partialsOptimized(sf, ANAL_DIR, f0min, nMIPs, pm2command)

if nargin < 5
    pm2command = 'pm2';
end

if nargin < 4
    nMIPs = 15;
end

if nargin < 3
    f0min = 20;
end

nbSteps = 64;

[tmp_v, sr_hz] = importSignal(sf);

t_debut = 0.0;
t_fin = length(tmp_v) ./ sr_hz;

freqMIPs = zeros(nMIPs, nbSteps);
ampMIPs = zeros(nMIPs, nbSteps);
ampDevMIPs = zeros(nMIPs, nbSteps);
%disp(' ... pm2 chordseq');
[freq_v,amp_v] = FChordSeqOptimized(sf, ANAL_DIR, sr_hz, f0min, nMIPs*3, t_debut, t_fin, nbSteps, pm2command);
%disp(' ... auditory model filter');
for i = 1:(nbSteps)
    [F_MIPs,A_MIPs] = Fmips2(freq_v(:, i),amp_v(:,i),nMIPs, f0min);
    if length(F_MIPs) == nMIPs
        freqMIPs(:, i) = F_MIPs;
        ampMIPs(:, i) = A_MIPs;
    else
        if ~isempty(F_MIPs)
            if length(F_MIPs) < nMIPs
                freqMIPs(1:length(F_MIPs), i) = F_MIPs;
                ampMIPs(1:length(F_MIPs), i) = A_MIPs;
            else
                freqMIPs(:, i) = F_MIPs(1:nMIPs);
                ampMIPs(:, i) = A_MIPs(1:nMIPs);
            end
        end
    end
    %ampDevMIPs(:, i) = Astd_MIPs;
end
% Computing mean values
[freqMEANs, ampMEANs] = Fmips2(mean(freq_v, 2), mean(amp_v, 2), nMIPs, f0min);

end

