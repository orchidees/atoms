%
% connectDistant.m  : Connecting to a distant database
%
% host              : Adress of host for the database
% port              : Port to use for the connection
% user              : Username for the connection
% pass              : Password for the connection
% dbName            : Name of the database
%
% Version           : 1.0 / 2009
%
% Author            : Philippe ESLING
%                    <esling@ircam.fr>
%
function [ connecDB ] = connectDistant(host, port, user, pass, dbName)
% Transforming port to string
nPort = num2str(port);
% JDBC Parameters
jdbcString = ['jdbc:mysql://' host ':' nPort '/' dbName];
jdbcDriver = 'com.mysql.jdbc.Driver';
% Create the database connection object
connecDB = database(dbName, user , pass, jdbcDriver, jdbcString);
% Check to make sure that we successfully connected
if isconnection(connecDB)
    set(connecDB, 'AutoCommit', 'on');
    disp(['Connected to database ' dbName ' on port ' nPort '.']);
else
    disp(sprintf('Connection failed : %s', connecDB.Message));
end
end
