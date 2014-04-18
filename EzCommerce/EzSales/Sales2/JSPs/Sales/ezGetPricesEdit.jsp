<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import="ezc.ezsap.*,java.util.*"%>
<%@ page import="ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%

	ezc.ezcommon.EzLog4j log4j = new ezc.ezcommon.EzLog4j();
	
	String reqDateStr	=request.getParameter("ReqDate");

	String SCDocNr 		=request.getParameter("refdoc");
	String webOrNo 		=request.getParameter("webOrNo");
	String PartnNum 	=request.getParameter("soldTo");
	String inDate 		=request.getParameter("orderDate");
	String PONO 		=request.getParameter("poNo");
	String PODate 		=request.getParameter("poDate");
	String GeneralNotes 	=request.getParameter("GeneralNotes");
	String Agent	    	=request.getParameter("agent");
	String ShipTo	    	=request.getParameter("shipTo");
	String IncoTerms1   	=request.getParameter("incoTerms1");
	String IncoTerms2   	=request.getParameter("incoTerms2");
	String PayementTerms	=request.getParameter("paymentTerms");
	String RefDocType   	=request.getParameter("refDocType");
	int TotalCount 	    	=Integer.parseInt(request.getParameter("total"));
	String docType 	    	=request.getParameter("docType");
        

        log4j.log("TotalCountTotalCount>>>>>>>>>>>>>"+TotalCount,"W");
        
	log4j.log("SCDocNrSCDocNr:"+SCDocNr+"-->"+webOrNo+"-->"+PartnNum+"-->"+inDate+"-->"+PONO+"-->"+PODate,"W");
	log4j.log("Agent:"+Agent+"-->"+ShipTo+"-->"+RefDocType+"-->"+docType,"W");
	
	System.out.println("SCDocNrSCDocNr:"+SCDocNr+"-->"+webOrNo+"-->"+PartnNum+"-->"+inDate+"-->"+PONO+"-->"+PODate);

	//docType = "ZOR";


	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	String defSoldTo 	=UtilManager.getUserDefErpSoldTo();
	String defSysKey	=(String) session.getValue("SalesAreaCode"); 

	log4j.log("defSoldTodefSoldTodefSoldTo::"+defSoldTo,"I");
	

	if(!defSoldTo.equals(PartnNum) )
		UtilManager.setSysKeyAndSoldTo(defSysKey,PartnNum);

	final int DATE 	= 1; 
	final int MONTH = 0 ; 
	final int YEAR 	= 2;
	
	EzcSalesOrderParams  ezcSalesOrderParams = new EzcSalesOrderParams();
	EzcSalesOrderParams  ezcSalesOrderParamsForSm = new EzcSalesOrderParams();

	// BAPI Parameters	
	EzBapisdheadStructure 	orderHeader = null;
	EzBapipartnrTable 	orderPartners =  null;
	EzBapipartnrTableRow 	aRow = null;
	EzBapiiteminTable 	iteminTable = null;
	EzBapiiteminTableRow 	aItemRow = null; 

	EziSalesOrderCreateParams ioParams = null;

	EzoSalesOrderCreate 	osmParams = null;
	ReturnObjFromRetrieve  	itemoutTable = null;
	

	FormatDate formatDate = new FormatDate();
	java.util.GregorianCalendar fromDate = null ; 
	java.util.GregorianCalendar deliveryDate = null ;
	java.util.GregorianCalendar reqDate = null ;
	java.util.GregorianCalendar reqDateH = null ;
	fromDate = (java.util.GregorianCalendar)java.util.GregorianCalendar.getInstance();	
 
	int dateReq 	= Integer.parseInt(inDate.substring(3,5));
	int monthReq 	= Integer.parseInt(inDate.substring(0,2));
	int yearReq 	= Integer.parseInt(inDate.substring(6,10));

	
	
	reqDateH = new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
	EzcSalesOrderParams initParams = new EzcSalesOrderParams();
	EziSalesOrderCreateParams initCreateParams = new EziSalesOrderCreateParams();
	initParams.setObject(initCreateParams);
	Session.prepareParams(initParams);
	ioParams = (EziSalesOrderCreateParams) EzSalesOrderManager.initializeSalesOrder(initParams);
       

	//Set values for OrderHeader 
	orderHeader = ioParams.getOrderHeaderIn(); 
	orderHeader.setDivision("");    // need to set "" because hard coded in initializeSalesOrder
	orderHeader.setDistrChan("");
	orderHeader.setSalesOrg("");
	
	orderHeader.setDocType(docType); 
	orderHeader.setPurchNo(PONO); 
	orderHeader.setPoSupplem("WWW"); 
	orderHeader.setReqDateH(reqDateH.getTime());
	orderHeader.setIncoterms1(IncoTerms1);
	orderHeader.setIncoterms2(IncoTerms2);
	orderHeader.setAgentCode((String)session.getValue("SAPPRDCODE"));

	//set values for partners
	
	orderPartners = ioParams.getOrderPartners();
	if(PartnNum !=null)
	{
		aRow = new EzBapipartnrTableRow();
		aRow.setPartnRole("AG"); //for sold to
		aRow.setPartnNumb(PartnNum);
		orderPartners.appendRow(aRow); 
	}
	System.out.println("**************************PartnNum"+PartnNum);

	if(ShipTo != null)
	{
		EzBapipartnrTableRow aRow2 = new EzBapipartnrTableRow();
		aRow2.setPartnNumb(PartnNum);
		aRow2.setPartnRole("WE"); //for ship to
		orderPartners.appendRow(aRow2);
	}
	System.out.println("**************************ShipTo"+ShipTo);

	//Set ordered items 
	iteminTable = ioParams.getOrderItemsIn(); 
	int j = 0;

    	java.math.BigDecimal bOrderQty = null;
	int bQty = 0;

	String matno_1[] 	= request.getParameterValues("product");
	String fmDate_1[] 	= request.getParameterValues("desiredDate");  
	String OrderQuantity_1[]= request.getParameterValues("desiredQty");
	String foc_1[] 		= request.getParameterValues("focVal");
	String custprodCode[] 	= request.getParameterValues("custprodCode");
	String itemListPrice[] 	= request.getParameterValues("itemListPrice");
	
	String matId[]  	= request.getParameterValues("matId");
	String mfrNr[]  	= request.getParameterValues("mfrNr");
	String eanupc[]  	= request.getParameterValues("EanUPC"); 
	
	
	

	Hashtable getValues = new Hashtable();
	Hashtable getPrices = new Hashtable();

        
	if(iteminTable.getRowCount() == 0) 
	{
		while ( j < TotalCount) 
		{				
			//String matno 		= matno_1[j];
			String matno 		= custprodCode[j];
			String fmDate 		= fmDate_1[j];
			String OrderQuantity 	= OrderQuantity_1[j];
			String foc 		= foc_1[j];	
		
			if(!OrderQuantity.equals(""))
			{
				bOrderQty  	= new java.math.BigDecimal(OrderQuantity);
				bQty 		= bOrderQty.intValue();
				bOrderQty 	= bOrderQty.multiply(new java.math.BigDecimal(Integer.toString(1000)));
				fmDate 		= fmDate.trim();
					
				dateReq 	= Integer.parseInt(fmDate.substring(3,5));
				monthReq	= Integer.parseInt(fmDate.substring(0,2));
				yearReq 	= Integer.parseInt(fmDate.substring(6,10));
		
				getValues.put(matId[j],OrderQuantity+","+fmDate+","+foc);
					
				reqDate 	= new java.util.GregorianCalendar(yearReq,monthReq-1,dateReq);
				aItemRow 	= new EzBapiiteminTableRow();
				aItemRow.setItmNumber(new java.math.BigInteger(String.valueOf((j+1)*10)));
				aItemRow.setMaterial(matno); 
				aItemRow.setBillDate(fromDate.getTime());
				aItemRow.setReqQty(bOrderQty.toBigInteger());
				aItemRow.setReqDate(reqDate.getTime());
				
				
				aItemRow.setEanUpc(eanupc[j]); 
				aItemRow.setMatExt(matno); 
				aItemRow.setMatlGroup(mfrNr[j]);  
				aItemRow.setBatch(matId[j]);   
				
				
				
				
				try{
					aItemRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(itemListPrice[j])/10));
					aItemRow.setCondType("PR00");   // "ZPR1" in AF    					

				}catch(Exception err){  
								
				}
 
				iteminTable.appendRow(aItemRow); 
			}// End If
				
			bOrderQty 	= null;
			reqDate 	= null;
			OrderQuantity 	= null;
			matno 		= null;
			fmDate		= null;
			j++;
		} // While Close		
	} // End If for Row Count 
		
	
	
	ioParams.setCreditChkFlag("Y");
	//ioParams.setType("RBPG");
	ezcSalesOrderParams.setObject(ioParams);
	EzBapischdlTable deliveryScheduleTable = new EzBapischdlTable();
	ioParams.setOrderDelSchedule(deliveryScheduleTable);
	Session.prepareParams(ezcSalesOrderParams);
	osmParams 	= (EzoSalesOrderCreate)EzSalesOrderManager.ezSimulateWebSalesOrder(ezcSalesOrderParams);
		
	itemoutTable 	= (ReturnObjFromRetrieve)osmParams.getOrderItemsOut();
	ReturnObjFromRetrieve messageTable = (ReturnObjFromRetrieve)osmParams.getMessageTable();
	ReturnObjFromRetrieve returnStruct = (ReturnObjFromRetrieve)osmParams.getReturn();
        
        
	String Currency = itemoutTable.getFieldValueString(0,"Currency");

	java.math.BigDecimal netValue =new java.math.BigDecimal("0"); 
	String prdNo ="";
	
	
	if(itemoutTable !=null)
	{
		if(itemoutTable.getRowCount()!=0)
		{
			String sapPCode = (String)session.getValue("SAPPRDCODE");
			
			for(int i=0;i<itemoutTable.getRowCount();i++)
			{
				String sapMat  = itemoutTable.getFieldValueString(i,"Material");
				String custMat = itemoutTable.getFieldValueString(i,"CustMat");
				String matIdT = itemoutTable.getFieldValueString(i,"MatId");
				
				if (custMat!=null && !"null".equals(custMat) && !"".equals(custMat.trim()))
					prdNo = custMat;
				else
				        prdNo = itemoutTable.getFieldValueString(i,"Material");
				        
				double obj = Double.parseDouble(itemoutTable.getFieldValueString(i,"NetValue1"))/Double.parseDouble( itemoutTable.getFieldValueString(i,"ReqQty") );
				
				if(sapMat!=null && !"null".equals(sapMat) && sapMat.equals(sapPCode))
				   	obj = Double.parseDouble(itemListPrice[i]);
				   
				getPrices.put(matIdT,String.valueOf(obj));
				
				String netValue1= itemoutTable.getFieldValueString(i,"NetValue1");
				String ItemCat =itemoutTable.getFieldValueString(i,"ItemCat");
				if(!("KLN").equals(ItemCat))
					netValue = netValue.add(new java.math.BigDecimal(netValue1));
			}
		}
	}
	String creditChk ="";
	if(messageTable !=null)
	{
		if(messageTable.getRowCount()!=0)
		{
			for(int i=0;i<messageTable.getRowCount();i++)
			{
				String crdtChk= messageTable.getFieldValueString(i,"MESSAGE_V4");

				if("CREDIT_CHECK".equals(crdtChk))
				{
					creditChk = "Yes";
				}
			}
		}
	}
	
	String mesg = "";
	if(returnStruct!=null && returnStruct.getRowCount()> 0)
	{
		for(int pc=0;pc<returnStruct.getRowCount();pc++)
		{
			if ((returnStruct.getFieldValue(pc,"Type")).equals("E"))
			{
				mesg=mesg+ returnStruct.getFieldValue(pc,"Message")+"<br>";
			}
		}
	}
	
	
	log4j.log("getPricesgetPricesgetPricesgetPrices:::"+getPrices,"W");
	log4j.log("itemoutTableitemoutTable:::"+itemoutTable.toEzcString(),"W");
	
	log4j.log("getPrices:::"+getPrices,"W");
	log4j.log("getValues:::"+getValues,"W");
	
        
	session.putValue("ITEMSOUT",itemoutTable);
	
	session.setAttribute("getPrices",getPrices);
	session.setAttribute("getValues",getValues);   
	String carrierName = request.getParameter("carrierName");
	
	carrierName = ("null".equals(carrierName)||carrierName==null)?"":carrierName;	
	
%>
<jsp:forward page="ezEditSales.jsp">
 	<jsp:param name="poNo" 		value="<%=PONO%>"/>
  	<jsp:param name="currency" 	value="<%=Currency%>"/>
	<jsp:param name="webOrNo" 	value="<%=webOrNo%>"/>
	<jsp:param name="confirm" 	value="confirm" />
	<jsp:param name="netValue" 	value="<%=netValue%>"/>
	<jsp:param name="sysKey" 	value="<%=defSysKey%>"/>
	<jsp:param name="reqDateStr" 	value="<%=reqDateStr%>"/>
	<jsp:param name="creditChk" 	value="<%=creditChk%>"/>
	<jsp:param name="carrierName" 	value="<%=carrierName%>"/> 
	<jsp:param name="mesg" 	value="<%=mesg%>"/> 

</jsp:forward>
<Div id="MenuSol"></Div>
 