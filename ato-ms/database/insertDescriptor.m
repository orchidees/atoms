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
function insertDescriptor(connecDB, name, type, functionPointer)
disp(['Adding descriptor ' name ' to database.']);
exec(connecDB, ['ALTER TABLE Sounds ADD ' name ' ' type]);
soundFiles = getValuesList(connecDB, 'file');
disp('Reprocessing whole database.');
for i = 1:length(soundFiles)
    soundFile = soundFiles{i};
    if (exist(soundFile, 'file') ~= 2)
        disp([' ! ' soundFile ' not found']);
        continue;
    end
    dValue = functionPointer(soundFile);
    disp(['  o ' soundFile ' : ' dValue]);
    setDescriptorValue(connecDB, i, name, dValue);
end
end
