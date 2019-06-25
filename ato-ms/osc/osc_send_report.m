% osc_send_report - Send automatic report
%
% Usage: handles = osc_export_solutions(osc_message,handles)
%
function handles = osc_send_report(osc_message,handles)
% Check that a session is opened
if isempty(handles.session)
    error('osc_get_attribute_domain:UexpectedMessage', 'First open a session.');
end
% Check input arguments
if length(osc_message.data) < 6
    error('osc_export_solutions:IncompleteOscMessage', 'Send report requires 6 arguments.');
end
if ~ischar(osc_message.data{2})
    error('osc_export_solutions:BadArgumentType', 'Type must be a string.' );
end
if ~ischar(osc_message.data{3})
    error('osc_export_solutions:BadArgumentType', 'Type must be a string.' );
end
if ~ischar(osc_message.data{4})
    error('osc_export_solutions:BadArgumentType', 'Type must be a string.' );
end
if ~ischar(osc_message.data{5})
    error('osc_export_solutions:BadArgumentType', 'Type must be a string.' );
end
disp(osc_message.data);
type = osc_message.data{2};
author = osc_message.data{3};
title = osc_message.data{4};
description = osc_message.data{5};
doSendSession = osc_message.data{6};
handles.session.sendReport(type, author, title, description, doSendSession);