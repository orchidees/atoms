%
% Export.m          : Abstract interface for exporting data
%
% This class allows to define an abstract export mode.
% Each kind of solution should be related to a different export function
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef Export < handle
    
    properties
        fileName        % Filename which will contains export
        sSession        % Current user session
    end

    methods (Abstract)
       
        %
        % Initialize the exporting system
        %
        initializeExport(this)
       
        %
        % Export a single solution to the appropriate format
        %
        exportSingleSolution(this, solution)
       
        %
        % Export the whole solution set to the desired format
        %
        exportSolutionSet(this, solutionSet)
        
        %
        % Export the solution set in a light version.
        % This allows to define a simpler and faster export solution
        %
        exportSolutionSetLight(this, solutionSet, mapFile)
       
    end
   
    methods
       
        %
        % Main constructor for the export object
        %
        function sI = Export(sessObj, file)
            sI.fileName = file;
            sI.sSession = sessObj;
        end
        
    end
   
end 
