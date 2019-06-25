function handles = parse_osc_message(osc_message,handles)

% PARSE_OSC_MESSAGE - Get an input OSC message, check its ID, send
% an acknowledge message to server, then call the appropriate
% method according to the OSC path value.
%
% Usage: handles = parse_osc_message(osc_message,handles)
%


switch osc_message.path

    case '/setoutport'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_setoutport(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/databasequery'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_databasequery(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/dbmake'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_dbmake(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/dbupdate'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_dbupdate(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/dbsave'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_dbsave(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/dbload'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_dbload(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/dbreset'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_dbreset(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/dbgetfields'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        send_busy_message(handles);
        handles = osc_dbgetfields(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/dbgetqueryfields'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        send_busy_message(handles);
        handles = osc_dbgetqueryfields(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/dbgettemporalfields'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        send_busy_message(handles);
        handles = osc_dbgettemporalfields(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);
        
    case '/dbexportinstsymbols'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        send_busy_message(handles);
        handles = osc_dbexportinstsymbols(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/dbgetfieldvaluelist'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_dbgetfieldvaluelist(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/dbgetfieldvalues'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_dbgetfieldvalues(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);
        
    case '/dbgetscoreorder'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_dbgetscoreorder(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/dbquery'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_dbquery(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/dbanalyzesamples'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_dbanalyzesamples(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/dbexportmap'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_dbexportmap(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/dbeasyupdate'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_dbeasyupdate(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/newsession'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_new_session(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/closesession'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_close_session(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/setsoundfile'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_set_soundfile(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/abstracttarget'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_abstract_target(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);
     
    case '/gettargetfeatures'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_get_targetfeature(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/gettargetparameters'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_get_targetparameters(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);
        
    case '/gettargetpartials'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_get_targetpartials(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);
        
    case '/sessionsave'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_session_save(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);
        
    case '/sessionload'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_session_load(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/settargetparameters'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_set_targetparameters(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/settargetfeature'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_set_targetfeature(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/settargetduration'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_set_targetduration(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/setresolution'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_set_resolution(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/setorchestra'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_set_orchestra(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/setfilter'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_set_filter(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/setharmonicfiltering'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_set_harmonic_filtering(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/getattributedomain'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_get_attribute_domain(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/getcriterialist'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_get_criteria_list(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/getfilterslist'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_get_filters_list(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);
        
    case '/setcriteria'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_set_criteria(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/orchestrate'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_orchestrate(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    case '/exportsolutions'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_export_solutions(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);
        
    case '/exportsolutionslight'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_export_solutions_light(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);
        
    case '/sendreport'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_send_report(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);
        
    case '/solutiontotext'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_solution_to_text(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);
        
    case '/solutiontoscore'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_solution_to_score(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);
        
    case '/getsearchalgorithms'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_get_search_algorithms(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);
        
    case '/getsearchparameters'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_get_search_parameters(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);
        
    case '/setsearchparameter'

        messageid = check_message_id(osc_message);
        send_acknowledge(handles,messageid);
        handles = osc_set_search_parameter(osc_message,handles);
        send_done_message(handles,messageid);
        send_ready_message(handles);

    otherwise

        % Raise exception if path is unkown
        error('orchidee:osc:parse_osc_message:BadOscPath',[ osc_message.path ': Unknown OSC path.']);

end




function messageid = check_message_id(osc_message)

% CHECK_MESSAGE_ID - Check that first data element of the OSC
% message exist and s a number. If true, return this number as the
% message ID.
%
% Usage: messageid = check_message_id(osc_message)
%

messageid = 0;

if  isempty(osc_message.data)
    error('orchidee:osc:parse_osc_message:MissingMessageId','Message ID missing.');
else
    if ~isnumeric(osc_message.data{1})
        error('orchidee:osc:parse_osc_message:MissingMessageId','Message ID missing.');
    else
        messageid = osc_message.data{1};
    end
end
