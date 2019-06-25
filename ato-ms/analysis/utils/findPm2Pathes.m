function pm2_pathes = findPm2Pathes()

% FIND_PM2_PATHES - Returns all locations of the pm2
% executable from the /Applications/ folder.
%
% Usage: pm2_pathes = find_pm2_pathes()
%

%current_dir = pwd;

pm2_pathes = {};

app_contents_s = dir('/Applications/');

audioscuplt_dirs = {};

pat = '[Aa][Uu][Dd][Ii][Oo][Ss][Cc][Uu][Ll][Pp][Tt]';

for i = 1:length(app_contents_s)
    if regexp(app_contents_s(i).name,pat)
        audioscuplt_dirs = [ audioscuplt_dirs ; ['/Applications/' app_contents_s(i).name ''] ];
    end
end

pat = [ pat ' ' ];

for i = 1:length(audioscuplt_dirs)
    
    cmd = [ 'find ''' audioscuplt_dirs{i} ''' -name ''pm2'' -type f' ];
    [s,w] = unix(cmd);
    idx = max(strfind(w,'pm2'));
    w = w(1:idx+2);
    idx = regexp(w,pat,'once');
    if ~isempty(idx)
        oldpat = w(idx:idx+11);
        newpat = strrep(oldpat,' ','\ ');
        w = strrep(w,oldpat,newpat);
    end
    pm2_pathes = [ pm2_pathes ; w ];
    
    %cd(audioscuplt_dirs{i});
    %tmp_file = [ '/tmp/tmp_' datestr(now,'yyyymmddHHMMSSFFF') ];
    %cmd = [ 'find ''' audioscuplt_dirs{i} ''' -name ''pm2'' -type f > ' tmp_file]; unix(cmd);
    %fid = fopen(tmp_file);
    %tmp_file_content = textscan(fid,'%s');
    
    %if ~isempty(tmp_file_content)
    %    tmp_file_content = tmp_file_content{1};
    %    for j = 1:length(tmp_file_content)
    %        tmp_file_content{j} = strrep(tmp_file_content{j},'./',audioscuplt_dirs{i} );
    %    end
    %    pm2_pathes = [ pm2_pathes ; tmp_file_content ];
    %end

    %fclose(fid);
    %cmd = ['rm ' tmp_file]; unix(cmd);
end


%cd(current_dir);
