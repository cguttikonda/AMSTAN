<%@ page import="ezc.ezparam.*,ezc.ezsap.*,ezc.client.*"%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*,java.text.*" %>
<%
	if(session.getValue("EzDeliveryLines")!= null)
	{
		session.removeValue("EzDeliveryLines");
	}
	if(session.getAttribute("getprices") != null)
	{
		session.removeAttribute("getprices");
	}
	if(session.getAttribute("getValues") != null)
	{
		session.removeAttribute("getValues");
	}
	
	System.out.println("Start of the 11111111iListSalesOrders page >>>>>>>>>>>>>>>>>>>");
		
	/****	 To get the List of Sales Orders   
	
	Few Important Descriptions of Variables Used in this page.

	A1. statKeys-- ArrayList, contains all allowed statuses for  Given User Role.
	A2. statDesc--ArrayList,  contains descriptions of statuses used in the Heading of the List page.	
		      Pls note that statKeys and statDesc indexes must be matched.
	A3. displayStatus-- Hashtable , Used to display Satus columns in List Page.

	A4. NewFilter-- Used to filter the rows based on Last Login date and Last Login Time.
	A5. vec-- ArrayList, contains list of statues to be fetched  for current request. 
		if the orderStatus is "Null"  it will contain first element in statKeys
		if the orderStatus is "All" it will conatin all elements of statKeys.
	
	---------------------------------------------------------------------


	Type Codes
	
	As you know for all List Querys  SoldTo ,ShipTo and SalesAreas checks  are necessary.   
	If you want  to add more checks  like on Created by , on modified by etc you need to set Type Codes
	as following.

	
	E1. "C"-- If you would like to Query on Created By 
	E2. "M"-- If you would like to Query on Modified By

	If the NewFilter flag is Y Values will be filtred on Last Login Date also.
		
	

	Error Prone Cases

	1. If request status is not existed in statKeys.
	2. If lengths of statKeys and statDesc are not matched.
	3. If displayStatus does conatin any requested status  as Key.
		
	
	*/

	formatDate = new FormatDate();
	ezc.ezbasicutil.EzSearchReturn mySearch= new ezc.ezbasicutil.EzSearchReturn();
	ReturnObjFromRetrieve retobj = null;		

	String strMaterial = request.getParameter("MATERIAL");
	String strPOnumber = request.getParameter("PONUMBER");
	if(strPOnumber != null)	strPOnumber = strPOnumber.trim();
	String orderStatus=request.getParameter("orderStatus");
	String orderByMaterial=request.getParameter("orderByMaterial"); 
	String newFilter=request.getParameter("newFilter");
	String searchType=request.getParameter("SearchType");
	
	String refDocType = request.getParameter("RefDocType"); // this parameter is for orders created from saved orders 
			
	// SECTION CHANGED BY MB TO HANDLED MULTIPLE STATUSES
	String[] orderType_N_Array = request.getParameterValues("ORDERTYPE");

  	if ((orderType_N_Array != null)){
  		for (int i=0;i<orderType_N_Array.length;i++){
  			if (i==0)
  				orderStatus = "'NEGOTIATED'";
  			else
  				orderStatus = ","+"SUBMITTED";
  		}
  	}
  	// END OF SECTION CHANGED BY MB
  	
	String orderType_N = request.getParameter("ORDERTYPE");
	if("N".equals(orderType_N))
		orderStatus = "'NEGOTIATED'";
	else if("A".equals(orderType_N))
		orderStatus = "'SUBMITTED'";
	//out.println(orderType_N);
	
	
	String orderStatustemp=request.getParameter("orderStatus");
	
	user=Session.getUserId();	
	userRole=(String)session.getValue("UserRole");	
	LAST_LOGIN_DATE=(String)session.getValue("LAST_LOGIN_DATE");
	LAST_LOGIN_TIME=(String)session.getValue("LAST_LOGIN_TIME"); 
	agentCode=(String)session.getValue("AgentCode");
	salesAreaCode=(String)session.getValue("SalesAreaCode"); 
	
	ArrayList statKeys=new ArrayList(); 
	ArrayList statDesc=new ArrayList();
	ArrayList allStatKeys=new ArrayList();
	
	//statKeys.add("'New'"); 				statDesc.add("Saved");
	//statKeys.add("'RetNew'");				statDesc.add("Saved Return");
	//statKeys.add("'Transfered'");				statDesc.add("Accepted");
	//statKeys.add("'RETTRANSFERED'");			statDesc.add("Posted Return");

	if("CU".equals(userRole) || "AG".equals(userRole))
	{
		statKeys.add("'New'"); 				statDesc.add("Saved");			
		statKeys.add("'Transfered'");			statDesc.add("Accepted");		
		statKeys.add("'Negotiated'");			statDesc.add("Negotiated");
		statKeys.add("'Submitted'");			statDesc.add("Submitted");
	}
	else if("CM".equals(userRole))
	{

		statKeys.add("'New'"); 				statDesc.add("Saved");
		statKeys.add("'Transfered'");			statDesc.add("Accepted");
		statKeys.add("'Negotiated'");			statDesc.add("Negotiated");
		statKeys.add("'Submitted'");			statDesc.add("Submitted");
	}
	//out.println("orderStatus>>>>>>>>>>>><<<<<<<<11111"+orderStatus);
	
	refDocType=(refDocType==null)?"P": refDocType;
	orderStatus=(orderStatus==null)?(String)statKeys.get(0):orderStatus;
	ArrayList vec= new ArrayList();
	vec.add(orderStatus);
	vec=("All".equals(orderStatus))?statKeys:vec;
	
	
