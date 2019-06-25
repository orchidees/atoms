%
% ConstraintsSymbolic.m     : Class definition for symbolic constraints
%
% This class allows to define a constraint system based on symbolic
% properties. It should embed a whole language of constraint interaction.
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef ConstraintsSymbolic < Constraints
    
   methods
       
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
