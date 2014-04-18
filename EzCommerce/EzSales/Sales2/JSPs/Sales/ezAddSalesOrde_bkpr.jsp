<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file="../../../Includes/JSPs/Sales/iGetShoppingCart.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />

<%
	// this part of code is to check if valid user
	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	String defSoldTo = UtilManager.getUserDefErpSoldTo();
	String SoldTo	 = request.getParameter("soldTo");
	   	
	if(!SoldTo.equals(defSoldTo))
		response.sendRedirect("ezGeneralError.jsp");
	// end of check of valid user

	// this part of code is to delete the products from cart in any
	params 		= new EzcShoppingCartParams();
	subparams 	= new EziShoppingCartParams();
	EziReqParams reqparams= new EziReqParams();
	if(Cart!=null)
	{
		String [] dproducts = new String[Cart.getRowCount()];
		String [] dreqQtys  = new String[Cart.getRowCount()];
		String [] dreqDates = new String[Cart.getRowCount()];
		for(int i=0;i<Cart.getRowCount();i++)
		{
	 		dproducts[i]	=Cart.getMaterialNumber(i);
			dreqQtys[i]	=Cart.getOrderQty(i);
	 		dreqDates[i]	=Cart.getReqDate(i);
		}
	        reqparams.setProducts(dproducts);
                reqparams.setReqDate(dreqDates);
                reqparams.setReqQty(dreqQtys);
                subparams.setLanguage("EN");
                subparams.setEziReqParams(reqparams);
                subparams.setObject(reqparams);
                params.setObject(subparams);
                Session.prepareParams(params);
                Object retObjDelete = SCManager.deleteCartElement(params); 
	}
	// end of deletion

  	String[] p  = request.getParameterValues("prodCode");
  	String[] op = request.getParameterValues("oldprodCode");
	String[] PQ = request.getParameterValues("prodQty");
	
	String[] prodCode = new String[p.length];
    	String[] prodDate = new String[p.length];
	String[] prodQty  = new String[p.length];
	
	for(int i=0;i<p.length;i++)
	{
		prodCode[i] = p[i];//.substring(0,p[i].indexOf(",")); 
		prodDate[i] ="1.11.1000"; // what ever format it is pls don't delete it,as it reflects in more than one place
		if(PQ != null && op != null) // if old prodcode and old prod qty that comes on clicking back != null
		{
			for(int j=0;j<op.length;j++)
			{	
				if(prodCode[i].equals(op[j]))
				{
					prodQty[i] =PQ[j];
				}
			}
			if(prodQty[i]==null || "null".equals(prodQty[i]) || prodQty[i].trim().length() ==0)
				prodQty[i] ="0";
		}
		else
			prodQty[i] ="0";	
	}
	params 	  = new EzcShoppingCartParams();
        subparams = new EziShoppingCartParams();
	reqparams = new EziReqParams();

	reqparams.setProducts(prodCode);
        reqparams.setReqDate(prodDate);
	reqparams.setReqQty(prodQty);

	subparams.setEziReqParams(reqparams);
	params.setObject(subparams);
	Session.prepareParams(params);
	try{
		SCManager.saveCart(params);
	}catch(Exception e){}
		
	if(session.getAttribute("getprices")!=null)
	{
		session.removeAttribute("getprices");
	}
	if(session.getAttribute("getValues") != null)
	{
		session.removeAttribute("getValues");
	}
%>
<jsp:forward page="ezPlaceOrder.jsp">
	<jsp:param name="from"    value="ezAddSales"/>
	<jsp:param name="pageUrl" value="ezAddSales"/>
</jsp:forward>