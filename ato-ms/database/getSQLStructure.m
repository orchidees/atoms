function sound = getSQLStructure()
sound = getSQLStructureTemplate();
% Section features (new table (?))
sound = analyzeSound('emptyTarget.wav', defaultAnalysisParams(), sound);
end
