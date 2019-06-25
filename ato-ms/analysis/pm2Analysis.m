function pm2Analysis(filename, sr_hz, minf0, nMIPs, pm2command)

filename = strrep(filename, ' ', '\ ');

fmin = minf0;

winsize = max(4/fmin * sr_hz, 1024);
winsize_asc = num2str(winsize);

fftsize = min(2^(ceil(log2(winsize))+2), 16384);
fftsize_asc = num2str(fftsize);

numpartials = nMIPs;
numpartials_asc = num2str(numpartials);

step = winsize/2;
step_asc = num2str(step);

devFr = 0.02;
devFr_asc = num2str(devFr);

Ct = 0.01;
Ct_asc = num2str(Ct);

Cfcent = 20;
Cf = 2^(Cfcent/1200)-1;
Cf_asc = num2str(Cf);

minPartialsLength = .015; % en sec
minPartialsLength_asc = num2str(minPartialsLength);

options = ['-Wblackman -p1 -q' numpartials_asc ...
	       ' -M' winsize_asc ' -N'  fftsize_asc ' -I' step_asc ...
           ' -a0 -r0 -Ct' Ct_asc ' -Cf' Cf_asc  ' --devFR=' devFr_asc ...
           '--devFC=0.0 --devM=1 --devK=3 -L' minPartialsLength_asc ' '];

optionsF0 = ['-Wblackman -p1 -q' numpartials_asc ...
           ' -a0 -r0 -Ct' Ct_asc ' -Cf' Cf_asc  ' --devFR=' devFr_asc ...
           '--devFC=0.0 --devM=1 --devK=3 -L' minPartialsLength_asc ' '];
       
system([pm2command ' -S' filename ' -Apar ' options '/tmp/analysisFile.par.sdif']);
system([pm2command ' -S' filename ' -Af0 ' optionsF0 '/tmp/analysisFile.f0.sdif']);

end
