%
% removeSound.m     : Remove a sound from the database by its ID
%
% connecDB          : Pointer to the SQL connection
% soundID           : ID of the sound to remove
%
% Version           : 1.0 / 2009
%
% Author            : Philippe ESLING
%                    <esling@ircam.fr>
%
function removeSound(connecDB, soundID)
sqlQ = ['DELETE FROM Sounds WHERE soundID = ' num2str(soundID)];
exec(connecDB, sqlQ);
end
