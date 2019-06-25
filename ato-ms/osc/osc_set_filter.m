function handles = osc_set_filter(osc_message,handles)

% OSC_SET_FILTER - Set a filter on a database queryable field, in
% order to restrict/extend the search space
%
% Usage: handles = osc_set_filter(osc_message,handles)
%

% Check that a session is opened
if isempty(handles.session)
    disp('Empty session in set filter.');
    handles.session = OSession();
    handles.session.constructDefaultSession();
    handles.session.setHandles(handles);
end
handles.session.getProduction().needInit();
% Check input arguments
if length(osc_message.data) < 2
    error('osc_set_filter:BadArgumentNumber', 'Too few arguments for /setfilter.');
end
if ~ischar(osc_message.data{2})
    error('osc_set_filter:BadArgumentType', 'Attribute must be a string.');
end
fSet = osc_message.data{2};
% Set filter
sFilters = handles.session.getProduction().filtersSet;
if ~isfield(sFilters, fSet)
    error('osc_set_filter:Unknown', [fSet 'is not a valid filter.']);
end
curFilter = sFilters.(fSet);
if isa(curFilter, 'FiltersSymbolic')
    if strcmp(osc_message.data(3), '(null)');
        curFilter.setMode('include');
        curFilter.setIncludeList([]);
    else
        incList = osc_message.data(3:end);
        curFilter.setMode('force');
        curFilter.addIncludeList(incList);
    end
end
if isa(curFilter, 'FiltersSpectral')
    fRange = [osc_message.data{3} osc_message.data{4}];
    disp(fRange);
    curFilter.setMode('between');
    curFilter.setFilterRange(fRange);
end