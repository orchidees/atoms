% extractMIPs3          : Launch computation of more important partials
% 
% Params :
%   - soundFile         : name of soundfile
%   - analysisDir       : directory for temporary files
%   - f0min             : minimal F0 to use
%   - nMIPs             : number of MIP to extract
%   - soundFile         : name of soundfile
%   - tBegin            : begining time
%   - tEnd              : ending time
%   - pm2command        : where to find pm2
% Returns :
%   - F_MIPs            : frequencies of MIPs
%   - A_MIPs            : amplitude of MIPs
%   - Astd_MIPs         : ampDeviation of MIPs
%
function [F_MIPs,A_MIPs,Astd_MIPs] = extractMIPs3(soundFile, analysisDir, f0min, nMIPs, tBegin, tEnd, pm2command)
if nargin < 7
    pm2command = 'pm2';
end
if nargin < 6
    tEnd = 1.5;
end
if nargin < 5
    tBegin = 0.5;
end
if nargin < 4
    nMIPs = 25;
end
if nargin < 3
    f0min = 20;
end
[tmp_v, sr_hz] = FreadSoundFile(soundFile, 2);
%disp(' ... pm2 chordseq');
[freq_v, amp_v, ampStd_v] = FchordSeq(soundFile, analysisDir, sr_hz, f0min, nMIPs*5, tBegin, tEnd, pm2command);
%disp(' ... auditory model filter');
[F_MIPs, A_MIPs, Astd_MIPs] = Fmips2(freq_v, amp_v, ampStd_v, nMIPs, f0min);

