%
% Constraints.m     : Abstract interface for constraints definition
%
% This class allows to define an abstract constraint system
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef Constraints < handle

   properties (SetAccess = protected, SetAccess = protected)
       cNetwork         % Network of constraints
       cDomains         % Domains of possible values
   end

   methods (Abstract)
       
       %
       % Initialize the constraint system
       %
       initialize(this)
       
       %
       % Check the feasibility of the current network
       %
       feasible = checkFeasibility(this)
       
       %
       % Apply the constraint network to obtain a set
       %
       set = apply(this)
       
       %
       % Add a constraint to the current network
       %
       addConstraint(this, constraint)
       
       %
       % Remove a constraint from the current network
       %
       removeConstraint(this, constraint)
       
   end
end 
