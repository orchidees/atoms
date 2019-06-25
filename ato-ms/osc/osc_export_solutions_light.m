function handles = osc_export_solutions_light(osc_message,handles)

% OSC_EXPORT_SOLUTION_LIGHT - Export current solution set in text file
%
% Usage: handles = osc_export_solutions_light(osc_message,handles)
%

% Check that a session is opened
% Check that a session is opened
if isempty(handles.session)
    error('osc_get_attribute_domain:UexpectedMessage', 'First open a session.');
end
if isempty(handles.session.getSolution)
    error('osc_get_attribute_domain:EmptySolution', 'No solution in set.');
end
% Check input arguments
if length(osc_message.data) < 2
    error('osc_export_solutions:IncompleteOscMessage', 'Export file is missing.');
end
if ~ischar(osc_message.data{2})
    error('osc_export_solutions:BadArgumentType', 'Export file must be a string.' );
end
exportObj = ExportRaw(handles.session, osc_message.data{2});
solutions = handles.session.getSolution();
exportObj.exportSolutionSetLight(solutions, osc_message.data{3});