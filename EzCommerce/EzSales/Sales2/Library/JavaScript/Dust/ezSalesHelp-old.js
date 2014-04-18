function EzHelpKeywords(aKey,aText)
{
	this.helpKey=aKey;
	this.helpText=aText
	
}
var poptext
function ezKeepInWindow(myMenu,myDIV)
{
    var ne = (document.layers);
    var ie = (document.all);
    var ExtraSpace     = 10;
    var WindowLeftEdge = (ie) ? document.body.scrollLeft   : window.pageXOffset;
    var WindowTopEdge  = (ie) ? document.body.scrollTop    : window.pageYOffset;
    var WindowWidth    = (ie) ? document.body.clientWidth  : window.innerWidth;
    var WindowHeight   = (ie) ? document.body.clientHeight : window.innerHeight;

    var WindowRightEdge  = (WindowLeftEdge + WindowWidth) - ExtraSpace;
    var WindowBottomEdge = (WindowTopEdge + WindowHeight) - ExtraSpace;
			
    var MenuLeftEdge = parseInt(myMenu.left.substring(0,myMenu.left.indexOf("px")));
    var MenuRightEdge = MenuLeftEdge + myDIV.scrollWidth;
    var MenuBottomEdge = parseInt(myMenu.top.substring(0,myMenu.top.indexOf("px"))) + 30;	
				
    if (MenuRightEdge > WindowRightEdge)
    {
		dif = MenuRightEdge - WindowRightEdge;
		myMenu.left=parseInt(myMenu.left.substring(0,myMenu.left.indexOf("px")))- myDIV.scrollWidth + 50 +"px"
    }
	
    if (MenuBottomEdge > (WindowBottomEdge-20)) 
    {
		dif = MenuBottomEdge - WindowBottomEdge;
		myMenu.top=parseInt(myMenu.top.substring(0,myMenu.top.indexOf("px")))- myDIV.scrollHeight-35 +"px"
    }
}

function ezPOPUp(msg,myDIV)
{
	
	var ne = (document.layers);
	var ie = (document.all);
	poptext = myDIV.style;
	var docPath = "";
	if(top.main.display)
		docPath=top.main.display.document
	else
		docPath=top.main.document

	
	//ezGetPOPCoordinates()
	var content ="<Table width=300 BORDER=1 CELLPADDING=1 CELLSPACING=0 BGCOLOR=#336699 BORDERCOLOR=#336699 align = center><Tr><Td><Table WIDTH=100% BORDER=0 CELLPADDING=2 CELLSPACING=2 BGCOLOR=#ecdebe align = center><Tr><Td><p style='align:justify'><FONT COLOR=black SIZE=2 face='arial'>"+msg+"</b></font></p></Td></TR></Table></Td></TR></Table>";
	if (ne)
	{
	    poptext.document.write(content);
	    poptext.document.close();
	    poptext.visibility = "visible";
  	}
   	else if (ie)
	{
	  myDIV.innerHTML = content;
	  poptext.left = 0 
		
	  poptext.top =docPath.body.clientHeight  - myDIV.scrollHeight;
	  poptext.visibility = "visible";
  	}
}
function ezGetPOPCoordinates()
{
	var ne = (document.layers);
              var ie = (document.all);
	var x = (ne) ? e.pageX : event.x+document.body.scrollLeft;
	var y = (ne) ? e.pageY : event.y+document.body.scrollTop;
	poptext.left = x  - 50;
	poptext.top  = y;
}

function ezPOPOut()
{
  if(top.main.display)
  		docPath=top.main.display.document
  	else
		docPath=top.main.document
		
  listBoxIds=docPath.getElementsByTagName("select")
  	if(listBoxIds!=null)
  	{
  		 for(i=0;i<listBoxIds.length;i++)
  		 {
  		      if(listBoxIds[i].id=="ShowHelp")
  			     listBoxIds[i].style.visibility="visible"
  			 } 
	}
poptext.visibility = "hidden";
}
	
