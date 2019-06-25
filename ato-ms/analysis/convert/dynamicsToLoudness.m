% Fdyn2loudnessLevel        : Transform symbolic dynamics to loudness val
%
%
function [ldl_v] = dynamicsToLoudness(dyn_c)
dynref_c = {'fff'; 'ff'; 'f'; 'mf'; 'mp';'p'; 'pp'; 'fp'; 'ppff'; 'ffpp'; 'ppmfpp'};
ldlref_v = [33,28,23,18,15,8,3,15,18,16,8];
if ~iscell(dyn_c)
    dyn_c = {dyn_c};
end
ldl_v = zeros(size(dyn_c));
for k = 1:length(dyn_c)
    valID = find(strcmp(dyn_c{k},dynref_c));
    if isempty(valID)
        ldl_v(k) = 18;
    else
        ldl_v(k) = ldlref_v(valID);
    end
end