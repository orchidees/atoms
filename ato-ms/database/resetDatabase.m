%
% resetDatabase.m   : Perform a complete reset of the database
%
% connecDB          : Pointer to the SQL connection
% tableStructure    : New base structure of the database
%
% Version           : 1.0 / 2009
%
% Author            : Philippe ESLING
%                    <esling@ircam.fr>
%
function resetDatabase(connecDB, tableStructure)
% Erasing previous 'ircamSpectralDB' database
sqlQ = 'DROP DATABASE IF EXISTS ircamSpectralDB';
exec(connecDB, sqlQ);
sqlQ = 'CREATE DATABASE ircamSpectralDB';
exec(connecDB, sqlQ);
sqlQ = 'USE ircamSpectralDB';
exec(connecDB, sqlQ);
% Erasing previous 'Sounds' table
sqlQ = 'DROP TABLE IF EXISTS Sounds';
exec(connecDB, sqlQ);
% Preparing the SQL Query to build the new table
sqlQ = 'CREATE TABLE Sounds(';
% Retrieve each name of the structure fields
fName = fieldnames(tableStructure);
% Create an appropriate column for each field
for i = 1:size(fName)
    curField = fName{i};
    fieldQ = [curField ' '];
    fieldVal = tableStructure.(curField);
    fClass = class(fieldVal);
    if (ischar(fClass))
        sqlClass = ' varchar(256)';
    end
    if (iscell(fieldVal))
        if (length(fieldVal) == 1)
            sqlClass = ' varchar(256)';
        else
            sqlClass = ' int(35)';
        end
    end
    if (strcmp(fClass, 'double'))
        % int(32) = Gaussian mixture
        % int(33) = Array of simple values
        % int(34) = Array of Gaussian mixtures
        if (size(fieldVal, 1) == 1)
            if (size(fieldVal, 2) == 1)
                sqlClass = ' float';
            else
                sqlClass = ' int(32)';
            end
        else
            if (size(fieldVal, 2) == 1)
                sqlClass = ' blob';
            else
                sqlClass = ' longblob';
            end
        end
    end
    fieldQ = strcat(fieldQ, ' ', sqlClass);
    sqlQ = strcat(sqlQ, fieldQ, ', ');
end
sqlQ = [sqlQ 'soundID int(36))'];
exec(connecDB, sqlQ);
sqlQ = 'CREATE INDEX SoundIDIndex ON Sounds (soundID)';
exec(connecDB, sqlQ);
end
