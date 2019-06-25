%
% Knowledge.m       : Abstract interface for knowledge definition
%
% This class allows to define an abstract source of knowledge
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef Knowledge < handle
    
    properties (SetAccess = protected, GetAccess = protected)
        creationDate             % Date of creation for the knowledge
        knowledgeDescription     % Description of the knowledge source
        attributeDomains         % Possible values for symbolic attributes
        allowedFeatures          % Set of allowed features
        neutralElement           % Neutral element of knowledge
        sSession                 % Pointer to current session
    end

	methods (Abstract)
       
        %
        % Build the knowledge structure from its source
        %
        buildKnowledge(this)
       
        %
        % Update the knowledge structure to obtain the latest version
        %
        updateKnowledge(this)
       
        %
        % Add a source of knowledge and extract corresponding informations
        %
        addKnowledge(this, knowSource)
       
        %
        % Remove a part of the knowledge from the source
        %
        removeKnowledge(this, knowName)
       
        %
        % Extract symbolic informations from a source
        %
        sInfo = extractSymbolicInfos(this)
        
        %
        % Get informations about a knowledge field
        %
        fInfo = getFieldsInfo(this, fList)
       
        %
        % Get values of a knowledge field for a specified ID list
        %
        fVals = getFieldsValues(this, fNames, fID)
       
        %
        % Get all possible values for a knowledge field
        %
        fValList = getFieldsValueList(this, fNames)
       
        %
        % Perform a query over the knowledge source
        %
        qResults = query(this, qStruct)
       
        %
        % Modify values of fields from the knowledge
        %
        setFields(this, fVals, fID)
        
        %
        % Compute domains for a specific attribute
        %
        computeAttributeDomains(this, aName)
       
    end
   
    methods
        
        %
        % Main constructor for the knowledge object
        %
        function sK = Knowledge(sessionObj)
            sK.allowedFeatures = [];
            sK.attributeDomains = struct;
            sK.creationDate = datestr(now,'yyyymmddHHMMSS');
            sK.knowledgeDescription = struct;
            sK.neutralElement = -1;
            sK.sSession = sessionObj;
        end
        
        %
        % Get the structure of attributes domain
        %
        function attDom = getAttributeDomains(this)
            attDom = this.attributeDomains;
        end
        
        function creaD = getCreationDate(this)
            creaD = this.creationDate;
        end
        
    end
end 
