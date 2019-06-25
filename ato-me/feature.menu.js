var features = new Array();
var menuItems = new Array();
var minSWidth = 15;
var minSHeight = 15;
var maxSWidth = 42;
var maxSHeight = 42;
var maxWidth = 2000;
var basePosY = 26;
var basePosX = 10;
var nbFeatures = 0;
var currentWidth = 0;
var range_m = 2;
var previousSelect = -1;
var featureShowing = -1;
var curShowTask = 0;
var pictureLoaded = 0;
var finishedShowing = 0;
var multiTargetON = 0;
var setDefault = 1;
outlets = 3;

function emptyFeatures()
{
    outlet(2, "clear");
    if (multiTargetON)
    {
        nbUsed = 0;
        tmpFeatures = new Array();
        tmpMenu = new Array();
        for (i = 0; i < menuItems.length; i++)
            if (menuItems[i].isUsed)
            {
                tmpFeatures[nbUsed] = features[i];
                tmpMenu[nbUsed] = menuItems[i];
                tmpMenu[nbUsed].posX = nbUsed * (minSWidth + 1) + basePosX;
                nbUsed = nbUsed + 1;
            }
        features = tmpFeatures;
        menuItems = tmpMenu;
        nbFeatures = nbUsed;
        currentWidth = nbUsed * (minSWidth + 1) + minSWidth;
    }
    else
    {
        features = new Array();
        menuItems = new Array();
        nbFeatures = 0;
        currentWidth = 0;
    }
    previousSelect = -1;
    featureShowing = -1;
    curShowTask = 0;
    finishedShowing = 0;
    drawloop();
}

function multiTargetMode()
{
    setDefault = 0;
    if (multiTargetON == 1)
        multiTargetON = 0;
    else
        multiTargetON = 1;
}

// Feature handler object
function Feature(fIndex, fName, fMean, fStdDev, fValue, fObj)
{
    this.index = fIndex;
    this.name = fName;
    this.mean = fMean;
    this.deviation = fStdDev;
    this.temporal = fValue;
    this.fObject = fObj;
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
    this.isUsed = 0;
    this.meanUsed = 0;
    this.deviUsed = 0;
}

function expoInOut(t,b,c,d)
{
    return (t==0) ? b : ((t==d) ? b+c : ((t/=d/2)<1) ?  c/2*Math.pow(2, 10*(t-1))+b : c/2*(-Math.pow(2,-10*--t)+2)+b);
}

function drawItem(item)
{
        if (item.isSelected || item.isUsed || item.meanUsed || item.deviUsed)
            picture = "feature_on";
        else
	{
	    if (item.isHover)
		picture = "feature_hover";
	    else
            	picture = "feature";
	}
        outlet(2, "penmode 32");
        aVal = 255 * item.alpha;
        outlet(2, "oprgb " + aVal + " " + aVal + " " + aVal);
        outlet(2, "drawpict " + picture + " " + item.posX + " " + item.posY + " " + item.width + " " + item.height);
        if (item.isHover)
        {
            outlet(2, "pensize 4 4");
            outlet(2, "color 22");
            outlet(2, "moveto 15 16");
            outlet(2, "write " + item.name);
        }
}

function drawloop()
{
    outlet(2, "clear");
    outlet(2, "oprgb 255 255 255");
    outlet(2, "drawpict panel 0 0 540 290");
    for (var i = 0; i < menuItems.length; i++)
        drawItem(menuItems[i]);
}

function loadbang()
{
    outlet(2, "readpict panel feature.menu.panel.png");
    outlet(2, "readpict feature feature.menu.image.png");
    outlet(2, "readpict feature_on feature.menu.image.on.png");
    outlet(2, "readpict feature_hover feature.menu.image.hover.png");
    outlet(2, "drawpict panel 0 0 540 290");
    outlet(2, "color 22");
}

function addfeature(fName, fMean, fStdDev, fValue)
{
    for (var i = 0; i < menuItems.length; i++)
        if (menuItems[i].name == fName)
            break;
    if (multiTargetON && i < menuItems.length && menuItems[i].isUsed)
    {
        sendToObject(fName, 4, fName);
        return;
    }
    featobj = patcher.newdefault(300,400, "bpatcher", "@name", "feature.maxpat", "@varname", fName, "@presentation", 1, "@presentation_size", 300, 30, "@presentation_position", 600, nbFeatures * 30 + 1, "@presentation_rect", 1, nbFeatures * 30 + 1, 1, 1);
    setStr = "set ";
    sendToObject(fName, 0, setStr.concat(fName));
    sendToObject(fName, 1, fMean);
    sendToObject(fName, 2, fStdDev);
    sendToObject(fName, 3, fValue);
    newFeat = new Feature(fName, fMean, fStdDev, fValue, featobj);
    features[nbFeatures] = newFeat;
    bindMenuImage(nbFeatures, fName);
    nbFeatures = nbFeatures + 1;
}

