outlets = 1;

function expoInOut(t,b,c,d)
{
    return (t==0) ? b : ((t==d) ? b+c : ((t/=d/2)<1) ?  c/2*Math.pow(2, 10*(t-1))+b : c/2*(-Math.pow(2,-10*--t)+2)+b);
}

function loadbang()
{
    outlet(0, "window size 100 100 447 730");
    outlet(0, "window exec");
}

function startQuery()
{
    tsk = new Task(startQueryLoop, this);
    tsk.interval = 20;
    tsk.repeat(100, 400);
}

function startQueryLoop()
{    
    curRep = arguments.callee.task.iterations / 100.0;
    curYshift = expoInOut(curRep, 0, 600, 0.2);
    outlet(0, "window size 100 100 " + (447 + curYshift) + " 730");
    outlet(0, "window exec");
}

function sendToObject(dest, thein, msg)
{
    myobj = this.patcher.getnamed(dest);
    this.patcher.connect(this.box,0,myobj,thein);
    outlet(0,msg);
    this.patcher.disconnect(this.box,0,myobj,thein);
}