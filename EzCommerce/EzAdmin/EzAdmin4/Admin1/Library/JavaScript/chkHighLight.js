function ezHL(myChkObj)
{
	var r = null;
	if (myChkObj.parentNode && myChkObj.parentNode.parentNode)
	{
	    r = myChkObj.parentNode.parentNode;
	}
	else if (myChkObj.parentElement && myChkObj.parentElement.parentElement) 
	{
	    r = myChkObj.parentElement.parentElement;
	}
	if (r)
	{
	    if( myChkObj.checked)
	    {
		r.className = "ezhighlight";
	    }
	    else 
	    {
		r.className = "ezunhighlight";
	    }
	}
	if(myChkObj.type=="radio")
	{
		if(isNaN(myChkObj.length))
		{
			for(i=0;i<myChkObj.length;i++)
				ezHLR(myChkObj[i]);
		}
	}
}
function ezHLR(myChkObj)
{
	alert("in HRL");
	var r = null;
	if (myChkObj.parentNode && myChkObj.parentNode.parentNode) 
	{
	    r = myChkObj.parentNode.parentNode;
	}
	else if (myChkObj.parentElement && myChkObj.parentElement.parentElement) {
	    r = myChkObj.parentElement.parentElement;
	}


	if (r)
	{

	    if( myChkObj.checked)
	    {
		r.className = "ezhighlight";

	    }
	    else 
	    {
		r.className = "ezunhighlight";
	    }
	}

}