%
% FiltersSymbolic.m	: Class definition for applying symbolic filters 
%
% This class allows to define an abstract constraint system
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%

classdef FiltersSymbolic < Filters
    
    properties (SetAccess = protected, GetAccess = public)
        includeList             % Values to include in the search space
        valueList               % Complete list of values
    end
    
   methods
       
       function fI = FiltersSymbolic(sessObj, attribute)
            fI = fI@Filters(sessObj, attribute);
            fI.includeList = {};
            fI.valueList = {};
       end
       
       function setValuesList(this, vals)
           this.valueList = vals;
           this.includeList = vals;
       end
       
       function setIncludeList(this, vals)
           this.includeList = vals;
       end
       
       function addIncludeList(this, vals)
           if isempty(this.includeList)
               this.includeList = vals;
           else
               this.includeList = [this.includeList vals];
           end
       end
       
       function list = apply(this)
           switch this.fMode
               case 'free'
                   list = this.valueList;
                   return;
               case 'force'
                   list = this.includeList;
                   return;
               otherwise
                   list = this.valueList;
                   return;
           end
       end
       
   end
   
end 
