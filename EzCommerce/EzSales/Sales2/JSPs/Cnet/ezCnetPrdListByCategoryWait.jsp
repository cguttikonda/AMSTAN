<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%
	String categoryID = request.getParameter("categoryID");
	String categoryDesc = request.getParameter("categoryDesc");
	String STYPE = request.getParameter("STYPE");
	String atrvalstr = request.getParameter("atrvalstr");
	String pageSize = request.getParameter("pageSize");
	String ProdDesc1 = request.getParameter("ProdDesc1");
	
	String mfrID = request.getParameter("mfrID");
	String mfrDesc = request.getParameter("mfrDesc");
	String pgSizeCh = request.getParameter("pgSizeCh");
	String pageNum = request.getParameter("pageNum");
	String retCatCnt = request.getParameter("retCatCnt");

%>
<html>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>

	function fun1()
	{
		document.body.style.cursor='wait'
		document.myForm.action = "ezCnetPrdListByCategory.jsp"
		document.myForm.submit();
	}
</script>
</head>
<body  onLoad="fun1()" onContextMenu="return  false" scroll=no>
<form name="myForm" method="post">
<input type="hidden" name="categoryID" value="<%=categoryID%>">
<input type="hidden" name="categoryDesc" value="<%=categoryDesc%>">
<input type="hidden" name="STYPE" value="<%=STYPE%>">
<input type="hidden" name="atrvalstr" value="<%=atrvalstr%>">
<input type="hidden" name="pageSize" value="<%=pageSize%>">
<input type="hidden" name="ProdDesc1" value="<%=ProdDesc1%>">
<input type="hidden" name="mfrID" value="<%=mfrID%>">
<input type="hidden" name="mfrDesc" value="<%=mfrDesc%>">
<input type="hidden" name="pgSizeCh" value="<%=pgSizeCh%>">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
<input type="hidden" name="retCatCnt" value="<%=retCatCnt%>">
<br><br><br><br>
<center><img src="../../Images/Buttons/<%= ButtonDir%>/pleasewait.gif"></center>
</form>
<Div id="MenuSol"></Div> 
</body>
</html>

