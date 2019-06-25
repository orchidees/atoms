%
% RepresentationAbstract.m  : Abstract representation models
%
% This class allows to define an abstract representation
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef RepresentationAbstract < Representation
    
    properties (SetAccess = protected, GetAccess = protected)
        orderingMode        % Mode of reordering the solutions list
    end

    methods
        
        %
        % Main constructor for abstract representations
        %
        function rA = RepresentationAbstract()
            rA = rA@Representation();
            rA.orderingMode = 'none';
        end
       
        %
        % Construct the representation from the set of solution
        %
        function construct(this)
        end
       
        %
        % Transform the representation based on different properties
        %
        function transform(this, tProps)
        end
       
        %
        % Export the representation to a file depending on format
        %
        function export(this, fName)
        end
       
   end
   
end 
