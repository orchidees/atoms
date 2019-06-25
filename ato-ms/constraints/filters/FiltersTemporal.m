%
% FiltersTemporal.m	: Class definition for temporal filters 
%
% This class allows to define an abstract constraint system
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%

classdef FiltersTemporal < Filters
        
    properties (SetAccess = protected, GetAccess = public)
        timeShape
    end
    
    methods
        
        function fI = FiltersTemporal(sessObj, attribute)
            fI = fI@Filters(sessObj, attribute);
            fI.timeShape = [];
        end
        
    end
    
end 
