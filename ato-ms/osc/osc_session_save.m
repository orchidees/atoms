% OSC_DBSAVE - Save an insturment knowledge object in an external
% mat file.
%
% Usage: handles = osc_dbsave(osc_message,handles)
%

function handles = osc_session_save(osc_message,handles)
% Check input arguments
if length(osc_message.data) < 2
    error('osc_saveSession:IncompleteOscMessage', '/dbsave requires 2 arguemnts.')
end
if ~ischar(osc_message.data{2})
    error('osc_saveSession:BadArgument', 'filename should be a string.');
end
filename = osc_message.data{2};
idDot = find(filename == ':', 1, 'first');
filename = filename((idDot + 1):end);
% Save knowledge object on disk
server_says(handles,[ 'Dumping session to file : ' filename ],0);
handles.session.saveSession(filename);
server_says(handles,[ 'Dumping session to file : ' filename ],1);