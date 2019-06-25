%
% Session.m         : Main class for user interactivity.
%
% This class centralize every aspect of a search problem. It can be
% considered as a workspace which contains every defined parts of the
% search.
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef OSession < handle
    
    properties (SetAccess = private, GetAccess = private)
        sFeatures            % Features object to use
        sFeatList            % List of string features
        tFeatures            % Total features list (with dependancies)
        sKnowledge           % Knowledge source
        sConstraints         % Constraints on search
        sRepresentation      % Representation model
        sProduction          % Type of production output
        sSolution            % Solution set to the search
        sSearch              % Search algorithm used
        sTarget              % Target to optimize
        sHandles             % Handles for OSC server
        debugMode            % Output plots and verbose
    end

    methods
       
        %
        % Main void constructor for the Session object.
        % Initialize every class variables to empty objects.
        %
        function sA = OSession()
            sA.sFeatures = [];
            sA.sSolution = [];
            sA.sHandles = [];
            sA.debugMode = 0;
        end

		function emptyThis(sa)
			delete(sa.sKnowledge);
			delete(sa.sProduction);
		end
        
        %
        % Set the session in debug mode
        %
        function setDebug(this)
            this.debugMode = 1;
        end
        
        %
        % Check if the session is in debug mode
        %
        function dMode = isDebug(this)
            dMode = this.debugMode;
        end
       
        %
        % Fill the session with default values
        %
        function constructDefaultSession(this)
            % Start by instatiating each object
            this.setKnowledge(KnowledgeSQL(this, 'ircamSpectralDB', 'root', ''));
            this.sKnowledge.buildKnowledge();
            this.setRepresentation(RepresentationAbstract());
            this.setProduction(ProductionOrchestra(this, {}, 1));
            this.sProduction.constructBaseFilters();
            this.setTarget(TargetAbstract(this));
            this.setSearch(SearchGenetic(this));
            % Build the knowledge description
        end
      
        %
        % Set the list of optimization criteria
        %
        function setCriteriaList(this, critList)
            allowedFeats = this.sKnowledge.getCriteriaList();
            [aField aType] = this.sKnowledge.getFieldsList();
            this.sFeatures = cell(length(critList), 1);
            for i = 1:length(critList)
                curCriteria = critList{i};
                if ~ismember(critList{i}, allowedFeats)
                    error('Session:setCriteriaList', ['Unrecognized criteria : ' critList{i}]);
                end
                if exist(['Features' critList{i}], 'class');
                    eval(['this.sFeatures{i} = Features' critList{i} '(this, ''' critList{i} ''');']); 
                else
                    switch curCriteria
                        case 'Loudness'
                            this.sFeatures{i} = FeaturesLoudness(this, critList{i});
                        case 'PartialsAmplitude'
                            this.sFeatures{i} = FeaturesPartialsAmplitude(this, critList{i});
                        case 'PartialsMeanAmplitude'
                            this.sFeatures{i} = FeaturesPartialsMeanAmplitude(this, critList{i});
                        case 'SpectralCentroid'
                            this.sFeatures{i} = FeaturesSpectralCentroid(this, critList{i});
                        case 'SpectralCentroidMean'
                            this.sFeatures{i} = FeaturesSpectralCentroidMean(this, critList{i});
                        case 'SpectralSpread'
                            this.sFeatures{i} = FeaturesSpectralSpread(this, critList{i});
                        case 'SpectralSpreadMean'
                            this.sFeatures{i} = FeaturesSpectralSpreadMean(this, critList{i});
                        otherwise
                            id = ismember(aField, critList{i});
                            if (strncmp(aType{id}, 'Complex', 7))
                                if ~(isempty(strfind(critList{i}, 'Energy')))
                                    this.sFeatures{i} = FeaturesGenericTemporalEnergy(this, critList{i});
                                else
                                    this.sFeatures{i} = FeaturesGenericTemporal(this, critList{i});
                                end
                            else
                                this.sFeatures{i} = FeaturesGenericStatic(this, critList{i});
                            end
                    end
                end
            end
            this.sProduction.emptyVariableDomains();
            this.setTotalFeaturesList();
            this.sFeatList = critList;
        end
        
        function cList = getFeaturesList(this)
            cList = this.sFeatList;
        end
        
        %
        % Set the full features list
        %
        function setTotalFeaturesList(this)
            % Optimization features
            optFeatures = this.sFeatures;
            this.tFeatures = cell(length(optFeatures), 1);
            % Get every feature dependancy
            for i = 1:length(optFeatures)
                this.tFeatures{i} = optFeatures{i}.dependancy();
            end
            this.tFeatures = unique(flatcell(this.tFeatures));
            % Add the duration information
            this.tFeatures{end + 1} = 'duration';
        end
        
        %
        % Get complete features list
        %
        function tFeat = getTotalFeaturesList(this)
            tFeat = this.tFeatures;
        end
       
        %
        % Launch target features analysis
        %
        function computeTargetFeatures(this)
            if (isempty(this.sTarget))
                error('Session:ComputeTarget:NoTarget', 'No target has been defined');
            end
            if (this.sTarget.isComputed)
                return;
            end
            this.sTarget.computeFeatures();
        end
       
        %
        % Set the current production type
        %
        function setProduction(this, prodType)
            if ~isa(prodType, 'Production')
                error('Session:SetProduction:BadType', 'Object is not of Production type');
            end
            if ~isempty(this.sProduction)
                delete(this.sProduction);
            end
            prodType.constructBaseFilters();
            this.sProduction = prodType;
        end
       
        %
        % Set the current target
        %
        function setTarget(this, targ)
            if ~isa(targ, 'Target')
                error('Session:SetTarget:BadType', 'Object is not of Target type');
            end
            if (~isempty(this.sTarget))
                delete(this.sTarget);
            end
            this.sTarget = targ;
        end
        
        %
        % Set the current knowledge
        %
        function setKnowledge(this, know)
            if ~isa(know, 'Knowledge')
                error('Session:SetKnowledge:BadType', 'Object is not of Knowledge type');
            end
            if (~isempty(this.sKnowledge))
                delete(this.sKnowledge);
            end
            this.sKnowledge = know;
        end
        
        %
        % Set the current search algorithm
        %
        function setSearch(this, sear)
            if ~isa(sear, 'Search')
                error('Session:SetSearch:BadType', 'Object is not of Search type');
            end
            if (~isempty(this.sSearch))
                delete(this.sSearch);
            end
            this.sSearch = sear;
        end
        
        %
        % Set the current representation type
        %
        function setRepresentation(this, repr)
            if ~isa(repr, 'Representation')
                error('Session:SetRepresentation:BadType', 'Object is not of Representation type');
            end
            if (~isempty(this.sRepresentation))
                delete(this.sRepresentation);
            end
            this.sRepresentation = repr;
        end
       
        %
        % Update the current search domains by applying the constraints
        % Should be called before launching the search and at each time a
        % new constraints is added to the search problem.
        %
        function updateSearchStructure(this)
            %this.sConstraints.apply();
            %this.sProduction.computeVariableDomains();
        end
       
       %
       % Launch the search algorithm
       % First update the search structure to obtain the right domains
       %
       function solutions = launchSearch(this, isServer)
           if nargin < 2
               isServer = 0;
           end
           this.updateSearchStructure();
           this.sSolution = this.sSearch.launchSearch(isServer);
           solutions = this.sSolution;
       end
       
       %
       % Retrieve the current features
       %
       function feat = getFeatures(this)
           feat = this.sFeatures;
       end
       
       %
       % Retrieve the current knowledge source
       %
       function know = getKnowledge(this)
           know = this.sKnowledge;
       end
       
       %
       % Retrieve the constraint system
       %
       function cons = getConstraints(this)
           cons = this.sConstraints;
       end
       
       %
       % Retrieve the representation model
       %
       function repr = getRepresentation(this)
           repr = this.sRepresentation;
       end
       
       %
       % Retrieve the actual production model
       %
       function prod = getProduction(this)
           prod = this.sProduction;
       end
       
       %
       % Retrieve the current solutions set
       %
       function sols = getSolution(this)
           sols = this.sSolution;
       end
       
       %
       % Retrieve the current search algorithm
       %
       function sear = getSearch(this)
           sear = this.sSearch;
       end
       
       %
       % Retrieve the current target
       %
       function targ = getTarget(this)
           targ = this.sTarget;
       end
       
       %
       % Works only in server mode, handles for the OSC communication
       %
       function handles = getHandles(this)
           handles = this.sHandles;
       end
       
       function setHandles(this, h)
           this.sHandles = h;
       end
       
       function sendTmpSolutions(this, iter, solutions)
           exportObj = ExportRaw(this, ['/tmp/.solutions_' num2str(iter) '.txt']);
           exportObj.exportSolutionSetLight(solutions, ['/tmp/.solutions_map_' num2str(iter) '.txt'], ['/tmp/.solutions_features_' num2str(iter) '.txt']);
           message.path = '/tmpsolutions';
           message.tt = 'i';
           message.data{1} = iter;
           flux{1} = message;
           osc_send(this.sHandles.osc.address,flux);
       end
       
       %
       % Save the current Session to a single file
       %
       function status = saveSession(this, filename)
           status = 0;
           save([filename '.orch'], 'this');
           if (isvalid(this) && exist([filename '.orch'], 'file'))
               status = 1;
           end
       end
       
        function sendReport(this, type, author, title, description, doSendSession)
            newline = char([13 10]);
            spaceChar = char(32);
            errorIdentify = [];
            errorMessage = [];
            errorFile = [];
            errorFName = [];
            errorLine = 0;
            switch type
                case 'Idea'
                    msgType = '[IDEA]';
                case 'Error'
                    msgType = '[ERROR]';
                case 'Feature'
                    msgType = '[FEATURE]';
                case 'Problem'
                    msgType = '[PROBLEM]';
                case 'Good results'
                    msgType = '[GOOD RESULTS]';
                case 'Bad results'
                    msgType = '[BAD RESULTS]';
                case 'Suggestion'
                    msgType = '[SUGGEST]';
                otherwise
                    msgType = '[OTHER]';
            end
            msgAuthor = ['[' author ']'];
            subjectTitle = [msgType msgAuthor title];
            err_s = lasterror;
            if ~isempty(err_s)
                errorIdentify = err_s.identifier;
                errorMessage = err_s.message;
                if length(err_s.stack) >= 1
                    errorStack = err_s.stack(1);
                    errorFile = errorStack.file;
                    errorFName = errorStack.name;
                    errorLine = num2str(errorStack.line);
                else
                    errorFile = 'No error stack';
                    errorFName = '';
                    errorLine = 0;
                end
            end
            messageResults = [ ...
                'Author : ', spaceChar, author, newline, ...
                'Title : ', spaceChar, title, newline, ...
                'Description : ', spaceChar, description, newline, ...
                'Last error description', newline, ...
                '  - identifier : ', spaceChar, errorIdentify, newline, ...
                '  - message ; ', spaceChar, errorMessage, newline, ...
                '  - file : ', spaceChar, errorFile, newline, ...
                '  - name : ', spaceChar, errorFName, newline, ...
                '  - line : ', spaceChar, errorLine, newline];
            % Send attached files
            if doSendSession
                % Export session
                this.saveSession('/tmp/exportSession');
                % Exporting target to wave
                % wavwrite(target, sRate, nBits, '/tmp/exportTarget.wav');
                attachments = {'/tmp/exportSession.orch'};
                tarFileType = '.tar.gz';
                tarFileName = '/tmp/resultsPackaged';
                tarFile = strcat(tarFileName, tarFileType);
                numberOfFileExtensions = length(strfind(tarFileType, '.'));
                tarFile = char(timeStamp(tarFile, numberOfFileExtensions, char('sec_OFF')));
                contentsToBeTarZipped = vertcat(attachments);
                contentsToBeTarZipped = contentsToBeTarZipped(:)';
                tar(tarFile, contentsToBeTarZipped);
                attachments = tarFile;
            else
                attachments = [];
            end
            emailContents = messageResults;
            senderMail = 'filooops@gmail.com';
            senderPassword = 'ynCrKbfe';
            recipientEmails = {'ircam-orchestration@googlegroups.com'};
            sendMail(senderMail, senderPassword, recipientEmails, subjectTitle, emailContents, attachments)
        end
       
   end
   
   methods (Static)
       
       %
       % Allows to reload a Session from a previous file
       %
       function this = loadSession(filename)
           load(filename, '-mat');
       end
       
   end
   
end 
