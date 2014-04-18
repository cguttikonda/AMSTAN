
<%@ page import="ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%
	EzShoppingCartManager SCManager = new EzShoppingCartManager(Session);

	String categoryID  =  request.getParameter("categoryID");
	String lineNo 	   =  request.getParameter("lineNo");
 
	String poItems[] = request.getParameterValues("CheckBox1");

	int poItemsLen = 0;

	if(poItems!=null)
		poItemsLen = poItems.length;

	EzcShoppingCartParams params1 = new EzcShoppingCartParams();
	EziReqParams reqparams1 = new EziReqParams();
	EziShoppingCartParams subparams1 = new EziShoppingCartParams();

	String[] products1 	= new String[poItemsLen];
	String[] reqQtys1  	= new String[poItemsLen];
	String[] reqDates1 	= new String[poItemsLen];
	String[] vendCatalogs1 	= new String[poItemsLen];
	String[] matIds1 	= new String[poItemsLen];

	if(poItemsLen > 0)
	{
		for(int i=0;i<poItemsLen;i++)
		{
			String poItemStr = poItems[i];

			products1[i]	 = request.getParameter("lineItem_"+poItemStr);
			reqQtys1[i] 	 = request.getParameter("reqQty_"+poItemStr);
			reqDates1[i] 	 = "1.11.1000";
			vendCatalogs1[i] = request.getParameter("venCat_"+poItemStr);
			matIds1[i] 	 = request.getParameter("matId_"+poItemStr);
			lineNo 		 = poItemStr;
%>
<%@include file="../../../Includes/JSPs/Misc/iPointsAlertsRemove.jsp"%>
<%
		}

		reqparams1.setProducts(products1);
		reqparams1.setReqDate(reqDates1);
		reqparams1.setReqQty(reqQtys1);
		reqparams1.setVendorCatalogs(vendCatalogs1);
		reqparams1.setMatId(matIds1);

		subparams1.setType("CNET");
		subparams1.setLanguage("EN");
		
		subparams1.setEziReqParams(reqparams1);
		subparams1.setObject(reqparams1);

		params1.setObject(subparams1);

		Session.prepareParams(params1);

		Object retObj = SCManager.deleteCartElement(params1);
		Object retObj1 = SCManager.deletePersistentCartElement(params1);
	}
	response.sendRedirect("ezViewCart.jsp");
%>
<!--<html>
<head>
<script type="text/javascript">
	function onLoad()
	{
		document.myForm.action="ezViewCart.jsp";
		document.myForm.submit();
	}
</script>
</head>
<body onLoad="onLoad();">
<form name="myForm" method="post">
<input type="hidden" name="categoryID" value="<%//=categoryID%>">
</form>
</body>
</html>-->