function checkForFile(fileName) //check to see if file exists
{
var s = new String();
s = fileName
f = new File(s, "read");
if (f.isopen) //if succeed in opening file
{    
    f.close();
    return (true);
}
else //file doesn't exist
{
    f.close(); //anal retentively close file
    return (false);
}
}

function anything()
{
    var a = arrayfromargs(messagename, arguments);
    outlet(0,checkForFile(a));
}