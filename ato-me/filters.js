var namesArray;
var nbValuesArray;
var nbSymbolicFilters = 0;
var curSymbolicX = 0;
var nbSpectralFilters = 0;
var firstUse = 1;
outlets = 3;

function loadbang()
{
    nbValuesArray = new Array();
}

function filtersList(paramString)
{
    paramArray = paramString.split(' ');
    name = paramArray[0];
    type = paramArray[1];
    finalNb = paramArray[2];
    finalNbStr = "" + finalNb;
    myobj = this.patcher.getnamed(name);
    if (myobj == null)
    {
        if (type == "Symbolic")
        {
            nbValues = (paramArray.length - 3);
            featobj = this.patcher.newdefault(300,400, "bpatcher", "@name", "filters.symbolic.maxpat", "@varname", name, "@presentation", 1, "@presentation_size", 200, finalNb * 20 + 50, "@presentation_position", 1, curSymbolicX + 5, "@presentation_rect", 1, curSymbolicX, 200, finalNb * 20 + 50);
            sendToObject(name, 0, name);
            valuesList = paramString.substring(name.length + type.length + finalNbStr.length + 3, paramString.length);
            sendToObject(name, 1, valuesList);
            nbSymbolicFilters++;
            nbValuesArray[nbSymbolicFilters] = nbValues;
            curSymbolicX += finalNb * 20 + 50;
            sendToObject(name, 3, 'bang');
        }
        else
        {
            if (type == "Spectral")
            {
                featobj = this.patcher.newdefault(300, 400, "bpatcher", "@name", "filters.spectral.maxpat", "@varname", name, "@presentation", 1, "@presentation_size", 240, 20, "@presentation_position", 220, nbSpectralFilters * 120 + 4, "@presentation_rect", 220, 60, 240, 120);
                sendToObject(name, 0, name);
                sendToObject(name, 1, "" + paramArray[2] + " " + paramArray[3]);
                nbSpectralFilters++;
            }
        }
    }
    else
	{
	    nbValues = (paramArray.length - 3);
	    valuesList = paramString.substring(name.length + type.length + finalNbStr.length + 3, paramString.length);
	    sendToObject(name, 1, valuesList);
        nbValuesArray[nbSymbolicFilters] = nbValuesArray[nbSymbolicFilters] + nbValues;
        sendToObject(name, 3, 'bang');
	}
    //outlet(1, "script sendtoback searchPanel");
}

function sendToObject(dest, thein, msg)
{
    myobj = this.patcher.getnamed(dest);
    this.patcher.connect(this.box,0,myobj,thein);
    outlet(0,msg);
    this.patcher.disconnect(this.box,0,myobj,thein);
}