<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%
	String categoryID = request.getParameter("categoryID");
	String categoryDesc = request.getParameter("categoryDesc");
	String STYPE = request.getParameter("STYPE");
	String atrvalstr = request.getParameter("atrvalstr");

%>
<html>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>

	function fun1()
	{
		document.body.style.cursor='wait'
		document.myForm.action = "ezCnetCategoryAttr.jsp"
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
<br><br><br><br>
<center><img src="../../Images/Buttons/<%= ButtonDir%>/pleasewait.gif"></center>
</form>
<Div id="MenuSol"></Div> 
</body>
</html>
