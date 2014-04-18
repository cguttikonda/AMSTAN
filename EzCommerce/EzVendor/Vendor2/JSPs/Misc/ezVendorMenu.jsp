<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/Lib/AddMenuDir.jsp" %>
<html>
<head>
<base target="display">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" >
<style type="text/css">
	a:active { text-decoration: none}
	a:active {color: #00355d}
	a:visited {color: #00355d}
	a:hover {color: #00355d}
	a:link {text-decoration: none;color: #00355d}
	table {
		font-family: verdana,arial,sans-serif;
		font-size: 10px;
		font-style: normal;
		font-weight: bold;
		}
	th {
		font-family: verdana,arial,sans-serif;
		font-size: 10px;
		font-style: normal;
		font-weight: bold;
		color: #FFFFFF
		}
	td {
		font-family: verdana,arial,sans-serif;
		font-size: 10px;
		font-style: normal;
		font-weight: bold;
		color: #FFFFFF
		}
</style>  
<%@include file="../../../Includes/JSPs/Misc/iEzVendMenuScript.jsp" %>  
<script>
	EZ_FontColor          = "<%= session.getValue("fontColor")%>"
	EZ_FontColorOver      = "<%= session.getValue("fontColorOver")%>"
	EZ_BGColor            = "<%= session.getValue("menuBGColor")%>"
	EZ_BGColorOver        = "<%= session.getValue("menuBGColorOver")%>"
	EZ_SeparatorColor     =	"<%= session.getValue("menuSeperatorColor")%>"
	EZ_SeparatorColor1    = "<%= session.getValue("menuSeperatorColor1")%>"

	EZ_NoOfMenusToBuild=7
</script>

<script src="../../Library/JavaScript/EZ_VEND_MENU_SCRIPT.js">
</script>
<script>
var EzHideAll=0
	function ezMouseOver1(mDivId,left)
	{
		var welcomeMenu = null
		if(parent.display != null)
			welcomeMenu = parent.display.document.getElementById("MenuSol");
		if(welcomeMenu != null)
		{
			if(EzHideAll!=0)
				clearTimeout(EzHideAll)
			parent.frames.display.scroll(0,0)
			if(EzPrevOver1 != mDivId)
				ezHideAll()
			EzPrevOver1=mDivId;
			ezShowMenu(mDivId,left+"%",0,-1)
		}	
	}
	function ezMouseOver2(mDivId)
	{
		mainDiv=document.getElementById(mDivId);
		ezHideAll();
	}

	function ezMouseOut1(mDivId)
	{

			EzHideAll=setTimeout("ezHideAll()",3000);

	}

    function backToNoError()
	{
		return true
	}
</script>
</head>
<body  topmargin = "0" leftmargin = "0" class=menubgcolor>
<form name="msnForm" method="post">
<%@ include file="../../../Includes/JSPs/Misc/iEzVendMenu.jsp" %>
<input type="hidden" name="pageUrl">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
