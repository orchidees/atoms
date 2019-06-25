% pathHandler.m     : Add or remove source directories to the Matlab path.
%
% mode: 
%   - 'load'        : Add directories to path
%   - 'unload'      : Remove directories from path
%
function pathHandler(mode)

pathes = { ...
    'utils/' ...
    'sdif/' ...
    };
root_dir = which('pathHandler.m');
root_dir = strrep(root_dir,'pathHandler.m','');
switch mode
    case 'load'
        cmd = 'addpath';
    case 'unload'
        cmd = 'rmpath';
    otherwise
        error([ mode ' : unknown path handling mode.']);
end
eval([cmd ' ' root_dir ])
for k = 1:length(pathes)
    eval([cmd ' ' root_dir pathes{k}])
end