<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*"%>
<%@ page import = "ezc.ezutil.FormatDate" %>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%
	String salesAreaCode	= (String)session.getValue("SalesAreaCode");
	String agentCode	= (String)session.getValue("AgentCode");
	String UserRole 	= (String)session.getValue("UserRole");	
	//String[] customer 	= request.getParameterValues("customer");
	String rem 		= request.getParameter("RefDocType");
	String fromDate 	= request.getParameter("FromDate");
	String toDate	 	= request.getParameter("ToDate");

	salesAreaCode 	= "999666";
	agentCode	= "0010007646";
	UserRole	= "CM";
	//String[] customer	= {"0010003209","0010006473","0010007654","0010002678","0010002922"};
	rem		= "P";
	fromDate	= "04/01/2006";
	toDate		= "08/18/2006";
	
	/*
	for(int i=0;i<customer.length;i++)
	{
		log4j.log("customercustomer::"+customer[i],"W");
	}
	*/
	
	String custStr 		= request.getParameter("custStr");
	
	custStr 		= "0010003209,0010006473,0010007654";
	
	log4j.log("custStr1111111222222222222::"+custStr,"W");

	ReturnObjFromRetrieve retCustList = new ReturnObjFromRetrieve();
	if("P".equals(rem))
	{
		if(session.getValue("customers")!= null);
		{
			log4j.log("session value not null  ","W");
			session.removeValue("customers");
		}	
	}
	log4j.log("RefDocTypeRefDocTypeRefDocTypeRefDocType  "+rem,"W");
	
	log4j.log("agentCodeagentCodeagentCode::"+agentCode,"W");
	
	java.util.StringTokenizer custNo = null;
	java.util.Vector custVec = new java.util.Vector(); 
	
	if(custStr!=null)
	{
		int Count = 0;
		//if(custVal!=null)
		{
			custNo 	= new java.util.StringTokenizer(custStr,",");
			Count 	= custNo.countTokens();
			log4j.log("CountCountCountCountCountCount::"+Count,"W");
			for(int i=0;i<Count;i++)
			{
				custVec.add(custNo.nextToken());
			}

			log4j.log("custVeccustVeccustVeccustVeccustVec::"+custVec,"W");
		}
	}
	
%>
<%@ include file="../../../Includes/JSPs/Sales/iGetGroupCustomers.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iGetProductGroups.jsp"%>
<%


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
		//ArrayList duplicate = new ArrayList();
		for(int i=0;i<custVec.size();i++)
		{
			//if(!duplicate.contains(custVec[i]))
			//{
				//duplicate.add(custVec[i]);
				
				log4j.log("1112222333445556666 "+(String)custVec.get(i),"W");
				
				custtableRow = new EzBapicustselectTableRow();
				custtableRow.setCustomer((String)custVec.get(i));
				custtable.appendRow(custtableRow);
			//}
		}
		iParams.setCustomerSelection(custtable);
		
		log4j.log("Before Executing SAP call:: ","W");
		
	        EzoSalesOrderList params =(EzoSalesOrderList)EzSalesOrderManager.ezuSalesOrderListWithStatus(ezcSalesOrderParams);
	        
	        log4j.log("After Executing SAP call:: ","W");
	        
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
	
	log4j.log("orderListorderListorderList::","W");
	log4j.log(orderList.toEzcString(),"W");
	log4j.log("orderListorderListorderList::","W");
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
<%!
	public static String replaceChar(String s,char c)
	{
		StringBuffer r = new StringBuffer(s.length()+4);
		r.setLength(s.length()+4);
		int current = 0;
		for(int i=0;i<s.length();i++)
		{
			char cur=s.charAt(i);
			if(cur==c)
			{
				r.setCharAt(current++,cur);
				r.setCharAt(current++,'a');
				r.setCharAt(current++,'m');
				r.setCharAt(current++,'p');
				r.setCharAt(current++,';');
			}
			else
			{
				r.setCharAt(current++,cur);
			}
		}
		return r.toString();
	}

