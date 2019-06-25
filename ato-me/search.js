var namesArray;
var firstUse = 1;
outlets = 3;

function loadbang()
{
}

function searchParameters(paramString)
{
    if (firstUse == 0)
        for (i = 0; i < namesArray.length; i++)
            outlet(1, "script delete " + namesArray[i]);
    firstUse = 0;
    namesArray = new Array();
    paramArray = paramString.split(' ');
    for (i = 0; i < paramArray.length; i = i + 2)
    {
        namesArray[(i / 2)] = paramArray[i];
        myobj = this.patcher.getnamed(paramArray[i]);
        if (myobj == null)
        {
            featobj = patcher.newdefault(300,400, "bpatcher", "@name", "search.parameters.maxpat", "@varname", paramArray[i], "@presentation", 1, "@presentation_size", 180, 20, "@presentation_position", 180, (i / 2) * 20 + 5, "@presentation_rect", 180, (i / 2) * 20 + 1, 180, 20);
        sendToObject(paramArray[i], 0, paramArray[i]);
        sendToObject(paramArray[i], 1, paramArray[i + 1]);
    	}
    }
    outlet(1, "script sendtoback searchPanel");
}

function applyTask(index)
{
    sendToObject(namesArray[index], 2, "apply");
}

function applyParams()
{
    for (i = 0; i < namesArray.length; i++)
    {
        tsk = new Task(applyTask, this, i);
        tsk.repeat(1, (i * 100));
    }
}

function sendToObject(dest, thein, msg)
{
    myobj = this.patcher.getnamed(dest);
    this.patcher.connect(this.box,0,myobj,thein);
    outlet(0,msg);
    this.patcher.disconnect(this.box,0,myobj,thein);
}