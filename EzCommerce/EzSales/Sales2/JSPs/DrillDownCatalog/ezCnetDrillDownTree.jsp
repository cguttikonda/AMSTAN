<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/DrillDownCatalog/iCnetDrillDownTree.jsp" %>
<html>
<head>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="../../Library/JavaScript/ddaccordion.js">
</script>
<script type="text/javascript">
ddaccordion.init({
	headerclass: "expandable", //Shared CSS class name of headers group that are expandable
	contentclass: "categoryitems", //Shared CSS class name of contents group
	revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false
	defaultexpanded: [2], //index of content(s) open by default [index1, index2, etc]. [] denotes no content
	onemustopen: false, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: false, //Should contents open by default be animated into view?
	persiststate: false, //persist state of opened contents within browser session?
	toggleclass: ["", "openheader"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["prefix", "", ""], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: "fast", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
		//do nothing
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
		//do nothing 
	}
})

function selectCat(catid,desc,idx)
{	alertall(idx)	
	parent.document.getElementById("subDisplay").src="../Cnet/ezCnetPrdListByCategoryWait.jsp?categoryID="+catid+"&categoryDesc="+desc+"&STYPE=BY_CAT";
	
}
function selectFav(cStr,idx)
{
	alertall(idx)	
	parent.document.getElementById("subDisplay").src="ezViewPCDetails.jsp?catalogStr="+cStr;
}
function gSearch(idx)
{
	alertall(idx)	
	parent.document.getElementById("subDisplay").src="../Cnet/ezCnetSearch.jsp";
}
function alertall(indx) 
{
	var li=document.getElementsByTagName("li");
	if(li!=null && !isNaN(li.length))
	{
		for(i=1;i<=li.length;i++) 
		{
			span = document.getElementById("mspan"+i);
			if(i==indx)
			{
				span.style.color = '#A70303'
			}
			else
			{
				span.style.color = '#000000'
			}
		}
	}
}
function hideStatus()
{
	window.status="";
	return true;
}

</script>
<style type="text/css">
.arrowlistmenu{
width: 100%; /*width of accordion menu*/ 
}

.arrowlistmenu .menuheader{ /*CSS class for menu headers in general (expanding or not!)*/
font: bold 10px Verdana;
color: white;
background-color: #227A7A;
/*background: black url(titlebar2.png) repeat-x center left;*/
margin-bottom: 10px; /*bottom spacing between header and rest of content*/
/*text-transform: uppercase;*/
padding: 4px 0 4px 10px; /*header text is indented 10px*/
cursor: hand;
cursor: pointer;
}

.arrowlistmenu .openheader{ /*CSS class to apply to expandable header when it's expanded*/
/*background-image: url(titlebar-active2.png);*/
}

.arrowlistmenu ul{ /*CSS for UL of each sub menu*/
list-style-type: none;
margin: 0;
padding: 0;
margin-bottom: 8px; /*bottom spacing between each UL and rest of content*/
}

.arrowlistmenu ul li{
padding-bottom: 2px; /*bottom spacing between menu items*/
}

.arrowlistmenu ul li a{
color: #000000;
background: url(arrowbullet.png) no-repeat center left; /*custom bullet list image*/
display: block;
padding: 2px 0;
padding-left: 19px; /*link text is indented 19px*/
text-decoration: none;
font-weight: bold;
border-bottom: 1px solid #dadada;
font-size: 9px;
font-family:verdana;
}

.arrowlistmenu ul li a:visited{
color: #000000;
}

.arrowlistmenu ul li a:hover{ /*hover state CSS*/
color: #000000;
background-color: #F3F3F3;
}
</style>
</head>
<body>

<table border=0 style="width:100%;height:100%">
<tr>
<td style="width:100%;height:100%" valign=top>
<div style="overflow:auto;position:absolute;width:99%;height:99%">
<div class="arrowlistmenu">
<h3 class="menuheader expandable">My Favourites</h3>
<ul class="categoryitems">
<li><a href="javascript:selectFav('<%=catalogStr%>','1')" onMouseOver="return hideStatus()"><span id="mspan1"><%=perCatDesc%></span></a></li>
</ul>

<h3 class="menuheader expandable">Search</h3>
<ul class="categoryitems">
<%
if(retCatCount>0)
{
%>
<li><a href="javascript:gSearch('2')" onMouseOver="return hideStatus()"><span id="mspan2">Global Search</span></a></li>
<%
}
else
{
%>
<li><a href="#"><span id="mspan2">Global Search</span></a></li>
<%
}
%>
</ul>

<h3 class="menuheader expandable">Categories</h3>
<ul class="categoryitems">
<%
	if(retCatCount>0)
	{
		int ctr = 2;
		for(int k=0;k<retCatCount;k++)
		{
		ctr++;
		String tempDesc = retcat.getFieldValueString(k,"Description");
		tempDesc = tempDesc.replaceAll("&","@");
		
%>
		<li><a href="javascript:selectCat('<%=retcat.getFieldValueString(k,"CatID")%>','<%=tempDesc%>','<%=ctr%>')"  onMouseOver="return hideStatus()" ><span id="mspan<%=ctr%>"><%=retcat.getFieldValueString(k,"Description")%></span></a></li>
<%
		}
	}
	else
	{
%>
		<li><a href="#" ><span id="mspan3">No Categories</span></a></li>
<%
	}
%>
</ul>

<!--
<h3 class="menuheader" style="cursor: default">FeedBack</h3>
<div>
Regular contents here. Header does not expand or contact.
</div>
-->
</div>
</td>
</tr>
</table>

</div>
</body>
</html>