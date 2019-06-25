var screenLeft = 0;
var screenTop = 0;
var screenRight = 640;
var screenBottom = 480;
var curLeft = 320;
var curTop = 240;
var curRight = 320;
var curBottom = 240;
var isReady = 0;
var isSolution = 0;
outlets = 3;

function loadbang()
{
}

function screenSize(l, t, r, b)
{
    screenLeft = l;
    screenTop = t;
    screenRight = r;
    screenBottom = b;
    curLeft = (r / 2.0) - 80.0;
    curTop = (b / 2.0) - 40.0;
    curRight = curLeft + 160.0;
    curBottom = curTop + 80.0;
    outlet(0, "brgb 255 255 255");
    outlet(0, "clear");
    outlet(0, "readpict mainCenter main.pict.center.png");
    outlet(0, "readpict mainLeft main.pict.left.png");
    outlet(0, "readpict mainRight main.pict.right.png");
    outlet(0, "readpict mainTitle main.pict.title.png");
    tsk = new Task(startingAnimation, this);
    outlet(1, "script sendbox powerButton presentation_position 800 0");
    tsk.interval = 20;
    tsk.repeat(100, 100);
}

function expoInOut(t,b,c,d)
{
    return (t==0) ? b : ((t==d) ? b+c : ((t/=d/2)<1) ?  c/2*Math.pow(2, 10*(t-1))+b : c/2*(-Math.pow(2,-10*--t)+2)+b);
}

function startingTextAnimation()
{
    curRep = arguments.callee.task.iterations / 100.0;
    curAlpha = expoInOut(curRep, 0, 255, 0.2);
    outlet(0, "penmode 32");
    outlet(0, "oprgb " + curAlpha + " " + curAlpha + " " + curAlpha);
    outlet(0, "drawpict mainTitle 15 -1 284 85");
    topShift = expoInOut(curRep, 40.0, 96.0, 0.42);
    bottomShift = expoInOut(curRep, 40.0, 140.0, 0.42);
    posTitle = expoInOut(curRep, 0, 56, 0.42);
    curTop = (screenBottom / 2.0) - topShift;
    curBottom = (screenBottom / 2.0) + bottomShift;
    outlet(1, "script sendbox mainTitle presentation_position 0 " + posTitle);
    outlet(1, "window size " + curLeft + " " + curTop + " " + curRight + " " + curBottom);
    outlet(1, "window exec");
    if (curRep == 0.2)
	outlet(1, "script sendbox powerButton presentation_position 465 67");
}

function loadSolutionBrowser()
{
}

function startingAnimation()
{
    curRep = arguments.callee.task.iterations / 100.0;
    outlet(0, "clear");
    outlet(0, "penmode 32");
    outlet(0, "oprgb 255 255 255");
    curXshift = expoInOut(curRep, 45, 380.0, 0.3);
    curMidShift = expoInOut(curRep, 0, 190, 0.3);
    outlet(0, "drawpict mainCenter 45 0 " + (curXshift - 45) + " 80");
    outlet(0, "drawpict mainLeft 0 0 45 80");
    outlet(0, "drawpict mainRight " + curXshift + " 0 116 80");
    curLeft = (screenRight / 2) - 82.0 - curMidShift;
    curRight = (screenRight / 2) + 82.0 + curMidShift;
    outlet(1, "window size " + curLeft + " " + curTop + " " + curRight + " " + curBottom);
    outlet(1, "window exec");
    if (curRep == 0.4)
    {
        sendToObject("toolbarPatch", 0, "startingAnimation");
        sendToObject("serverPanel", 0, "startingAnimation");
        tsk = new Task(startingTextAnimation, this);
        tsk.interval = 20;
        tsk.repeat(100, 100);
        //tsk = new Task(loadSolutionBrowser, this);
        //tsk.interval = 10;
        //tsk.repeat(1, 6000);
    }
}

function readyBangAnimation(args)
{
    curRep = arguments.callee.task.iterations / 50.0;
    topShift = expoInOut(curRep, 136.0, 206.0, 0.42);
    bottomShift = expoInOut(curRep, 180.0, 200.0, 0.42);
    posTitle = expoInOut(curRep, 0, 56, 0.42);
    curTop = (screenBottom / 2.0) - topShift;
    curBottom = (screenBottom / 2.0) + bottomShift;
    outlet(1, "window size " + curLeft + " " + curTop + " " + curRight + " " + curBottom);
    outlet(1, "window exec");
}

function readyBang()
{
    if (isReady == 1)
        return;
    tsk = new Task(readyBangAnimation, this);
    tsk.interval = 20;
    tsk.repeat(50, 20);    
    isReady = 1;
}

function solutionsBangAnimation(args)
{
    curRep = arguments.callee.task.iterations / 50.0;
    curShift = expoInOut(curRep, 272.0, 292.0, 0.42);
    curLeft = (screenRight / 2) - curShift;
    curRight = (screenRight / 2) + curShift;
    outlet(1, "window size " + curLeft + " " + curTop + " " + curRight + " " + curBottom);
    outlet(1, "window exec");
}

function deploySolutions()
{
    if (isSolution == 1)
        return;
    tsk = new Task(solutionsBangAnimation, this);
    tsk.interval = 20;
    tsk.repeat(50, 20);    
    isSolution = 1;
}

function solutionsBang()
{
    if (isSolution == 1)
        return;
    tsk = new Task(solutionsBangAnimation, this);
    tsk.interval = 20;
    tsk.repeat(50, 20);    
    isSolution = 1;
}

function sendToObject(dest, thein, msg)
{
    myobj = this.patcher.getnamed(dest);
    this.patcher.connect(this.box,0,myobj,thein);
    outlet(0,msg);
    this.patcher.disconnect(this.box,0,myobj,thein);
}
