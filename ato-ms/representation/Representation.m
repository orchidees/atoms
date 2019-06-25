%
% Representation.m  : Abstract interface for representation models
%
% This class allows to define the behavior of any representation
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef Representation < handle
    
    properties (SetAccess = protected, GetAccess = protected)
        solutionSet      % Set of solutions that should be represented
    end

    methods (Abstract)
       
        %
        % Construct the representation from the set of solution
        %
        construct(this)
       
        %
        % Transform the representation based on different properties
        %
        transform(this, tProps)
       
        %
        % Export the representation to a file depending on format
        %
        export(this, fName)
       
    end
    
    methods
 
        %
        % Main constructor for representation objects
        %
        function rI = Representation()
            rI.solutionSet = [];
        end
        
    end
end 
