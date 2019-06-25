%
% getSoundsNumber.m         : Retrieving number of sounds in the database
%
% connecDB                  : Pointer to the SQL connection
%
% Version                   : 1.0 / 2009
%
% Author                    : Philippe ESLING
%                            <esling@ircam.fr>
%
function sNumber = getSoundsNumber(connecDB)
sqlQ = 'SELECT MAX(soundID) from Sounds';
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
sNumber = cursor.Data{1};
end
