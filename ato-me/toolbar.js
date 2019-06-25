var menuItems = new Array();
var minSWidth = 48;
var minSHeight = 38;
var maxSWidth = 56;
var maxSHeight = 45;
var maxWidth = 2000;
var nbFeatures = 0;
var range_m = 2;
var previousSelect = -1;
var isInited = 0;
outlets = 3;

function loadbang()
{
    outlet(0, "clear");
    outlet(0, "readpict toolTop toolbar.pict.top.png");
    outlet(0, "readpict toolCenter toolbar.pict.center.png");
    outlet(0, "readpict toolBottom toolbar.pict.bottom.png");
    for (i = 0; i < 10; i++)
	{
		if (i < 9)
		{
	        	outlet(0, "readpict toolButton" + i + " toolbar.pict.button.0" + (i + 1) + ".png");
        		outlet(0, "readpict toolButton" + i + "Hover toolbar.pict.button.0" + (i + 1) + ".hover.png");
		}
		else
		{
	        	outlet(0, "readpict toolButton" + i + " toolbar.pict.button." + (i + 1) + ".png");
        		outlet(0, "readpict toolButton" + i + "Hover toolbar.pict.button." + (i + 1) + ".hover.png");
		}
	}
}

function startingAnimation()
{
    tsk = new Task(startAnimationLoop, this);
    tsk.interval = 20;
    tsk.repeat(100, 300);
}

function expoInOut(t,b,c,d)
{
    return (t==0) ? b : ((t==d) ? b+c : ((t/=d/2)<1) ?  c/2*Math.pow(2, 10*(t-1))+b : c/2*(-Math.pow(2,-10*--t)+2)+b);
}

function startAnimationLoop()
{    
    curRep = arguments.callee.task.iterations / 100.0;
    outlet(0, "clear");
    outlet(0, "penmode 32");
    outlet(0, "oprgb 255 255 255");
    curYshift = expoInOut(curRep, 7, 44, 0.2);
    outlet(0, "drawpict toolCenter 0 7 532 44");
    outlet(0, "drawpict toolTop 0 0 532 7");
    outlet(0, "drawpict toolBottom 0 " + curYshift + " 532 5");
    if (curRep == 0.6)
    {
        fillUpMenu();
    }
}

function fillUpMenu()
{
    addMenuItem(0, "About");
    addMenuItem(1, "Save");
    addMenuItem(2, "Load");
    addMenuItem(3, "Database");
    addMenuItem(4, "Search");
    addMenuItem(5, "Orchestra");
    addMenuItem(6, "Filters");
    addMenuItem(7, "Prefs");
    addMenuItem(8, "Report");
    addMenuItem(9, "Timeline");
    nbFeatures = 9;
}

// Item menu handler object
function MenuItem(fIndex, fName, fPosX, fPosY, fWidth, fHeight, fAlpha)
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
}


function addMenuItem(nbfeat, fName)
{
    menuItems[nbfeat] = new MenuItem(nbfeat, fName, (nbfeat * minSWidth) + 15, 8, minSWidth, minSHeight, 0.0);
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
    menuItems[featobj].alpha = expoInOut(curRep / 50.0, 0.0, 1.0, 0.42);
    shiftX = expoInOut(curRep / 50.0, (featobj * minSWidth) + 15.0, 470.0, 0.84);
    menuItems[featobj].posX = (470 + (featobj * minSWidth) + 15) - Math.min(shiftX, 470);
    drawloop();
    if (featobj == (nbFeatures - 1) && curRep > 10)
        isInited = 1;
}

function drawItem(item)
{

    picture = "toolButton" + item.index;
    if (item.isHover)
        picture = "toolButton" + item.index + "Hover";
        
        aVal = 255 * item.alpha;
        outlet(0, "oprgb " + aVal + " " + aVal + " " + aVal);
        outlet(0, "drawpict " + picture + " " + item.posX + " " + item.posY + " " + item.width + " " + item.height);
        if (item.isHover)
        {
            outlet(0, "pensize 4 4");
            //outlet(2, "frameoval " + item.posX + " " + item.posY + " " + (item.posX + item.width) + " " + (item.posY + item.height) + " 9");
//            outlet(0, "moveto " + (item.posX + (item.width / 2) - (item.name.length * 4) - 5) + " 60");
//            outlet(0, "write " + item.name);
        }
}

