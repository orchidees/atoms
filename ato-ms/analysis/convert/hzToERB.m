% e=hzToERB(f,formula) - convert frequency from Hz to erb-rate scale 
%
% Params :
%    - f        : Frequency in Hz
%    - formula  : 'glasberg90' / 'moore83'
% Returns :
%    - e        : ERB rate
%

function e = hzToERB(f, formula)
if nargin<2
    formula='glasberg90'; 
end
switch formula
    case 'glasberg90'
        e = 9.26*log(0.00437*f + 1);
    case 'moore83'
    	erb_k1 = 11.17;
        erb_k2 = 0.312;
    	erb_k3 = 14.675;
    	erb_k4 = 43;
    	f=f / 1000;
    	e = erb_k1 * log((f + erb_k2) ./ (f + erb_k3)) + erb_k4;
    otherwise
        error('Analysis::Eunexpected formula');
end