%>
	<%@ include file="iGetWorkFlowSessionUsers.jsp"%> 
<%

	
	ReturnObjFromRetrieve webOrdsRet = null;	
	ordTypeSel = request.getParameter("orderinforadio");
	ezc.ezcommon.EzLog4j.log("ordTypeSel:::::::"+ordTypeSel,"D");

	SAPSO 	= request.getParameter("SAPSO");
	PONO 	= request.getParameter("PONO");
	if(!"".equals(PONO) && !"null".equals(PONO))PONO=PONO.trim();
	prdCODE = request.getParameter("prdCODE");
	orderType= request.getParameter("orderType");
	selSoldTo= request.getParameter("selSoldTo");
	if("CU".equals(userRole))
	{
		String tempSoldTp_A = 	request.getParameter("tempSoldTo");
		if(tempSoldTp_A.indexOf("$$")!=-1)
		{
			int splitCnt=0;
			java.util.StringTokenizer allsoldTo_A = new java.util.StringTokenizer(tempSoldTp_A,"$$");
			while(allsoldTo_A.hasMoreTokens())
			{
				if(splitCnt==0)
					selSoldTo = allsoldTo_A.nextToken()+"";
				else
					selSoldTo = selSoldTo +"','"+allsoldTo_A.nextToken()+"";
				
				splitCnt++;
			}			
		}
		else
			selSoldTo = request.getParameter("tempSoldTo");
	}
	//out.println("selSoldTo::::::::"+selSoldTo);
	selShipTo= request.getParameter("shipTo");
	fromDate= request.getParameter("fromDate");
	toDate 	= request.getParameter("toDate");	

	String toPasssUsers ="";
	String cancelTable = "";
	String appendQry   = "";
	String cancelQry   = "";
	
	EzcParams mainParamsRef= new EzcParams(false);
	EziMiscParams miscParamsRef = new EziMiscParams();
	String schQry = "";	
	String customerSearch="";
		

	if(!"RETURNS".equalsIgnoreCase(ordTypeSel) && !"CANCEL".equalsIgnoreCase(ordTypeSel))
	{
		//if(!"RETURNS".equalsIgnoreCase(ordTypeSel))
		{
			if("INPROCESS".equalsIgnoreCase(ordStat))
				appendQry = " AND ESDH_STATUS IN ('APPROVED','ACCEPTED','NEGOTIATED','"+ordStat+"')";
			if("REJECTED".equalsIgnoreCase(ordStat))
				appendQry = " AND ESDH_STATUS IN ('"+ordStat+"')";
			if("SAS".equalsIgnoreCase(ordStat))
				appendQry = " AND EWDHH_WF_STATUS IN ('TRANSFERED')";
			if("NEW".equalsIgnoreCase(ordStat))	
			{
				if("CU".equals(userRole))
					customerSearch = " AND ESDH_CREATED_BY ='"+Session.getUserId()+"'";
				appendQry = " AND EWDHH_WF_STATUS IN ('"+ordStat+"')" + customerSearch; 
				
			}	
			if("SUBMITTED".equalsIgnoreCase(ordStat) && "CM".equals(userRole))	
				appendQry = " AND ESDH_STATUS IN ('"+ordStat+"') AND ESDH_DOC_NUMBER IN (SELECT DISTINCT(EON_ORDER_NO) FROM EZC_ORDER_NEGOTIATE WHERE EON_STATUS IN('FOCAPPROVED','FOCACCEPTED','FOCREJECTED','FORAPPROVAL'))";	
			if("A".equalsIgnoreCase(ordStat) && !"CM".equals(userRole))	
				//appendQry = " AND ESDH_STATUS IN ('NEGOTIATED','NEW','INPROCESS','ACCEPTED','APPROVED')";
				appendQry = " AND ESDH_STATUS NOT IN ('TRANSFERED','SUBMITTED','DELETED','NEW')";
			if("A".equalsIgnoreCase(ordStat) && "CM".equals(userRole))
				appendQry = " AND ESDH_STATUS NOT IN ('TRANSFERED','DELETED','NEW')";	
		}		

		if(prdCODE!=null && !"".equals(prdCODE) && !"null".equals(prdCODE))
			schQry = "SELECT ESDH_DOC_NUMBER WEB_ORNO,ESDH_CREATE_ON  ORDER_DATE,ESDH_PO_NO PO_NO,ESDH_SOLD_TO SOLD_TO_CODE,ESDH_BACK_END_ORDER BACKEND_ORNO,ESDH_STATUS STATUS,ESDH_RES1 RES1,ESDH_SOLDTO_ADDR_1 SOTO_ADDR1,ESDH_SHIP_TO SHIP_TO_CODE, ESDH_SHIPTO_ADDR_1 SHTO_ADDR1,ESDH_PURCH_DATE PURCH_DATE,ESDH_NET_VALUE NET_VALUE,ESDH_SAVE_FLAG SAVE_FLAG,ESDH_FREIGHT_PRICE FREIGHT_PRICE,EWDHH_CREATED_BY CREATED_BY,ESDH_TEMPLATE_NAME TEMPLATE_NAME,ESDH_SYS_KEY SYSKEY FROM EZC_WF_DOC_HISTORY_HEADER,EZC_SALES_DOC_HEADER,EZC_SALES_DOC_ITEMS WHERE EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_DOC_NUMBER=ESDI_SALES_DOC "+appendQry+" AND (ESDI_MATERIAL ='"+prdCODE+"' OR ESDI_SHORT_TEXT ='"+prdCODE+"' OR ESDI_ITEM_UPC ='"+prdCODE+"')";
		else
			schQry = "SELECT ESDH_DOC_NUMBER WEB_ORNO,ESDH_CREATE_ON  ORDER_DATE,ESDH_PO_NO PO_NO,ESDH_SOLD_TO SOLD_TO_CODE,ESDH_BACK_END_ORDER BACKEND_ORNO,ESDH_STATUS STATUS,ESDH_RES1 RES1,ESDH_SOLDTO_ADDR_1 SOTO_ADDR1,ESDH_SHIP_TO SHIP_TO_CODE, ESDH_SHIPTO_ADDR_1 SHTO_ADDR1,ESDH_PURCH_DATE PURCH_DATE,ESDH_NET_VALUE NET_VALUE,ESDH_SAVE_FLAG SAVE_FLAG,ESDH_FREIGHT_PRICE FREIGHT_PRICE,EWDHH_CREATED_BY CREATED_BY,ESDH_TEMPLATE_NAME TEMPLATE_NAME,ESDH_SYS_KEY SYSKEY FROM EZC_WF_DOC_HISTORY_HEADER,EZC_SALES_DOC_HEADER WHERE EWDHH_DOC_ID=ESDH_DOC_NUMBER "+ appendQry;

		if(PONO!=null && !"".equals(PONO))		
			schQry = schQry+" AND ESDH_PO_NO LIKE '"+PONO.toUpperCase()+"%'";
		if(selSoldTo!=null && !"".equals(selSoldTo) )
			schQry = schQry+" AND ESDH_SOLD_TO  IN ('"+selSoldTo+"')";
		if(selShipTo!=null && !"".equals(selShipTo) && !"A".equalsIgnoreCase(selShipTo) && !"A".equalsIgnoreCase(request.getParameter("selSoldTo"))) 	
			schQry = schQry+" AND ESDH_SHIP_TO ='"+selShipTo+"'";
		if(selShipTo!=null && !"".equals(selShipTo) && "A".equalsIgnoreCase(selShipTo))
		{
			String shipToStr = request.getParameter("tempShipTo");
			if(shipToStr!=null && shipToStr.indexOf("$$")!=-1)
			{
				java.util.StringTokenizer allshipTo = new java.util.StringTokenizer(shipToStr,"$$");
				while(allshipTo.hasMoreTokens())
				{
					if("".equals(shipToStr))
						shipToStr = allshipTo.nextToken()+"";
					else
						shipToStr = shipToStr+"','"+allshipTo.nextToken()+"";
				}
			}
			schQry = schQry+" AND ESDH_SHIP_TO IN ('"+shipToStr+"')";
		}
		if(fromDate!=null && toDate!=null && !"null".equals(fromDate) && !"null".equals(toDate))
			schQry=schQry+" AND ESDH_ORDER_DATE BETWEEN  convert(DATETIME,'"+fromDate+"',110)  and  convert(DATETIME,'"+toDate+"',110)";
		if(SAPSO!=null && !"".equals(SAPSO))	
			schQry=schQry+" AND ESDH_BACK_END_ORDER = '"+SAPSO+"'";
		if(orderType!=null && !"".equals(orderType) && ("NEW".equals(orderType) || "NEGOTIATED".equals(orderType)))	
			schQry=schQry+" AND ESDH_STATUS = '"+orderType.toUpperCase()+"'";
		/*iif("CU".equals(userRole))
		{
			toPasssUsers = "'"+user+"','"+subuserIds+"','"+superiorsusers+"'";
			//schQry = schQry+" AND EWDHH_CREATED_BY IN("+toPasssUsers+")";

		}
		if("CM".equals(userRole))
		{
			toPasssUsers = "'"+user+"','"+toPassUserId+"','"+SoldTos+"'";
			//schQry = schQry+" AND EWDHH_CREATED_BY IN("+toPasssUsers+")";

			ezc.ezcommon.EzLog4j.log("SoldTos::::"+SoldTos,"D");
		}
		
		if(!"RETURNS".equalsIgnoreCase(ordTypeSel) && ("INPROCESS".equalsIgnoreCase(ordStat) || "REJECTED".equalsIgnoreCase(ordStat)))
		{
			//schQry = schQry+" AND ESDH_DOC_NUMBER IN (SELECT DISTINCT(EON_ORDER_NO) FROM EZC_ORDER_NEGOTIATE WHERE EON_STATUS IN('"+ordStat+"')";
			//schQry = schQry+" AND ESDH_STATUS IN ('"+ordStat+"','NEGOTIATED')";
			if("CU".equals(userRole))
			{
				//toPasssUsers = "'"+user+"','"+subuserIds+"'";
				//schQry = schQry+" AND EON_CREATED_BY IN("+toPasssUsers+"))";
			}
			if("CM".equals(userRole))
			{
				//toPasssUsers = "'"+user+"','"+toPassUserId+"','"+SoldTos+"'";
				//schQry = schQry+" AND EON_CREATED_BY IN("+toPasssUsers+"))";
			}	

		}*/
	}
	else
	{

		schQry = "SELECT ESCH_ID CANCEL_ID,ESCH_PO_NUM PO_NO,ESCH_SO_NUM BACKEND_ORNO,ESCH_CREATED_BY CREATED_BY,ESCH_CREATED_ON ORDER_DATE,ESCH_MODIFIED_BY MODIFIED_BY,ESCH_MODIFIED_ON MODIFIED_ON,ESCH_STATUS STATUS,ESCH_TYPE,ESCH_EXT1 SHIP_TO_CODE,ESCH_EXT2,ESCH_EXT3,ESCH_SOLD_TO SOLD_TO_CODE,ESCH_SYSKEY SYSKEY FROM EZC_SO_CANCEL_HEADER,EZC_SO_CANCEL_ITEMS WHERE ESCH_ID=ESCI_ID";
		/*String cancelType = " AND ESCH_STATUS IN ('"+ordStat+"')";
		if("ALL".equals(ordStat))cancelType=" ";*/
		//schQry = schQry+ "  AND ESCH_SOLD_TO='"+selSoldTo+"' ";
		
		/*if("CU".equals(userRole))
		{
			toPasssUsers = "'"+user+"','"+subuserIds+"'";
			schQry = schQry+" AND ESCH_CREATED_BY IN("+toPasssUsers+")";
		}
		if("CM".equals(userRole))
		{
			toPasssUsers = "'"+user+"','"+toPassUserId+"'"; //,'"+SoldTos+"'
			schQry = schQry+" AND ESCH_CREATED_BY IN("+toPasssUsers+")";

			ezc.ezcommon.EzLog4j.log("SoldTos::::"+SoldTos,"D");
		}*/				
		
		if(prdCODE!=null && !"".equals(prdCODE) && !"null".equals(prdCODE))
			schQry = schQry+" AND ESDI_MAT_CODE ='"+prdCODE+"' OR ESDI_MAT_DESC='"+prdCODE+"'";
		if(PONO!=null && !"".equals(PONO))
			schQry = schQry+" AND ESCH_PO_NUM LIKE '"+PONO.toUpperCase()+"%'";
		if(selSoldTo!=null && !"".equals(selSoldTo))
			schQry = schQry+" AND ESCH_SOLD_TO IN ( '"+selSoldTo+"')";
		if(selShipTo!=null && !"".equals(selShipTo) && !"A".equals(selShipTo) && !"A".equalsIgnoreCase(request.getParameter("selSoldTo"))) 
			schQry = schQry+" AND ESCH_EXT1 = '"+selShipTo+"'";
		if(selShipTo!=null && !"".equals(selShipTo) && "A".equalsIgnoreCase(selShipTo))
		{
			String shipToStr = request.getParameter("tempShipTo");
			if(shipToStr!=null && shipToStr.indexOf("$$")!=-1)
			{
				java.util.StringTokenizer allshipTo = new java.util.StringTokenizer(shipToStr,"$$");
				while(allshipTo.hasMoreTokens())
				{
					if("".equals(shipToStr))
						shipToStr = allshipTo.nextToken()+"";
					else
						shipToStr = shipToStr+"','"+allshipTo.nextToken()+"";
				}
			}
			schQry = schQry+" AND ESCH_EXT1 IN ('"+shipToStr+"')";
		}
		if(SAPSO!=null && !"".equals(SAPSO))		
			schQry = schQry+" AND ESCH_SO_NUM = '"+SAPSO+"'";
		if(fromDate!=null && toDate!=null && !"null".equals(fromDate) && !"null".equals(toDate))
			schQry=schQry+" AND ESCH_CREATED_ON BETWEEN  convert(DATETIME,'"+fromDate+"',110)  and  convert(DATETIME,'"+toDate+"',110)";
		if(ordStat!=null && !"null".equals(ordStat) && !"ALL".equalsIgnoreCase(ordStat))
		{
			
			if("R".equals(ordStat) && "RETURNS".equalsIgnoreCase(ordTypeSel))
				schQry = schQry+" AND ESCH_STATUS IN ('R','CA')";
			else
				schQry = schQry+" AND ESCH_STATUS IN ('"+ordStat+"')";
		}	
			
		if("RETURNS".equalsIgnoreCase(ordTypeSel))
			schQry = schQry+" AND ESCH_TYPE IN ('RGA')";	
		if("CANCEL".equalsIgnoreCase(ordTypeSel))
			schQry = schQry+" AND ESCH_TYPE IN ('RC','C')";
				
	}	
		
	miscParamsRef.setIdenKey("MISC_SELECT");
	miscParamsRef.setQuery(schQry);

	mainParamsRef.setLocalStore("Y");
	mainParamsRef.setObject(miscParamsRef);
	Session.prepareParams(mainParamsRef);	

	try
	{		
		ezc.ezcommon.EzLog4j.log("miscParamsRef.getQuery()::::::::"+miscParamsRef.getQuery() ,"I");
		webOrdsRet = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsRef);
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}

		
%>

	
