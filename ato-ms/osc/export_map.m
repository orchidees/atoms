% export_map    : Write in a text file basic information about the
% knowledge database items: URIs, indices, paths, loudness factors,
% instruments, notes and playing styles. The DB map file can be
% used to avoid multiple queries in a client interface.
%
% Params :
%   - knowledge_instance    : knowledge to export
%   - mapfile               : name of export file
%
function [] = export_map(mapfile,handles,tmpSession)
% Check if in server mode
if nargin < 2
    handles = [];
end
if nargin < 3
    tmpSession = OSession();
    tmpSession.constructDefaultSession();
end
% Open export file
if mapfile(1) == '~'
    mapfile = [ home_directory mapfile(2:length(mapfile)) ];
end
fid = fopen(mapfile,'w');
if fid == -1
    error('orchidee:knowledge:export_map:CannotOpenFile', ...
        [ 'Cannot open ''' mapfile '''.' ] );
end
% Get number of entries
nbEntries = tmpSession.getKnowledge().getNbEntries();
maxThous = floor(nbEntries / 1000);
for i = 0:maxThous
    % Collect data to export
    listIDs = ((i * 1000) + 1):((i + 1) * 1000);
    values = tmpSession.getKnowledge().getFieldsValues({'file', 'name', 'instrument', 'playingStyle', 'note', 'dynamics', 'duration'}, listIDs');
    for j = 1:size(values, 1)
        if ~iscell(values)
            str = [ num2str(listIDs(j)) ' Fichier Nom Instrument ModeJeu Note Velocite 0.0'];
            fprintf(fid,'%s\n',str);
            continue;
        end
        if strcmp(values{j}, 'No Data')
            str = [ num2str(listIDs(j)) ' Fichier Nom Instrument ModeJeu Note Velocite 0.0'];
            fprintf(fid,'%s\n',str);
            continue;
        end
        str = [ num2str(listIDs(j)) ' ' values{j, 1} ' ' values{j, 2} ' ' values{j, 3} ' ' values{j, 4} ' ' values{j, 5} ' ' values{j, 6} ' ' num2str(values{j, 7}) ];
        fprintf(fid,'%s\n',str);
    end
    server_says(handles, 'Creating DB map ...', i / maxThous);
end
% Close export file
fclose(fid);