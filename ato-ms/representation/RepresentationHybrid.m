%
% RepresentationHybrid.m  : Hybrid representation models
%
% This class allows to define an hybrid representation model
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef RepresentationHybrid < Representation
    
   properties (SetAccess = protected, GetAccess = protected)
        ordering
   end

   methods

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
