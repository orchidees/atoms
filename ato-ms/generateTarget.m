function generateTarget(fileName, nbSnds, polyphonic)
addpath(genpath('./'));
connecDB = connectLocal('root', '', 'ircamSpectralDB');
nbSoundsInDB = getSoundsNumber(connecDB);
disp('Starting generating target.');
if polyphonic == 1
    rndSnds     = floor(rand(nbSnds, 1) * nbSoundsInDB) + 1;
else
    possibleSnds = [];
    while length(possibleSnds) < nbSnds
        dbNotes     = getValuesList(connecDB, 'note');
        selectedNote = dbNotes{ceil(rand(1, 1) * length(dbNotes))};
        noteQuery = struct;
        noteQuery.descriptor = 'note';
        noteQuery.type = 'contains';
        noteQuery.value = cell(2, 1);
        noteQuery.value{1} = selectedNote;
        try
            possibleSnds = cell2mat(getSoundsQuery(connecDB, [noteQuery], 10000));
        catch
            continue;
        end
    end
    rndSnds      = floor(rand(nbSnds, 1) * length(possibleSnds)) + 1;
    rndSnds = possibleSnds(rndSnds);
end
    % Init testing structures
    curSndID    = unique(rndSnds);
    nbSoundsMax = length(curSndID);
    curSndFile  = cell(nbSoundsMax, 1);
    curSndInst  = cell(nbSoundsMax, 1);
    waveform    = cell(nbSoundsMax, 1);
    sRate       = zeros(nbSoundsMax, 1);
    maxLength   = 0;
    maxSRate    = 0;
    disp('- Test structure :');
    disp(['  o Sounds parsed : ' num2str(nbSoundsMax)]);
    for i = 1:nbSoundsMax
        curSndFile{i} = getDescriptorValue(connecDB, curSndID(i), 'file');
        curSndInst{i} = getDescriptorValue(connecDB, curSndID(i), 'instrument');
        disp(['    [' num2str(i) '] : ' char(curSndInst{i}) ':' char(curSndFile{i})]);
        [waveform{i} sRate(i)] = importSignal(['../dbProcessed/' char(curSndFile{i})]);
        waveform{i} = mean(waveform{i}, 2);
        waveform{i} = waveform{i} ./ (max(abs(waveform{i})) + eps);
        if (length(waveform{i}) > maxLength)
            maxLength = length(waveform{i});
        end
        if (sRate(i) > maxSRate)
            maxSRate = sRate(i);
        end
    end
    for i = 1:nbSoundsMax
        tmpLength = length(waveform{i});
        if (tmpLength < maxLength)
            disp(size(waveform{i}));
            waveform{i} = [waveform{i} ; zeros(maxLength - tmpLength, 1)];
        end
    end
    disp('- Starting combining sounds');
    mixture     = zeros(maxLength, 1);
    for i = 1:nbSoundsMax
        mixture = mixture + waveform{i};
    end
    wavwrite(mixture ./ (max(abs(mixture)) + eps), maxSRate, 32, fileName);
end

