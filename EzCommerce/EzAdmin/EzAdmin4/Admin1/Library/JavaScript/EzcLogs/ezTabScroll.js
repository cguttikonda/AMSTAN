
var boxTop=0,boxLeft=0,boxWidth=0,addwidth=0;
tabHeadWidth=100/(100-tabHeadWidth);

var bversion;
x=window.navigator.userAgent;

if(window.navigator.appName =="Microsoft Internet Explorer")
	bversion=x.substring(  (x.indexOf("MSIE ")+4), x.indexOf(";",(x.indexOf(";")+1)) );
if (parseFloat(bversion)>=5.1)
	scrollAdj=0
else
	scrollAdj=15
if (!(window.navigator.appName =="Microsoft Internet Explorer"))
	scrollAdj=0

function scrollInit(stot)
{
	
	headDiv=document.getElementById("theads");
	headTab=document.getElementById("tabHead");
	linesDiv=document.getElementById("InnerBox1Div");
	linesTab=document.getElementById("InnerBox1Tab");
	if((linesDiv != null)&&(headTab != null)&&(headDiv != null))
	{

		boxTop=headDiv.offsetTop+headDiv.offsetHeight;
		linesDiv.style.position="absolute";
		linesDiv.style.top=boxTop;
		linesDiv.style.overflow="auto";
		linesDiv.style.height=tabHeight;



		if(linesDiv.offsetHeight < linesTab.offsetHeight){
			addwidth=19
		}else{
			addwidth=0+scrollAdj
		}
			boxWidth=headDiv.offsetWidth+addwidth
			boxWidth=boxWidth-(boxWidth/tabHeadWidth)
			boxWidth=Math.round(boxWidth)
			linesDiv.style.width=boxWidth
			boxLeft = ((headDiv.offsetWidth-boxWidth)/2)+(addwidth/2)
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
