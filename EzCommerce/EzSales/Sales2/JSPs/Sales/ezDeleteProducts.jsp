<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>

<%
	ezc.ezcommon.EzLog4j log = new ezc.ezcommon.EzLog4j(); 

	String product 		= null;
	String quantity 	= null;
	String reqdate 		= null;
	String pProductNumber 	= null;
	String pQuantity	= null;
	String pReqDate 	= null;

	String [] products 	= null;
	String [] reqQtys  	= null;
	String [] reqDates 	= null;
	
	products	= request.getParameterValues("product");
	reqQtys		= request.getParameterValues("desiredQty");
	reqDates	= request.getParameterValues("desiredDate");
	
	for(int i=0;i<reqQtys.length;i++)
		log.log("reqQtysreqQtysreqQtys::"+products[i]+"-->"+reqQtys[i]+"-->"+reqDates[i]+"-->"+products.length,"W");
	
	String poNo		= request.getParameter("poNo");
	String poDate		= request.getParameter("poDate");
	String shipTo		= request.getParameter("shipTo");
	String soldTo 		= request.getParameter("soldTo");
	String shipToName	= request.getParameter("shipToName");
	String soldToName	= request.getParameter("soldToName");
	String requiredDate	= request.getParameter("requiredDate");
	String carrierName	= request.getParameter("carrierName");
	String orderDate	= request.getParameter("orderDate");
	String ProductGroup	= request.getParameter("ProductGroup");



	String [] productsForDel= null;
	String [] reqQtysForDel = null;
	String [] reqDatesForDel= null;
	String [] products1 	= new String[products.length];
	String [] reqQtys1  	= new String[products.length];

	
	
	String strTcount= request.getParameter("total");
	String pDelFlag = request.getParameter("DelFlag");

	productsForDel	= request.getParameterValues("prodsForDelete");
	reqQtysForDel	= request.getParameterValues("qtysForDelete");
	reqDatesForDel	= request.getParameterValues("datesForDelete");
	
	if ( strTcount != null )
	{
		int totCount = (new Integer(strTcount)).intValue();
		int selCount =  0;

		EzcShoppingCartParams params1 = new EzcShoppingCartParams();
		EziReqParams reqparams = new EziReqParams();
		EziShoppingCartParams subparams = new EziShoppingCartParams();
		reqparams.setProducts(productsForDel);
		reqparams.setReqDate(reqDatesForDel);
		reqparams.setReqQty(reqQtysForDel);
		subparams.setLanguage("EN");
		subparams.setEziReqParams(reqparams);
		subparams.setObject(reqparams);
		params1.setObject(subparams);
		Session.prepareParams(params1);

		if (pDelFlag.charAt(0) == 'N')
		{

			Object retObj = SCManager.updateCart(params1);
		}else
		{
			Object retObj = SCManager.deleteCartElement(params1);
		}
		pProductNumber 	= null;
		pQuantity	= null;
		pReqDate  	= null;
	}
	
	
	java.util.List prodList = java.util.Arrays.asList(productsForDel);
	int count = 0;
	String reqDt = "";
	for(int i=0;i<products.length;i++)
	{
		if(prodList.contains(products[i]))
			continue;
			
				
		
		reqDt = reqQtys[i];
		
		if("null".equals(reqDt) || reqDt==null)
			reqDt = "";
		products1[count] = products[i];
		reqQtys1[count]	 = reqDt;
		
		log.log("BaluBaluBaluBaluBalu:products1::"+products1[count]+"-->"+reqQtys1[count],"W");		
		
		count++;
	}
	
	log.log("BaluBaluBaluBaluBalu shipToNameshipToName:"+shipToName,"W");
		
	response.sendRedirect("ezAddSalesOrder.jsp?soldTo="+soldTo+"&prodCode="+products1+"&prodQty="+reqQtys1+"&oldprodCode="+products1+"&poNo="+poNo+"&poDate="+poDate+"&shipTo="+shipTo+"&shipToName="+shipToName+"&soldToName="+soldToName+"&requiredDate="+requiredDate+"&carrierName="+carrierName+"&orderDate="+orderDate+"&pageFlag=Y"+"&ProductGroup="+ProductGroup);	
%>

