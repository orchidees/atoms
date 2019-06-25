var menuItems = new Array();
var nbFeatures = 0;
var previousSelect = -1;
var isInited = 0;

outlets = 3;

function loadbang()
{
    outlet(0, "local 0");
    outlet(0, "idle 1");
    outlet(0, "brgb 255 255 255");
    outlet(0, "clear");
}

function pathLoaded()
{
    outlet(0, "readpict serverCenter server.pict.center.png");
    outlet(0, "readpict serverTop server.pict.top.png");
    outlet(0, "readpict serverBottom server.pict.bottom.png");
    for (i = 0; i < 4; i++)
        outlet(0, "readpict serverButton" + i + " server.pict.button.0" + (i + 1) + ".png");
    outlet(0, "readpict serverButtonHover server.pict.button.hover.png");
}

function expoInOut(t,b,c,d)
{
    return (t==0) ? b : ((t==d) ? b+c : ((t/=d/2)<1) ?  c/2*Math.pow(2, 10*(t-1))+b : c/2*(-Math.pow(2,-10*--t)+2)+b);
}

function startingAnimation()
{
    tsk = new Task(startingAnimationLoop, this);
    tsk.interval = 20;
    tsk.repeat(100, 200);
}

function fillUpMenu()
{
    addMenuItem(0, "Launch", 1);
    addMenuItem(1, "Ping", 0);
    addMenuItem(2, "Version", 0);
    addMenuItem(3, "Quit", 0);
    nbFeatures = 4;
}

// Item menu handler object
function MenuItem(fIndex, fName, fPosX, fPosY, fWidth, fHeight, fAlpha, act)
{
    this.index = fIndex;
    this.name = fName;
    this.posX = fPosX;
    this.posY = fPosY;
    this.height = fHeight;
    this.width = fWidth;
    this.alpha = fAlpha;
    this.isSelected = 0;
    this.isHover = 0;
    this.isActive = act;
}


function addMenuItem(nbfeat, fName, active)
{
    menuItems[nbfeat] = new MenuItem(nbfeat, fName, 13, 50 + (nbfeat * 18), 71, 21, 0.0, active);
    args = new Array();
    args[0] = nbfeat;
    tsk = new Task(introduceFeature, this, args);
    tsk.interval = 20;
    tsk.nbFeature = nbfeat;
    tsk.repeat(50, nbfeat * 105);
}

function introduceFeature(featobj)
{
    curRep = arguments.callee.task.iterations;
    menuItems[featobj].alpha = expoInOut(curRep / 50.0, 0.1, 1.1, 0.74);
    shiftX = expoInOut(curRep / 50.0, 40, 42 + (featobj * 22), 0.84);
    menuItems[featobj].posY = Math.min(shiftX, 42 + (featobj * 22));
    drawloop();
    if (featobj == (nbFeatures - 1) && curRep > 1)
        isInited = 1;
}

function drawItem(item)
{

    picture = "serverButton" + item.index;
    if (item.isHover)
        picture = "serverButtonHover";
    aVal = 255 * item.alpha;
    outlet(0, "oprgb " + aVal + " " + aVal + " " + aVal);
    outlet(0, "drawpict " + picture + " " + item.posX + " " + item.posY + " " + item.width + " " + item.height);
}

function drawloop()
{
    outlet(0, "clear");
    outlet(0, "penmode 32");
    outlet(0, "oprgb 255 255 255");
    outlet(0, "drawpict serverCenter 0 24 540 144");
    outlet(0, "drawpict serverTop 0 0 540 24");
    outlet(0, "drawpict serverBottom 0 168 540 5");
    outlet(0, "drawpict serverControls 80 10 420 150"); 
    for (var i = 0; i < menuItems.length; i++)
        drawItem(menuItems[i]);
}

function serverReady()
{
    if (menuItems.length > 0)
    {
        menuItems[0].isActive = 0;
        menuItems[1].isActive = 1;
        menuItems[2].isActive = 1;
        menuItems[3].isActive = 1;
    }
}

function startingAnimationLoop()
{
    curRep = arguments.callee.task.iterations / 100.0;
    outlet(0, "clear");
    outlet(0, "penmode 32");
    outlet(0, "oprgb 255 255 255");
    curYshift = expoInOut(curRep, 1, 144, 0.42);
    outlet(0, "drawpict serverCenter 0 24 540 " + curYshift);
    outlet(0, "drawpict serverTop 0 0 540 24");
    outlet(0, "drawpict serverBottom 0 " + (curYshift + 24) + " 540 5");
    if (curRep == 0.5)
        fillUpMenu();
    if (curRep > 0.2)
    {
        alpha = expoInOut((curRep - 0.3) * 1.5, 0, 255, 0.8);
        outlet(0, "oprgb " + alpha + " " + alpha + " " + alpha);
        outlet(0, "drawpict serverControls 80 10 420 150");
        if (curRep >= 0.6)
        {
            outlet(1, "script sendbox loadSlide presentation_position 78 145");
            outlet(2, "animEnd");
        }
        else
            outlet(1, "script sendbox loadSlide presentation_position 708 133");
    }
}

function sendToObject(dest, thein, msg)
{
    myobj = this.patcher.getnamed(dest);
    this.patcher.connect(this.box,0,myobj,thein);
    outlet(0,msg);
    this.patcher.disconnect(this.box,0,myobj,thein);
}

function lcdidle(x, y)
{
    if (x < 18 || x > 75 || y < 28 || y > 130 || isInited == 0)
    {
        if (previousSelect != -1)
        {
            menuItems[previousSelect].isHover = 0;
            previousSelect = -1;
            drawloop();
        }
        return;
    }
    var index = 0;
    for ( ; index < menuItems.length; index++)
        if (menuItems[index].posY < y && y < menuItems[index].posY + 27)
            break;
    if (index == menuItems.length)
        return;
    if (index != previousSelect)
    {
        menuItems[index].isHover = 1;
        if (previousSelect != -1)
           menuItems[previousSelect].isHover = 0;
    }
    drawloop();
    previousSelect = index;
}

function lcdclick(x, y)
{
    if (x < 18 || x > 75 || y < 28 || y > 130)
        return;
    var index = 0;
    for ( ; index < menuItems.length; index++)
        if (menuItems[index].posY < y && y < menuItems[index].posY + 27)
            break;
    if (index == menuItems.length)
        return;
    menuItems[index].isSelected = 1;
    outlet(2, menuItems[index].name);
    drawloop();
}
