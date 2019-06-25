%
% ExportScore.m     : This class allows to export solutions to a score
%
% This object use the LilyPond application to export solutions to a score.
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef ExportScore < Export

   methods
       
        %
        % Main constructor for the raw export object
        %
        function iER = ExportScore(sessionObj, file)
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
            % Check if in server mode
            handles = this.sSession.getHandles();
            if isempty(solutionSet)
                error('ExportScore:exportSolutionSet:MissingData', 'Nothing to export !');
            end
            % Get LilyPond executable's complete path
            lilycommand = find_lily_command(this);
            prodType = this.sSession.getProduction();
            % Get instrument list
            instlist = prodType.allowedInstruments;
            server_says(handles,'Export solution scores ...',0);
            variableTable = unique(solutionSet.solutionIDs(:));
            values = this.sSession.getKnowledge().getFieldsValues({'instrument', 'note', 'playingStyle', 'dynamics', 'stringMute', 'brassMute', 'octave', 'file'}, variableTable);
            % write solutions data
            solutions = solutionSet.getSolutions();
            for i = 1:length(solutions)
                individuals = solutions(i).getIndividuals;
                % Open export file
                fid = fopen([this.fileName '_' num2str(i) '.ly'], 'w');
                % Raise exception if cannot open
                if fid == -1
                    error('ExportRaw:exportSolutionSet:CannotOpenFile', [ 'Cannot open export file ' this.fileName ] );
                end
                % Write header
                fprintf(fid, '\\version "2.12.3"\n');
                fprintf(fid, '#(set-global-staff-size %d)\n', length(individuals));
                fprintf(fid, '\\header {\n');
                fprintf(fid, '  title = " %s "\n', this.fileName);
                fprintf(fid, '  composer = "Score in C" }\n\n');
                % Iterate on solution's items
                for k = 1:length(individuals)
                    % Assign new voici for item k
                    fprintf(fid, 'inst%s = \\new Voice {\n', numbers2letters(this, k));
                    % If index is null
                    if individuals(k).sInstrument == this.sSession.getKnowledge().getNeutralID()
                        % Print instrument name
                        if k <= length(instlist)
                            this_inst = instlist{k};
                            if iscell(this_inst), this_inst = this_inst{1}; end
                        else
                            this_inst = [ 'Inst_' num2str(k) ];
                        end
                        fprintf(fid, '\\set Staff.instrumentName = #"%s"\n', this_inst);
                        % Print a rest
                        fprintf(fid, 'r1\n');
                        fprintf(fid, 's s s s s s s s');
                    % Otherwise...
                    else
                        index = find(variableTable == individuals(k).sInstrument);
                        nNVal = index(1);
                        onset = individuals(k).sOnset;
                        % Print instrument name
                        inst = values{nNVal,1};
                        fprintf(fid, '\\set Staff.instrumentName = #"%s"\n', inst);
                        % Get current item's symbolic attributes
                        note = lilynote(this, values{nNVal,2}, '');
                        ps = values{nNVal,3};
                        dyn = values{nNVal,4};
                        smute = values{nNVal,5};
                        bmute = values{nNVal,6};
                        oct = values{nNVal,7};
                        str = strrep(values{nNVal,8}, '#', 's');
                        % Swith to bass clef if pitch is below middle C
                        if oct < 4
                            fprintf(fid, '\\clef bass\n');
                        end
                        %onsetStr = repmat('_', onset, 1);
                        for mRest = 1:floor(onset / 16)
                            fprintf(fid, 's ');
                        end
                        for mRest = 1:mod(onset, 16)
                            fprintf(fid, 's16 ');
                        end
                        fprintf(fid, '\n');
                        %for rRest = 1:mod(onset, 8)
                        %    fprintf(fid, 'r4\n');
                        %end
                        %fprintf(fid, 'R1*%d\n', onset);
                        % Print note
                        fprintf(fid, '%s1', note);
                        % Print staccato notation if needed
                        if strcmp(ps, 'stacc'), fprintf(fid, '\\staccato'); end
                        % Print tremolo notation if needed
                        if strcmp(ps, 'trem'), fprintf(fid, ':32'); ps = ''; end
                        if strfind(ps, '-trem'), fprintf(fid, ':32'); ps = strrep(ps, '-trem', ''); end
                        % Compute above-note information
                        upmarkup = '^\markup{';
                        % Print mute if needed
                        if ~strcmp(smute, 'NA') && ~strcmp(smute, 'N')
                            upmarkup = [ upmarkup smute '\hspace #0.5 ' ];
                        elseif ~strcmp(bmute, 'NA') && ~strcmp(bmute, 'N')
                            upmarkup = [ upmarkup bmute '\hspace #0.5 ' ];
                        end
                        % Print playing style if needed
                        if strcmp(ps, 'ord') || strcmp(ps, 'stacc'), ps = ''; end
                        upmarkup = [ upmarkup '\italic\small{' ps ];
                        % Print string number if needed    
                        if str
                            upmarkup = [ upmarkup ' (' num2str(str) 'c) }}' ];
                        else
                            upmarkup = [ upmarkup ' }}' ];
                        end
                        fprintf(fid, '%s', upmarkup);  
                        % Compute below-note information
                        downmarkup = '_\markup{';
                        % print dynamics
                        downmarkup = [ downmarkup '\dynamic ' dyn ];
                        % Print microtonic transposition if needed
