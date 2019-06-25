%
% insertDescriptor.m    : Dynamically insert a new descriptor in the
% database. The whole sounds collection is reprocessed in order to compute
% the values of the new descriptor according to the function pointer passed
% to this function.
%
% connecDB              : Pointer to the SQL connection
% name                  : Name of the new descriptor
% descriptor            : Type of the descriptor
% functionPointer       : Function that handles computation 
%
% Version               : 1.0 / 2009
%
% Author                : Philippe ESLING
%                        <esling@ircam.fr>
%
function insertDescriptorXML(connecDB, name, type, functionPointer)
disp(['Adding descriptor ' name ' to database.']);
% exec(connecDB, 'ALTER TABLE Sounds ADD partialsMeanAmplitude int(33)');
% exec(connecDB, 'ALTER TABLE Sounds ADD noiseMeanEnvelope int(33)');
% exec(connecDB, 'ALTER TABLE Sounds ADD melMeanAmp int(33)');
% exec(connecDB, 'ALTER TABLE Sounds ADD loudnessFactor float');
% exec(connecDB, 'ALTER TABLE Sounds ADD logAttackTime float');
% exec(connecDB, 'ALTER TABLE Sounds ADD noiseMeanEnergy float');
% exec(connecDB, 'ALTER TABLE Sounds ADD noiseSpread float');
% exec(connecDB, 'ALTER TABLE Sounds ADD melNoisiness float');
% exec(connecDB, 'ALTER TABLE Sounds ADD energyModFreq float');
% exec(connecDB, 'ALTER TABLE Sounds ADD partialsMeanEnergy float');
% exec(connecDB, 'ALTER TABLE Sounds ADD loudnessLevel float');
% exec(connecDB, 'ALTER TABLE Sounds ADD melMeanEnergy float');
% exec(connecDB, 'ALTER TABLE Sounds ADD xSpectralCentroid float');
% exec(connecDB, 'ALTER TABLE Sounds ADD xSpectralSpread float');
soundFiles = getValuesList(connecDB, 'file');
disp('Reprocessing whole database.');
for i = 1:length(soundFiles)
    soundFile = soundFiles{i};
    soundFile = regexprep(soundFile, 'orchidee', 'xml/orchidee');
    soundFile = regexprep(soundFile, 'evo', 'xmlEvo/evo');
    soundFile((end - 3):(end + 2)) = '_*.xml';
    [s, soundFile] = unix([ 'find ' soundFile]);
    soundFile(end) = '';
    disp(soundFile);
    if (exist(soundFile, 'file') ~= 2)
        disp([' ! ' soundFile ' not found']);
        continue;
    end
    domFile = xmlread(soundFile);
    % Retrieving current filename
    disp('    o Adding XML values to structure.');
    % Add XML Definitions
    sqlStruct.loudnessFactor = domFile.getElementsByTagName('loudnessFactor').item(0).getChildNodes.item(0).getData;
    sqlStruct.logAttackTime = domFile.getElementsByTagName('logAttackTime').item(0).getChildNodes.item(0).getData;
    sqlStruct.noiseCentroid = domFile.getElementsByTagName('noiseCentroid').item(0).getChildNodes.item(0).getData;
    sqlStruct.noiseSpread = domFile.getElementsByTagName('noiseSpread').item(0).getChildNodes.item(0).getData;
    sqlStruct.melNoisiness = domFile.getElementsByTagName('melNoisiness').item(0).getChildNodes.item(0).getData;
    sqlStruct.energyModFreq = domFile.getElementsByTagName('energyModFreq').item(0).getChildNodes.item(0).getData;
    sqlStruct.partialsMeanEnergy = domFile.getElementsByTagName('partialsMeanEnergy').item(0).getChildNodes.item(0).getData;
    sqlStruct.loudnessLevel = domFile.getElementsByTagName('loudnessLevel').item(0).getChildNodes.item(0).getData;
    sqlStruct.noiseMeanEnergy = domFile.getElementsByTagName('noiseMeanEnergy').item(0).getChildNodes.item(0).getData;
    sqlStruct.melMeanEnergy = domFile.getElementsByTagName('melMeanEnergy').item(0).getChildNodes.item(0).getData;
    sqlStruct.xSpectralCentroid = domFile.getElementsByTagName('spectralCentroid').item(0).getChildNodes.item(0).getData;
    sqlStruct.xSpectralSpread = domFile.getElementsByTagName('spectralSpread').item(0).getChildNodes.item(0).getData;
    fNames = fields(sqlStruct);
    sqlQ = 'UPDATE Sounds SET ';
    for j = 1:length(fNames)
        if (strcmp(sqlStruct.(fNames{j}), 'NaN') == 1)
            sqlStruct.(fNames{j}) = '0';
        end
        sqlQ = [sqlQ ' ' fNames{j} ' = ' char(sqlStruct.(fNames{j})) ','];
    end
    sqlQ(end) = '';
    sqlQ = [sqlQ ' WHERE soundID = ' num2str(i)];
    disp(sqlQ);
    exec(connecDB, sqlQ);
    % Arrays;
%    pMA = str2num(char(domFile.getElementsByTagName('partialsMeanAmplitude').item(0).getChildNodes.item(0).getData));
%    nME = str2num(char(domFile.getElementsByTagName('noiseMeanEnvelope').item(0).getChildNodes.item(0).getData));
%    mMA = str2num(char(domFile.getElementsByTagName('melMeanAmp').item(0).getChildNodes.item(0).getData));
%    disp(pMA);
%    pID = num2str(addStructArray(connecDB, i, pMA));
%    nID = num2str(addStructArray(connecDB, i, nME));
%    mID = num2str(addStructArray(connecDB, i, mMA));
%    sqlQ = ['UPDATE Sounds SET partialsMeanAmplitude = ' pID ', noiseMeanEnvelope = ' nID ', melMeanAmp = ' mID ' WHERE soundID = ' num2str(i)];
%    exec(connecDB, sqlQ);
end
end
