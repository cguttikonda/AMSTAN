
var scrollBody="";
var speed=5
	
function setDefaultProps(tHead,index)
{
	var thWidth=tHead.style.width
		
	thWidth=thWidth.substring(0,2)
	var tLeft=(100-thWidth)/2 + "%" 
	tHead.style.left=tLeft
	
	var tp=tHead.clientHeight+tHead.offsetTop

	var tBody=document.getElementById("tableBody"+index);
	tBody.style.top=tp
	tBody.style.left=tLeft	

	var scrollButton=document.getElementById("ScrollBoxDiv"+index);
	
	for(var i=0;i<scrollButton.childNodes.length;i++)
	{
		if(scrollButton.childNodes[i].name=="scrollDn")
		{
			scrollButton.childNodes[i].onmouseover=mouseDownFun
			scrollButton.childNodes[i].onmouseout=ezMouseOut
			scrollButton.childNodes[i].tBody1=tBody
		}	
		else if(scrollButton.childNodes[i].name=="scrollUp")	
		{
			scrollButton.childNodes[i].onmouseover=mouseUpFun
			scrollButton.childNodes[i].onmouseout=ezMouseOut
			scrollButton.childNodes[i].tBody1=tBody
		}	
	}
	ezSetButtonEnable(tBody,scrollButton);
}

function scrollInit()
{
	var allDivs = document.getElementsByTagName("div")
	var divId=""
	for(var i=0;i<allDivs.length;i++)
	{
		divId=allDivs[i].id
		if((divId).indexOf("tableHead")>=0)
		{
			setDefaultProps(allDivs[i],divId.substring(divId.length-1,divId.length))
		}
	}
}


function mouseDownFun()
{
	scrollBody=this;
	myInterval=setInterval("ezScrollDown()",10)
}
function mouseUpFun()
{
	scrollBody=this;
	myInterval=setInterval("ezScrollUp()",10)
}

function ezScrollDown()
{
	scrollBody.tBody1.scrollTop=(scrollBody.tBody1.scrollTop)+speed
}

function ezMouseOut()
{
	clearInterval(myInterval)
}

function ezScrollUp()
{
	scrollBody.tBody1.scrollTop=(scrollBody.tBody1.scrollTop)-speed
}

function ezSetButtonEnable(tBody,scrollButton)
{
	if((tBody.offsetHeight + tBody.offsetTop ) > (scrollButton.offsetTop))
	{
		scrollButton.style.visibility="visible"
		tBody.style.height=scrollButton.offsetTop-tBody.offsetTop
		tBody.style.overflow="hidden"
	}
}