
<html>
<head>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iAddCart.jsp"%>  
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

<%

	String back = request.getParameter("back");

// Call the ezViewCart.jsp for showing the Shopping Cart
if("ezCatalogFinalLevel.jsp".equalsIgnoreCase(from))
{%>
	<script>
	function fun(){

		document.myForm.action="../BusinessCatalog/ezCatalogFinalLevel.jsp";
		//document.myForm.action="../DrillDownCatalog/ezCatalogFinalLevel.jsp";
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
				document.myForm.action="../BusinessCatalog/ezFavGroupFinalLevel.jsp";
				document.myForm.submit();
			}
		</script>
<%
	}else
		response.sendRedirect("../ShoppingCart/ezViewCart.jsp?back="+back); 
}

%>
</head>
<body onLoad=fun()>
<form name=myForm>
<br><br>
<input type=hidden name="back" value="<%=back%>">

<input type=hidden name="ProductGroup" value="<%=ProductGroup%>">
<input type=hidden name=CatalogDescription  value="<%=CatalogDescription%>">
<input type=hidden name=GroupLevel value="1">
<input type=hidden name="GroupDesc" value="<%=groupDesc%>">
<input type=hidden name="chkString" value="<%=chkString%>">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