%                        if ismember(transpo{k}, {'+1.16' '+1.8' '+3.16' '+3.8' '+5.16' '+3.8' '+5.16' })
%                            transpo{k} = strrep(transpo{k}, '.', '/');
%                            downmarkup = [ downmarkup ' \hspace #0.5 \small{(' transpo{k} ')}}' ];
%                        else
                            downmarkup = [ downmarkup ' }' ];
%                        end
                        fprintf(fid, '%s\n', downmarkup);
                        
                        for mRest = (onset + (16 - mod(onset, 16))):16:128
                            fprintf(fid, 's ');
                        end
                        fprintf('\n');
                    end
                    fprintf(fid, '}\n\n');
                end
                % Print score
                fprintf(fid, '\\score {\n');
                fprintf(fid, '\\new StaffGroup <<\n');
                fprintf(fid, '\\set Score.proportionalNotationDuration = #(ly:make-moment 1 8)\n');
                % Add staves
                for k = 1:length(individuals)
                    fprintf(fid, '\\new Staff << \\inst%s >>\n', numbers2letters(this, k));
                end
                fprintf(fid, '>>\n');
                fprintf(fid, '\\layout { \\context{\\Staff \n \\remove "Bar_engraver"} }\n');
                fprintf(fid, '}\n');
                % Close Lily file
                fclose(fid);
                % Convert to score
                cmd = [ lilycommand ' -fpdf -o ' this.fileName '_' num2str(i) ' ' this.fileName '_' num2str(i) '.ly'];
                unix(cmd);
                % Remove PS file, open PDF
                cmd = [ 'rm ' this.fileName '_' num2str(i) '.ps'];
                unix(cmd);
                % Remove Lily file
                cmd = [ 'rm ' this.fileName '_' num2str(i) '.ly' ];
                unix(cmd);
            end
        end
       
        % NUMBERTOLETTERS - Convert any number to a sequence of letters.
        % (LilyPond cannot handles numbers in voice definitions)
        function L = numbers2letters(this, N)
            L = num2str(N);
            L = strrep(L, '1', 'a');
            L = strrep(L, '2', 'b');
            L = strrep(L, '3', 'c');
            L = strrep(L, '4', 'd');
            L = strrep(L, '5', 'e');
            L = strrep(L, '6', 'f');
            L = strrep(L, '7', 'g');
            L = strrep(L, '8', 'i');
            L = strrep(L, '9', 'j');
            L = strrep(L, '0', 'k');
        end

        % LILYNOTE - Output a LilyPond-complient pitch from an Orchidee pitch and a
        % given microtonic transposition.
        function o = lilynote(this, i, transpo)
            % Process natural pitch
            o = lower(i);
            o = strrep(o, '7', '''''''');
            o = strrep(o, '6', '''''');
            o = strrep(o, '5', '''''');
            o = strrep(o, '4', '''');
            o = strrep(o, '3', '');
            o = strrep(o, '2', ',');
            o = strrep(o, '1', ',,');
            o = strrep(o, '0', ',,,');
            % Process sharps, semitones and quartertones
            if strfind(o, '#')
                if strcmp(transpo, '+1.4')
                    o = strrep(o, '#', 'isih');
                else
                    o = strrep(o, '#', 'is');
                end
            else
                if strcmp(transpo, '+1.4')
                    o = [ o(1) 'ih' o(2:length(o)) ];
                end
            end
        end
        
        
        function exportSolutionSetLight(this, solutionSet, mapFile, featFile)
        end
        
        %
        % FIND_LILY_COMMAND - Returns the complete path of the lipyond executable.
        % Lilypond must be previously installed. The searched path is:
        %
        function lilycommand = find_lily_command(this)
            % Locate LilyPond's folder
            cmd = 'find /Applications -name "LilyPond*" -maxdepth 1';
            [r, s] = unix(cmd);
            % Raise exception if LilyPond is not installed
            if isempty(s)
                error('Find_lily_command:MissingComponent', ...
                    'Cannot find LilyPond in Applications folder.');
            end
            % Convert path to string, remove carriage return at end
            if iscell(s), s = s{1}; end
            s = s(1:length(s)-1);
            % Build complete path to executable
            lilycommand = [ s '/Contents/Resources/bin/lilypond' ];
            % Check that executable exists
            if ~exist(lilycommand)
                error('Find_lily_command:MissingComponent', ...
                    [ 'Cannot find lilypond executable. Expecting: ' lilycommand '.' ]);
            end
        end
       
   end
   
end 
