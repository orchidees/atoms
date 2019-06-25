%
% TargetSound.m     : Main class for soundfile target
%
% This class allows to define a target from a soundfile.
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef TargetSound < Target
    
    properties (SetAccess = protected, GetAccess = protected)
        soundFile        % Name of the target soundfile
        fileType         % Type of soundfile
    end
   
	methods
       
        %
        % Main constructor for a sound target
        %
        function tS = TargetSound(sessionObj, filename)
            tS = tS@Target(sessionObj);
            tS.fileType = '';
            tS.loadSoundFile(filename);
            tS.analysisParameters = defaultAnalysisParams();
        end
       
        %
        % Launch computation of the target features
        %
        function success = computeFeatures(this)
            if (this.isComputed)
                return;
            end
            % Call sound analysis method
            this.spectralFeatures = analyzeTarget(this.soundFile, this.analysisParameters, this.sSession.getHandles());
            if ~isempty(this.spectralFeatures)
                this.isComputed = 1;
                success = 1;
            end
        end
        
        %
        % Load a different soundfile target
        %
        function loadSoundFile(this, filename)
            % Check if soundfile exists
            if ~exist(filename, 'file')
                error('Target:loadSoundFile:CannotOpenFile', 'Unable to find soundFile.' );
            end
            this.soundFile = filename;
            lastDot = find(filename == '.', 1, 'last');
            if ~isempty(lastDot)
                this.fileType = filename(lastDot(1):end);
            end
            this.spectralFeatures = [];
            this.isComputed = 0;
        end
       
        %
        % Modify the value of a target feature
        %
        function modifyFeature(this, fName, fValue)
            if ~isfield(this.spectralFeatures, fName)
                error('TargetSound:getFeature:Unknown', [fName 'is not a target feature']);
            end
            if ~isa(this.spectralFeatures.(fName), class(fValue))
                error('TargetSound:modifyFeature:BadType', [fName 'is not of good type']);
            end
            fLength = length(this.spectralFeatures.(fName));
            if fLength == 1
                this.spectralFeatures.(fName) = mean(fValue);
                return;
            end
            this.spectralFeatures.(fName) = resample(fValue, fLength, length(fValue));
        end
       
        %
        % Add a specfic feature to the target
        %
        function addFeature(this, fName, fValue)
        end
       
        %
        % Retrieve the value of a specific feature
        %
        function feature = getFeature(this, fName)
            if isempty(this.spectralFeatures) || (this.isComputed == 0)
                error('TargetSound:getFeature', 'Target features are not computed');
            end
            if ~isfield(this.spectralFeatures, fName)
                error('TargetSound:getFeature:Unknown', [fName 'is not a target feature']);
            end
            feature = this.spectralFeatures.(fName);
        end
       
        %
        % Retrieve the names of all features 
        %
        function featLis = getFeaturesNames(this)
            if isempty(this.spectralFeatures) || (this.isComputed == 0)
                error('TargetSound:getFeaturesNames', 'Target features are not computed');
            end
            featLis = fieldnames(this.spectralFeatures);
        end
       
        %
        % Retrieve the names of all features 
        %
        function featLis = getFeaturesList(this)
            if isempty(this.spectralFeatures) || (this.isComputed == 0)
                error('TargetSound:getFeaturesNames', 'Target features are not computed');
            end
            featLis = this.spectralFeatures;
        end
        
        %
        %
        %
        function comp = getComputed(this)
            comp = this.isComputed;
        end
       
        %
        % Set parameters for the features analysis
        %
        function success = setAnalysisParameter(this, paramName, paramValue)
            % Get parameter list
            allowed_parameters = fieldnames(this.analysisParameters);
            % Check the validity of the input parameter
            if ~ischar(paramName)
                error('TargetSound:setAnalysisParameter:BadArgumentType', 'Parameter name must be a string.');
            end
            if ~ismember(paramName,allowed_parameters)
                error('TargetSound:setAnalysisParameter:BadArgumentValue', [ '''' paramName ''': unknown analysis parameter.' ] );
            end
            % Get parameters types and allowed ranges
            [params_values,params_class,params_range] = defaultAnalysisParams();
            % Check type of parameter new value
            if ~strcmp(params_class.(paramName), class(paramValue));
                error('orchidee:target:set_parameter:BadArgumentType', [ 'Wrong type for parameter ''' paramName '''.' ] );
            end
            % Check if new value is i parameter range
            range = params_range.(paramName);
            if isnumeric(paramValue)
                if isnumeric(range)
                    T = (paramValue >= range(1)) && (paramValue <= range(2));
                else
                    range = cell2mat(range);
                    T = ismember(paramValue,range);
                end
            elseif ischar(paramValue)
                T = ismember(paramValue,range);
            end
            if ~T
                error('TargetSound:setAnalysisParameter:BadArgumentType', [ 'Bad value for parameter ''' paramName '''.' ] );
            end
            % Assign new value in slot
            this.analysisParameters.(paramName) = paramValue;
            success = 1;
       end
       
       function target_instance = set_sound_file(target_instance,sound_file)
% Allowed formats
allowed_sound_formats = { '.aiff' '.aif' '.wav' };
% Check that soundfile exists
if ~exist(sound_file)
    error('orchidee:target:set_sound_file:CannotOpenFile', ...
        [ sound_file ': file does not exist.' ] );
end
% Check that soundfile is a file
if exist(sound_file) ~= 2
    error('orchidee:target:set_sound_file:BadArgumentValue', ...
        [ sound_file ' is not a valid sound file.' ] );
end
% Check file format (assume extension is meaningful)
[P,N,ext] = fileparts(sound_file);
ext = lower(ext);
if ~ismember(ext,allowed_sound_formats)
    error('orchidee:target:set_sound_file:BadArgumentValue', ...
        [ '''' sound_file ''' : invalid sound file format.' ] );
end
% Get soundfile absolute path
if sound_file(1) == '~'
    sound_file = [ home_directory sound_file(2:length(sound_file)) ];
end
% If new soundfile is different than actual soundfile, replace it
% and clear feature slot
if ~strcmp(target_instance.soundfile,sound_file)
    target_instance.soundfile = sound_file;
    target_instance.filetype = strrep(ext,'.','');
    target_instance.features = [];
end
       end

       
       function target_instance = set_parameter(target_instance,param_name,param_value)

       end
       
       function param_value = get_parameter(target_instance,param_name)
if nargin < 2
    % Default method accesses all parameters
    param_value = target_instance.parameters;
else
  % If a parameter name is provided, do:
    % -- Get the possible parameter names
    allowed_parameters = fieldnames(target_instance.parameters);
    % -- Check the input parameter is valid
    if ~ischar(param_name)
        error('orchidee:target:get_parameter:BadArgumentType', ...
            'Parameter name must be a string.' );
    end
    if ~ismember(param_name,allowed_parameters)
        error('orchidee:target:get_parameter:BadArgumentValue', ...
            [ '''' param_name ''': unknown analysis parameter.' ] );
    end
    % -- Return the input parameter value
    param_value = target_instance.parameters.(param_name);
end
       end
       
   end
   
end 
