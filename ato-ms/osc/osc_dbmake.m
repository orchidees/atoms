% OSC_DBMAKE - Create an internal instrument knowledge object from
% a set of XML description files
%
% Usage: handles = osc_dbmake(osc_message,handles)
%
function handles = osc_dbmake(osc_message,handles)
% Import XML files in instrument knowledge
handles.session.getKnowledge().buildKnowledge();