function bindMenuImage(nbfeat, fName)
{
    menuItems[nbfeat] = new MenuItem(nbfeat, fName, nbFeatures * (minSWidth + 1) + basePosX, basePosY, minSWidth, minSHeight, 1);
    if (setDefault == 1 && (fName == 'EnergyEnvelope' || fName == 'PartialsAmplitude' || fName == 'SpectralCentroid'))
        menuItems[nbfeat].isUsed = 1;
    if (fName == 'PartialsAmplitude')
        setDefault = 0;
    args = new Array();
    args[0] = nbfeat;
    tsk = new Task(introduceFeature, this, args);
    tsk.interval = 80;
    tsk.nbFeature = nbfeat;
    tsk.repeat(10, nbfeat * 100);
}

function introduceFeature(featobj)
{
    curRep = arguments.callee.task.iterations / 10;
    menuItems[featobj].alpha = expoInOut(curRep, 0.1, 1, 0.9);
    menuItems[featobj].posY = - 100 + Math.min(100 + basePosY, expoInOut(curRep, 1, 140, 0.9));
    drawloop();
}

function sendToObject(dest, thein, msg)
{
    myobj = this.patcher.getnamed(dest);
    this.patcher.connect(this.box,0,myobj,thein);
    outlet(0,msg);
    this.patcher.disconnect(this.box,0,myobj,thein);
}

function showUpFeature(featobj)
{
    setDefault = 0;
    curRep = arguments.callee.task.iterations;
    ratioFactor = curRep / 25;
    height = expoInOut(ratioFactor, 0, 370, 0.5);
    outlet(1, "script sendbox " + menuItems[featobj].name + " presentation_size "+ height + " 170");
    outlet(1, "script sendbox " + menuItems[featobj].name + " presentation_position " + (menuItems[featobj].posX + 35) + " 70");
    if (curRep >= 15)
        curShowTask = 0;
}

function hideFeature(featobj)
{
    curRep = arguments.callee.task.iterations;
    ratioFactor = curRep / 50;
    height = expoInOut(ratioFactor, 0, 370, 0.5);
    outlet(1, "script sendbox " + menuItems[featobj].name + " presentation_size "+ (250 - height) + " 170");
    outlet(1, "script sendbox " + menuItems[featobj].name + " presentation_position " + (menuItems[featobj].posX + 35) + " 90");
    if (curRep == 100)
        curShowTask = 0;
}

function clickedFeature(index)
{
    outlet(1, "script bringtofront " + menuItems[index].name);
    args = new Array();
    args[0] = index;
    args[1] = menuItems[index].posX;
    var tsk = new Task(clickedFeatureAnim, this, args);
    tsk.interval = 25;
    tsk.repeat(50, 0);
}

function clickedFeatureAnim(args)
{
    index = args[0];
    startPosX = args[1];
    curRep = arguments.callee.task.iterations / 50;
    if (curRep < 0.5)
    {
        cposX = startPosX;
        cposY = Math.min(130, expoInOut(curRep * 2, basePosY, 130, 0.9));
    }
    if (curRep > 0.4)
    {
        cposX = Math.max(expoInOut((curRep - 0.5) * 2, startPosX, (currentWidth / 2) - 50 - startPosX, 0.4), basePosX);
        cposY = 130;
    }
    menuItems[index].posX = cposX;
    menuItems[index].posY = cposY;
    drawloop();
    if (curRep == 0.4)
    {
        args = new Array();
        args[0] = index;
        var tsk = new Task(showUpFeature, this, args);
        tsk.interval = 20;
        tsk.repeat(25, 0);
        finishedShowing = 1;
    }
}

function unshowFeature(index)
{
    outlet(1, "script sendtoback " + menuItems[index].name);
    args = new Array();
    args[0] = index;
    var tsk = new Task(unshowAnim, this, args);
    tsk.interval = 16;
    tsk.repeat(50, 0);
    var tsk = new Task(hideFeature, this, args);
    tsk.interval = 10;
    tsk.repeat(50, 0);
}

