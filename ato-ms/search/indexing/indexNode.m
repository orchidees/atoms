classdef indexNode < handle
    
    properties
        data;
        dist;
        dataSize;
        nearestNodes;
        nearestDists;
        nbChildren;
        nodeType;
        isInternal;
        isTerminal;
        cardinality;
        visited;
        hashNodes;
        seriesList;
        featureList;
        nbSeries;
        idList;
    end
    
    %- Methods -%
    
    methods
        
        % Constructor
        function self = indexNode(type, card, data)
            self = self@handle;
            if nargin > 2
                self.data = data;
            else
                self.data = [];
            end
            self.dataSize       = length(self.data);
            self.nbChildren     = 0;
            self.nbSeries       = 0;
            self.cardinality    = card;
            self.nodeType       = type;
            self.isTerminal     = strcmp(self.nodeType, 'terminal');
            self.isInternal     = strcmp(self.nodeType, 'internal');
            self.hashNodes      = cell(2 ^ (card - self.dataSize), 1);
            self.nearestNodes   = [];
            self.nearestDists   = [];
            self.idList         = [];
            self.seriesList     = {};
            self.featureList    = {};
            self.visited        = 0;
            self.dist           = 0;
        end
        
        % Set data
        function self = setData(self, data)
            self.data       = data;
            self.dataSize   = size(data, 2);
        end
        
        % Get leaves
        function leaves = getLeaves(self)
            if self.nbChildren
                leaves = [];
                for child = 1:length(self.hashNodes)
					if (~isempty(self.hashNodes{child}))
						leaves = cat(2, leaves, self.hashNodes{child}.getLeaves);
					end
                end
            else
                leaves = self;
            end
        end

		function result = getNumberDescendants(self)
			if self.nbChildren
				result = 1;
				for child = 1:length(self.hashNodes)
					if ~isempty(self.hashNodes{child})
						result = result + self.hashNodes{child}.getNumberDescendants();
					end
				end
			else
				result = 1;
			end
		end

        % Add child
        function addChild(self, child)
            self.nbChildren = self.nbChildren + 1;
            base = child.data;
            tmpHash = base((self.dataSize + 1):end);
            self.hashNodes{sum((2 .^ ((length(tmpHash) - 1):-1:0)) .* tmpHash) + 1} = child;
        end
        
        function data = getData(self)
            data = self.data;
        end
                
        function addSeries(self, series, id, feats)
            if nargin < 4
                feats = [];
            end
            self.featureList = [self.featureList, feats];
            self.seriesList = [self.seriesList, series];
            self.idList = [self.idList, id];
            self.nbSeries = self.nbSeries + 1;
        end
        
        function node = containsChild(self, binaryRep)
            tmpHash = binaryRep((self.dataSize + 1):end);
            node = self.hashNodes{sum((2 .^ ((length(tmpHash) - 1):-1:0)) .* tmpHash) + 1};
        end
        
        function addSoundID(self,id)
            self.idList = [self.idList, id];
        end
        
        function nb = numberOfSeries(self)
            nb = length(self.seriesList);
        end
        
        function size = getDataSize(self)
            size = self.dataSize;
        end
        
        function type = getType(self)
            type = self.nodeType;
        end
        
        function removeNearestNeighbor(self, oldNode)
            for i = 1:length(self.nearestNodes)
                if (self.nearestNodes{i} == oldNode)
                    break;
                end
            end
            self.nearestNodes = {self.nearestNodes{1:(i - 1)} self.nearestNodes{(i + 1):end}};
            self.nearestDists = [self.nearestDists(1:(i - 1)) self.nearestDists((i + 1):end)];
        end
        
        function sortNearestNeighbors(self)
            [self.nearestDists idS] = sort(self.nearestDists);
            self.nearestNodes = self.nearestNodes{idS};
        end
        
        function initNearestNeighbors(self, nbNodes)
            self.nearestDists = zeros(nbNodes, 1);
        end
        
        function addNearestNeighbor(self, newNode, wLen, orSize, id)
            lbDist = self.approxDistToNode(newNode.data, wLen, orSize);
            self.nearestDists(id) = lbDist;
        end
        
        function dist = approxDistToNode(self, binData, wLen, orSize)
            minLength = min([length(self.data) length(binData)]);
            dist = sqrt(orSize / wLen) * sqrt(sum((binData(1:minLength) - self.data(1:minLength)) .^ 2));
        end
        
        function dist = approxDistToNode2(self, binData, wLen, orSize)
            rawData = binData(:);
            selfDat = zeros(1, wLen);
            tmpData = zeros(1, wLen);
            cut = ((-(2^wLen - 1)):2:(2^wLen - 1)) ./ (2^(wLen - 1));
            for i = 1:wLen
                tmpSelf = self.data(i:wLen:length(self.data));
                tmpDat = rawData(i:wLen:length(self.data))';
                cardinality = length(tmpSelf);
                tmpValS = sum((2 .^ ((cardinality - 1):-1:0)) .* tmpSelf);
                tmpValD = sum((2 .^ ((cardinality - 1):-1:0)) .* tmpDat);
                if (tmpValS < tmpValD)
                    tmpSelf = [tmpSelf 1 zeros((length(rawData) / wLen) - cardinality - 1, 1)'];
                elseif (tmpValS > tmpValD)
                    tmpSelf = [tmpSelf 0 ones((length(rawData) / wLen) - cardinality - 1, 1)'];
                else
                    tmpSelf = [tmpSelf rawData((i + (cardinality * wLen)):wLen:length(rawData))'];
                end
                tmpDat = rawData(i:wLen:length(rawData))';
                selfDat(i) = cut(sum((2 .^ ((wLen - 1):-1:0)) .* tmpSelf) + 1);
                tmpData(i) = cut(sum((2 .^ ((wLen - 1):-1:0)) .* tmpDat) + 1);
            end
            dist = sqrt(orSize / wLen) * sqrt(sum((tmpData - selfDat) .^ 2));
        end
        
        function dist = approxDistToNode3(self, binData, wLen, orSize)
            minLength = min([length(self.data) length(binData)]);
            dist = sqrt(orSize / minLength) * sqrt(sum((binData(1:minLength) - self.data(1:minLength)) .^ 2));
        end
        
        function [dist id compDist] = bestTrueDistance(self, rawData, series)
            id = 0;
            dist = Inf;
            if (self.isInternal)
                id = 1;
                compDist = zeros(length(self.idList), 1);
                compDist(1) = Inf;
                return;
            end
            compDist = zeros(length(self.seriesList), 1);
            for i = 1:length(self.seriesList)
                curSeries = series(i, :);
                compDist(i) = sqrt(sum((curSeries - rawData) .^ 2));
                if compDist(i) < dist
                    dist = compDist(i);
                    id = self.idList(i);
                end
            end
        end
        
        function emptySeriesList(self)
            clear self.seriesList;
            self.seriesList = {};
        end
        
        % Disconnect
        function disconnect(self)
            clear self.idList;
            clear self.seriesList;
            clear self.hashNodes;
            clear self.children;
        end
        
        % Kill
        function kill(self)
            for child = 1:self.nbChildren
                kill(self.hashNodes{1});
            end
            disconnect(self);
        end
        
        % Delete
        function delete(self)
            self.disconnect;
        end
      
    end
    
end 
