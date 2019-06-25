function check_interruption(mode)
if nargin < 1
    mode = 'all';
end
switch mode
    case 'quit'
		quit();
    case 'interrupt'
		interrupt();
    case 'all'
		quit();
		interrupt();
    otherwise
        error('errors:check_interruption:UnknownInterruption', ...
            [ '''' mode ''': Unknow interruption.'] );

end




function quit()

if exist('/tmp/atoms_quit','file')
    !rm /tmp/atoms_quit
    error('errors:ForcedToQuit', 'Ato-ms has been externally forced to quit.');
end




function interrupt()

if exist('/tmp/atoms_interrupt','file')
    !rm /tmp/atoms_interrupt
    error('Errors:InterruptedAction', 'Ato-ms has been externally interrupted.');
end