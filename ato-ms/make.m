%
% make.m - Makefile for the MCC Matlab-compiled release.
%
% Usage: make           -> Compile in the current dir
%        make clean     -> Remove all files created by make
%        make path      -> add directoies to Matlab path
%        make release   -> create a release directoy with compiled files
%
% COMPILATION PROCEDURE
%
% 0. Make sure the version.m file is up to date
% 1. Exit Matlab and start a new session
% 2. Change dir to sources dir
% 3. Type 'make realase' in the Matlab shell
% 4. Lauch a Terminal and change dir to 'r' dir
% 5. Run the compiled version with the following command:
%      ./run_main.sh [path_of_the_v76intel_matlab_mcr_dir]
%    The CTF archive should expand into orchidee_mcr. Do not forget
%    to also run a client application to test the server.
% 6. Quit the server from your client application, or just send a
%    "/quit" OSC message.
% 7. Remove the script file
% 8. Copy the content of the release dir into the Contents/MacOS/distrib/
%    dir in the application bundle.
% 9. Change the version of the application in the Info.plist file
%
function make(varargin)
% Check the compilation flag
if ~isempty(varargin)
    switch varargin{1}
        case 'clean'
            !rm -f mccExcludedFiles.log
            !rm -f readme.txt
            !rm -f run_main.sh
            !rm -f main
            !rm -f main.ctf
            !rm -f main.prj
            !rm -f main_main.c
            !rm -f main_mcc_component_data.c
            !rm -rf main_mcr
            !rm -rf ../release/
        case 'path'
            pathHandler('load');
            setenv('DYLD_LIBRARY_PATH','/Applications/MATLAB_R2008a/bin/maci:/Applications/MATLAB_R2008a/sys/os/maci:/System/Library/Frameworks/JavaVM.framework/JavaVM:/System/Library/Frameworks/JavaVM.framework/Libraries');
        case 'release'
            pathHandler('unload');
            cd ..
            !rm -r release
            !cp -R ato-ms/ release
            cd release
            pathHandler('load');
            %mcc -m -C -R -nodisplay ion.m -I /usr/include/ -I analysis/ -I analysis/utils/ -I analysis/sax/ -I analysis/sdif/ -I analysis/logs/ -I analysis/features/ -I analysis/descriptor -I analysis/convert/ -I constraints/ -I constraints/filters/ -I constraints/instrumentation/ -I database/ -I errors/ -I export/ -I features/ -I knowledge/ -I osc/ -I osc/mex/ -I osc/lib/  -I production/ -I representation/ -I search/ -I search/genetic/ -I search/multiobjective/ -I session/ -I session/reports/ -I solution/ -I target/ -I utils/ -I utils/path/
            mcc -m -C -R '-nodisplay' atoms.m
            pathHandler('unload');
            !rm -r analysis
            !rm -r constraints
            !rm -r database
            !rm -r errors
            !rm -r export
            !rm -r features
            !rm -r knowledge
            !rm -r osc
            !rm -r production
            !rm -r representation
            !rm -r search
            !rm -r session
            !rm -r solution
            !rm -r target
            !rm -r utils
            !rm pathHandler.m
            !rm make.m
            !rm mccExcludedFiles.log
            !rm atoms.m
            !rm atoms_main.c
            !rm atoms_mcc_component_data.c
            !rm mainScript.m
            !rm mainVersion.m
            !rm readme.txt
    end
else
    make path
    mcc -m -R -nodesktop atoms.m
end

