%
% FiltersSpectral.m	: Class definition for applying spectral filters 
%
% This class allows to define an abstract constraint system
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%

classdef FiltersSpectral < Filters
    
    properties (SetAccess = protected, GetAccess = public)
        valuesRange
        filterRange
    end
    
    methods
        
        function fI = FiltersSpectral(sessObj, attribute)
            fI = fI@Filters(sessObj, attribute);
            fI.valuesRange = [-Inf +Inf];
            fI.filterRange = [-Inf +Inf];
        end
        
        function setValuesRange(this, vRange)
            this.valuesRange = vRange;
            this.filterRange = vRange;
        end
        
        function setFilterRange(this, fRange)
            this.filterRange = fRange;
        end
        
        function list = apply(this)
            switch this.fMode
                case 'free'
                    list = this.valuesRange;
                    return;
                case 'between'
                    list = this.filterRange;
                    return;
                case 'under'
                    list = this.filterRange(1);
                    return;
                case 'over'
                    list = this.filterRange(1);
                    return;
                case 'approx'
                    list = this.filterRange(1);
                    return;
            end
        end
        
    end
   
end 
