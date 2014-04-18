
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

var headDiv="";
var linesDiv="";
var linesTab="";
var headTab="";
function scrollInit(stot)
{

	headDiv=document.getElementById("theads");
	linesDiv=document.getElementById("InnerBox1Div");
	if((linesDiv != null)&&(headDiv != null))
	{
		linesTab=linesDiv.getElementsByTagName("table")[0];
		headTab=headDiv.getElementsByTagName("table")[0];

		boxTop=headDiv.offsetTop+headDiv.offsetHeight;
		linesDiv.style.position="absolute";
		linesDiv.style.overflow="auto";
		linesDiv.style.height=tabHeight;
		linesDiv.style.top=boxTop;
		if(linesDiv.offsetHeight < linesTab.offsetHeight){
			addwidth=19
		}else{
			addwidth=0+scrollAdj
		}
			boxWidth=headDiv.offsetWidth+addwidth
			boxWidth=boxWidth-(boxWidth/tabHeadWidth)
			boxWidth=Math.round(boxWidth)
			linesDiv.style.width=boxWidth
			boxLeft = ((headDiv.offsetWidth-boxWidth)/2)+(addwidth/2)-1
			boxLeft=Math.round(boxLeft)
			linesDiv.style.left=boxLeft
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
}
