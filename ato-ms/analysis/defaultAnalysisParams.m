%
% defaultAnalysisParmas.m   : Default parameters for IRCAMDescriptor
%
% This function returns a set of analysis parameters to give for
% IRCAMDescriptor when analyzing a sound
%
% Version                   : 1.0 / 2009
%
% Author                    : Philippe ESLING
%                            <esling@ircam.fr>
%
function [params_values,params_class,params_range] = defaultAnalysisParams()
% Starting time
params_values.t1 = 0.0;
% Ending time
params_values.t2 = inf;
% Frequency resolution (Hz)
params_values.fmin = 50;
params_values.fmin_hz = 50;
% Number of extracted partials
params_values.npartials = 50;
% Threshold for mapping between target partials
params_values.delta = 0.015;
% Automatic threshold for microtonal resolution
params_values.autodelta = 1;
% Extraction mode of partials
% params_values.partialsmode = 'ChordSeq+ERB';
params_class.t1 = 'double';                     
params_class.t2 = 'double';                     
params_class.fmin = 'double';                       
params_class.npartials = 'double';                  
params_class.delta = 'double';                   
params_class.autodelta = 'double';                   
%params_class.partialsmode = 'char';
params_range.t1 = [0 inf];                     
params_range.t2 = [0 inf];                     
params_range.fmin = [0 10000];                       
params_range.npartials = [0 100];                  
params_range.delta = [0 0.2];                   
params_range.autodelta = { 0 1 };                   
%params_range.partialsmode = { 'ChordSeq+ERB' 'ChordSeq' };   