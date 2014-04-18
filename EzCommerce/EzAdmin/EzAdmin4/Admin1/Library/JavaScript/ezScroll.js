/**
 * @(#) ezScroll.js V1.0	July 19,2002
 *
 * Copyright (c) 2002 EzCommerce Inc. All Rights Reserved.
 * @ author Krishna Prasad V
 *
 **/
var intSlideBy = 8;
var intTimeout = 1;
var timerID = 0;


var addWidth=0;
var boxBottom=0,boxTop=0,boxLeft=0,boxWidth=0;
var noOfDiv=0;
var scrolling=0;
var UpDn='';	

tabHeadWidth=100/(100-tabHeadWidth);
//*****Main calling function*****
var stime=0;
var etime=0;
var mtime=0;

var InnerdivId="";
var OuterdivId="";
var theadsId="";
var ScrollBoxID="";
var myInitFlag=false;
function scrollInit(adjustWidth)
{
	var st=new Date();
	stime=st.getTime();
	
	InnerdivId=document.getElementById("InnerBox1Div");
	OuterdivId=document.getElementById("OuterBox1Div");
	theadsId=document.getElementById("theads");
	ScrollBoxID=document.getElementById("ScrollBoxDiv");
	
	
	if((InnerdivId != null)&&(OuterdivId != null)&&(theadsId != null)&&(ScrollBoxID != null))
	{
		myInitFlag=true;
	}
	
	
	if(adjustWidth != null)
	{
		addWidth=adjustWidth
	}
	if (myInitFlag)
	{
		

		myInit()
		var positionFlag=getposition();
		if(positionFlag){
			ScrollBox.show()
		}else{
			ScrollBox.hide()
		}
	}
	
	
}
function myInit()
{
		
	boxTop=theadsId.offsetTop+theadsId.offsetHeight 
		

	if(document.body.clientHeight>boxTop+30)
	{
		
	
		boxWidth=theadsId.offsetWidth
		boxWidth=boxWidth-(boxWidth/tabHeadWidth)
		boxWidth=Math.round(boxWidth)
		boxBottom=ScrollBoxID.offsetTop	
		boxLeft = (((theadsId.offsetWidth-boxWidth)/2)+parseInt(addWidth))-parseInt(1)
		boxLeft=Math.round(boxLeft)
		settingTableWidth()
	}

	//Layer Init
		
	DynLayerInit()
		
	if (is.ie || is.ns)
	{	
	
		toScrollHeight=boxBottom-boxTop	 
		scrollWho=InnerBox1
		myScrollHeight =  InnerBox1.elm.scrollHeight
		myScrollHeight=	myScrollHeight-toScrollHeight	
		InnerBox1.slideInit()
		InnerBox1.onSlideEnd=scrollMessage
		intStartDivTop=OuterBox1.y
	
		
	}
	//************new code added *******************//
		
		scrollDiv=document.getElementById("ScrollBoxDiv")
		noOfRows = InnerBox1Div.getElementsByTagName("table")[0].rows.length
		tempStr=scrollDiv.innerHTML
		if(tempStr.indexOf("Total No. of Records:")<0)
		{
		  scrollDiv.innerHTML=scrollDiv.innerHTML+"<span id='recMsg'></span>"
		  recMsgSpan=document.getElementById("recMsg")
		  if(recMsgSpan!=null)
		  recMsgSpan.innerHTML="1&nbsp;of&nbsp;&nbsp;"+noOfRows+"&nbsp;&nbsp;"
		
		} 
    //*********************end added code*********** //	
}

function settingTableWidth(framesize)
{
	var oDiv=OuterdivId.style
	var iDiv=InnerdivId.style
	
	oDiv.top=boxTop-1;
	oDiv.left=boxLeft;
	oDiv.width=boxWidth;
	oDiv.height=boxBottom-boxTop;
	iDiv.top=0;
	iDiv.left=0;
	
	
	iDiv.width=boxWidth;
	
	
}
function getposition()
{
	if( scrollWho.elm.scrollHeight > (boxBottom-boxTop))
		return true
	else
		return false
}
function scrollMessage()
{
	if (is.ie)
	{
		myScrollHeight=scrollWho.elm.scrollHeight-toScrollHeight
		if (UpDn=='dn')
		{	
			if((scrollWho.y > (0 - myScrollHeight)) && scrolling==1)
			{
			 	scrollWho.slideBy(0,-intSlideBy,intSlideBy/2,intTimeout)
			}			
		}
		else if (UpDn=='up')
		{	if((scrollWho.y < 0) && scrolling==1)
			{
				scrollWho.slideBy(0,intSlideBy,intSlideBy/2,intTimeout)
			}
		}
	}
	//to find out the y coordinate of the scrolling layer
	//window.status=scrollWho.y
	//****************new code added ***********//
		
		recMsgSpan=document.getElementById("recMsg")
		var temp_cal=Math.round(InnerBox1Div.getElementsByTagName("table")[0].offsetHeight/noOfRows)
		if(recMsgSpan!=null)
		recMsgSpan.innerHTML=(parseInt(Math.round(-(scrollWho.y)/temp_cal))+parseInt(1))+"&nbsp;of&nbsp;&nbsp;"+noOfRows+"&nbsp;&nbsp;"
		
       //*****************end of new code *************************//
	return false;
}


function pageUpDnMessage()
{
	if (is.ie)
	{	
		myScrollHeight= scrollWho.elm.scrollHeight-toScrollHeight	   
		intPgDnBy=toScrollHeight
		if (UpDn=='dn')
		{
			if(scrollWho.y > intStartDivTop - myScrollHeight)
			{
				if(myScrollHeight+ scrollWho.y >= intStartDivTop+intPgDnBy)
				{
					if(scrollWho.y > 0 - myScrollHeight)
					{
						scrollWho.moveTo(2,scrollWho.y-intPgDnBy)
					}
				}
				else
				{	
					scrollWho.moveTo(2,0)
				}
			}
		}
		else if (UpDn=='up')
		{
		
			if(scrollWho.y < intStartDivTop)
			{	if(0-scrollWho.y>=intPgDnBy)
				{	
					if(scrollWho.y > 0 - myScrollHeight)
					{
						scrollWho.moveTo(2,scrollWho.y+intPgDnBy)
					}
				
				}
				else
				{
					scrollWho.moveTo(2,0)
				}
			}
		}
	}
	scrolling=0
	return false;
}



document.write("<STYLE>")
document.write("<!--")
document.write("#OuterBox1Div {overflow:hidden; position: absolute; visibility: visible; z-index: 0;}")
document.write("#InnerBox1Div {overflow:hidden; position: absolute; visibility: visible; z-index: 0;}")
document.write("-->")
document.write("</STYLE>")