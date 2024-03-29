function [valIndex message] = export_cellMessage(message, valIndex, tmpVal)
msgString = '( ';
for j = 1:length(tmpVal)
    if (length(tmpVal{j}) > 1 && ~ischar(tmpVal{j}))
        [valIndex message] = export_arrayMessage(message, valIndex, tmpVal{j});
    else
        if (ischar(tmpVal{j}))
            msgString = strcat(msgString, tmpVal{j}, ',');
        else    
            msgString = strcat(msgString, num2str(tmpVal{j}), ',');
        end
    end
end
valIndex = valIndex + 1;
msgString(end) = ')';
disp(msgString);
message.data{valIndex} = msgString;
message.tt = [ message.tt 's' ];
end
