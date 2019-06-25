%
% Solution.m         : Class definition for a single solution
%
% A solution is defined as a mixture of individuals.
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef Solution < handle
    
   properties (GetAccess = public, SetAccess = private)
       sSession             % Current orchestration session
       individualsSet       % Individuals that compose the mixture
       individualsID        % Array of individual indexes
       mixFeatures          % Features for this solution
       mixCriteria          % Value of criteria for this solution
       isComputed           % Boolean to check if solution has been computed
   end

   methods
       
       %
       % Main constructor for a solution object
       %
       function sSo = Solution(sessObj, size)
           if nargin > 0
               sSo.sSession = sessObj;
               sSo.individualsID = zeros(size, 1);
               tmpSet(size) =  Individual(sessObj, 0, 0);
               sSo.individualsSet = tmpSet;
               sSo.mixFeatures = [];
               sSo.mixCriteria = [];
               sSo.isComputed = 0;
           end
       end
       
       function setSession(this, sessObj)
           this.sSession = sessObj;
           this.mixFeatures = [];
           this.mixCriteria = [];
           this.isComputed = 0;
       end
       
       function setSize(this, size)
           this.individualsID = zeros(size, 1);               
           this.individualsSet = repmat(Individual(), size, 1);
       end
       
       %
       % Modify one individual of the solution
       %
       function setIndividual(this, iValue, id, idInst)
           if nargin < 4
               idInst = iValue.sInstrument;
           end
           %oldInd = this.individualsSet(id);
           % Check if we are replacing by exactly the same individual
           %if ~isempty(oldInd) && oldInd.sInstrument == iValue.sInstrument && oldInd.sOnset == iValue.sOnset
           %    return;
           %end
           % Update individual values
           this.individualsSet(id) = iValue;
           this.individualsID(id) = idInst;
           this.mixFeatures = [];
           this.mixCriteria = [];
           this.isComputed = 0;
       end
      
       %
       % Set all individuals of the solution
       %
       function setIndividuals(this, indivSet, idSet)
           this.individualsSet = indivSet;
           this.individualsID = idSet;
           this.mixFeatures = [];
           this.mixCriteria = [];
           this.isComputed = 0;
       end
       
       %
       % Empty all individuals of the solution
       %
       function emptyIndividuals(this)
           this.individualsSet = [];
           this.individualsID = [];
           this.mixFeatures = [];
           this.mixCriteria = [];
           this.isComputed = 0;
       end
       
       
       %
       % Retrieve the number of individuals in the mixture (including
       % neutral elements)
       %
       function nb = getNbInstruments(this)
           nb = length(this.individualsSet);
       end
       
       %
       % Set one feature of this solution
       %
       function setSolutionFeature(this, fName, fValue)
           this.mixFeatures.(fName) = fValue;
       end
       
       %
       % Set all features of this solution
       %
       function setFeatures(this, fSet)
           this.mixFeatures = fSet;
           this.isComputed = 1;
       end
       
       %
       % Set the criteria values for this solution
       %
       function setCriteria(this, cValue)
           this.mixCriteria = cValue;
       end
       
       function setComputed(this)
           this.isComputed = 1;
       end
       
       %
       % Retrieve the individuals for this solution
       %
       function idSet = getIndividuals(this)
           idSet = this.individualsSet;
       end
       
       %
       % Get the individual features
       %
       function mFeat = getIndividualFeatures(this)
           mFeat = this.individualsSet.finalFeatures;
       end
       
       %
       % Get the individual feature
       %
       function mFeat = getIndividualFeature(this, fName)
           curFeat = this.individualsSet(1).finalFeatures.(fName);
           if (size(curFeat, 1) == 1)
               mFeat = zeros(length(this.individualsSet(1).finalFeatures.(fName)), length(this.individualsSet));
               for i = 1:length(this.individualsSet)
                   mFeat(:, i) = this.individualsSet(i).finalFeatures.(fName);
               end
           else
               mFeat = zeros(size(curFeat, 1), size(curFeat, 2) * length(this.individualsSet));
               for i = 1:length(this.individualsSet)
                   mFeat(:, (((i - 1) * size(curFeat, 2)) + 1):(i * size(curFeat, 2))) = this.individualsSet(i).finalFeatures.(fName);
               end
           end
           %mFeat = this.individualsSet;
           %mFeat = mFeat(:).finalFeatures;
           %mFeat = mFeat.(fName);
       end
       
       %
       % Retrieve the features of this solution
       %
       function mFeat = getSolutionFeatures(this)
           mFeat = this.mixFeatures;
       end
       
       %
       % Retrieve the features of this solution
       %
       function mFeat = getSolutionFeature(this, fName)
           mFeat = this.mixFeatures.(fName);
       end
       
       %
       % Retrieve the criteria values of this solution
       %
       function mCrit = getSolutionCriteria(this)
           mCrit = this.mixCriteria;
       end
       
       %
       % Debug function to dump solution to files
       %
       function dumpSolution(this, dirName, id)
            if ~exist(dirName, 'dir')
                mkdir(dirName);
            end
            filename = [dirName 'Solution_' num2str(id)];
            myfile = fopen([filename '.txt'], 'w');
            fprintf(myfile, 'Solutions :\n------------\n\n');
            for i = 1:length(this.individualsID)
                fprintf(myfile, '%d\t', this.individualsID(i));
            end
            fprintf(myfile, '\n');
            fprintf(myfile, '\nCriteria :\n-----------\n\n');
            for i = 1:length(this.mixCriteria)
                fprintf(myfile, '%f\t', this.mixCriteria(i));
            end
            fprintf(myfile, '\n');
            fNames = fieldnames(this.mixFeatures);
            for i = 1:length(fNames)
                str1 = this.mixFeatures.(fNames{i});
                if (size(str1, 2) < 2)
                    continue;
                end
                figH = figure(1);
                set(figH,'OuterPosition',[0,0,1024,768]);
                plot(str1);
                saveas(figH, [filename '_' fNames{i} '.jpg'], 'jpg');
            end
            for i = 1:length(this.individualsSet)
                this.individualsSet(i).dumpIndividuals(filename, i);
            end
       end
   end
end 
