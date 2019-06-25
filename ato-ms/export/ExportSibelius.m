%
% ExportSibelius.m   : Main class for exporting to Sibelius format
%
% This class allows to obtain a set of files following the Sibelius format
% for solutions.
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef ExportSibelius < Export
    
   methods
       
        %
        % Main constructor for the Sibelius export object
        %
        function iES = ExportSibelius(sessionObj, file)
            iES = iES@Export(sessionObj, file);
        end
              
       %
       % Initialize the exporting system
       %
       function initializeExport(this)
       end
       
       %
       % Export a single solution to the appropriate format
       %
       function exportSingleSolution(this, solution)
       end
       
       %
       % Export the whole solution set to the desired format
       %
       function exportSolutionSet(this, solutionSet)
       end
       
   end
   
end 
