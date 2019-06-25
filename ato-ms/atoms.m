% main.m        : OSC server main function.
%
function atoms(varargin)
% Assign empty handle struct
handles = [];
% Clear previous log files
if exist('~/Library/Logs/IRCAM/Ato-ms/','dir')
    !rm ~/Library/Logs/IRCAM/Ato-ms/*.log
end
% javaaddpath('mysql-connector-java-5.1.10-bin.jar');
% pathHandler('load');
% Initialization procedure on first run
if exist('/tmp/ircamSpectralDB.db', 'file')
    fid = fopen('/tmp/atomsInstallReport.txt', 'w+');
    fprintf(fid, '%s', 'Importing full database ............ ');
    databaseFileImport('/tmp/ircamSpectralDB.db', 'ircamSpectralDB', 'localhost', 'root', []);
    fprintf(fid, '%s\n', 'OK');
    fprintf(fid, '%s', 'Exporting database map ............. ');    
	!mv /tmp/dbmap ~/Library/Preferences/IRCAM/
    fprintf(fid, '%s\n', 'OK');
    fprintf(fid, '%s', 'Moving descriptors indexes ......... ');
    !mkdir ~/Library/Preferences/IRCAM/descriptorsIndexes/
    !mv /tmp/descriptorsIndexes/* ~/Library/Preferences/IRCAM/descriptorsIndexes/
    fprintf(fid, '%s\n', 'OK');
    !rm /tmp/ircamSpectralDB.db
    fclose(fid);
    return;
end
feature accel on;
% Lauch OSC server
oscserver(handles);