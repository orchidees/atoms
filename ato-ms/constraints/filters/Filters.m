%
% Filters.m         : Abstract interface for filters definition
%
% This class allows to define an abstract constraint system
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef Filters < Constraints

    properties (SetAccess = protected, GetAccess = public)
        sSession                    % Current session
        fAttribute                  % Attribute on which the filter apply
        fMode                       % Mode of application
    end
    
    methods (Abstract)
    end
    
    methods
   
        %
        % Main constructor for filters
        %
        function fI = Filters(sessObj, attribute)
            fI.sSession = sessObj;
            fI.fAttribute = attribute;
            fI.fMode = 'bypass';
        end
        
        %
        % Modify the mode of application
        %
        function setMode(this, mode)
            this.fMode = mode;
        end
        
        %
        % Initialize the constraint system
        %
        function initialize(this)
        end
       
        %
        % Check the feasibility of the current network
        %
        function feasible = checkFeasibility(this)
        end
       
        %
        % Apply the constraint network to obtain a set
        %
        function set = apply(this)
        end
       
        %
        % Add a constraint to the current network
        %
        function addConstraint(this, constraint)
        end
       
        %
        % Remove a constraint from the current network
        %
        function removeConstraint(this, constraint)
        end
        
    end
   
end 
