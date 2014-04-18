var intTimeout = 1
var intSlideBy = 3

var intPgDnBy = boxBottom-boxTop
var timerID = 0
var intStartDivTop

var toScrollHeight		// 
var scrollWho

is.ns = (document.layers)? true:false
is.ie = (document.all)? true:false
var boxBottom=0,boxTop=0,boxLeft=0,boxWidth=0;

tabHeadWidth=100/(100-tabHeadWidth)
function initFun(framesize)
{
	var InnerdivId=document.getElementById("InnerBox1Div")
	var OuterdivId=document.getElementById("OuterBox1Div")
	if (!((InnerdivId == null)&&(OuterdivId == null)))
	{
		myInit(framesize)
		if(getposition())
		{
			ScrollBox.show()
		}
		else
		{
			ScrollBox.hide()
		}
	}
}

		
function myInit(framesize)
{

		boxTop=document.getElementById("theads").offsetTop+document.getElementById("theads").offsetHeight 	
		
		if(document.body.clientHeight>boxTop+30)
		{	
			boxWidth=document.getElementById("theads").offsetWidth
			boxWidth=boxWidth-boxWidth/tabHeadWidth
			boxWidth=Math.ceil(boxWidth)
			
			
			boxBottom=document.getElementById("ScrollBoxDiv").offsetTop	
			if(framesize==2)				
			boxLeft = (((document.getElementById("theads").offsetWidth)-boxWidth)/2)
			else
		        boxLeft = (((document.getElementById("theads").offsetWidth)-boxWidth)/2)+10
		        if(framesize==20)
		        {
				boxWidth="95%"
				boxLeft = "34%"
			}
			settingTableWidth(framesize)	
		}
		
	
	DynLayerInit()

	if (is.ie || is.ns)
	{	toScrollHeight=boxBottom-boxTop	 
		scrollWho=InnerBox1	
		myScrollHeight = (is.ns)? InnerBox1.doc.height : InnerBox1.elm.scrollHeight
		myScrollHeight=myScrollHeight-toScrollHeight	
		scrolling=0
		UpDn='aaa'	
		InnerBox1.slideInit()
		InnerBox1.onSlideEnd=scrollMessage
		intStartDivTop=OuterBox1.y
	}		
	else  // >=IE6,NS6
	{ 
		
		intStartDivTop=document.getElementById("OuterBox1Div").offsetTop
	}
	
}


function moveDivTo(y)
{	if (is.ie || is.ns)	
	{
		scrollWho.moveTo(2,y)
	}
	else //ns6
	{
		document.getElementById("InnerBox1Div").style.top = y 
	}		
}

function scrollMessage()
{	if (is.ie || is.ns)
	{ 	myScrollHeight= (is.ns)? scrollWho.doc.height : scrollWho.elm.scrollHeight
		

		myScrollHeight=myScrollHeight-toScrollHeight

		if (UpDn=='dn')
		{	if((scrollWho.y > 0 - myScrollHeight) && scrolling==1)
			{
			 scrollWho.slideBy(0,-intSlideBy,intSlideBy/2,intTimeout)
			}			
		}
		else if (UpDn=='up')
		{	if((scrollWho.y < 0) && scrolling==1)
			{ scrollWho.slideBy(0,intSlideBy,intSlideBy/2,intTimeout)
			}
		}
	}
	else //>=ns6,ie6
	{	toScrollHeight=document.getElementById("OuterBox1Div").offsetHeight
		myScrollHeight= document.getElementById("InnerBox1Div").offsetHeight
		myScrollHeight=myScrollHeight-toScrollHeight
		intTimeout=20
		intSlideBy=10
		if (UpDn=='dn')
		{	if((document.getElementById("InnerBox1Div").offsetTop > intStartDivTop - myScrollHeight) && scrolling==1)
			{	document.getElementById("InnerBox1Div").style.top = (document.getElementById("InnerBox1Div").offsetTop - intStartDivTop) - intSlideBy + "px"
				timerID = setTimeout("scrollMessage()",intTimeout)
			}
			else
			{	scrolling=0;
				clearTimeout(timerID)
			}			
		}

		else if (UpDn=='up')
		{	if((document.getElementById("InnerBox1Div").offsetTop < intStartDivTop) && scrolling==1)
			{
			 document.getElementById("InnerBox1Div").style.top = (document.getElementById("InnerBox1Div").offsetTop - intStartDivTop) + intSlideBy + "px"
			 timerID = setTimeout("scrollMessage()",intTimeout)
			}
			else
			{	scrolling=0;
				clearTimeout(timerID)
			}
		}		
	}
	//to find out the y coordinate of the scrolling layer
	//window.status=scrollWho.y
	return false;
}

