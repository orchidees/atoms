%
% Search.m          : Abstract interface for search algorithm
%
% This class allows to define an abstract target
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef Search < handle

   properties (SetAccess = protected, GetAccess = public)
       solutionSet          % Set of solutions
       searchParameters     % Parameters for the search
       sSession             % Session context of search
   end

   methods (Abstract)
       
       %
       % Initialize the search algorithm
       %
       initialize(this)
       
       %
       % Launch the search algorithm and return the solution set
       %
       solutions = launchSearch(this)
       
       %
       % Set the parameters of the search
       %
       setSearchParameters(this, params)
       
       %
       % Set one parameter of the search
       %
       setParameter(this, name, param)
       
       %
       % Get parameters of the search
       %
       params = getSearchParameters(this)
       
   end
   
   methods
       
       %
       % Main constructor for search algorithm
       %
       function sI = Search(sessionObj)
           sI.solutionSet = [];
           sI.searchParameters = struct;
           if ~isa(sessionObj, 'OSession')
               error('Search:Constructor', 'Object is not session type');
           end
           sI.sSession = sessionObj;
       end
   end
   
   methods (Static)
       
       function alg = availableAlgorithms()
           alg{1} = 'Sub-space genetic';
           alg{2} = 'Optimal warping';
       end
       
       function obj = constructSearch(index, sessObj)
           switch (index)
               case 0
                   obj = SearchGenetic(sessObj);
               case 1
                   obj = SearchOptimalWarping(sessObj);
               otherwise
                   obj = SearchGenetic(sessObj);
           end
       end
   end
   
end 
