%
% ProductionOrchestra.m      : Defining an orchestra for production
%
% This class allows to define an orchestra as a production mode
%
% Author            : Philippe ESLING
% Mail              : <esling@ircam.fr>
% Version           : 1.0
%
classdef ProductionOrchestra < Production
    
    methods
        
        %
        % Main constructor for using an orchestra as production mode
        %
        function pO = ProductionOrchestra(sessObj, instru, resolution)
            pO = pO@Production(sessObj, instru, resolution);
            pO.setInstruments(instru);
        end
        
        %
        % Set the list of allowed instruments
        % The list given as input can be :
        %   - {}        : All possible instruments
        %   - Int       : Size of the orchestra
        %   - List      : Specific list of instruments
        function setInstruments(this, instruments)
            knowledge = this.sSession.getKnowledge();
            if isempty(instruments)
                % Get orchestral order
                % scoreorder = this.getScoreOrder();
                % Assign default instrument list if needed
                % this.allowedInstruments = regexp(scoreorder, '\w*', 'match');
                this.allowedInstruments = knowledge.getFieldsValueList('instrument');
                return;
            end
            if isnumeric(instruments)    
                % Only size of the orchestra as input
                this.allowedInstruments = cell(1,round(instruments));
            else
                % Get allowed instruments from database
                fullInstruments = knowledge.getFieldsValueList('instrument');
                [flatInst, max_depth] = flatcell(instruments);
                % Check validity of instrument list
                if max_depth > 2
                    error('ProductionOrchestra:setInstruments:Structure', 'Recursion level in instrument list is too high.');
                end
                for i = 1:length(flatInst)
                    if ~ismember(flatInst{i}, fullInstruments)
                        server_says(this.sSession.getHandles(), ['Warning : ' flatInst{i} ' is not a valid instrument.']);
                    end
                end
                this.allowedInstruments = instruments;
            end
        end

       %
       % Initializing the knowledge source
       %
       function initialize(this)
       end
       
       %
        % GOTO ===> ORCHESTRA !
        %
        % SCOREORDER - Return a string of all database instruments in orchestral
        % order (families are separated with the symbol '-'). The order is read
        % from a preference file in ~/Library/Preferences/IRCAM/Orchidee/. If not
        % preference file exist, the order is computed from a set of rules
        % implicitely defined by nomenclature.m, and a new prefernece file is
        % written. Hence, the score order may be easily modified by editing
        % manually the preference file.
        %
        % Usage: scoreorder = get_score_order(knowledge_instance)
        %
        function scoreorder = getScoreOrder(this)
        % Set need-a-new-pref-file flag to false
        need_new_file = 0;
        % Look for scoreorder prefernce file
        [s, score_order_prefs_file] = unix([ 'find ' home_directory '/Library/Preferences/IRCAM/ -name "scoreorder*"' ]);
        % If no preference file exists ...
        if isempty(score_order_prefs_file)
            % ... set need-a-new-pref-file flag to true
            need_new_file = 1;
        else
            % ... else read preference file
            score_order_prefs_file = score_order_prefs_file(1:length(score_order_prefs_file)-1);
            % Get file creation date
            pat = '\d\d\d\d\d\d\d\d\d\d\d\d\d\d';
            file_date = regexp(score_order_prefs_file, pat, 'match');
            file_date = str2num(file_date{1});
            % If file is too older than knowledge, trash it
            if file_date < str2num(this.sSession.getKnowledge().getCreationDate())
                need_new_file = 1;
                unix(['rm ' score_order_prefs_file]);
            end
        end
        % If the current preference file is valid ...
        if ~need_new_file
            % ... read it and format content
            fid = fopen(score_order_prefs_file);
            scoreorder = fscanf(fid, '%s');
            scoreorder = strrep(scoreorder, ',', ' ');
            scoreorder = strrep(scoreorder, '-', ' - ');
            scoreorder = strrep(scoreorder, '  ', ' ');
            fclose(fid);   
        else
            % ... else, creete preference file from knowledge
            % Get instrument list in knowledgd
            instlist = this.sSession.getKnowledge().getFieldsValueList('instrument');
            % Get standardized nomenclature
            known_nomenclature = this.nomenclature();
            known_families = known_nomenclature(:,1);
            known_instruments = known_nomenclature(:,3);
            % This is a
            family_index = ones(length(known_families), 1);
            for k = 2:length(known_families);
                if strcmp(known_families(k), known_families(k-1))
                    family_index(k) = family_index(k-1);
                else
                    family_index(k) = family_index(k-1)+1;
                end
            end
            % Initialize instrument rank vector
            sort_instlist = zeros(length(instlist), 1);
            % Iterate on instrument list
            for k = 1:length(instlist)
                %if strcmp(instlist{k},'Sn'), keyboard; end
                %if strcmp(instlist{k},'Sw'), keyboard; end
                % Is current instrument in the nomenclature?
                [T,idx] = ismember(instlist{k}, known_instruments);
                % If yes ...
                if T
                    % ... compute current instrument's rank
                    this_family = known_families(idx);
                    family_idx = find(strcmp(this_family, known_families));
                    sort_instlist(k) = family_index(idx)+(((find(family_idx==idx))-1)/length(family_idx));
                else
                    % ... else, get current instrument's family
                    this_family = this.get_family(instlist{k});
                    T = ismember(this_family, known_families);
                    % If family is known...
                    if T
                        % ... append instrument to the family
                        % Update known families and instruments with new instrument
                        idx = find(strcmp(this_family, known_families), 1, 'last' );
                        known_families = [ known_families(1:idx) ; this_family ; known_families(idx+1:length(known_families)) ];
                        family_index = [ family_index(1:idx) ; family_index(idx) ; family_index(idx+1:length(family_index)) ];
                        known_instruments = [ known_instruments(1:idx) ; instlist(k) ; known_instruments(idx+1:length(known_instruments)) ];
                        % Compute current instrument's rank
                        idx = idx+1;
                        family_idx = find(strcmp(this_family, known_families));
                        sort_instlist(k) = family_index(idx)+(((find(family_idx==idx))-1)/length(family_idx));
                    else
                        % ... else append instrument and family at the end of the list
                        idx = length(known_families);
                        known_families = [ known_families ; this_family ];
                        family_index = [ family_index ; family_index(idx)+1 ];
                        known_instruments = [ known_instruments ; instlist(k) ];
                        % Compute current instrument's rank
                        idx = idx+1;
                        family_idx = find(strcmp(this_family, known_families));
                        sort_instlist(k) = family_index(idx)+(((find(family_idx==idx))-1)/length(family_idx));
                    end
                end
            end
            % Sort instrument list according to the previously computed ranks
            [sort_instlist, I] = sort(sort_instlist);
            instlist = instlist(I);
            % Open new preferences file
            score_order_prefs_file = [ home_directory '/Library/Preferences/IRCAM/scoreorder' ...
            datestr(now, 'yyyymmddHHMMSS')];
            fid = fopen(score_order_prefs_file, 'w');
            % Write preference file
            fprintf(fid, '%s,\n', instlist{1});
            for k = 2:length(instlist)
                [t, idx] = ismember(instlist{k-1}, known_instruments);
                prev_family = known_families{idx};
                [t, idx] = ismember(instlist{k}, known_instruments);
                this_family = known_families{idx};
                if ~strcmp(prev_family, this_family)
                    fprintf(fid, '-\n');
                end
                fprintf(fid, '%s,\n', instlist{k});
            end
            fclose(fid);
            % Output score order
            scoreorder = this.getScoreOrder();
        end
        end

        % GOTO ====> ORCHESTRA
        % GET_FAMILY - Return the family of an instrument, specified by its symbol
        % in the nomenclature.
        %
        % Usage: family = get_family(knowledge_instance, instrument)
        %
        function family = get_family(this, instrument)
            % Get all the database entries for the input instrument
            idx = this.sSession.getKnowledge().query('instrument', instrument);
            % Get the family of the first entry
            family = getFieldValues(knowledge_instance, 'family', idx(1));
        end
        
        %
        % GOTO =====> ORCHESTRA
        %
        % NOMENCLATURE - Theoretic table of instrument families, folders, and
        % symbols. It may contains instruments that are NOT in the current
        % database, in order to help the user when adding new instrument (hopefully
        % avoiding errors when naming file and folders). It is also used for
        % automatically sort the instrument list in the traditional orchestral
        % order.
        % 
        % Usage: nomenclature = nomenclature(knowledge_instance)
        %
        function nomenclature = nomenclature(this)
