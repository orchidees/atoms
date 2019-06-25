function [valIndex message] = export_arrayMessage_space(message, valIndex, tmpVal)
msgString = '';
for j = 1:length(tmpVal)
	if (ischar(tmpVal(j)))
    	msgString = [msgString tmpVal(j) ' '];
    else    
        msgString = [msgString num2str(tmpVal(j)) ' '];
    end
end
valIndex = valIndex + 1;
%msgString(end) = '"';
disp(msgString);
message.data{valIndex} = msgString;
message.tt = [ message.tt 's' ];
end
