<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*"%>
<%@ page import = "ezc.ezutil.FormatDate" %>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%
	String salesAreaCode	=(String)session.getValue("SalesAreaCode");
	String agentCode	=(String)session.getValue("AgentCode");
	String UserRole 	= (String)session.getValue("UserRole");	
	
	String[] customer 	= request.getParameterValues("customer");
	String rem 		= request.getParameter("RefDocType");
	
	String fromDate 	= request.getParameter("FromDate");
	String toDate	 	= request.getParameter("ToDate");

	
	ReturnObjFromRetrieve retCustList = new ReturnObjFromRetrieve();
	if("P".equals(rem))
	{
		if(session.getValue("customers")!= null);
		session.removeValue("customers");
	}
	System.out.println("RefDocTypeRefDocTypeRefDocTypeRefDocType  "+rem);
%>
<%@ include file="../../../Includes/JSPs/Sales/iGetGroupCustomers.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iGetProductGroups.jsp"%>
<%
	int custcount=retCustList.getRowCount();
	if(customer == null)
	{
		if(session.getValue("customers") != null)
		{
			customer=(String[])session.getValue("customers");
		}
		else
		{
			if(agentCode.indexOf(",")==-1)
			{
				customer=new String[1];
				customer[0]=agentCode;
			}
		}
	}else
	{
		session.putValue("customers",customer);
	}
	
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
	if(customer != null)
	{
		ArrayList duplicate = new ArrayList();
		for(int i=0;i<customer.length;i++)
		{
			if(!duplicate.contains(customer[i]) && allCust.contains(customer[i]))
			{
				duplicate.add(customer[i]);
				custtableRow = new EzBapicustselectTableRow();
				custtableRow.setCustomer(customer[i]);
				custtable.appendRow(custtableRow);
			}
		}
		iParams.setCustomerSelection(custtable);
	        EzoSalesOrderList params =(EzoSalesOrderList)EzSalesOrderManager.ezuSalesOrderListWithStatus(ezcSalesOrderParams);
		returnStruct = params.getReturn();
		if(returnStruct.getRowCount() > 0)
		{
			String errType = String.valueOf(returnStruct.getFieldValue(0,"Type"));
			if(errType.equalsIgnoreCase("E"))
			{
				orderList = params.getSalesOrders();
			}
		}
		else
		{
			orderList = params.getSalesOrders();
		}
		oH = params.getOrderStatusHeaderOut();
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