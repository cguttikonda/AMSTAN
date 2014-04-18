<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iGetMaterials.jsp" %>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iViewCart.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iCheckCart_Lables.jsp"%>
<html>
<title>ezViewCart</title>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>
<body>
<form name="myForm" method="post">
<%
String minQ;
String proQty;
String desc;
String tot;
int cartRows = Cart.getRowCount();
if ((cartRows > 0)&&(Cart != null))
{
	for ( int i = 0 ; i < cartRows ; i++ )
	{
		minQ =(String)Cart.getMaterialNumber(i);

		double proQty1=0;
		 proQty=(String)Cart.getOrderQty(i);


		 desc =(String)Cart.getMaterialDesc(i);
		desc=desc.replace('\'','`');

		 tot = minQ+","+desc+","+"EA";
%>

	<input type="hidden" name="prodCode" value="+tot+">
	<input type="hidden" name="prodQty" value="+proQty+">
	<input type="hidden" name="oldprodCode" value="+minQ+">
		<input type="hidden" name="soldTo" value="0010006806">

	
	
		

	tot=<%=tot%>
	Qty=<%=proQty%>
	matno = <%=minQ%>


<%	}

}
%>
<script>
	document.myForm.action="ezAddSalesOrder.jsp"
	document.myForm.submit()
</script>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
