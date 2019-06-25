%
% getTemporalQuery.m  : Query based on the temporal shape of a descriptor
% constrained to a particular subset of sound ID
%
% connecDB          : Pointer to the SQL connection
% descValue         : Desired shape of the descriptor
% descName          : Name of the descriptor
% soundID           : Set of sound ID
%
% Version           : 1.0 / 2010
%
% Author            : Philippe ESLING
%                    <esling@ircam.fr>
%
function orderListID = getTemporalQueryConstrained(connecDB, descValue, descName, soundID)
% Preparing descriptor value for string comparison
pStrVal = (descValue - mean(descValue)) ./ max(abs(descValue));
descStr = timeseries2symbol(pStrVal, length(pStrVal), 128, 20);
descriptors = [descName 'TString,' descName 'Mean,' descName 'StdDev'];
sqlQ = ['SELECT soundID, ' descriptors ' from Sounds'];
soundIDStr = [ '(' regexprep(num2str(cell2mat(soundID)'), ' +', ',') ')'];
sqlQ = [sqlQ ' where soundID IN ' soundIDStr];
cursor = exec(connecDB, sqlQ);
cursor = fetch(cursor);
dValue = cursor.Data;
orderListID = zeros(size(dValue, 1), 2);
for i = 1:size(dValue, 1)
    dataValue = dValue{i, 2};
    dMin = min_dist(descStr, dataValue(1:128), 20, 1);
    orderListID(i, 1) = dValue{i, 1};
    orderListID(i, 2) = dMin;
end
end
