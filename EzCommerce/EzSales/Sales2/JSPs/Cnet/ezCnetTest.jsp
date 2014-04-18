<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Cnet/iCnetTest.jsp" %>
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
</script>
<style type="text/css">
.arrowlistmenu{
width: 100%; /*width of accordion menu*/
}

.arrowlistmenu .menuheader{ /*CSS class for menu headers in general (expanding or not!)*/
font: bold 14px Arial;
color: white;
background: black url(titlebar.png) repeat-x center left;
margin-bottom: 10px; /*bottom spacing between header and rest of content*/
text-transform: uppercase;
padding: 4px 0 4px 10px; /*header text is indented 10px*/
cursor: hand;
cursor: pointer;
}

.arrowlistmenu .openheader{ /*CSS class to apply to expandable header when it's expanded*/
background-image: url(titlebar-active.png);
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
color: #A70303;
background: url(arrowbullet.png) no-repeat center left; /*custom bullet list image*/
display: block;
padding: 2px 0;
padding-left: 19px; /*link text is indented 19px*/
text-decoration: none;
font-weight: bold;
border-bottom: 1px solid #dadada;
font-size: 90%;
}

.arrowlistmenu ul li a:visited{
color: #A70303;
}

.arrowlistmenu ul li a:hover{ /*hover state CSS*/
color: #A70303;
background-color: #F3F3F3;
}
</style>
</head>
<body>

<table border=0 style="width:100%;height:100%">
<tr>
<td style="width:30%;height:100%" valign=top>
<div style="overflow:auto;position:absolute;width:99%;height:99%">
<div class="arrowlistmenu">
<h3 class="menuheader expandable">My Favourites</h3>
<ul class="categoryitems">
<li><a href="#">My Catalog</a></li>
</ul>

<h3 class="menuheader expandable">Manage Favourites</h3>
<ul class="categoryitems">
<li><a href="#">Manage</a></li>
</ul>

<h3 class="menuheader expandable">Categories</h3>
<ul class="categoryitems">
<%
	if(retCatCount>0)
	{
		for(int k=0;k<retCatCount;k++)
		{
%>
		<li><a href="#" ><%=retcat.getFieldValueString(k,"Description")%></a></li>
<%
		}
	}
	else
	{
%>
		<li><a href="#" >No Categories</a></li>
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
<td style="width:70%;height:100%">
&nbsp;
</td>
<tr>
</table>

</div>
</body>
</html>