function [valIndex message] = export_cellMessageMulti(message, valIndex, tmpVal)
valIndex = valIndex + 1;
message.data{valIndex} = '[';
message.tt = [ message.tt 's' ];
for j = 1:length(tmpVal)
    if (length(tmpVal{j}) > 1 && ~ischar(tmpVal{j}))
        [valIndex message ] = export_arrayMessage(message, valIndex, tmpVal{j});
    else
        valIndex = valIndex + 1;
        message.data{valIndex} = tmpVal{j}; 
        if (ischar(tmpVal{j}))
            message.tt = [ message.tt 's' ];
        else
            message.tt = [ message.tt 'f' ];
        end
    end
end
valIndex = valIndex + 1;
message.data{valIndex} = ']';
message.tt = [ message.tt 's' ];
end
