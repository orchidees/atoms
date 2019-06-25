var elementsArray;
var finalOrchestra;
var finalReceived;
var instruList;
var nbElements = 0;
var fakeNbElements = 0;
var dumpMode = "";
outlets = 3;

function loadbang()
{
    elementsArray = new Array();
    finalOrchestra = new Array();
    finalReceived = new Array();
    instruList = new Array();
    instruClean = new Array();
}

function instrumentList(iList)
{
    instruList[instruList.length] = iList;
    tmpInst = iList.split(" ");
    if (tmpInst.length > 1 && tmpInst[1] != "" && tmpInst[1] != 0)
        instruClean[instruClean.length] = tmpInst[1];
}

function orchestraElement(instList, idElt)
{
    for (i = 0; i < finalReceived.length; i++)
        if (finalReceived[i] == idElt)
            return;
    finalReceived[finalReceived.length] = idElt;
    finalOrchestra[finalOrchestra.length] = instList;
    if (finalOrchestra.length == elementsArray.length && dumpMode == "set")
    {
        finalOrch = "";
        for (i = 0; i < finalOrchestra.length; i++)
            finalOrch = finalOrch + " " + finalOrchestra[i];
        outlet(2, finalOrch);
    }
}

function setOrchestra()
{
    dumpMode = "set";
    finalOrchestra = new Array();
    finalReceived = new Array();
}

function saveOrchestra()
{
    dumpMode = "save";
    finalOrchestra = new Array();
    finalReceived = new Array();
}

function saveOrchestraTo(fName)
{
    fSave = new File(fName, "write");
    for (i = 0; i < finalOrchestra.length; i++)
        fSave.writeline(finalOrchestra[i]);
    fSave.close();
}

function loadOrchestra(fName)
{
    fLoad = new File(fName, "load");
    clearOrchestra();
    for (; fLoad.position != fLoad.eof; )
    {
        curInst = fLoad.readline(4096);
        curElts = curInst.split('/');
        for (i = curElts.length; i < 4; i++)
            curElts[i] = "";
        for (i = 0; i < 4; i++)
        {
            for (j = 0; j < instruClean.length; j++)
                if (curElts[i] == instruClean[j])
                    break;
            if (j == instruList.length)
                curElts[i] = 0;
            else
                curElts[i] = j;
        }
        addElements(1, curElts[0], curElts[1], curElts[2], curElts[3]);
    }
    fLoad.close();
}

function addInstrument(instStr)
{
    post(instStr, '\n');
    curElts = instStr.split('/');
    for (i = curElts.length; i < 4; i++)
        curElts[i] = "";
    for (i = 0; i < 4; i++)
    {
        for (j = 0; j < instruClean.length; j++)
            if (curElts[i] == instruClean[j])
                break;
        if (j == instruList.length)
            curElts[i] = 0;
        else
            curElts[i] = j;
    }
    addElements(1, curElts[0], curElts[1], curElts[2], curElts[3]);
}

function addElements(nbElt, strElt1, strElt2, strElt3, strElt4)
{
    for (i = 0; i < nbElt; i++, nbElements++, fakeNbElements++)
    {
        scriptName = "element" + fakeNbElements;
        elementsArray[elementsArray.length] = scriptName;
        featobj = patcher.newdefault(300,400, "bpatcher", "@name", "orchestra.slot.maxpat", "@varname", scriptName, "@presentation", 1, "@presentation_size", 300, 20, "@presentation_position", 5, (nbElements) * 20 + 5, "@presentation_rect", 10, (nbElements) * 20 + 1, 320, 20);
        for (j = 0; j < instruList.length; j++)
            sendToObject(scriptName, 0, instruList[j]);
        sendToObject(scriptName, 5, nbElements);
        sendToObject(scriptName, 1, strElt1);
        sendToObject(scriptName, 2, strElt2);
        sendToObject(scriptName, 3, strElt3);
        sendToObject(scriptName, 4, strElt4);
    }
}

function removeElement(idElt)
{
    outlet(1, "script delete " + elementsArray[idElt]);
    for (i = idElt + 1; i < elementsArray.length; i++)
    {
        scriptName = elementsArray[i];
        elementsArray[i - 1] = elementsArray[i]; 
        finalOrchestra[i - 1] = finalOrchestra[i]; 
        sendToObject(scriptName, 5, i - 1);
        outlet(1, "script sendbox " + scriptName + " presentation_position 5 " + ((i - 1) * 20 + 5));
    }
    elementsArray.splice(elementsArray.length - 1, 1);
    finalOrchestra.splice(finalOrchestra.length - 1, 1);
    nbElements--;
}

function clearOrchestra()
{
    if (elementsArray.length == 0)
        return;
    for (i = 0; i < elementsArray.length; i++)
        outlet(1, "script delete " + elementsArray[i]);
    elementsArray = new Array();
    finalOrchestra = new Array();
    nbElements = 0;
    fakeNbElements = 0;
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