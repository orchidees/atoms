function soundsets_features = compute_features(population,features)

% COMPUTE_FEATURES - Ouput a structure of feature matrices for
% each feature in the input feature cell array. In each feature
% matrix, each line i is the estimation of the feature vector for
% the soundset i. COMPUTE_FEATURES is a generic method that calls
% appropriate methods in the /compute/ sub-directory.
%
% Usage: soundsets_features = compute_features(feature_structure,soundsets,features)
%

Ndescriptors = length(features);

% Iterate on input feature cell array
for k = 1:Ndescriptors
    featName = features{k}.getFeatureName();
    soundsets_features.(featName) = features{k}.addition(population);
end