function unshowAnim(index)
{
    if (index == 0)
        arrivalX = 1;
    else
        arrivalX = menuItems[index - 1].posX + menuItems[index - 1].width + 2;
    curRep = arguments.callee.task.iterations / 50;
    if (curRep < 0.5)
    {
        cposX = expoInOut(curRep * 2, 19, arrivalX, 0.4);
        cposY = 130;
    }
    if (curRep > 0.4)
    {
        cposX = arrivalX;
        cposY = 131 - Math.min(131 - basePosY, expoInOut((curRep - 0.4) * 2, 1, 150, 0.3));
    }
    menuItems[index].posX = Math.min(cposX, arrivalX);
    menuItems[index].posY = cposY;
    drawloop();
    if (curRep > 0.5 && featureShowing == index)
        featureShowing = -1;
}

function lcdidle(x, y)
{
    if (featureShowing != -1 || menuItems.length == 0)
        return;
    if (y < basePosY || y > 64 + basePosY || x < basePosX || x > (menuItems[menuItems.length - 1].posX + menuItems[menuItems.length - 1].width))
    {
        curPosX = basePosX;
        for (i = 0; i < menuItems.length; i++)
        {
            menuItems[i].width = minSWidth;
            menuItems[i].height = minSHeight;
            menuItems[i].posX = curPosX;
            menuItems[i].posY = basePosY;
            curPosX += menuItems[i].width + 1;
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
        {
           menuItems[previousSelect].isHover = 0;
           outlet(1, "script sendtoback " + menuItems[previousSelect].name);            
           outlet(1, "script sendbox " + menuItems[previousSelect].name + " presentation_position 600 1");
           outlet(1, "script sendbox " + menuItems[previousSelect].name + " presentation_size 1 1");
        }
    }
   // obtain the fraction across the icon that the mouseover event occurred
    var across = (x - (menuItems[index].posX + (menuItems[index].width / 2) + 0.01)) / menuItems[index].width;
    // check a distance across the icon was found (in some cases it will not be)
    if (across)
    {
        // initialise the current width to 0
        currentWidth = 0;
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
        curPosX = basePosX;
        // update the sizes of the images
        for (i = 0; i < menuItems.length; i++)
        {
            menuItems[i].width = iconWidths[i];
            menuItems[i].height = iconHeights[i];
            menuItems[i].posX = curPosX;
            menuItems[i].posY = basePosY;
            curPosX += menuItems[i].width + 1;
        }
        drawloop();
        previousSelect = index;
    }
}

function lcdclick(x, y)
{
    if (y < basePosY || (y > (maxSHeight + basePosY) && featureShowing == -1))
        return;
    if (featureShowing >= 0 && finishedShowing == 1)
    {
        unshowFeature(featureShowing);
        menuItems[featureShowing].isSelected = 0;
        finishedShowing = 0;
    }
    if (y > maxSHeight + basePosY)
        return;
    var index = 0;
    for ( ; index < menuItems.length; index++)
        if (menuItems[index].posX < x && x < menuItems[index].posX + menuItems[index].width)
            break;
    if (index == menuItems.length)
        return;
    if (menuItems[index].isSelected == 0)
    {
        menuItems[index].isSelected = 1;
        clickedFeature(index);
        featureShowing = index;
    }
    finishedShowing = 0;
    drawloop();
}

function useTemporal(name, val)
{
    for (index = 0; index < menuItems.length; index++)
        if (menuItems[index].name == name)
            break;
    if (index == menuItems.length)
        return;
    menuItems[index].isUsed = val;
}

function useMean(name, val)
{
    for (index = 0; index < menuItems.length; index++)
        if (menuItems[index].name == name)
            break;
    if (index == menuItems.length)
        return;
    menuItems[index].meanUsed = val;
}

function useDeviation(name, val)
{
    for (index = 0; index < menuItems.length; index++)
        if (menuItems[index].name == name)
            break;
    if (index == menuItems.length)
        return;
    menuItems[index].deviUsed = val;
}

function orchestrate()
{
    setDefault = 0;
    usedFeatures = "orch /setcriteria 42"
    for (i = 0, j = 0; i < menuItems.length; i++)
    {
        if (menuItems[i].isUsed)
            usedFeatures = usedFeatures + " " + menuItems[i].name;
        if (menuItems[i].meanUsed)
            usedFeatures = usedFeatures + " " + menuItems[i].name + "Mean";
        if (menuItems[i].deviUsed)
            usedFeatures = usedFeatures + " " + menuItems[i].name + "StdDev";
    }
    outlet(0, usedFeatures);
    outlet(0, "orch /orchestrate 502");
}