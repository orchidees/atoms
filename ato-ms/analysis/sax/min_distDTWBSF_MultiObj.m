%
%
% MultiObjective Distance Function
%
%
function [BSF BSFi] = min_distDTWBSF_MultiObj(series, U, L, BSF, BSFi, id, handles)
    
%
%
%
    % Constructing dist for each objective
    tmpVal = zeros(size(U, 1), 1);
    currentBSF = ones(size(U, 1), 1);
    orderedBSF = {};
    for j = 1:size(BSF, 2)
        [orderedTmp oID] = sort(BSF(:,j),1);
        orderedBSF{j} = BSF(oID, :);
    end
    for j = 1:size(U,1);
        tmpVal(j) = mean(sqrt(sum([(series{j} > U(j,:)) .* (series{j} - U(j,:)); (series{j} < L(j,:)) .* (L(j,:) - series{j})] .^ 2)));
    end
        % Compute point by point
    %for i = 1:size(U, 2)
        % Check if point is Pareto dominated
    %    if ~isempty(orderedBSF)
    %        tmpBSF = [];
    %        for j = 1:size(U, 1)
    %            if currentBSF(j) > size(BSF, 1)
    %                tmpBSF = [tmpBSF ; orderedBSF{j}(size(BSF, 1), :)];
    %            else
    %                tmpBSF = [tmpBSF ; orderedBSF{j}(currentBSF(j), :)];
    %            end
    %        end
    %        if (isPareto(tmpVal, tmpBSF) == 0)
    %        	break;
    %        end
    %    end
    	% For each objective
    %	for j = 1:size(U, 1)
    %        curSerie = series{j};
            %
            %if curSerie(j) > U(j,i)
            %	tmpVal(j) = tmpVal(j) + ((curSerie(j) - U(j,i)) .^ 2);
            %elseif curSerie(j) < L(j,i)
            %	tmpVal(j) = tmpVal(j) + ((L(j,i) - curSerie(j)) .^ 2);
            %end
    %        tmpVal(j) = tmpVal(j) + mean(sqrt(sum([(curSerie(j) > U(j,i)) .* (curSerie(j) - U(j,i)); (curSerie(j) < L(j,i)) .* (L(j,i) - curSerie(j))] .^ 2)));
    %        if ~isempty(orderedBSF) && (currentBSF(j) < size(BSF, 1))
    %            if tmpVal(j) > orderedBSF{j}(currentBSF(j), j)
    %                currentBSF(j) = currentBSF(j) + 1;
    %            end
    %        end
    %    end
    %end
    % If not all objectives are dominated
    % Objective is pareto included
    %if (i == size(U, 2) && (isPareto(tmpVal, BSF) == 1))
    if (isPareto(tmpVal,BSF))
        BSF = [BSF; tmpVal'];
        BSFi = [BSFi, id];
        nBSF = [];
        nBSFi = [];
        for i = 1:length(BSFi)
            if (isPareto(BSF(i, :), BSF) == 1)
                nBSF = [nBSF; BSF(i, :)];
                nBSFi = [nBSFi, BSFi(i)];
          %      plot(BSF(i, 1), BSF(i, 2), 'go');
            else
                if (nargin > 6)
                    message = struct;
                    message.path = '/multiobjectiveRemovePoint';
                    message.tt = 'ii';
                    message.data{1} = 23;
                    message.data{2} = BSFi(i);
                    flux{1} = message;
                    osc_send(handles.osc.addressOut,flux);
                end
            end
        end
        BSF = nBSF;
        BSFi = nBSFi;
        disp(size(BSFi));
		if (nargin > 6)
			message = struct;
			message.path = '/multiobjectiveNewPoint';
			message.tt = 'ii';
			message.data{1} = 23;
			message.data{2} = id;
			for i = 1:length(tmpVal)
			   message.tt = [message.tt 'f'];
			   message.data{2 * (i - 1) + 3} = tmpVal(i);
               message.tt = [message.tt 's'];
               tmpS = series{i};
               tmpS = tmpS - (mod(tmpS, 0.001));
               tmpS = (tmpS - 10);
               matStr = mat2str(tmpS);
               message.data{2 * (i - 1) + 4} = matStr(2:end);
			end
			flux{1} = message;
			osc_send(handles.osc.addressOut,flux);
		end
    end
    %dist = sqrt(compression_ratio * sum(diag(dist_matrix(str1,str2))));

function paretoB = isPareto(distMatrix, paretoFront)
paretoB = 1;
if (isempty(paretoFront))
    return;
end
nbFront = size(paretoFront, 1);
nbObjec = size(paretoFront, 2);
for i = 1:nbFront;
    pareto = nbObjec;
    for j = 1:nbObjec
        if distMatrix(j) > paretoFront(i, j)
            pareto = pareto - 1;
        end
    end
    if pareto == 0;
        paretoB = 0;
        break;
    end
end