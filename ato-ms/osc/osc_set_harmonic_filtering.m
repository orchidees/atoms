function handles = osc_set_harmonic_filtering(osc_message,handles)

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
fSet = osc_message.data{2};
% Set filter
handles.session.getProduction().setHarmonicFiltering(fSet);