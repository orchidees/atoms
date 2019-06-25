classdef indexTree < handle
    %- Properties -%
    properties
        root;
        wordLength;
        maxCardinality;
        terminalNodes;
		cardIncrease;
        maxSeries;
        cutPoints;
    end
    
    %- Methods -%
    methods
        % Constructor
        function self = indexTree(wordLen, cardinality, maxN, cardInc, root)
            if nargin < 5
                root = indexNode('internal', wordLen);
            end
            if ~isa(root, 'indexNode')
                error('The root must be given as an index node.');
            end
            self = self@handle;
            self.root               = root;
            self.wordLength         = wordLen;
            self.maxCardinality     = cardinality;
			self.cardIncrease		= cardInc;
            self.maxSeries          = maxN;
            self.cutPoints          = ((-(2^cardinality - 1)):2:(2^cardinality - 1)) ./ (2^cardinality / 2);
            self.cutPoints(1)       = -inf;
            self.cutPoints(end)     = inf;
            self.terminalNodes      = {};
        end
        
        function removeAllSeries(self)
            for i = 1:length(self.terminalNodes)
                curNode = self.terminalNodes{i};
                curNode.emptySeriesList();
            end
        end
        
        function constructNearestNeighbors(self)
            for i = 1:(length(self.terminalNodes) - 1)
                disp([num2str(i) '/' num2str(length(self.terminalNodes))]);
                curNodeBase = self.terminalNodes{i};
                curNodeBase.initNearestNeighbors(length(self.terminalNodes) - 1);
                for j = (i + 1):length(self.terminalNodes)
                    curNodeSec = self.terminalNodes{j};
                    curNodeBase.addNearestNeighbor(curNodeSec, self.wordLength, self.wordLength, j - 1);
                    curNodeSec.addNearestNeighbor(curNodeBase, self.wordLength, self.wordLength, i);
                end
                [curNodeBase.nearestDists idS] = sort(curNodeBase.nearestDists);
                idS(idS < i) = idS(idS < i);
                idS(idS > i) = idS(idS > i) + 1;
                curNodeBase.nearestNodes = self.terminalNodes(idS);
                %curNodeBase.sortNearestNeighbors();
            end
            curNodeBase = self.terminalNodes{end};
            [curNodeBase.nearestDists idS] = sort(curNodeBase.nearestDists);
            idS(idS < i) = idS(idS < i);
            idS(idS > i) = idS(idS > i) + 1;
            curNodeBase.nearestNodes = self.terminalNodes(idS);
        end
        
        function updateNearestNeighbors(self, newNode)
