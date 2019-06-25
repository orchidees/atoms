%
% databaseFileImport.m  : Importing database from a serialized file
%
% fName                 : Name of the serialized file
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
function databaseFileImport(fName, dbName, host, user, pass)
% First create the corresponding database
connecDB = connectDistant(host, 3306, user, pass, '');
sqlQ = ['DROP DATABASE IF EXISTS ' dbName];
exec(connecDB, sqlQ);
sqlQ = ['CREATE DATABASE ' dbName];
exec(connecDB, sqlQ);
close(connecDB);
mySQLPath = findMySQLPath();
disp(mySQLPath);
hostStr = [' -h ' host];
userStr = [' -u ' user];
if (isempty(pass))
    passStr = '';
else
    passStr = [' -p' pass];
end
finalReq = ['mysql ' hostStr userStr passStr ' ' dbName];
disp(finalReq);
disp([mySQLPath '/' finalReq ' < ' fName]);
system([mySQLPath '/' finalReq ' < ' fName]);
end
