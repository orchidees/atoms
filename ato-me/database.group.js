var activated = [];
outlets = 1;

function expoInOut(t,b,c,d)
{
    return (t==0) ? b : ((t==d) ? b+c : ((t/=d/2)<1) ?  c/2*Math.pow(2, 10*(t-1))+b : c/2*(-Math.pow(2,-10*--t)+2)+b);
}

function loadbang()
{
    emptyResults();
}

function emptyResults()
{
    outlet(0, "script sendbox queryElt1 presentation_position 0 800");
    outlet(0, "script sendbox queryElt2 presentation_position 0 800");
    outlet(0, "script sendbox queryElt3 presentation_position 0 800");
    outlet(0, "script sendbox queryElt4 presentation_position 0 800");
    outlet(0, "script sendbox queryElt5 presentation_position 0 800");
    outlet(0, "script sendbox queryElt6 presentation_position 0 800");
    outlet(0, "script sendbox queryElt7 presentation_position 0 800");
    for (i = 1; i <= 7; i++)
        activated[i] = 0;
}

function dbquery(queryID)
{
    finalID = Math.floor(queryID / 10) % 10;
    if (activated[finalID] == 0)
    {
        args = [];
        args[0] = finalID;
        activated[finalID] = 1;
        tsk = new Task(startQueryLoop, this, args);
        tsk.interval = 20;
        tsk.repeat(100, 100);
    }
}

function startQueryLoop(finalID)
{    
    curRep = arguments.callee.task.iterations / 100.0;
    curYshift = expoInOut(curRep, 0, 770 - ((finalID - 1) * 80), 0.42);
    outlet(0, "script sendbox queryElt" + finalID + " presentation_position 0 " + (800 - curYshift));
}

function sendToObject(dest, thein, msg)
{
    myobj = this.patcher.getnamed(dest);
    this.patcher.connect(this.box,0,myobj,thein);
    outlet(0,msg);
    this.patcher.disconnect(this.box,0,myobj,thein);
}