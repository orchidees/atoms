%
% getDescriptorMultipleValues.m	: Retrieving the value of multiple descriptors
%
% connecDB						: Pointer to the SQL connection
% soundID						: ID of the sound to retrieve
% descriptor					: Cell with names of the descriptors
%
% Version						: 1.0 / 2010
%
% Author						: Philippe ESLING
%								 <esling@ircam.fr>
%
function dValue = getDescriptorMinMax(connecDB, descriptor)
sqlQ = ['SELECT MIN(' descriptor '), MAX(' descriptor ')'];
sqlQ = [sqlQ ' from Sounds'];
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
dValue = cursor.Data;
end
