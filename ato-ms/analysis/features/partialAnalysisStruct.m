function [ Pa ] = partialAnalysisStruct(partF, partA, partFM, partAM)
Pa = struct;
Pa.partFrq = struct;
Pa.partFrq.name = 'PartialsFrequency';
Pa.partFrq.value =  partF.';
Pa.partAmp = struct;
Pa.partAmp.name = 'PartialsAmplitude';
Pa.partAmp.value =  partA.';
Pa.partFrqM = struct;
Pa.partFrqM.name = 'PartialsMeanFrequency';
Pa.partFrqM.value =  partFM.';
Pa.partAmpM = struct;
Pa.partAmpM.name = 'PartialsMeanAmplitude';
Pa.partAmpM.value =  partAM.';
end
