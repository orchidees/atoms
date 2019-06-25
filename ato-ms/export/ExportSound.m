%
% ExportSound.m     : Class for exporting soundfiles
%
% This class allows to export solutions to a soundfile by adding the
% different components of any proposal.
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef ExportSound < Export
 
    methods
        
        %
        % Main constructor for the Sibelius export object
        %
        function iES = ExportSound(sessObj, file)
            iES = iES@Export(sessObj, file);
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
       function exportSolutionSet(this, solutionSet, outName)
            dbBasePath = '../dbProcessed/';
            variableTable = unique(solutionSet.solutionIDs);
            values = this.sSession.getKnowledge().getFieldsValues({'soundID', 'file'}, variableTable);
            ids = cell2mat(values(:, 1));
            solutions = solutionSet.getSolutions();
            tDuration = this.sSession.getTarget().getFeature('duration');
            for instru = 1:length(solutions)
                resultSignal = zeros(1, 1);
                curSol = solutions(instru);
                disp(['Solution ' num2str(instru) ' :']);
                for s = 1:length(curSol.individualsSet)
                    curIndividual = curSol.individualsSet(s);
                    sID = find(ids == curIndividual.sInstrument, 1, 'first');
                    if isempty(sID)
                        disp('empty');
                        continue;
                    end
                    disp([num2str(curIndividual.sInstrument) ' / ' num2str(sID) ' / ' num2str(curIndividual.sOnset)]);
                    disp(cell2mat(values(sID, 2)));
                    instruPath = [dbBasePath cell2mat(values(sID, 2))];
                    try
                    instruSignal = importSignal(instruPath);
                    catch
                        continue;
                    end
					if isempty(instruSignal)
						continue;
					end
                    if (size(instruSignal, 2) > 1)
                        instruSignal = mean(instruSignal, 2);
                    end
                    instruSignal = instruSignal ./ max(abs(instruSignal));
                    instruSignal = padarray(instruSignal, [floor(curIndividual.sOnset * (tDuration / 128) * 44100) 0], 0, 'pre');
                    lenDiff = abs(length(instruSignal) - length(resultSignal));
                    if length(instruSignal) < length(resultSignal)
                        instruSignal =  padarray(instruSignal, [lenDiff 0], 0, 'post');
                    else    
                        resultSignal =  padarray(resultSignal, [lenDiff 0], 0, 'post');
                    end
                    resultSignal = resultSignal + instruSignal;
                end
                resultSignal = resultSignal ./ (max(abs(resultSignal)) + 0.01);
                wavwrite(resultSignal, 44100, 32, [outName '_' num2str(instru) '.wav']);
            end
       end
       
       
        function exportSolutionSetLight(this, solutionSet, mapFile)
        end
       
   end
   
end 
