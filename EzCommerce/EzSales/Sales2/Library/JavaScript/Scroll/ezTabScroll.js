/****************************************************************************************
        * Copyright Notice ===================================================
	* This file contains proprietary information of Answerthink Ind Ltd.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2005-2006 =====================================*
		Author: Ramesh.S
		Team:   EzcSuite
		Date:   12/09/2005
*****************************************************************************************/

var boxTop=0,boxLeft=0,boxWidth=0,addwidth=0;
tabHeadWidth=100/(100-tabHeadWidth);

var bversion;
x=window.navigator.userAgent;

if(window.navigator.appName =="Microsoft Internet Explorer")
	bversion=x.substring(  (x.indexOf("MSIE ")+4), x.indexOf(";",(x.indexOf(";")+1)) );
if ((parseFloat(bversion)>=5.1)||(window.navigator.appName=="Netscape"))
	scrollAdj=0
else
	scrollAdj=15

var headDiv ="";
var linesDiv="";
var linesTab="";
var headTab ="";

var headDiv1 ="";
var linesDiv1="";
var linesTab1="";
var headTab1 ="";


function scrollInit(stot)
{

	try
	{
		headDiv=document.getElementById("theads");
		headDiv1=document.getElementById("theads1");
		linesDiv=document.getElementById("InnerBox1Div");
		linesDiv1=document.getElementById("InnerBox1Div1");

		var leftAdj=0;
		if(stot==10)
			leftAdj=10;
		if((linesDiv != null)&&(headDiv != null))
		{
			linesTab=linesDiv.getElementsByTagName("table")[0];
			headTab=headDiv.getElementsByTagName("table")[0];


			boxTop=headDiv.offsetTop+headDiv.offsetHeight;
			linesDiv.style.position="absolute";
			linesDiv.style.overflow="auto";
			linesDiv.style.height=tabHeight;
			linesDiv.style.top = boxTop;
			if(linesDiv.offsetHeight < linesTab.offsetHeight){
				addwidth=19
			}else{
				addwidth=0+scrollAdj
			}
				boxWidth=headDiv.offsetWidth+addwidth
				boxWidth=boxWidth-(boxWidth/tabHeadWidth)
				boxWidth=Math.round(boxWidth)
				linesDiv.style.width=boxWidth
				boxLeft = ((headDiv.offsetWidth-boxWidth)/2)+(addwidth/2)-2
				boxLeft=Math.round(boxLeft)
				linesDiv.style.left=boxLeft+leftAdj


		}

		if((linesDiv1 != null)&&(headDiv1 != null))
		{

			headDiv1.style.top= linesDiv.offsetTop+linesDiv.offsetHeight + 10;
			linesTab=linesDiv1.getElementsByTagName("table")[0];
			headTab=headDiv1.getElementsByTagName("table")[0];
			boxTop=headDiv1.offsetTop+headDiv1.offsetHeight;
			linesDiv1.style.position="absolute";
			linesDiv1.style.overflow="auto";
			linesDiv1.style.height=tabHeight;
			linesDiv1.style.top=boxTop;
			if(linesDiv1.offsetHeight < linesTab.offsetHeight){
				addwidth=19
			}else{
				addwidth=0+scrollAdj
			}
			boxWidth=headDiv1.offsetWidth+addwidth
			boxWidth=boxWidth-(boxWidth/tabHeadWidth)
			boxWidth=Math.round(boxWidth)
			linesDiv1.style.width=boxWidth
			boxLeft = ((headDiv.offsetWidth-boxWidth)/2)+(addwidth/2)-2
			boxLeft=Math.round(boxLeft)
			linesDiv1.style.left=boxLeft+leftAdj

		}

		if(stot=="SHOWTOT")
		{
			var showTotDiv=document.getElementById("showTot");
			if(showTotDiv!=null){
				showTotDiv.style.left=boxLeft
				showTotDiv.style.position="absolute"
				showTotDiv.style.width=boxWidth-addwidth
				if(linesDiv.offsetHeight < linesTab.offsetHeight)
					showTotDiv.style.top=linesDiv.offsetHeight+boxTop
				else
					showTotDiv.style.top=linesTab.offsetHeight+boxTop
				showTotDiv.style.visibility = "visible"
			}

		}
	}catch(myerror){}	
}
