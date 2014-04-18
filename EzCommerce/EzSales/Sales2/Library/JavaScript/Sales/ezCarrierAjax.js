var req;
var reqType;
var ezEntryDiv = document.createElement("Div");
function Initialize()
{
	try
	{
		req=new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e)
	{
		try
		{
			req=new ActiveXObject("Microsoft.XMLHTTP");
		}
		catch(oc)
		{
			req=null;
		}
	} 
	if(!req&&typeof XMLHttpRequest!="undefined")
	{
		req=new XMLHttpRequest();
	}
}

function SendQuery(key,stat)
{
	try
	{
		req=new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e)
	{
		try
		{
			req=new ActiveXObject("Microsoft.XMLHTTP");
		}
		catch(oc)
		{
			req=null;
		}
	}

	if(!req&&typeof XMLHttpRequest!="undefined")
	{
		req=new XMLHttpRequest();
	}
	document.body.appendChild(ezEntryDiv);
	with(ezEntryDiv)
	{
		var carrId     = document.getElementById("carrierName");
		var catalogDiv = document.getElementById("CalendarDiv");
		if(catalogDiv!=null)
			catalogDiv.style.visibility="hidden";
		id="ezEntryDiv"
		style.position="absolute"
		style.top =(findPosY(carrId)+3)+"px";
		style.left=(findPosX(carrId)+2)+"px";
		style.visibility="hidden";
		style.background="#CCCCFF";
	}
	reqType = stat;
	var url=location.protocol+"//"+serverName+"/KissUSA/EzCommerce/EzSales/Sales2/JSPs/Sales/ezCarrierSearch.jsp?carrierNo="+key+"&Status="+stat+"&date="+new Date();	
	if(req!=null)
	{
		req.onreadystatechange = Process;
		req.open("GET", url, true);
		req.send(null);

	}
}

function Process()
{

	if(req.readyState == 4)
        {
		if(req.status == 200)
		{
			if(reqType=="I")
			{
				ShowDiv("ezEntryDiv");
				document.getElementById("ezEntryDiv").innerHTML =req.responseText;
			}
			else
			{
				var resText=req.responseText;
				if(resText.indexOf("NOTVALID")!=-1)				
				{
				       alert("Please enter valid Carrier Name")
				       var carrId = document.getElementById("carrierName");
				       carrId.value="";
				       carrId.focus();
				}
				else
				{
					HideDiv("ezEntryDiv");					
					var catalogDiv = document.getElementById("CalendarDiv");
					if(catalogDiv!=null)
						catalogDiv.style.visibility="visible";
				}	
			}
		}
		else
		{
			document.getElementById("ezEntryDiv").innerHTML ="There was a problem retrieving data:<br>"+req.statusText;
		}
	}
}	


function ShowDiv(divid)
{
	if(document.layers)document.layers[divid].visibility="show";
	else document.getElementById(divid).style.visibility="visible";
}

function HideDiv(divid)
{
	if(document.layers) document.layers[divid].visibility="hide";
	else document.getElementById(divid).style.visibility="hidden";
}

function findPosX(obj)
{
	var curleft = 0;
	if (obj.offsetParent){
		while (obj.offsetParent){
			curleft += obj.offsetLeft;
			obj = obj.offsetParent;
		}
	}
	else if (obj.x)
		curleft += obj.x;
	return curleft;
}

function findPosY(obj)
{
	var curtop = 0;
	if (obj.offsetParent){
		curtop += obj.offsetHeight;
		while (obj.offsetParent){
			curtop += obj.offsetTop;
			obj = obj.offsetParent;
		}
	}
	else if (obj.y){
		curtop += obj.y;
		curtop += obj.height;
	}
	return curtop;
}
