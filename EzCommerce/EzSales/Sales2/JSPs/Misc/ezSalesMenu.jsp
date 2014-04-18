
<%@ include file="../../../Includes/JSPs/Lables/iSalesMenu_Lables.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iSalesMenuOptions_Lables.jsp" %>
<html>
<head>
	<base target="display">
	<%@ include file="../../../Includes/Lib/ezAddMenuDir.jsp"%>
<%
	String urlByRole="";
	String role	=(String)session.getValue("UserRole");
	String backRole	=(String)session.getValue("UserRole1");
%>
<script>
	var userroles = '<%=role%>';
</script>
<script src="../../Library/JavaScript/Misc/EZ_XML_MENU_SCRIPT.js"></script>
<script>
	function ezMouseOver1(mDivId,left)
	{
		parent.frames.display.scroll(0,0)
		if(EzPrevOver1 != mDivId)
			ezHideAll()
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
<body  topmargin = "0" leftmargin = "0" class=menubgcolor>
<form name="msnForm" method="post">
<% 
	if("CU".equals(role))
	{
%>		<%@ include file="../../../Includes/JSPs/Misc/iSalesCUMenu.jsp"%>
<%	}else if("CM".equals(role))
	{
%>		<%@ include file="../../../Includes/JSPs/Misc/iSalesCUMenu.jsp"%>
<%	}else
	{
%>		<%@ include file="../../../Includes/JSPs/Misc/iSalesCUMenu.jsp"%>
<%	}
%>

</form>
<Div id="MenuSol"></Div>
</body>
</html>

