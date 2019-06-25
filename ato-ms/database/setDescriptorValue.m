%
% setDescriptorValue.m  : Modify the value of a descriptor in the database
%
% connecDB              : Pointer to the SQL connection
% soundID               : ID of the sound to update
% descriptor            : Name of the descriptor to modify
% value                 : New value for the descriptor
%
% Version               : 1.0 / 2009
%
% Author                : Philippe ESLING
%                        <esling@ircam.fr>
%
function setDescriptorValue(connecDB, soundID, descriptor, value)
if (strcmp(class(value), 'double'))
    sValue = num2str(value);
else
    sValue = ['"' value '"'];
end
sqlQ = ['UPDATE Sounds SET ' descriptor ' = ' sValue];
sqlQ = [sqlQ ' WHERE soundID = ' num2str(soundID)];
exec(connecDB, sqlQ);
end
