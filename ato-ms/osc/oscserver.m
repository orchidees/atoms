function oscserver(handles)

% OSCSERVER - Launch the Orchidee OSC server.
%
% Usage: [] = oscserver(handles);
%

% Read OSC settings in preferences file
osc_settings = read_osc_settings();
log_file_name = ['~/Library/Logs/Ion' datestr(now) '.log'];
try
    % Set the OSC address (for sending messages)
    osc_address = osc_new_address(osc_settings.ip,osc_settings.sendport);
    % Lauch the OSC server (for receiving messages)
    osc_server = osc_new_server(osc_settings.receiveport);
catch
    % Output and open log file if OSC connection fail
    log_file = log_file_name;
    print_last_error(log_file,'ION CRASH REPORT');
    unix(['open ' log_file]);
    beep;
    return;
end
% Include OSC info in handles struct
handles.osc.settings = osc_settings;
handles.osc.address = osc_address;
handles.osc.server = osc_server;

% Load instrument knowledge database
%try
    send_busy_message(handles,0,'Constructing modular session ...');
    % If a user-defined default knowledge exists ...
    handles.session = OSession();
    handles.session.setHandles(handles);
    handles.session.constructDefaultSession();
    send_busy_message(handles,1,'Constructing modular session ...');
    % Export DB map if necessary
    if ~exist('~/Library/Preferences/IRCAM/dbmap')
        export_map('~/Library/Preferences/IRCAM/dbmap', handles, handles.session);
    end
    % Export DB map if necessary
    send_ready_message(handles);
%catch
    % Output and open log file if OSC connection fail
%    log_file = log_file_name;
%    print_last_error(log_file,'ION CRASH REPORT');
%    unix(['open ' log_file]);
%    beep;
%    return;
%end

% OSC listen loop
while 1
    % Normal execution bracnh
    try
        % Non-OSC interruption check
        check_interruption('quit');
        % Get first OSC messgae
        M = osc_recv(osc_server,1);
        % Process message if non empty
        if ~isempty(M)
            % Quit server message
            if strcmp(M{1}.path, '/quit')
                send_quit_message(handles);
                break;
            end
            for i = 1:length(M)
                message = M{i};
                disp(message);
                % Fix the appropriate action
                switch message.path
                        % Handshake message
                    case '/isready'
                        send_ready_message(handles);
                        % Version query message
                    case '/version'
                        send_version_message(handles);
                        % Debug mode message (non-compiled Matlab only)
                    case '/debug'
                        keyboard;
                        % Otherwise, parse more complex instruction
                    otherwise
                        handles = parse_osc_message(message,handles);
                end
            end
        end
    % Exception branch
    catch
        last_error = lasterror;
        % Non-OSC QUIT message check
        if strfind(last_error.identifier, 'ForcedToQuit')
            % Send error and quit message
            send_error_message(handles);
            send_quit_message(handles);
            % Print log file
            log_file = log_file_name;
            print_last_error(log_file,'Ion Error Report');
            % Quit
            break;
        else
            % Catch last error and send an OSC '/error' message
            send_error_message(handles);
            send_ready_message(handles);
            % Print log file
            log_file = log_file_name;
            print_last_error(log_file,'Ion Error Report');
        end
    end
end

% Free OSC address and server
osc_free_server(osc_server);
osc_free_address(osc_address);