function pageUpDnMessage()
{	if (is.ie || is.ns)
	{	
		myScrollHeight= (is.ns)? scrollWho.doc.height : scrollWho.elm.scrollHeight
		myScrollHeight=myScrollHeight-toScrollHeight	   

		if (UpDn=='dn')
		{	if(scrollWho.y > intStartDivTop - myScrollHeight)
			{	if(myScrollHeight+ scrollWho.y>=intStartDivTop+intPgDnBy)
				{	scrollWho.moveTo(2,scrollWho.y-intPgDnBy)
				}
				else
				{	scrollWho.moveTo(2,-myScrollHeight)
				}
			}
		}
		else if (UpDn=='up')
		{	if(scrollWho.y < intStartDivTop)
			{	if(0-scrollWho.y>=intPgDnBy)
				{	scrollWho.moveTo(2,scrollWho.y+intPgDnBy)
				}
				else
				{	scrollWho.moveTo(2,0)
				}
			}
		}
	}
	else //ns6
	{	
		toScrollHeight = document.getElementById("OuterBox1Div").offsetHeight
		myScrollHeight = document.getElementById("InnerBox1Div").offsetHeight
		myScrollHeight = myScrollHeight-toScrollHeight

		if (UpDn=='dn')
		{	if(document.getElementById("InnerBox1Div").offsetTop > intStartDivTop - myScrollHeight)
			{ 	if(myScrollHeight+ document.getElementById("InnerBox1Div").offsetTop>=intStartDivTop+intPgDnBy)
				{	document.getElementById("InnerBox1Div").style.top = (document.getElementById("InnerBox1Div").offsetTop - intStartDivTop)-intPgDnBy
				}
				else
				{	document.getElementById("InnerBox1Div").style.top = -myScrollHeight //intStartDivTop-myScrollHeight-10
				}
			}
		}
		else if (UpDn=='up')
		{	if(document.getElementById("InnerBox1Div").offsetTop < intStartDivTop)
			{	if(intStartDivTop-document.getElementById("InnerBox1Div").offsetTop>=intPgDnBy)
				{	document.getElementById("InnerBox1Div").style.top = (document.getElementById("InnerBox1Div").offsetTop - intStartDivTop)+intPgDnBy
				}
				else
				{	document.getElementById("InnerBox1Div").style.top = 0 //intStartDivTop+10
				}
			}
		}
	}		
	scrolling=0
	return false;
}

function getposition()
{
	myScrollHeight = (is.ns) ? scrollWho.doc.height : scrollWho.elm.scrollHeight
	if(myScrollHeight > (boxBottom-boxTop))
	{
		
		return true
	}
	else
	{
		return false
	}
}
function getPositionForNetscape()
{
	toScrollHeight = document.getElementById("OuterBox1Div").offsetHeight
	myScrollHeight = document.getElementById("InnerBox1Div").offsetHeight
	myScrollHeight = myScrollHeight-toScrollHeight
	
	if((document.getElementById("InnerBox1Div").offsetTop > intStartDivTop - myScrollHeight) )
	{
		return true
	}
	else
		return false
}
function settingTableWidth(framesize)
{
	var Outer = document.getElementById("OuterBox1Div")
	var Inner = document.getElementById("InnerBox1Div")
	
	Outer.style.top=boxTop-1
	Outer.style.left=boxLeft
	Outer.style.width=boxWidth
	Outer.style.height=boxBottom-boxTop
	Inner.style.top=0
	Inner.style.left=0
	Inner.style.width=boxWidth
	if(framesize==20)
	{
			Outer.style.top=boxTop+2
			Inner.style.top=2
	}
}


function adjustTableWidth(framesize)
{
	var InnerdivId=document.getElementById("InnerBox1Div")
	var OuterdivId=document.getElementById("OuterBox1Div")
	
	if (!((InnerdivId == null)&&(OuterdivId == null)))
	{
		
		myInit(framesize)
	
		if(getposition())
		{
			ScrollBox.show()
		}
		else
		{
			ScrollBox.hide()
		}
	}
}

document.write("<STYLE>")
document.write("<!--")
document.write("#OuterBox1Div {overflow:hidden; position: absolute; visibility: visible; z-index: 0;}")
document.write("#InnerBox1Div {overflow:hidden; position: absolute; visibility: visible; z-index: 0;}")
document.write("-->")
document.write("</STYLE>")