%>
<%

	log4j.log("33333333333333333333333333333333333333333","W");
	
	String refDocType1 = request.getParameter("RefDocType");
	String forkey 	= (String)session.getValue("formatKey");
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();

	if(forkey==null) forkey="/";
	int LrowCount=orderList.getRowCount();
	out.println("<?xml version=\"1.0\"?>");		
	out.println("<rows>");

	
	log4j.log("4444444444444444444444444444444444444444444","W");
	
	int p = 0;
	if(cnt >0)
	{
		log4j.log("555555555555555555555555555555555555","W");
	
		for(int i=0;i<LrowCount;i++)
		{
			p++;
			String tempsoNumber = "";
			String soNumber	=orderList.getFieldValueString(i,"SdDoc");
			String soCust 	=orderList.getFieldValueString(i,"SoldTo");
			String netValue	=orderList.getFieldValueString(i,"NetValHd");
			String cuname	=orderList.getFieldValueString(i,"Name");
			String DocDate 	=ret.getFieldValueString(i,"DocDate");
			StringTokenizer st1 = new StringTokenizer(DocDate,"/");
			String[] docsplit = new String[3];
			int h=0;
			while(st1.hasMoreTokens())
			{
				docsplit[h]=st1.nextToken();
				h++;
			}			
			java.util.Date dDate = new java.util.Date(Integer.parseInt(docsplit[2])-1900,Integer.parseInt(docsplit[0])-1,Integer.parseInt(docsplit[1]));
			DocDate = formatDate.getStringFromDate(dDate,forkey,formatDate.MMDDYYYY);				
			String podate=ret.getFieldValueString(i,"ValidFrom");
			if(podate!=null && podate.indexOf(".")>0)
			{
				StringTokenizer st2 = new StringTokenizer(podate,".");
				String[] fromsplit = new String[3];
				int h1=0;
				while(st2.hasMoreTokens())
				{
					fromsplit[h1]=st2.nextToken();
					h1++;
				}
				java.util.Date frDate = new java.util.Date(Integer.parseInt(fromsplit[2])-1900,Integer.parseInt(fromsplit[0])-1,Integer.parseInt(fromsplit[1]));
				podate = formatDate.getStringFromDate(frDate,forkey,formatDate.MMDDYYYY);
			}
			else
			{
				podate ="N/A";
			}
			try{
				tempsoNumber = (Long.parseLong(soNumber))+"";	
			}
			catch(Exception e)
			{	
				tempsoNumber = soNumber;
			}
			cuname=(cuname == null || "null".equals(cuname))?"":cuname;
			
			if(cuname.length()>31)
			{
				cuname = cuname.substring(0,30);
				
			}
			cuname = replaceChar(cuname,'&');
			
			String pono = orderList.getFieldValueString(i,"PurchNo");
			if((podate==null)||(podate=="null")||(podate.trim().length() == 0))
			{
				podate ="N/A";
			}
			if((pono == null)||(pono.trim().length() == 0))
			{
				pono ="N/A";
				out.println("<row id='"+soNumber+"'><cell><![CDATA[<nobr><a href='../Sales/ezBackWaitSalesDisplay.jsp?SONumber="+soNumber+"&amp;SoldTo="+soCust+"&amp;status=O&amp;pageUrl=BackOrder&amp;PODATE=&amp;orderType=Open'>"+tempsoNumber+"</a></nobr>]]></cell><cell>"+formatDate.getStringFromDate(dDate,forkey,formatDate.MMDDYYYY)+"</cell><cell>N/A</cell><cell>"+podate+"</cell><cell>"+cuname.trim()+"</cell></row>");
			}
			else
			{
				out.println("<row id='"+soNumber+"'><cell><![CDATA[<nobr><a href='../Sales/ezBackWaitSalesDisplay.jsp?SONumber="+soNumber+"&amp;SoldTo="+soCust+"&amp;status=O&amp;pageUrl=BackOrder&amp;PODATE=&amp;orderType=Open&amp;netValue='>"+tempsoNumber+"</a></nobr>]]></cell><cell>"+formatDate.getStringFromDate(dDate,forkey,formatDate.MMDDYYYY)+"</cell><cell><![CDATA[<nobr><a href='../Sales/ezBackWaitSalesDisplay.jsp?Back="+soNumber+"&amp;SoldTo="+soCust+"&amp;status=O&amp;pageUrl=EditBackOrder&amp;PODATE=&amp;orderType=Open'>"+pono+"</a></nobr>]]></cell><cell>"+podate+"</cell><cell>"+cuname.trim()+"</cell></row>");
			}	
		}
		log4j.log("66666666666666666666666666666666666666","W");
	}
	else
	{
		out.println("<row id='"+LrowCount+"'></row>");
	}
	
	log4j.log("7777777777777777777777777777777777777","W");
	
	out.println("</rows>");
	
	log4j.log("88888888888888888888888888888888888888888","W");
%>
