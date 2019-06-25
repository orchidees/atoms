% LOG_FILE_NAME - Ouput log file name
% (located in the ~/Preferences/Logs/IRCAM/Ato-ms/ directory)
%
% Usage: log_file = log_file_name()
% 
function log_file = log_file_name()
if ~exist('~/Library/Logs/IRCAM/', 'dir')
    mkdir('~/Library/Logs/IRCAM/');
end
if ~exist('~/Library/Logs/IRCAM/Ato-ms/', 'dir')
    mkdir('~/Library/Logs/IRCAM/Ato-ms/');
end

log_file = [ '~/Library/Logs/IRCAM/Ato-ms/ato-ms.' datestr(now,'yyyy.mm.dd.HH.MM.SS') '.log' ];