% OSC_SOLUTION_TO_TEXT - Export an orchestration solution into a text
% file.
%
% Usage: handles = osc_solution_to_text(osc_message, handles)
%
function handles = osc_solution_to_text(osc_message, handles)
% Check unmber of input arguments
if length(osc_message.data) < 3
    error('osc_solution_to_text:IncompleteOscMessage', 'Too few arguemnts.')
end
% Check target name
targetname = osc_message.data{2};
if ~ischar(targetname)
    error('osc_solution_to_text:BadArgumentType', 'Target name must be a string.')
end
% Check output text file name
textfile = osc_message.data{3};
if ~ischar(textfile)
    error('osc_solution_to_text:BadArgumentType', 'Output file name must be a string.')
end
% Is there something to export?
if length(osc_message.data) == 3
    error('osc_solution_to_text:IncompleteOscMessage', 'Nothing to export.')
end
% Get current's solution data
this_solution = osc_message.data(4:length(osc_message.data));
export = ExportRaw(handles.session, textfile);
% Export text
export.exportSolutionSet(this_solution);