function drawloop()
{
    outlet(0, "clear");
    outlet(0, "penmode 32");
    outlet(0, "oprgb 255 255 255");
    outlet(0, "drawpict toolCenter 0 7 532 44");
    outlet(0, "drawpict toolTop 0 0 532 7");
    outlet(0, "drawpict toolBottom 0 51 532 5");
    for (var i = 0; i < menuItems.length; i++)
        drawItem(menuItems[i]);
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
    if (isInited == 0)
        return;
    if (y > 50 || y < 10 || x < 15 || x > menuItems[menuItems.length - 1].posX + menuItems[menuItems.length - 1].width)
    {
        curPosX = 15;
        // update the sizes of the images
        for (i = 0; i < menuItems.length; i++)
        {
            menuItems[i].width = minSWidth;
            menuItems[i].height = minSHeight;
            menuItems[i].posX = curPosX;
            menuItems[i].posY = 8;
            curPosX += menuItems[i].width;
            menuItems[i].isHover = 0;
        }
        drawloop();
        return;
    }
    var index = 0;
    for ( ; index < menuItems.length; index++)
        if (menuItems[index].posX < x && x < menuItems[index].posX + maxSWidth)
            break;
    if (index == menuItems.length)
        return;
    iconWidths = new Array(menuItems.length);
    iconHeights = new Array(menuItems.length); 
    if (index != previousSelect)
    {
        menuItems[index].isHover = 1;
        if (previousSelect != -1)
           menuItems[previousSelect].isHover = 0;
    }
   // obtain the fraction across the icon that the mouseover event occurred
    var across = (x - (menuItems[index].posX + (menuItems[index].width / 2) + 0.01)) / menuItems[index].width;
    // check a distance across the icon was found (in some cases it will not be)
    if (across)
    {
        // initialise the current width to 0
        var currentWidth = 0;
        // loop over the icons
        for (var i = 0; i < menuItems.length; i++)
        {
            // check whether the icon is in the range to be resized
            if (i < index - range_m || i > index + range_m)
            {
                // set the icon size to the minimum size
                iconWidths[i] = minSWidth;
                iconHeights[i] = minSHeight;
            }
            else if (i == index)
            {
                // set the icon size to be the maximum size
                iconWidths[i] = maxSWidth;
                iconHeights[i] = maxSHeight;
            }
            else if (i < index)
            {
                // set the icon size to the appropriate value
                iconWidths[i] = minSWidth + Math.round((maxSWidth - minSWidth - 1) * (Math.cos((i - index - across + 1) / range_m * Math.PI) + 1) / 2);
                iconHeights[i] = minSHeight + Math.round((maxSHeight - minSHeight - 1) * (Math.cos((i - index - across + 1) / range_m * Math.PI) + 1) / 2);
                // add the icon size to the current width
                currentWidth += iconWidths[i];
            }
            else
            {
                // set the icon size to the appropriate value
                iconWidths[i] = minSWidth + Math.round((maxSWidth - minSWidth - 1) * (Math.cos((i - index - across) / range_m * Math.PI) + 1) / 2);
                iconHeights[i] = minSHeight + Math.round((maxSHeight - minSHeight - 1) * (Math.cos((i - index - across) / range_m * Math.PI) + 1) / 2);
                // add the icon size to the current width
                currentWidth += iconWidths[i];      
            } 
        }
        // update the maximum width if necessary
        if (currentWidth > maxWidth)
            maxWidth = currentWidth;
        // detect if the total size should be corrected
        if (index >= range_m && index < iconWidths.length - range_m && currentWidth > maxWidth)
        {
            // correct the size of the smallest magnified icons
            iconSizes[index - range_m] += Math.floor((maxWidth - currentWidth) / 2);
            iconSizes[index + range_m] += Math.ceil((maxWidth - currentWidth) / 2);
        }
        curPosX = 15;
        // update the sizes of the images
        for (i = 0; i < menuItems.length; i++)
        {
            menuItems[i].width = iconWidths[i];
            menuItems[i].height = iconHeights[i];
            menuItems[i].posX = curPosX;
            menuItems[i].posY = 8 - Math.round((iconWidths[i] / 2) - (minSWidth / 2));
            curPosX += menuItems[i].width;
        }
        drawloop();
        previousSelect = index;
    }
}

function lcdclick(x, y)
{
    if (y > 64)
        return;
    var index = 0;
    for ( ; index < menuItems.length; index++)
        if (menuItems[index].posX < x && x < menuItems[index].posX + maxSWidth)
            break;
    if (index == menuItems.length)
        return;
    menuItems[index].isSelected = 1;
    outlet(2, menuItems[index].name);
    drawloop();
}