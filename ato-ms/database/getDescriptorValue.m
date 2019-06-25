%
% getDescriptorsValue.m     : Retrieving the value of a specific descriptor
%
% connecDB                  : Pointer to the SQL connection
% soundID                   : ID of the sound to retrieve
% descriptor                : Name of the descriptor
%
% Version                   : 1.0 / 2009
%
% Author                    : Philippe ESLING
%                            <esling@ircam.fr>
%
function dValue = getDescriptorValue(connecDB, soundID, descriptor)
sqlQ = ['SELECT ' descriptor ' from Sounds where soundID = ' num2str(soundID)];
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
dValue = cursor.Data;
end
