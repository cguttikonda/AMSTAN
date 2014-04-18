<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<html>
<head>
<Title>Welcome to EzCommerce Administration Module.</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<base target="display">
	<style type="text/css">
	<!--
	a:active { text-decoration: none}
	a:active {color:#000066}
	a:hover {color:#000066}
	a:visted{color:#000066}
	a:link {text-decoration: none;color:#000066}
	table {
		font-family: verdana,arial,sans-serif;
		font-size: 11px;
		font-style: normal;
		font-weight: bold;
		}
	th {
		font-family: verdana,arial,sans-serif;
		font-size: 11px;
		font-style: normal;
		font-weight: bold;
		}
	td {
		font-family: verdana,arial,sans-serif;
		font-size: 11px;
		font-style: normal;
		font-weight: bold;
		}
	div{
		font-family: "verdana,arial,sans-serif";
		font-size: 11px;
		font-style: normal;
		padding = 0px;
		border-top=2px outset <%= session.getValue("menuSeperatorColor")%>;
		border-bottom=2px inset <%= session.getValue("menuSeperatorColor")%>;
		border-left=1px outset <%= session.getValue("menuSeperatorColor")%> ;
		border-right=1px outset black;
		background:"#ffcc66";
		color:"skyblue";
		}
	-->
	</style>
<%@ include file="../../../Includes/JSPs/Misc/iMenuScript.jsp"%>
<script src="../../Library/JavaScript/EZ_ADMIN_MENU_SCRIPT.js"></script>
<script>
	function ezMouseOver1(mDivId,left)
	{

		parent.frames.display.scroll(0,0)
		if(EzPrevOver1 != mDivId)
		{	
			ezHideAll()
		}
		EzPrevOver1=mDivId;
		ezShowMenu(mDivId,left+"%",0,-1)
	}
	function ezMouseOver2(mDivId)
	{
		mainDiv=document.getElementById(mDivId);
		ezHideAll();
	}
       	function backToNoError()
	{
		return true
	}
	window.onerror=backToNoError
</script>
<script>
	EZ_FontColor          = "<%= session.getValue("fontColor")%>"
	EZ_FontColorOver      = "<%= session.getValue("fontColorOver")%>"
	EZ_BGColor            = "<%= session.getValue("menuBGColor")%>"
	EZ_BGColorOver        = "<%= session.getValue("menuBGColorOver")%>"
	EZ_SeparatorColor     =	"<%= session.getValue("menuSeperatorColor")%>"
	EZ_SeparatorColor1    = "<%= session.getValue("menuSeperatorColor1")%>"
</script>
</head>
<body  onLoad=ezMakeMenus() topmargin = "2" leftmargin = "3" text="#FFFFFF" link="WHITE" vlink="WHITE" alink="#FFFFFF" bgcolor=bgcolorclass topmargin="0">
<form name=myForm method=post>
 <%@ include file="../../../Includes/JSPs/Misc/iMenu.jsp"%>
<input type="hidden" name="pageUrl">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