nomenclature = { ...
    'Flutes'            'Piccolo'                   'Picc'      ;... 
    'Flutes'            'Flute'                     'Fl'        ;...
    'Flutes'            'Alto-Flute'                'AlFl'       ;...
    'Flutes'            'Bass-Flute'                'BFl'       ;...
    'Flutes'            'Contrabass-Flute'          'CbFl'      ;...
...
    'Oboes'             'Oboe'                      'Ob'        ;...
    'Oboes'             'Oboe-dAmore'               'ObAm'      ;...
    'Oboes'             'English-Horn'              'EH'        ;...
    'Oboes'             'Heckelphone'               'Heck'      ;...
...
    'Clarinets'         'Piccolo-Clarinet-Ab'       'PiClAb'    ;...
    'Clarinets'         'Clarinet-Eb'               'ClEb'      ;...
    'Clarinets'         'Piccolo-Clarinet-D'        'PiClD'     ;...
    'Clarinets'         'Clarinet-C'                'ClC'       ;...
    'Clarinets'         'Clarinet-Bb'               'ClBb'      ;...
    'Clarinets'         'Clarinet-A'                'ClA'       ;...
    'Clarinets'         'Basset-Horn-F'             'BstHn'     ;...
    'Clarinets'         'Alto-Clarinet-Eb'          'AlClEb'    ;...
    'Clarinets'         'Bass-Clarinet-Bb'          'BClBb'     ;...
    'Clarinets'         'Bass-Clarinet-A'           'BsClA'     ;...
    'Clarinets'         'Contra-Alto-Clarinet-Eb'   'CtAlClEb'  ;...
    'Clarinets'         'Contrabass-Clarinet-Bb'    'CbClBb'    ;...
...
    'Bassoons'          'Bassoon'                   'Bn'        ;...
    'Bassoons'          'Contrabassoon'             'Cbn'       ;...
...
    'Saxophones'        'Soprano-Sax'               'SoSax'     ;...
    'Saxophones'        'Alto-Sax'                  'ASax'      ;...
    'Saxophones'        'Tenor-Sax'                 'TnSax'     ;...
    'Saxophones'        'Baritone-Sax'              'BarSax'    ;...
    'Saxophones'        'Bass-Sax'                  'BsSax'     ;...
    'Saxophones'        'Contrabass-Sax'            'CbSax'     ;...
...
    'Horns'             'Horn'                      'Hn'        ;...
...
    'Trumpets'          'Piccolo-Trumpet-Bb'        'PiTpBb'    ;...
    'Trumpets'          'Piccolo-Trumpet-A'         'PiTpA'     ;...
    'Trumpets'          'High-Trumpet-F'            'HgTpF'     ;...
    'Trumpets'          'High-Trumpet-Eb'           'HgTpEb'    ;...
    'Trumpets'          'High-Trumpet-D'            'HgTpD'     ;...
    'Trumpets'          'Cornet-Eb'                 'CntEb'     ;...
    'Trumpets'          'Trumpet-C'                 'TpC'       ;...
    'Trumpets'          'Trumpet-Bb'                'TpBb'      ;...
    'Trumpets'          'Cornet-Bb'                 'CntBb'     ;...
    'Trumpets'          'Alto-Trumpet-F'            'AlTpF'     ;...
    'Trumpets'          'Bass-Trumpet-Eb'           'BsTpEb'    ;...
    'Trumpets'          'Bass-Trumpet-C'            'BsTpC'     ;...
    'Trumpets'          'Bass-Trumpet-Bb'           'BsTpBb'    ;...
...
    'Trombones'         'Alto-Trombone'             'AlTbn'     ;...
    'Trombones'         'Tenor-Trombone'            'TTbn'      ;...
    'Trombones'         'Bass-Trombone'             'BTbn'      ;...
    'Trombones'         'Contrabass-Trombone'       'CbTbn'     ;...
...
    'Tubas'             'Euphonium'                 'Eup'       ;...
    'Tubas'             'Bass-Tuba'                 'BTb'       ;...
    'Tubas'             'Contrabass-Tuba'           'CbTb'      ;...
...
    'Saxhorns'          'Flugelhorn'                'Flg'       ;...
...
    'Keyboards'         'Piano'                     'Pn'        ;...
    'Keyboards'         'Celesta'                   'Cel'       ;...
    'Keyboards'         'Harpsichord'               'Hpscd'     ;...
...
    'Plucked-Strings'   'Harp'                      'Hp'        ;...
    'Plucked-Strings'   'Guitar'                    'Gtr'       ;...
    'Plucked-Strings'   'Mandolin'                  'Mdl'       ;...
...
    'Strings'           'Violin'                    'Vn'        ;...
    'Strings'           'Viola'                     'Va'        ;...
    'Strings'           'Violoncello'               'Vc'        ;...
    'Strings'           'Contrabass'                'Cb'        ;...
    };
        end
       
   end
   
end 
