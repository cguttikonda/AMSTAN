<%@ page import="ezc.ezutil.*" %>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="ezGetProductInfo.jsp"%>
<%
	//out.println("11111");
	EzShoppingCartManager SCManager = new EzShoppingCartManager(Session);

	String categoryID  =  request.getParameter("categoryID");
	String cartRows = request.getParameter("cartRows");

	if(cartRows!=null)
	{
		int totCount = (new Integer(cartRows)).intValue();

		String[] products1 	= new String[totCount];
		String[] reqQtys1  	= new String[totCount];
		String[] reqDates1 	= new String[totCount];
		String[] vendCatalogs1 	= new String[totCount];
		String[] matIds1 	= new String[totCount];
		String[] brand	 	= new String[totCount];

		String[] prodSku 	= new String[totCount];
		String[] poLine 	= new String[totCount];
		String[] dispProd 	= new String[totCount];
		String[] vipProd 	= new String[totCount];

		String[] cat2	 	= new String[totCount];
		String[] cat3	 	= new String[totCount];
		String[] reftype 	= new String[totCount];

		String[] division 	= new String[totCount];
		String[] distChnl 	= new String[totCount];
		String[] salesOrg 	= new String[totCount];
		String[] ordType 	= new String[totCount];
		String[] volume_A	= new String[totCount];
		String[] points_A	= new String[totCount];
		String[] plant_A	= new String[totCount];
		String[] kitComp_A	= new String[totCount];
		String[] ext1		= new String[totCount];
		String[] ext2		= new String[totCount];
		String[] ext3		= new String[totCount];

		session.removeValue("Faucets(incl. Flush Valves)-Non Luxury");
		session.removeValue("Faucets(incl. Flush Valves)-Luxury"); 
		session.removeValue("Chinaware"); 
		session.removeValue("Americast & Acrylics (Excludes Acrylux)"); 
		session.removeValue("Acrylux");
		session.removeValue("Enamel Steel"); 
		session.removeValue("Marble"); 
		session.removeValue("Shower Doors-Standard"); 
		session.removeValue("Shower Doors-Custom"); 
		session.removeValue("Walk In Baths"); 
		session.removeValue("Repair Parts"); 
		session.removeValue("JADO"); 
		session.removeValue("FIAT");

		for(int i=0;i<totCount;i++)
		{
			products1[i]	 = request.getParameter("lineItem_"+i);
			reqQtys1[i] 	 = request.getParameter("cartQty_"+i);
			reqDates1[i] 	 = "1.11.1000";
			vendCatalogs1[i] = request.getParameter("venCat_"+i);
			matIds1[i] 	 = request.getParameter("matId_"+i);

			prodSku[i]	 = request.getParameter("prodSku_"+i);
			poLine[i]	 = request.getParameter("poLine_"+i);

			salesOrg[i]	= request.getParameter("salesOrg_"+i);
			division[i]	= request.getParameter("division_"+i);
			distChnl[i]	= request.getParameter("distChnl_"+i);
			ordType[i]	= request.getParameter("ordType_"+i);

			String prodCode = request.getParameter("matId_"+i);
			String quantity = request.getParameter("cartQty_"+i);
			String sOrg_C = request.getParameter("salesOrg_"+i);
			String div_C = request.getParameter("division_"+i);
			String dChnl_C = (String)session.getValue("dc");;//request.getParameter("distChnl_"+i);
			String oType_C = "OR";//request.getParameter("ordType_"+i);
			String dispVipProd = request.getParameter("dispVipProd_"+i);
			String totJobQua = request.getParameter("totJobQua_"+i);
			String prodAttr = request.getParameter("prodAttr_"+i);
			//out.println(" In Update Cart Items : "+dispVipProd);
%>
<%@include file="../../../Includes/JSPs/Misc/iPointsAlerts.jsp"%>

<%
			try
			{
				//out.println("2222");
				String fileName = "ezUpdateCartItems.jsp";
				String filePath = request.getRealPath(fileName);
				String returnValue = "";
				if(dispVipProd!=null && "FOC".equals(dispVipProd)) {
				// Distribution Channel is 70 for all FOC Orders
					returnValue = getProductInfo(Session,prodCode,sOrg_C,div_C,"70",oType_C,fileName,filePath);
				} else {
					returnValue = getProductInfo(Session,prodCode,sOrg_C,div_C,dChnl_C,oType_C,fileName,filePath);
				}
				
				//out.println("returnValue::"+returnValue);

				salesOrg[i] = returnValue.split("¥")[0];
				division[i] = returnValue.split("¥")[1];
				distChnl[i] = returnValue.split("¥")[2];
				ordType[i]  = returnValue.split("¥")[3];
				brand[i]    = returnValue.split("¥")[4];	// setting plant
				cat2[i]     = returnValue.split("¥")[5];	// setting material division
				plant_A[i]  = returnValue.split("¥")[6];	// getting material plant not sure of above plant at [4]
			}
			catch(Exception e){}

			if(prodSku[i]==null || "null".equalsIgnoreCase(prodSku[i]) || "".equals(prodSku[i])) prodSku[i] = "N/A";
			if(poLine[i]==null || "null".equalsIgnoreCase(poLine[i]) || "".equals(poLine[i])) poLine[i] = "N/A";

			if(dispVipProd!=null && "DISP".equals(dispVipProd))
				dispProd[i] = "DISP";
			else if(dispVipProd!=null && "VIP".equals(dispVipProd))
				dispProd[i] = "VIP";
			else if(dispVipProd!=null && "FOC".equals(dispVipProd))
				dispProd[i] = "FOC";
			else if(dispVipProd!=null && "QS".equals(dispVipProd))
				dispProd[i] = "QS";
			else if(dispVipProd!=null && "CS".equals(dispVipProd))
				dispProd[i] = "CS";
			else if(dispVipProd==null || (dispVipProd.equals("N/A")))
				dispProd[i] = "N/A";
				
			//cat2[i]		= "N/A";
			cat3[i]		= "N/A";
			reftype[i]	= "N/A";
			kitComp_A[i]	= compItems_A;	//num of kit components
			ext1[i]		= classType;	//this is for classification, LUX for luxury, COM for commercial
			ext2[i]		= totJobQua;	// Total Job Quantity
			ext3[i]		= prodAttr;	// Product Attribute

			//out.println("33333");
			if("DISP".equals(dispProd[i]))
			{
				if("ZIDS".equals(ordType[i]))
					ordType[i] = "ZIDP";
				else
					ordType[i] = "ZDPO";
			}
			else if("VIP".equals(dispProd[i]))
			{
				ordType[i] = "ZDPO";
			}
			else if("QS".equals(dispProd[i]))
			{
				ordType[i] = "Z1";
			}
			//else if("QS".equals(reftype[i]))	//used for quick ship items
				//ordType[i] = "Z1";
			else if("FOC".equals(dispProd[i]))
			{
				distChnl[i] = "70";

				if("24".equals(plant_A[i]) || "956".equals(plant_A[i]) || "167".equals(plant_A[i]))//(ordType[i]).startsWith("ZIS"))
					ordType[i] = "ZIDF";
				else
					ordType[i] = "FD";
			}

			if("20".equals(distChnl[i]))
			{
				if("ZDPO".equals(ordType[i]))
					ordType[i] = "Z28";
			}
			/* Commented on 8/20/2012 on Sam's request fro E-Tail */
			/**
			else if("90".equals(distChnl[i]))
			{
				ordType[i] = "Z1";
			}
			*/
			/* End of Commented on 8/20/2012 on Sam's request fro E-Tail */
			volume_A[i]	= volume;
			points_A[i]	= points;

			//out.println("::"+prodSku[i]+"::");
			//out.println("::"+poLine[i]+"::");
			//out.println("::"+dispProd[i]+"::");
			//out.println("::"+vipProd[i]+"::");
		}

		EzcShoppingCartParams params1 = new EzcShoppingCartParams();
		EziReqParams reqparams1 = new EziReqParams();
		EziShoppingCartParams subparams1 = new EziShoppingCartParams();

		reqparams1.setProducts(products1);
		reqparams1.setReqDate(reqDates1);
		reqparams1.setReqQty(reqQtys1);
		reqparams1.setVendorCatalogs(vendCatalogs1);
		reqparams1.setMatId(matIds1);

		reqparams1.setCat1(dispProd);
		reqparams1.setCat2(cat2);
		reqparams1.setCat3(cat3);
		reqparams1.setCustSku(prodSku);
		reqparams1.setPoLine(poLine);
		reqparams1.setType(dispProd);//reftype

		reqparams1.setBrand(brand);
		reqparams1.setDivision(division);
		reqparams1.setDistChnl(distChnl);
		reqparams1.setSalesOrg(salesOrg);
		reqparams1.setOrdType(ordType);
		reqparams1.setVolume(volume_A);
		reqparams1.setPoints(points_A);
		reqparams1.setKitComp(kitComp_A);
		reqparams1.setExt1(ext1);
		reqparams1.setExt2(ext2);
		reqparams1.setExt3(ext3);

		subparams1.setType("AF");
		subparams1.setLanguage("EN");
		subparams1.setEziReqParams(reqparams1);
		subparams1.setObject(reqparams1);

		params1.setObject(subparams1);
		
		Session.prepareParams(params1);

		Object retObj = SCManager.updateCart(params1);
		Object retObj1 = SCManager.updatePersistentCart(params1);
		
	}
	//out.println("44444");
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