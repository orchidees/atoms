%
% TargetAbstract.m  : Main class for abstract target
%
% This class allows to define an abstract target
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef TargetAbstract < Target
   
   methods
       
       %
       % Main constructor for the abstract target
       %
       function tA = TargetAbstract(sessionObj)
           tA = tA@Target(sessionObj);
           tA.isComputed = 0;
       end
              
       %
       % Launch computation of the target features
       %
       function success = computeFeatures(this)
           this.isComputed = 1;
           success = 1;
       end
       
       %
       % Modify the value of a target feature
       %
       function success = modifyFeature(this, fName, fValue)
       end
       
       %
       % Add a specfic feature to the target
       %
       function success = addFeature(this, fName, fValue)
       end
       
       %
       % Retrieve the value of a specific feature
       %
       function feature = getFeature(this, fName)
       end
       
        %
        % Retrieve the names of all features 
        %
        function featLis = getFeaturesNames(this)
        end
        
        %
        % Retrieve the names of all features 
        %
        function featLis = getFeaturesList(this)
        end
       
       %
       % Set parameters for the features analysis
       %
       function success = setAnalysisParameter(this, paramName, paramValue)
       end
       
   end
   
end 
