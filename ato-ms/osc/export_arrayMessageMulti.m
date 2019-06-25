function [valIndex message] = export_arrayMessageMulti(message, valIndex, tmpVal)
valIndex = valIndex + 1;
message.data{valIndex} = '[';
message.tt = [ message.tt 's' ];
for j = 1:length(tmpVal)
	valIndex = valIndex + 1;
	message.data{valIndex} = tmpVal(j);
	if (ischar(tmpVal(j)))
        message.tt = [ message.tt 's' ];
    else
        message.tt = [ message.tt 'f' ];
    end
end
valIndex = valIndex + 1;
message.data{valIndex} = ']';
message.tt = [ message.tt 's' ];
end
