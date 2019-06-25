%
% removeFamily.m    : Remove a whole family from the database
%
% connecDB          : Pointer to the SQL connection
% family            : Name of the family
%
% Version           : 1.0 / 2009
%
% Author            : Philippe ESLING
%                    <esling@ircam.fr>
%
function removeFamily(connecDB, family)
sqlQ = ['DELETE FROM Sounds WHERE family = "' family '"'];
exec(connecDB, sqlQ);
end