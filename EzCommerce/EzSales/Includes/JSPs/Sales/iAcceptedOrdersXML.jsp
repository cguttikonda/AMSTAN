<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*"%>
<%@ page import = "ezc.ezutil.FormatDate" %>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%
	String agtCode		= (String)session.getValue("AgentCode");
	String UserRole 	= (String)session.getValue("UserRole");	
	String[] customer 	= request.getParameterValues("customer");
	String rem 		= request.getParameter("RefDocType");
	String fromDate 	= request.getParameter("FromDate");
	String toDate	 	= request.getParameter("ToDate");
	String custStr 		= request.getParameter("custStr");
	
	if(custStr!=null){
		custStr =custStr.replace('@','&'); 
	}
	
	ReturnObjFromRetrieve retCustList = new ReturnObjFromRetrieve();
	if("P".equals(rem))
	{
		if(session.getValue("customers")!= null);
		{
			log4j.log("session value not null  ","W");
			//session.removeValue("customers");
		}	
	}
	
	java.util.StringTokenizer custNo = null;
	java.util.Vector custVec = new java.util.Vector(); 
	
	log4j.log("custStrcustStr111:"+custStr,"W");
	log4j.log("agtCodeagtCode:"+agtCode,"W");
	
	if(custStr!=null)
	{
		int Count = 0;
		try
		{
			custNo 	= new java.util.StringTokenizer(custStr,",");
			Count 	= custNo.countTokens();
			for(int i=0;i<Count;i++)
			{
				custVec.add(custNo.nextToken());
			}
		}
		catch(Exception e)
		{
			log4j.log("ExceptionException:"+e,"W");
		}
		session.putValue("custStr",custStr);
	}
	log4j.log("End of tokens:","W");
	
	if("CU".equals(UserRole))
		custStr = agtCode;
	String urlPage = "ACPORDERS";
%>
<%@ include file="../../../Includes/JSPs/Sales/iCopySOList.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iGetGroupCustomers.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iGetProductGroups.jsp"%>
<%

	java.util.ArrayList localList = new java.util.ArrayList();	
	if(retobj!=null)
	{
		for(int i=0;i<retobj.getRowCount();i++)
		{
			localList.add(retobj.getFieldValueString(i,"BACKEND_ORNO").trim());
		}
		log4j.log("localListlocalListlocalList:"+localList,"W");
	}

	
	log4j.log("End of COPY ORDER:","W");
	
	int custcount=retCustList.getRowCount();
	/*
	if(customer == null)
	{
		if(session.getValue("customers") != null)
		{
			customer=(String[])session.getValue("customers");
		}
		else
		{
			if(agtCode.indexOf(",")==-1)
			{
				customer=new String[1];
				customer[0]=agtCode;
			}
		}
	}else
	{
		session.putValue("customers",customer);
	}
	*/
	
	/*
	if(customer == null){
		log4j.log("in iAcceptedOrdersXML.jsp customer is null","W");
		if(session.getValue("customers") != null){
			log4j.log("in iAcceptedOrdersXML.jsp session is not null","W");
			customer=(String[])session.getValue("customers");
		}else{
			log4j.log("in iAcceptedOrdersXML.jsp session not null","W");
			if(agtCode.indexOf(",")==-1){
				customer=new String[1];
				customer[0]=agtCode;
			}
		}
	}else{
		log4j.log("in iAcceptedOrdersXML.jsp csutomer is not null","W");
		//session.putValue("customers",customer);
	}	
	
	session.putValue("customers",customer);
	
	for(int i=0;i<customer.length;i++)
	{
		log4j.log("within iAcceptedOrdersSOList.jsp111222333444::"+customer[i],"W");
	}
	*/
	
	ReturnObjFromRetrieve orderList 		= new ReturnObjFromRetrieve();
	ReturnObjFromRetrieve returnStruct		= null;
	ReturnObjFromRetrieve oH 			= null;
	ReturnObjFromRetrieve so			= null;

	EzcSalesOrderParams  	     ezcSalesOrderParams= new EzcSalesOrderParams();
	EziSalesOrderSearchParams    iParams 		= new EziSalesOrderSearchParams();
	EziExtSalesOrderSearchParams iExtParams 	= new EziExtSalesOrderSearchParams();
	EzBapicustselectTable 	     custtable		= new EzBapicustselectTable();
	EzBapicustselectTableRow     custtableRow 	= null;
	
	iParams.setStatusFlag("O");
