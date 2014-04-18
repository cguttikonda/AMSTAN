<html>
<head>
	<Title>Welcome to EZC</Title>
	<base target="display">
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" author="krishna prasad">
	<style type="text/css">
	<!--
	a:active { text-decoration: none}
	a:active {color: ORANGE}
	a:hover {color: WHITE}
	a:link {text-decoration: none;
	color: WHITE}
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
		border-top=2px outset lightblue;
		border-bottom=2px inset lightblue;
		border-left=1px outset lightblue ;
		border-right=1px outset black;
		background:"#336699";
		color:"skyblue";
		}
	-->
	</style>
<%@ include file="../../../Includes/JSPs/misc/iMenuScript.jsp"%>

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
</head>
<body  onLoad=ezMakeMenus() topmargin = "2" leftmargin = "3" class="bodyclass" text="#FFFFFF" link="WHITE" vlink="WHITE" alink="#FFFFFF" bgcolor="#336699" topmargin="0">
<form name="msnForm" method="post">
 <%@ include file="../../../Includes/JSPs/misc/iMenu.jsp"%>
<input type="hidden" name="pageUrl">
</form>
</body>
</html>