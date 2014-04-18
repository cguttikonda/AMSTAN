
<html>
<head>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iAddCart.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

<%
// Call the ezViewCart.jsp for showing the Shopping Cart
if("ezCatalogFinalLevel.jsp".equalsIgnoreCase(from))
{%>
	<script>
	function fun(){

		//document.myForm.action="ezCatalogFinalLevel.jsp";
		document.myForm.action="../DrillDownCatalog/ezCatalogFinalLevel.jsp";
		document.myForm.submit();
	}
	</script>
<%}else
{
	if("ezFavGroupFinalLevel.jsp".equalsIgnoreCase(from))
	{
%>
		<script>
			function fun(){
				document.myForm.action="../DrillDownCatalog/ezFavGroupFinalLevel.jsp";
				document.myForm.submit();
			}
		</script>
<%
	}else
		response.sendRedirect("ezViewCart.jsp");
}
	String pst = request.getParameter("produm");

%>
</head>
<body onLoad=fun()>
<form name=myForm>
<br><br>

<input type=hidden name="produm" value="<%=pst%>">
	
<input type=hidden name="ProductGroup" value="<%=ProductGroup%>">
<input type=hidden name=CatalogDescription  value="<%=CatalogDescription%>">
<input type=hidden name=GroupLevel value="1">
<input type=hidden name="GroupDesc" value="<%=groupDesc%>">
<input type=hidden name="chkString" value="<%=chkString%>">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
