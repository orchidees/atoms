function [] = logClose(fid)
if fid ~= -1
    fclose(fid);
end
