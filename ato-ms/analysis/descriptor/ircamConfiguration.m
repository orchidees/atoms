function [ defaultParams ] = ircamConfiguration(writeConfig, changeParams)
if nargin == 0
    writeConfig = 1;
    changeParams = [];
end
if nargin == 1
    changeParams = [];
end
defaultParams = struct;
defaultParams.parameters = struct;
% [Parameters]
% Internal sampling rate of the program [11025-44100]
defaultParams.parameters.ResampleTo = 44100;
% Apply normalization to the input file [0-1]
defaultParams.parameters.NormalizeSignal = 1;
% The window applied to every frame [hanning blackman hamming hanning2]
defaultParams.parameters.WindowType = 'blackman';
% Saves or not the short time temporal features [0-1]
defaultParams.parameters.SaveShortTermTMFeatures = 1;
% Enables the DC offset removal frame by frame [0-1]
defaultParams.parameters.SubstractMean = 0;
% Max lag to compute the autocorrelation [1-N]
defaultParams.parameters.AutoCorrelationCoeffs = 12;
% Number of frequency bands used for Flatness and Crest [1-4]
defaultParams.parameters.ReducedBands = 4;
% Number of Mel Bands [10-24]
defaultParams.parameters.PerceptualBands = 24;
% Number of MFCCs [1-N]
defaultParams.parameters.MFCCs = 13;
% Max number of harmonics for harmonic analysis [1-N]
defaultParams.parameters.Harmonics = 20;
% Cutoff frequency for F0 estimation [1 - ResamplingTo/2]
defaultParams.parameters.F0MaxAnalysisFreq = 3000;
% Minimum detected F0 frequency [1 - ResamplingTo/2]
defaultParams.parameters.F0MinFrequency = 200;
% Maximum detected F0 frequency [F0MinFrequency - ResamplingTo/2]
defaultParams.parameters.F0MaxFrequency = 1000;
% Thresholding of the spectrum in F0 detection [0-1]
defaultParams.parameters.F0AmpThreshold = 1;
% Trigger the computation of the F0 modulation descriptor [0-1]
defaultParams.parameters.F0AmplitudeModulation = 0;
% The percentage of energy used by the rolloff descriptors [0.0-1.0]
defaultParams.parameters.RolloffThreshold = 0.95;
% Max number of bands to use in the deviation [1-Harmonics/MFCC]
defaultParams.parameters.DeviationStopBand = 10;
% Percentage of the maximum value of the loudness (or energy) [0.0-1.0]
defaultParams.parameters.DecreaseThreshold = 0.4;
% Percentage of the maximum value of the loudness (or energy) [0.0-1.0]
defaultParams.parameters.NoiseThreshold = 0.15;
% The minimum F0 for chroma [1-ChromaFreqMax]
defaultParams.parameters.ChromaFreqMinHz = 77;
% Maximum F0 for Chroma [ChromaFreqMin-ResampleTo/2]
defaultParams.parameters.ChromaFreqMinHz = 1500;
% The resolution of Chroma in semitones [0.0001 - 12]
defaultParams.parameters.ChromaResolution = 1;
% Normalize or not the chroma result [0-1]
defaultParams.parameters.ChromaNormmax = 1;
% Size of the median filter [1-N (odd)]
defaultParams.parameters.MedianFilterOrder = 5;
% Normalization of the median filter [0-1]
defaultParams.parameters.MedianFilterNormalize = 1;
% Triggers the computation of attack, decrease ... based on Loudness [0-1]
defaultParams.parameters.DynamicMorfologicFeatures = 0;
%[StandardDescriptors]
% Size of analysis window [seconds]
defaultParams.standard.WindowSize = 0.06;
% Size of analysis step [seconds]
defaultParams.standard.HopSize = 0.02;
% Compute temporal modelings every N frame, not on whole file [1-N]
defaultParams.standard.TextureWindowsFrames = -1;
% Step size for texture windows in number of short time descriptors
defaultParams.standard.TextureWindowsHopFrames = -1;
% [EnergyDescriptors]
% Size of analysis window [seconds]
defaultParams.energy.WindowSize = 0.1;
% Size of analysis step [seconds]
defaultParams.energy.HopSize = 0.002;
% Compute temporal modelings every N frame, not on whole file [1-N]
defaultParams.energy.TextureWindowsFrames = -1;
% Step size for texture windows in number of short time descriptors
defaultParams.energy.TextureWindowsHopFrames = -1;
% Compute following temporal descriptors
defaultParams.energy.TemporalIncrease = 1;
defaultParams.energy.TemporalDecrease = 1;
defaultParams.energy.TemporalCentroid = 1;
defaultParams.energy.EffectiveDuration = 1;
defaultParams.energy.LogAttackTime = 1;
defaultParams.energy.AmplitudeModulation = 1;
defaultParams.energy.EnergyEnvelope = 1;
if writeConfig
    fid = fopen('ircamDescriptor.cfg', 'w');
    fprintf(fid, '\n[Parameters]\n\n');
    paramNames = fieldnames(defaultParams.parameters);
    for i = 1:length(paramNames)
        if ~isempty(changeParams) && isfield(changeParams, 'parameters') && isfield(changeParams.parameters, (paramNames{i}))
            if strcmp(paramNames{i}, 'WindowType')
                fprintf(fid, '%s = %s\n', paramNames{i}, changeParams.parameters.(paramNames{i}));
            else
                fprintf(fid, '%s = %f\n', paramNames{i}, changeParams.parameters.(paramNames{i}));
            end
        else
            if strcmp(paramNames{i}, 'WindowType')
                fprintf(fid, '%s = %s\n', paramNames{i}, defaultParams.parameters.(paramNames{i}));
            else
                fprintf(fid, '%s = %f\n', paramNames{i}, defaultParams.parameters.(paramNames{i}));
            end
        end
    end
    fprintf(fid, '\n[StandardDescriptors]\n\n');
    paramNames = fieldnames(defaultParams.standard);
    for i = 1:length(paramNames)
        if ~isempty(changeParams) && isfield(changeParams, 'standard') && isfield(changeParams.standard, (paramNames{i}))
            fprintf(fid, '%s = %f\n', paramNames{i}, changeParams.standard.(paramNames{i}));
        else
            fprintf(fid, '%s = %f\n', paramNames{i}, defaultParams.standard.(paramNames{i}));
        end
    end
    fprintf(fid, '\n');
    fidDesc = fopen('configurationFull.desc');
    tline = fgetl(fidDesc);
    while ischar(tline)
        fprintf(fid, '%s\n', tline);
        tline = fgetl(fidDesc);
    end
    fclose(fidDesc);
    fprintf(fid, '\n[EnergyDescriptors]\n\n');
    paramNames = fieldnames(defaultParams.energy);
    for i = 1:length(paramNames)
        if ~isempty(changeParams) && isfield(changeParams, 'energy') && isfield(changeParams.energy, (paramNames{i}))
            fprintf(fid, '%s = %f\n', paramNames{i}, changeParams.energy.(paramNames{i}));
        else
            fprintf(fid, '%s = %f\n', paramNames{i}, defaultParams.energy.(paramNames{i}));
        end
    end
end
end