/***Ramesh***/	
	int month=0, date=0, year=0;
	
	month = Integer.parseInt(fromDate.substring(0,2));
	date  = Integer.parseInt(fromDate.substring(3,5));
	year  = Integer.parseInt(fromDate.substring(6,10));	
	java.util.GregorianCalendar DateFrom = new java.util.GregorianCalendar(year,month-1,date);
	
	month = Integer.parseInt(toDate.substring(0,2));
	date  = Integer.parseInt(toDate.substring(3,5));
	year  = Integer.parseInt(toDate.substring(6,10));	
	java.util.GregorianCalendar DateTo = new java.util.GregorianCalendar(year,month-1,date);

	iParams.setDocumentDate(DateFrom.getTime());
	iParams.setDocumentDateTo(DateTo.getTime());
/***Ramesh***/

	EzBapiordersTable ordtable= new EzBapiordersTable();
	EzBapiordersTableRow ordtableRow =null;
	
	try
	{
		java.util.ResourceBundle EzGetSalesList = java.util.ResourceBundle.getBundle("EzGetSalesList");
		int retCatCount = retCatManager.getRowCount();
		ArrayList duplicate = new ArrayList();
		for(int i=0;i<retCatCount;i++)
		{
			if("Y".equals(retCatManager.getFieldValueString(i,"ISCHECKED")))
 	   		{
				String grp = retCatManager.getFieldValueString(i,"EPG_NO");
				if(grp != null && !"null".equals(grp))
				{
					String EzDocTypes = EzGetSalesList.getString("ORD_"+grp);
					if(EzDocTypes != null)
					{
						EzStringTokenizer doctypesSt = new EzStringTokenizer(EzDocTypes,",");
						int doctypesCt =doctypesSt.getTokens().size();
						if(doctypesCt == 0)
						{
							if(!duplicate.contains(EzDocTypes))
							{
								duplicate.add(EzDocTypes);
								ordtableRow = new EzBapiordersTableRow();
								ordtableRow.setDocType(EzDocTypes);
								ordtable.appendRow(ordtableRow);
							}	
						}
						else
						{
							for(int linall=0;linall<doctypesCt;linall++)
							{
								String docT = (String)doctypesSt.getTokens().elementAt(linall);
								if(!duplicate.contains(docT))
								{
									duplicate.add(docT);
									ordtableRow = new EzBapiordersTableRow();
									ordtableRow.setDocType(docT);
									ordtable.appendRow(ordtableRow);
								}
							}	
						}
					}
				}
	   		}//end of if
		}
	}catch(Exception e){}

	iParams.setSalesOrders(ordtable);
	ezcSalesOrderParams.setObject(iParams);
	ezcSalesOrderParams.setObject(iExtParams);
	Session.prepareParams(ezcSalesOrderParams);
	
	
	if(custVec != null)
	{
		for(int i=0;i<custVec.size();i++)
		{
			log4j.log("custStrcustStr11122332244:"+(String)custVec.get(i),"W");
			custtableRow = new EzBapicustselectTableRow();
			custtableRow.setCustomer((String)custVec.get(i));
			custtable.appendRow(custtableRow);
		}
		iParams.setCustomerSelection(custtable);
		
		log4j.log("Before Executing SAP call:: ","W");
		
	        EzoSalesOrderList salesParams =(EzoSalesOrderList)EzSalesOrderManager.ezuSalesOrderListWithStatus(ezcSalesOrderParams);
	        
	        log4j.log("After Executing SAP call:: ","W");
	        
		returnStruct = salesParams.getReturn();
		if(returnStruct.getRowCount() > 0)
		{
			String errType = String.valueOf(returnStruct.getFieldValue(0,"Type"));
			if(errType.equalsIgnoreCase("E"))
			{
				orderList = salesParams.getSalesOrders();
			}
		}
		else
		{
			orderList = salesParams.getSalesOrders();
		}
		oH = salesParams.getOrderStatusHeaderOut();
	}
	
	int cnt= 0;
	ezc.ezparam.ReturnObjFromRetrieve ret = null;
	if(orderList!=null) cnt = orderList.getRowCount();
	if(cnt>0)
	{
		String sortCols[]= new String[1];
		sortCols[0]="DocDate";
		orderList.sort(sortCols,false);
	
		Vector types = new Vector();
		types.addElement("date");
		types.addElement("date");
		types.addElement("");
		EzGlobal.setColTypes(types);
		Vector names = new Vector();
		names.addElement("DocDate");
		names.addElement("ValidFrom");
		names.addElement("SdDoc");
		EzGlobal.setColNames(names);
	
		ret = EzGlobal.getGlobal(orderList);
	}
	
	
%>