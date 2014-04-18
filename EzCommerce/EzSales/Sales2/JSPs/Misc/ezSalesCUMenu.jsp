<%@ include file="../../../Includes/JSPs/Lables/iSalesMenu_Lables.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iSalesMenuOptions_Lables.jsp" %>
<%@ page import="java.util.*" %>
<html>
<head>
	<base target="display">
	<%@ include file="../../../Includes/Lib/ezAddMenuDir.jsp"%>   
	<script>
	var EZ_NoOfMenusToBuild=6
	</script>

<%@ include file="../../../Includes/JSPs/Misc/iSalesCUMenuScript.jsp"%>   
<script src="../../Library/JavaScript/Misc/EZ_VEND_MENU_SCRIPT.js"></script>    
 
<script>
var EzHideAll=0
	function ezMouseOver1(mDivId,left)  
	{
		/*parent.frames.display.scroll(0,0)
		if(EzPrevOver1 != mDivId)
		{	
			ezHideAll()
		}
		EzPrevOver1=mDivId; 
		ezShowMenu(mDivId,left+"%",0,-1)*/  
		 
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
	//window.onerror=backToNoError

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
<body  onLoad="ezMakeMenus()" topmargin = "0" leftmargin = "0" class=menubgcolor>
<form name="msnForm" method="post">
 <%@ include file="../../../Includes/JSPs/Misc/iSalesCUMenu.jsp"%>                  
</form>
<Div id="MenuSol"></Div>
</body>
</html>
