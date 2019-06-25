function [signalI sRate nBits] = importSignal(currentFileChar)
signalI = [];
sRate = 0;
nBits = 32;
[filePath trackFileName fileExt] = fileparts(currentFileChar);
if strcmp(fileExt, '.aif') == 1 || strcmp(fileExt, '.aiff') == 1 
    [signalI sRate format] = aiffread(char(currentFileChar));
    nBits = format(2);
end
if strcmp(fileExt, '.wav') == 1
    [signalI sRate nBits] = wavread(char(currentFileChar));
end
if strcmp(fileExt, '.mp3') == 1
    [signalI sRate] = mp3read(char(currentFileChar));
end
end
