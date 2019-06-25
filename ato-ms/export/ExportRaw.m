%
% ExportRaw.m       : This class allows to export solutions to a raw format
%
% The export follows a raw property format which allows to put every
% informations about a solution inside a text file.
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef ExportRaw < Export
    
   properties
   end

   methods
       
        %
        % Main constructor for the raw export object
        %
        function iER = ExportRaw(sessionObj, file)
            iER = iER@Export(sessionObj, file);
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
            % Check if in sever mode
            handles = this.sSession.getHandles();
            % Raise exception if solution set is empty
            if isempty(solutionSet)
                error('ExportRaw:exportSolutionSet:MissingData', 'Nothing to export !');
            end
            % Open export file
            fid = fopen(this.fileName,'w');
            % Raise exception if cannot open
            if fid == -1
                error('ExportRaw:exportSolutionSet:CannotOpenFile', [ 'Cannot open export file ' filename ] );
            end
            server_says(handles,'Export solution set ...',0);
            % write solutions data
            solutions = solutionSet.getSolutions();
            % write number of solution
            fprintf(fid,'%d\n',length(solutions));
            % write number of instruments
            fprintf(fid,'%d\n',length(solutions(1).getIndividuals()));
            % write number of features
            features = this.sSession.getFeaturesList();
            fprintf(fid,'%d\n',length(features));
            variableTable = unique(solutionSet.solutionIDs(:));
            values = this.sSession.getKnowledge().getFieldsValues({'instrument', 'note', 'playingStyle', 'dynamics', 'stringMute', 'brassMute', 'file'}, variableTable);
            for i = 1:length(solutions)
                % write solution number
                fprintf(fid,'%d\n',i);
                % write symbolic data
                individuals = solutions(i).getIndividuals;
                for j = 1:length(individuals)
                    if individuals(j).sInstrument == this.sSession.getKnowledge().getNeutralID()
                        fprintf(fid,'%s\n','<empty>');
                    else
                        index = find(variableTable == individuals(j).sInstrument);
                        nNVal = index(1);
                        on = individuals(j).sOnset;
                        on = on * (this.sSession.getTarget().getFeaturesList().duration / 128);
                        inst = values{nNVal,1};
                        note = values{nNVal,2};
                        ps = values{nNVal,3};
                        dy = values{nNVal,4};
                        sm = values{nNVal,5};
                        bm = values{nNVal,6};
                        file = values{nNVal,7};
                        if strcmp(sm,'NA') && strcmp(bm,'NA')
                            mute = 'NA';
                        elseif strcmp(sm,'NA') && ~strcmp(bm,'NA')
                            mute = bm;
                        elseif ~strcmp(sm,'NA') && strcmp(bm,'NA')
                            mute = sm;
                        end
                        fprintf(fid,'%f %s %s %s %s %s ', on,inst,note,ps,dy,mute);
                        fprintf(fid,'/%s\n',file);
                    end
                end
                server_says(handles,'Export solution set ...',i/length(solutions));    
            end
            % Close export file
            fclose(fid);
        end
   
        
        %
        %
        %
        function exportSolutionSetLight(this, solutionSet, mapFile, featFile)
            if nargin < 3
                featFile = [];
            end
            handles = this.sSession.getHandles();
            % Raise exception if solution set is empty
            if isempty(solutionSet)
                error('ExportRaw:export_light:MissingData', 'Nothing to export !');
            end
            % Retrieve the target duration
            tDuration = this.sSession.getTarget().getFeature('duration');
            % Open export file
            fid = fopen(this.fileName,'w');
            % Raise exception if cannot open
            if fid == -1
                error('ExportRaw:export_light:CannotOpenFile', [ 'Cannot open export file ' this.fileName] );
            end
            server_says(handles,'Export solution set ...',0);
            % write solutions data
            solutions = solutionSet.getSolutions();
            for i = 1:length(solutions)
                individuals = solutions(i).getIndividuals;
                for j = 1:length(individuals)
                    if individuals(j).sInstrument == this.sSession.getKnowledge().getNeutralID()
                        fprintf(fid,'0 +0 0 ');
                    else
                        % write sound index and transposition
                        db_idx = individuals(j).sInstrument;
                        in_ons = individuals(j).sOnset * tDuration / 128;
                        fprintf(fid,'%d %s %.3f ', db_idx, '+0', (in_ons * 1000));
                    end
                end
                fprintf(fid,'\n');
                server_says(handles,'Export solution set ...',i / length(solutions));
            end
            % Close export file
            fclose(fid);
            % If a non-empty 'map_file' is specified, ...
                if ~isempty(mapFile)
                    % Open map file
                    fid = fopen(mapFile,'w');
                    % Raise exception if cannot open
                    if fid == -1
                        error('ExportRaw:export_light:CannotOpenFile', [ 'Cannot open map file ' map_file ] );
                    end
                    server_says(handles,'Export solution set map ...',0);
                    % Get current timbre features
                    features = this.sSession.getFeaturesList();
                    % Compute criteria names
                    criteria_names = cell(length(features));
                    for k = 1:length(features)
                        criteria_names{k} = strcat(features{k},'_distance');
                    end
                    % Normalize criteria
                    map_criteria = solutionSet.getCriteria();
                    map_criteria = map_criteria - repmat(min(map_criteria, [], 1) * 0.9, size(map_criteria,1), 1);
                    map_criteria = map_criteria ./ repmat(max(map_criteria, [], 1) * 1.1, size(map_criteria,1), 1);
                    % Get 1D-feature names and values
                    feature_names = {};
                    map_features = cell(length(features), 1);
                    solutionFeatures = solutionSet.getFeatures();
                    for k = 1:length(features)
                        curFeature = solutionFeatures.(features{k});
                        if iscell(curFeature)
                            continue;
                        end
                        tmpFeature = [];
                        feature_names = [ feature_names ; features{k} ];
                        for i = 1:length(solutions)
                            tmpFeature = [tmpFeature ; curFeature(i, :)];
                        end
                        map_features{k} = tmpFeature;
                    end
                    % Normalize 1D-features
