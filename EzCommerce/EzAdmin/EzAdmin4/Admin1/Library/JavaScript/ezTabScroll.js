var tabHeadWidth="90%";
var  tabHeight="45%"
function scrollInit()
{
	headDiv=document.getElementById("theads");
	headTab=document.getElementById("tabHead");
	linesDiv=document.getElementById("InnerBox1Div");
	linesTab=document.getElementById("InnerBox1Tab");
	buttonsDiv=document.getElementById("ButtonDiv");
	if(buttonsDiv !=null)
	{
		buttonsDiv.style.position="absolute";
		buttonsDiv.style.visibility="visible";
	}
	if((linesDiv != null)&&(headTab != null)&&(headDiv != null))
	{		
		linesDiv.style.position="absolute";
		
		linesDiv.style.overflow="auto";
		linesDiv.style.height=tabHeight;

		if(linesDiv.offsetHeight>linesTab.offsetHeight)
			linesDiv.style.width=tabHeadWidth;
 		else
	                linesDiv.style.width="92%";
			linesDiv.style.left="5%";

		if(parent.frames.length==0)
		{
	                linesDiv.style.width="94%";
			linesDiv.style.left="7%";
		}
		headTab.style.width="89%";
		linesTab.style.width="99%";
	}			
}
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
	//alert("in HRL");
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
