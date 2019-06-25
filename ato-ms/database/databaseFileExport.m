%
% databaseFileExport.m  : Exporting database to a file
%
% The whole database is exported to a single serialized file.
%
% fName                 : Name of the exporting file
% host                  : Adress of host for the database
% user                  : Username for the connection
% pass                  : Password for the connection
% dbName                : Name of the database
%
% Version               : 1.0 / 2009
%
% Author                : Philippe ESLING
%                        <esling@ircam.fr>
%
function databaseFileExport(fName, dbName, host, user, pass)
mySQLPath = findMySQLPath();
fileStr = [' -r' fName];
hostStr = [' -h ' host];
userStr = [' -u ' user];
if (isempty(pass))
    passStr = '';
else
    passStr = [' -p' pass];
end
finalReq = ['mysqldump ' hostStr userStr passStr fileStr ' ' dbName];
system([mySQLPath '/' finalReq]);
end
