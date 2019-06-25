%function [param_s] = FextractParamFromName(filename, nomenclature)
%
% Extrait d'un nom de fichier son le nom de l'instrument, la note jouée, l'octave de la note, la nuance. 
% Il serait interessant de pouvoir spécifier une nomenclature en entrée ...
%
% ===INPUTS
% Un nom de fichier suivant une certaine ? nomenclature
%
%
% ===OUTPUTS
%
%
%
function [sqlStruct] = extractSymbolicInfos(filename, fullPath, nomenclature, sqlStruct)
filename = strrep(filename, ' ', '');
switch(nomenclature)
    
 case 'sol1.0'
  pat = '(?<instrument>^\w+?)_.+_(?<nuance>\w+)_(?<note>\w+)_12.wav';
  param_s = regexp(filename, pat, 'names');
 
 case 'SOL'
  
  pat = '(?<note>[A-G]#?[0-9]\+?)';
  param_s = regexp(filename, pat, 'names');
  
  if isempty(param_s)
      param_s = struct;
      param_s.note = 'NA';
      note = 'NA';
      octave = 0;
  end
  
  % si il y a plusieurs notes dans le nom de fichier
  if length(param_s) >= 2
      i_start = min(regexp(filename, pat, 'start'));
      i_end = max(regexp(filename, pat, 'end'));
      note = filename(i_start:i_end);
      param_s = [];
      param_s.note = note;
      octave = 'NA';
  end

  % si il existe une note, on l'utilise comme reference pour trouver le reste sinon ...
  if ~strcmp(param_s.note, 'NA');
      note_asc = strrep(param_s.note, '+', '\+');
      pat = ['(?<instrument>^[a-z_A-Z]+)\+?(?<sourdine>[a-z_A-Z]*)-(?<modeDeJeu>.*)-(?<note>' note_asc ')-(?<dynamique>[m f p]+)-?'];
      param_s = regexp(filename, pat, 'names');
      if (isempty(param_s))
        pat = ['(?<instrument>^[a-z_A-Z]+)-\+?'];
        param_s = regexp(filename, pat, 'names');
        param_s.sourdine = [];
        param_s.modeDeJeu = 'NA';
        param_s.dynamique = 'mf';
      end
      param_s.note = note_asc;
      octave = regexp(note_asc, '\d', 'match');
      param_s.octave = str2num(octave{1});
  else
      pat = ['(?<instrument>^[a-z_A-Z]+)\+?(?<sourdine>[a-z_A-Z]*)-(?<modeDeJeu>.*)-(?<dynamique>[m f p]+)-?'];
      param_s = regexp(filename, pat, 'names');
      if (isempty(param_s))
        pat = ['(?<instrument>^[a-z_A-Z]+)-\+?'];
        param_s = regexp(filename, pat, 'names');
        if (isempty(param_s))
            param_s = struct;
            param_s.instrument = 'NA';
        end
        param_s.sourdine = [];
        param_s.modeDeJeu = 'NA';
        param_s.dynamique = 'mf';
      end
      param_s.note = note;
      param_s.octave = octave;
  end
  % Numero de corde
  pat = '[1-6]c';
  pos_v = regexp(filename, pat);
  param_s.cordes_v = str2num(filename(pos_v)');
  if isempty(param_s.sourdine)
      param_s.sourdine = 'N';
  end
  param_s = orderfields(param_s, {'instrument', 'sourdine', 'modeDeJeu', ...
                        'note', 'octave', 'dynamique', 'cordes_v'});
 case 'VSL'
%  [NUMERIC,vienna2sdb_c,RAW]=XLSREAD('~/Orchestration/sdb/SDB_Vienna-_SOL-short.xlw');
  pat = ['(?<instrument>^[a-z_A-Z0-9\-]+?)_(?<modeDeJeu>.*?)_(?<dynamique>[a-z]+)[0-9]?_(?<note>[A-G]#?[0-9]).wav'];
  param_s = regexp(filename, pat, 'names');
  
 case 'violonNMD'
  gamme = cellstr(strvcat('do', 'dod', 're', 'red', 'mi', 'fa', 'fad', 'sol', 'sold', 'la', 'lad', 'si'));
  diatoniqueMajeur = [0, 2, 4, 5, 7, 9, 11];
  reMaj = gamme(mod(diatoniqueMajeur+2, 12)+1);
  
  pat = '(?<player>^\w)-(?<nuance>\w+)-(?<mode>\w+)-(?<noteNb>\d+).aiff';
  param_s = regexp(filename, pat, 'names');
  param_s.noteNb = str2num(param_s.noteNb);
  if param_s.noteNb <= 7
      param_s.note = reMaj{param_s.noteNb};
  elseif param_s.noteNb > 8
      param_s.note = reMaj{16 - param_s.noteNb};
  else
      param_s.note = 're';
  end

  case 'iowa'
    pat = '^(\w+)\.(\w*\.)?(\w+)\.(sul\w)*\.?(\w+)\.wav';
    a = regexp(filename, pat, 'tokens');
    param_s.instrument = a{1}{1};
    param_s.modeDeJeu = strrep(a{1}{2}, '.', '');
    param_s.dynamique = a{1}{3};
    param_s.cordes_v = strrep(a{1}{4}, 'sul', '');
    param_s.note = a{1}{5};
    
  case 'virto'
    pat = '(\w+)-?(\w+)?-(\w+\#?\w)-(\w+).AIF';
    a = regexp(filename, pat, 'tokens');
    param_s.instrument = a{1}{1};
    param_s.dynamique = a{1}{4};
    param_s.cordes_v = a{1}{2};
    param_s.note = a{1}{3};
end
%
% Final parsing of symbolic informations
%
dot_idx = find(fullPath == '/');
if length(dot_idx) > 3
    sqlStruct.file = fullPath((dot_idx(end - 3) + 1):end);
else
    sqlStruct.file = fullPath;
end
sqlStruct.name = filename;
sqlStruct.source = nomenclature;
sqlStruct.instrument = param_s.instrument;
sla_idb = find(sqlStruct.file == '/', 1, 'first');
sqlStruct.family = sqlStruct.file(1:(sla_idb - 1));
sqlStruct.note = param_s.note;
if ~isempty(find(sqlStruct.note == '-', 1)) || ~isempty(find(sqlStruct.note == '_', 1))
    sqlStruct.note = strrep(sqlStruct.note, '\+', '');
    sqlStruct.note = strrep(sqlStruct.note, '-', ',');
    sqlStruct.note = strrep(sqlStruct.note, '_', ',');
end
if strcmp(param_s.octave, 'NA')
    octave = regexp(param_s.note,'\d','match');
    sqlStruct.octave = octave{1};
else
    sqlStruct.octave = param_s.octave;
end
sqlStruct.pitchClass = regexprep(sqlStruct.note, '[0-9]', '');
sqlStruct.dynamics = param_s.dynamique;
sqlStruct.playingStyle = param_s.modeDeJeu;
sqlStruct.brassMute = 'NA';
sqlStruct.stringMute = 'NA';
if ismember(sqlStruct.family,{'Trumpets','Trombones','Tubas','Horns'})
	sqlStruct.brassMute = param_s.sourdine;
end
if strcmp(sqlStruct.family,'Strings')
    sqlStruct.stringMute = param_s.sourdine;
end
