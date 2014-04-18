<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>
<%
		String toFile = request.getParameter("urlString");
		String fromDate=request.getParameter("FromDate");
		String toDate=request.getParameter("ToDate");
		String fromForm=request.getParameter("FromForm");
		String RefDocType=request.getParameter("RefDocType");
		String datesFlag=request.getParameter("DatesFlag");
 		String monthOpt= request.getParameter("ezMonths");
 		String bkpflg  = request.getParameter("bkpflg");
 		
		if("ViewCart".equals(request.getParameter("urlPage")))
		{
			String strTcount =  request.getParameter("TotalCount");

			int totCount =0;
			if ( strTcount != null )
			{
				 totCount = Integer.parseInt(strTcount);
			}

			String [] products = new String[totCount];
			String [] reqQtys  = new String[totCount];
			String [] reqDates = new String[totCount];
			String [] venCatalogs = new String[totCount];
			String [] matIds = new String[totCount];

			for(int i=0;i<totCount;i++)
			{

				products[i] = request.getParameter("Product_"+i);
				reqQtys[i] = request.getParameter("Quantity_"+i);
				if((reqQtys[i].trim().length()==0)||(reqQtys[i]==null))
				reqQtys[i]="0";
				reqDates[i] = request.getParameter("Reqdate_"+i);
				if((reqDates[i].trim().length()==0)||(reqDates[i]==null))
				reqDates[i]="1.11.1000";
				venCatalogs[i]=request.getParameter("VendCatalog_"+i);
				matIds[i]     =request.getParameter("matId_"+i); 
			}

			 EziReqParams reqparams = new EziReqParams();
	   		 EziShoppingCartParams subparams = new EziShoppingCartParams();
			 EzcShoppingCartParams params1 = new EzcShoppingCartParams();

			 reqparams.setProducts(products);
      	       		 reqparams.setReqDate(reqDates);
     			 reqparams.setReqQty(reqQtys);
                         reqparams.setVendorCatalogs(venCatalogs);
                         reqparams.setMatId(matIds);
			               
	      		 subparams.setType("AF");
     			 subparams.setLanguage("EN");
	     		 subparams.setEziReqParams(reqparams);
     			 subparams.setObject(reqparams);

	     		 params1.setObject(subparams);
     			 Session.prepareParams(params1);
			try{
			SCManager.updateCart(params1);
			}catch(Exception e){}

		}
		String BackOrder	= request.getParameter("BackOrder");
		String soldTo 		= request.getParameter("soldTo");
		String fromDetails 	= request.getParameter("fromDetails");
		String fromCart 	= request.getParameter("fromCart");
		String pageFlg 	        = request.getParameter("pageFlg");
		String frameFlg 	= request.getParameter("frameFlg");
		
		if("../Sales/ezAddSCOrder.jsp".equals(toFile))
				toFile = "../Sales/ezAddSCOrder.jsp?RefDocType=S";
			else if("../Sales/ezAddSalesSh.jsp".equals(toFile))
			{
				
				if(BackOrder!=null && !"null".equals(BackOrder) && !"".equals(BackOrder.trim()) && "Y".equals(BackOrder.trim()))
					toFile = "../Sales/ezAddSalesSh.jsp?RefDocType=P&shop=shop&BackOrder=Y&soldTo="+soldTo+"&fromDetails="+fromDetails;
				else if(fromCart!=null && !"null".equals(fromCart) && !"".equals(fromCart.trim()) && "Y".equals(fromCart.trim()))
					toFile = "../Sales/ezAddSalesSh.jsp?RefDocType=P&shop=shop&fromCart=Y&pageFlg="+pageFlg+"&frameFlg="+frameFlg;
				else	
					toFile = "../Sales/ezAddSalesSh.jsp?RefDocType=P&shop=shop";
				
			}	
		if("../Sales/ezBackEndClosedSOList.jsp".equals(toFile))
		{
			if((fromDate != null)&&(toDate != null)&&(fromForm != null))
			{
				toFile=toFile+"?FromDate="+fromDate+"&ToDate="+toDate+"&FromForm="+fromForm+"&RefDocType="+RefDocType+"&DatesFlag="+datesFlag+"&ezMonths="+monthOpt;
			}else
				toFile=toFile+"?RefDocType="+RefDocType;

		}

		if("../Sales/ezClosedInvoices.jsp".equals(toFile))
		{
			if((fromDate != null)&&(toDate != null)&&(fromForm != null))
			{
				toFile=toFile+"?FromDate="+ fromDate +"&ToDate=" + toDate + "&FromForm=" + fromForm+"&ezMonths="+monthOpt+"&DatesFlag="+datesFlag;
			}
		}
%>
	function fun1()
	{
		document.body.style.cursor='wait'
		document.location.replace("<%=toFile%>");
	}
</script>
</head>
<body  onLoad="fun1()" onContextMenu="return  false" scroll=no>
<br><br><br><br>
<center><img src="../../Images/Buttons/<%= ButtonDir%>/pleasewait.gif"></center>
<Div id="MenuSol"></Div> 
</body>
</html>
