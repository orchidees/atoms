%
% KnowledgeSQL.m    : Defining a knowledge based on a SQL database
%
% This class allows to define a source of knowledge based on a SQL database
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef KnowledgeSQL < Knowledge
    
    properties (SetAccess = protected, GetAccess = public)
        connecDB
        dbName
        dbUser
        dbPass
	end

	methods
        
        %
        % Main constructor for SQL-based knowledge 
        % Knowledge is connected to the given SQL source
        %
        function sKI = KnowledgeSQL(sessionObj, dbName, user, pass)
            sKI = sKI@Knowledge(sessionObj);
            sKI.connecDB = connectLocal(user, pass, dbName);
            sKI.dbName = dbName;
            sKI.dbUser = user;
            sKI.dbPass = pass;
        end
        
        %
        % Build the knowledge structure from its source
        % This function fills the description of knowledge :
        %   - Name of the existing fields
        %   - Types of each field
        %   - Possibility of querying
        %
        function buildKnowledge(this)
            [fields types] = getDescriptorList(this.connecDB);
            this.knowledgeDescription.fields = fields;
            % Define which types are allowed for queries
            queryable = zeros(size(fields));
            aFeats = cell(size(fields));
            handles = this.sSession.getHandles();
            for i = 1:length(types)
                server_says(handles, ['Constructing knowledge : '  fields{i}], i / length(types));
                if (strncmp('TimeFrame', fields{i}, 9))
                    types{i} = 'Internal';
                    queryable(i) = 0;
                    continue;
                end
                if (strncmp('varchar', types(i), 7))
                    types{i} = 'Symbolic';
                    if ~strncmp('name', fields{i}, 4) && ~strncmp('file', fields{i}, 4) 
                        this.computeAttributeDomains(fields{i});
                    end
                    queryable(i) = 1;
                    continue;
                end
                if (strncmp('float', types(i), 5))
                    if (length(fields{i}) > 8 && strcmp(fields{i}((end - 8):end), 'Dimension'))
                        types{i} = 'Internal';
                        queryable(i) = 0;
                        continue;
                    end
                    if ~strncmp('duration', fields{i}, 8)
                        aFeats{i} = fields{i};
                    end
                    this.attributeDomains.(fields{i}) = getDescriptorMinMax(this.connecDB, fields{i});
                    %this.attributeDomains.(fields{i}) = {0 100000};
                    types{i} = 'Float';
                    queryable(i) = 1;
                    continue;
                end
                if (strcmp('blob', types(i))) || (strcmp('int(33)', types(i)))
                    types{i} = 'Array';
                    aFeats{i} = fields{i};
                    queryable(i) = 0;
                    continue;
                end
                if (strcmp('longblob', types(i))) || (strcmp('int(34)', types(i)))
                    types{i} = 'Array2D';
                    aFeats{i} = fields{i};
                    queryable(i) = 0;
                    continue;
                end
                if ~strncmp('soundID', fields{i}, 7)
                    aFeats{i} = fields{i};
                end
                queryable(i) = 0;
                types{i} = 'Complex';
            end
            this.knowledgeDescription.types = types;
            this.knowledgeDescription.queryable = queryable;
            aFeats(all(cellfun(@isempty,aFeats),2),:) = [];
            this.allowedFeatures = aFeats;
            disp(aFeats);
            server_says(this.sSession.getHandles, 'Done.', 1);
        end
        
        %
        % Compute domains for a specific attribute
        %
        function computeAttributeDomains(this, aName)
            if ~ismember(this.knowledgeDescription.fields, aName)
                error('KnowledgeSQL:computeAttributeDomains:Unknown', [aName 'is not a knowledge field.']);
            end
            this.attributeDomains.(aName) = this.getFieldsValueList(aName);
        end
        
        %
        % Get possible list of optimization criteria
        %
        function cList = getCriteriaList(this)
            if isempty(this.knowledgeDescription)
                this.buildKnowledge();
            end
            cList = this.allowedFeatures;
        end
        
        %
        % Retrieve the number of sounds in the database
        %
        function nbInst = getNbEntries(this)
            nbInst = getSoundsNumber(this.connecDB);
        end
        
        %
        % Get list of all fields and related types
        %
        function [aField aTypes aQuery] = getFieldsList(this)
            if isempty(this.knowledgeDescription)
                this.buildKnowledge();
            end
            aField = this.knowledgeDescription.fields;
            aTypes = this.knowledgeDescription.types;
            aQuery = this.knowledgeDescription.queryable;
        end
        
        %
        % Function to save the object
        %
        function res = saveobj(this)
            res = this;
            res.connecDB = [];
        end
        
        %
        % Get values of a knowledge field for a specified ID list
        %
        function fVals = getFieldsValues(this, fName, fID)
            if nargin < 3
                fID = []; 
            end
            dbFields = this.knowledgeDescription.fields;
            if ~ismember(fName, dbFields);
                if iscell(fName)
                    fName = fName{1};
                end
                error('KnowledgeSQL:getFieldValues:Unknown', [ fName ' : no such field in database.' ] );
            end
            fVals = getDescriptorMultipleOrch(this.connecDB, fName, fID);
        end
       
        %
        % Get all possible values for a knowledge field
        %
        function fValList = getFieldsValueList(this, fName, fID)
            if nargin < 3
                fID = [];
            end
            dbFields = this.knowledgeDescription.fields;
            if ~ismember(fName,dbFields)
                error('KnowledgeSQL:getFieldsValueList:Unknown', [ fName ' : no such field in database.' ]);
            end
            fValList = getValuesListID(this.connecDB, fName, fID);
            % If method is called on the 'note' field, sort values by pitch
            if strcmp(fName,'note')
                finalList = {};
                for i = 1:length(fValList)
                    sSplit = regexp(fValList{i}, ',', 'split');
                    finalList = [finalList sSplit(:)'];
                end
                fValList = midi2mtnotes(sort(mtnotes2midi(finalList)));
            end
        end
        
        %
        % Get neutral element ID of knowledge
        %
        function nID = getNeutralID(this)
            if (this.neutralElement == -1)
                uris = this.getFieldsValueList('soundID');
                this.neutralElement = max(cell2mat(uris)) + 1;
            end
            nID = this.neutralElement;
        end
        
        %
        % Add a source of knowledge and extract corresponding informations
        %
        function addKnowledge(this, knowSource)
            addDBSoundDirectory(this.connecDB, knowSource);
        end
       
       %
       % Update the knowledge structure to obtain the latest version
       %
       function updateKnowledge(this)
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
       % Get list of admitted criterias
       %
       function criteria = getCriterias(this)
           criteria = this.getFieldsInfo('list');
       end
       
       %
       % Get informations about a knowledge field
       %
       function fInfo = getFieldsInfo(this, fList)
            if nargin < 2
                mode = 'all';
            end
            switch mode    
                case 'connecDB'
                    fields_info = knowledge_instance.connecDB;
                case 'list'
                    % Output field names list
                    field_list = knowledge_instance.database_description.fields;
                    fields_info = reshape(field_list,[],1);
                case 'type'
                     % Output field types ('I', 'A' or 'F') list 
                    field_types = knowledge_instance.database_description.types;
                    fields_info = reshape(field_types,[],1);
                case 'query'
                    % Output field query flags
                    field_query = knowledge_instance.database_description.queryable;
                    fields_info = reshape(field_query,[],1);
                case 'all'
                    % Output names, types and query flags
                    field_list = knowledge_instance.database_description.fields;
                    field_types = knowledge_instance.database_description.types;
                    field_query = knowledge_instance.database_description.queryable;
                    fields_info = [ reshape(field_list,[],1) ...
                        reshape(field_types,[],1) ];
                    for i = 1:length(field_query)
                        fields_info{i,3} = field_query(i);
                    end
                otherwise
                    error('orchidee:knowledge:get_fields_info:BadArgumentValue', ...
                        'Optional argument should be ''list'', ''type'', ''query'' or ''all''.');
            end
       end
       
       %
       % Perform a query over the knowledge source
       %
       %function qResults = query(this, qStruct)
       %end
       
       % QUERY - Multiple query in instrumental knowledge database.
        %
        % Usage: entries = query(knowledge_instance,field1,value1,...,fieldN,valueN)
        %        where: valuei = vi
        %               valuei = 'vi'
        %               valuei = 'vi1/vi2/.../vik'
        %               valuei = { 'vi1' 'vi2' ... 'vik' }
        %               valuei = [ vi1 vi2 ... vik ]
        %
        function entries = query(this,varargin)
            % Get number of fields to query
            if length(varargin) == 1
                varargin = varargin{1};
                nargin = length(varargin);
            else
                nargin = length(varargin)+1;
            end
            % Iterate on fields to query
            curIndex = 1;
            for k = 1:3:(nargin - 1)
                if (isempty(varargin{k}))
                    continue;
                end
                valueRight = 0;
                if (strcmp(varargin{k}, 'note'))
                    value = regexprep(varargin{k + 2}, '/', '|');
                    value = strcat('''', value, '''');
                    queries(curIndex).type = 'regexp';
                elseif ischar(varargin{k + 2})
                    value = regexprep(varargin{k + 2}, '/', '","');
                    value = strcat('("', value, '")');
                    queries(curIndex).type = 'in';
                else
                    queries(curIndex).type = varargin{k + 1};
                    tmpVal = varargin{k + 2};
                    value = tmpVal(1);
                    if length(tmpVal) > 1
                        valueRight = tmpVal(2);
                    end
                end
                queries(curIndex).connector = 'AND';
                queries(curIndex).descriptor = varargin{k};
                queries(curIndex).value{1} = value;
                queries(curIndex).value{2} = valueRight;
                curIndex = curIndex + 1;
            end
            entries = getSoundsQuery(this.connecDB, queries, Inf);
            if (~iscell(entries))
                entries = {};
            end
        end

        function c = parse_query(s)

        % PARSE_QUERY - Segment a multiple value input string into a cell
        % array of strings (char values) or double vector (numeric vector)
        %
        % Examples:
        % - parse_query('C3/D3/G#3') -> { 'C3' 'D3' 'G#3' }
        % - parse_query('1/3/7') -> [ 1 3 7 ]

        if ischar(s)
            I = find(s=='/');
            if ~length(I)
                c = s;
            else
                I = [ I length(s)+1 ];
                start = 1;
                for k = 1:length(I)
                    stop = I(k)-1;
                    this = s(start:stop);
                    if regexp(this,'\d') == 1
                        c(k) = str2num(this);
                    else
                        c{k} = this;
                    end
                    start = I(k)+1;
                end
            end
        else
            c = s;
        end
        end
       
       %
       % Modify values of fields from the knowledge
       %
       function setFields(this, fVals, fID)
       end
       
        % get_possible_notes - Return the set of pitches (without redundancy)
        % contained in a knowledge instance. If provided, the microtonic resolution
        % of the orchestra is considered. That is, get_possible_notes(K,N)
        % returns N more notes than get_possible_notes(K).
        %
        % Usage: note_list = get_possible_notes(knowledge_instance,<resolution>)
        %
        function note_list = get_possible_notes(knowledge_instance,resolution)
            if nargin < 2
                resolution = 1;
            end
            note_list = get_field_value_list(knowledge_instance,'note');
            midinotes = reshape(note2midi(note_list),[],1);
            allnotes = [];
            for r = 0:resolution-1
                allnotes = [ allnotes ; midinotes + r / resolution ];
            end
            note_list = unique(midi2mtnotes(sort(allnotes)));
        end
        
    end
   
    methods (Static = true)
        function res = loadobj(a)
            res = a;
            res.connecDB = connectLocal(a.dbUser, a.dbPass, a.dbName);
        end
    end
end 
