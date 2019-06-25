%
% KnowledgeModel.m       : Definition of a model-based knowledge source
%
% This class allows to define a knowledge source based on a generative
% model of instrumental properties.
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef KnowledgeModel < Knowledge
    
   properties
   end

   methods
       
       %
       % Build the knowledge structure from its source
       %
       function buildKnowledge(this)
       end
       
       %
       % Update the knowledge structure to obtain the latest version
       %
       function updateKnowledge(this)
       end
       
       %
       % Add a source of knowledge and extract corresponding informations
       %
       function addKnowledge(this, knowSource)
       end
       
       %
       % Remove a part of the knowledge from the source
       %
       function removeKnowledge(this, knowName)
       end
       
       %
       % Extract symbolic informations from a source
       %
       function sInfo = extractSymbolicInfos(this)
       end
       
       %
       % Nomenclature extraction for the knowledge
       %
       function nStruct = nomenclature(this)
       end
       
       %
       % Get informations about a knowledge field
       %
       function fInfo = getFieldsInfo(this, fList)
       end
       
       %
       % Get values of a knowledge field for a specified ID list
       %
       function fVals = getFieldsValues(this, fNames, fID)
       end
       
       %
       % Get all possible values for a knowledge field
       %
       function fValList = getFieldsValueList(this, fNames)
       end
       
       %
       % Perform a query over the knowledge source
       %
       function qResults = query(this, qStruct)
       end
       
       %
       % Modify values of fields from the knowledge
       %
       function setFields(this, fVals, fID)
       end
       
   end
   
end 