%            for i = 1:length(self.terminalNodes)
%                self.terminalNodes{i}.addNearestNeighbor(newNode, self.wordLength, self.wordLength);
%                newNode.addNearestNeighbor(self.terminalNodes{i}, self.wordLength, self.wordLength);
%            end
            if isempty(self.terminalNodes)
                self.terminalNodes = {newNode};
            else
                self.terminalNodes = {self.terminalNodes{1:end} newNode};
            end
        end
        
        function removeTerminalNode(self, oldNode)
            rIndex = 1;
            for i = 1:length(self.terminalNodes)
                curNode = self.terminalNodes{i};
                if (curNode == oldNode)
                    rIndex = i;
                    continue;
                end
            end
            self.terminalNodes = {self.terminalNodes{1:(rIndex - 1)} self.terminalNodes{(rIndex + 1):end}};
        end
        
        function insertSeries(self, rawData, serieID, featList)
            if nargin < 4
                featList = [];
            end
            binaryRep = indexRepresentation(rawData, length(rawData), ...
                        self.wordLength, self.maxCardinality, self.cutPoints);
            
            curNode = self.root;
            while (curNode.isInternal)
                curNode.idList = [curNode.idList, serieID];
                curNode.featureList = [curNode.featureList featList];
                curCard = curNode.cardinality;
                curBinary = binaryRep(1:curCard);
                tmpHash = curBinary((curNode.dataSize + 1):end);
                node = curNode.hashNodes{sum((2 .^ ((length(tmpHash) - 1):-1:0)) .* tmpHash) + 1};
                if ~isempty(node)
                    if node.isTerminal
                        if (node.nbSeries < self.maxSeries)
                             node.seriesList = [node.seriesList binaryRep];
                             node.nbSeries = node.nbSeries + 1;
                             node.idList = [node.idList serieID];
                             node.featureList = [node.featureList featList];
                             break;
                        else
                            newCard = curCard + self.cardIncrease;
                            if (newCard > size(binaryRep, 1) * size(binaryRep, 2))
                                node.addSeries(binaryRep, serieID, featList);
                                break;
                            end
                            self.removeTerminalNode(node);
                            newIntNode = indexNode('internal', newCard, curBinary);
                            tmpSeries = node.seriesList;
                            tmpIDList = node.idList;
                            tmpFList = node.featureList;
                            for i = 1:length(tmpIDList)
                                curSeries = tmpSeries{i};
                                tmpBinary = curSeries(1:newCard);
                                tmpHash = tmpBinary((newIntNode.dataSize + 1):end);
                                tmpNode = newIntNode.hashNodes{sum((2 .^ ((length(tmpHash) - 1):-1:0)) .* tmpHash) + 1};
                                if ~isempty(tmpNode)
                                    tmpNode.seriesList = [tmpNode.seriesList curSeries];
                                    tmpNode.nbSeries = tmpNode.nbSeries + 1;
                                    tmpNode.idList = [tmpNode.idList tmpIDList(i)];
                                    tmpNode.featureList = [tmpNode.featureList tmpFList(i)];
                                else
                                    newNode = indexNode('terminal', newCard, tmpBinary);
                                    self.updateNearestNeighbors(newNode);
                                    newNode.addSeries(curSeries, tmpIDList(i), tmpFList(i));
                                    newIntNode.addChild(newNode);
                                end
                            end
                            clear tmpSeries;
                            clear tmpIDList;
                            curNode.nbChildren = curNode.nbChildren - 1;
                            node.delete();
                            clear node;
                            curNode.addChild(newIntNode);
                            curNode = newIntNode;
                        end
                    elseif node.isInternal
                        curNode = node;
                    end
                else
                    newNode = indexNode('terminal', curCard, curBinary);
                    self.updateNearestNeighbors(newNode);
                    newNode.seriesList = [newNode.seriesList binaryRep];
                    newNode.nbSeries = newNode.nbSeries + 1;
                    newNode.idList = [newNode.idList serieID];
                    newNode.featureList = [newNode.featureList featList];
                    curNode.addChild(newNode);
                    break;
                end
            end
        end
        
        function [results, resNode, binaryRep] = approximateQuery(self, rawData, filterID, maxNum)
            binaryRep = indexRepresentation(rawData, length(rawData), self.wordLength, self.maxCardinality, self.cutPoints);
            
            resNode = self.root;
            nbBound = 2 ^ nextpow2(maxNum);
            while (resNode.isInternal)
                results = intersect(resNode.idList, filterID);
                if (length(results) < nbBound)
                    break;
                end
                curCard = resNode.cardinality;
                curBinary = binaryRep(1:curCard);
                node = resNode.containsChild(curBinary);
                if ~isempty(node)
                    if (length(intersect(node.idList, filterID)) < nbBound)
                        break;
                    end
                    resNode = node;
                else
                    break;
                end
            end
            results = intersect(resNode.idList, filterID);
        end
        
        function [results, resNode, binaryRep] = approximateQueryConstrained(self, rawData, filterID, maxNum, duration)
            binaryRep = indexRepresentation(rawData, length(rawData), self.wordLength, self.maxCardinality, self.cutPoints);
            
            distList = [];
            resNode = self.root;
            nbBound = 2 ^ nextpow2(maxNum);
            durVariability = 0.2 * duration;
            while (resNode.isInternal)
                results = intersect(resNode.idList, filterID);
                if (length(results) < nbBound)
                    break;
                end
                curCard = resNode.cardinality;
                curBinary = binaryRep(1:curCard);
                node = resNode.containsChild(curBinary);
                if ~isempty(node)
                    if (length(intersect(node.idList, filterID)) < nbBound)
                        break;
                    end
                    resNode = node;
                else
                    break;
                end
            end
            distList = abs(cell2mat(resNode.featureList) - duration);
            tmpResults = resNode.idList(distList < durVariability);
            results = intersect(tmpResults, filterID);
            if (resNode == self.root)
                results = [];
            end
        end
        
        function resetVisitedStatus(self)
            for i = 1:length(self.terminalNodes)
                self.terminalNodes{i}.visited = 0;
            end
        end
        
        % Exact query (bottom up style)
        function [results BSF dList cList] = exactQuery(self, rawData, filterID, maxNum, series)
            [results resNode bRep] = self.approximateQuery(rawData, filterID, maxNum);
            BSF = struct;
            BSF.node = resNode;
            orSize = length(rawData);
            dList = zeros(size(series, 1), 1);
            cList = zeros(size(series, 1), 1);
            nbSeriesComputed = length(resNode.idList);
            [BSF.dist BSF.id tmpList] = resNode.bestTrueDistance(rawData, series(resNode.idList, :));
            %disp('After best true distance :');
            %disp(size(resNode.idList));
            %disp(size(tmpList));
            dList(resNode.idList) = tmpList;
            cList(resNode.idList) = tmpList;
            if isinf(BSF.dist)
                resNode = self.terminalNodes{1};
            end
            NNList = resNode.nearestNodes;
            dists = [];
            pq = [];
            for i = 1:length(NNList)
                curNode = NNList{i};
                curNode.dist = curNode.approxDistToNode(bRep, self.wordLength, orSize);
                dList(curNode.idList) = curNode.dist;
                if (curNode.dist >= BSF.dist)
                    continue;
                end
                dists = [dists curNode.dist];
                pq = [pq curNode];
            end
            [dists idS] = sort(dists);
            pq = pq(idS);
            while ~isempty(pq)
                min = pq(1);
                if (length(pq) > 1)
                    pq = pq(2:end);
                else
                    pq = [];
                end
                if min.dist >= BSF.dist
                    break;
                end
                %if min.isTerminal
                if min ~= resNode
                    [tmpDist tmpID tmpList] = min.bestTrueDistance(rawData, series(min.idList, :));
                    dList(min.idList) = tmpList;
                    cList(min.idList) = tmpList;
                    nbSeriesComputed = nbSeriesComputed + length(min.idList);
                    if BSF.dist > tmpDist
                        BSF.id = tmpID;
                        BSF.dist = tmpDist;
                        BSF.node = min;
                    end
                end
            end
            results = intersect(BSF.node.idList, filterID);
            %disp('Total number of nodes computed :');
            %disp(nbSeriesComputed);
        end
       
        function BSF = exactQueryTopDown(self, rawData, filterID, maxNum, series)
            [results resNode bRep] = self.approximateQuery(rawData, filterID, maxNum);
            BSF = struct;
            BSF.node = resNode;
            orSize = length(rawData);
            nbSeriesComputed = length(resNode.idList);
            [BSF.dist BSF.id] = resNode.bestTrueDistance(rawData, series(resNode.idList, :));
            pq = {self.root};
            % pq.offer(self.root);
            while ~isempty(pq)
                min = pq{1};
                if (length(pq) > 1)
                    pq = pq(2:end);
                else
                    pq = {};
                end
                if min.dist >= BSF.dist
                    break;
                end
                if min.isTerminal
                    [tmpDist tmpID] = min.bestTrueDistance(rawData, series(min.idList, :));
                    nbSeriesComputed = nbSeriesComputed + length(min.idList);
                    if BSF.dist > tmpDist
                        BSF.id = tmpID;
                        BSF.dist = tmpDist;
                        BSF.node = min;
                    end
                elseif (min.isInternal)
                    for i = 1:length(min.hashNodes)
                        curNode = min.hashNodes{i};
                        if (isempty(curNode))
                            continue;
                        end
                        curNode.dist = curNode.approxDistToNode(bRep, self.wordLength, orSize);
                        if (curNode.dist >= BSF.dist)
                            continue;
                        end
                        for j = 0:(length(pq) - 1)
                            if (curNode.dist < pq{j + 1}.dist)
                                break;
                            end
                        end
                        pq = {pq{1:j} curNode pq{(j + 1):end}};
                    end
                end
            end
            disp('Total number of nodes computed :');
            disp(nbSeriesComputed);
        end
        
        % Exact query (bottom up style)
        function [orderedResults] = exactQueryUpward(self, rawData, filterID, maxNum)
            [results resNode bRep] = self.approximateQuery(rawData, filterID, maxNum);
            BSF = struct;
            BSF.node = resNode;
            [BSF.dist BSF.id] = resNode.bestTrueDistance(rawData);
            
            pq = queuePriority('indexTree');
            pq.offer(resNode.parent);
            while ~pq.isempty()
            end
        end
        
        function dumpTree(self)
            pq = [self.root];
            while ~isempty(pq)
                min = pq(1);
                disp(min);
                if (length(pq) > 1)
                    pq = pq(2:end);
                else
                    pq = [];
                end
                if min.isTerminal
                    continue;
                elseif (min.isInternal)
                    for i = 1:length(min.hashNodes)
                        curNode = min.hashNodes{i};
                        if ~isempty(curNode)
                            pq = [pq curNode];
                        end
                    end
                end
            end
        end
    end
end 
