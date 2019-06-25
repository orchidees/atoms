%
% connectLocal.m    : Connecting to a local database
%
% Host is assumed to be 'localhost' and port to be 3306
%
% user              : Username for the connection
% pass              : Password for the connection
% dbName            : Name of the database
%
% Version           : 1.0 / 2009
%
% Author            : Philippe ESLING
%                    <esling@ircam.fr>
%
function [ connecDB ] = connectLocal(user, pass, dbName)
if (nargin < 3)
    dbName = '';
end
% Database server
host = 'localhost';
% Database port
port = 3306;
% Launching connection
connecDB = connectDistant(host, port, user, pass, dbName);
end
