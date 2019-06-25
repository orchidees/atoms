% EXTRACT_PARETO_SET - Extract Pareto solutions from a set of criteria vectors.
%
% Usage: paretoSet = extract_pareto_set(X)
%
function [paretoSet idSet] = extract_pareto_set(X)
Npoints = size(X,1);
if Npoints
    % Add first point to Pareto set
    paretoSet = X(1,:);
    idSet = 1;
    for i = 2:Npoints
        % Remove from Pareto set all points dominated by new point
        I = is_dominated_by(X(i,:),paretoSet,'max');
        paretoSet = paretoSet(~I,:);
        idSet = idSet(~I);
        if ~isempty(paretoSet)
            % Add new point to Pareto set if it is not dominated by
            % any Pareto vector
            I = is_dominated_by(X(i,:),paretoSet,'min');
            if ~max(I)
                paretoSet = [ paretoSet ; X(i,:) ];
                idSet = [idSet i];
            end
        else
            paretoSet = X(i,:);
            idSet = i;
        end
    end
else
    paretoSet = [];
end