%                    map_features = map_features-repmat(min(map_features,[],1),size(map_features,1),1);
%                    map_features = map_features./repmat(max(map_features,[],1),size(map_features,1),1);
                    % Write map_file first line (file content)
                    for k = 1:length(criteria_names)
                        fprintf(fid,'%s ',criteria_names{k});
                    end
                    for k = 1:length(feature_names)
                        fprintf(fid,'%s ',feature_names{k});
                    end
                    fprintf(fid,'\n');
                    % Write data in map_file
                    map_data = map_criteria; %map_features ];
                    for i = 1:size(map_data, 1)
                        server_says(handles,'Export solution criteria ...',i/size(map_data,1));
                        for j = 1:size(map_data, 2)
                            fprintf(fid,'%.8f ',map_data(i,j));
                        end
                        fprintf(fid,'\n');
                    end
                    fclose(fid);
                end
                if ~isempty(featFile)
                    fid = fopen(featFile, 'w');
                    for i = 1:size(map_features{1}, 1)
                        for k = 1:length(map_features)
                            curFeat = map_features{k};
                            server_says(handles,'Export solution features ...',i/size(map_features,1));
                            for j = 1:size(curFeat, 2)
                                fprintf(fid, '%.3f ', curFeat(i, j));
                            end
                            fprintf(fid, '\n');
                        end
                    end
                    % Close map_file
                    fclose(fid);
                end
        end


% char strings associated with microtonic pitches
function str_tsp = string_transpo(tsp)
I = find([0 0.125 0.25 0.375 0.5 0.625 0.75 0.875]==tsp);
tsp_all = { '+0' '+1.16' '+1.8' '+3.16' '+1.4' '+5.16' '+3.8' '+7.16' };
str_tsp = tsp_all{I};
end
       
   end
   
end 
