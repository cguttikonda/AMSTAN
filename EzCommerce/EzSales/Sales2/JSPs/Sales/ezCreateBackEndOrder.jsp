<html>
<head>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iCreateBackEndOrder.jsp"%>  
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>
<body>
<form name=myForm method="post">

<%
	EzShoppingCart Cart = null;
	
	// Get The Whole Shopping Cart
	      EzcShoppingCartParams params = new EzcShoppingCartParams();
	      EziShoppingCartParams subparams = new EziShoppingCartParams();
	      subparams.setLanguage("EN");
	      params.setObject(subparams);
	      Session.prepareParams(params);
	      Cart = (EzShoppingCart)SCManager.getSavedCart(params);
	//END

	int cartRows  = Cart.getRowCount(); 
%>

<input type="hidden" name="TotalCount" 	value="<%=cartRows%>" >


<%
String proQty = "";
for ( int i = 0 ; i < cartRows ; i++ )
{
	proQty=(String)Cart.getOrderQty(i);
	try
	{
		proQty = String.valueOf(Double.parseDouble(proQty));
		proQty = proQty.substring(0,proQty.indexOf('.'));
	}
	catch(Exception ee)
	{ 
	
	}
%>
	<input type="hidden" name="Product_<%=i%>" size="18" value="<%=Cart.getMaterialNumber(i)%>">
	<input type="hidden" name="Quantity_<%=i%>" value="<%=proQty%>" >
	<input type="hidden" readonly name="Reqdate_<%=i%>" value="1.11.1000">

<%

}
%>

<input type="hidden" name="BackOrder" value="Y">
<input type="hidden"  name="soldTo" value='<%=request.getParameter("soldTo")%>'>
<input type="hidden"  name="urlString" value="../Sales/ezAddSalesSh.jsp">
<input type="hidden"  name="fromDetails" value='<%=request.getParameter("fromDetails")%>'>


<script>
	document.myForm.action ="../Misc/ezListWait.jsp";
	document.myForm.submit();
</script>
</form>
<Div id="MenuSol"></Div>
</body>
</html>