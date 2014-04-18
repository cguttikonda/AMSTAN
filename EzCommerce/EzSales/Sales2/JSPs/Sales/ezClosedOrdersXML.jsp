<%
	response.setContentType("text/xml");
	out.println("<?xml version=\"1.0\" encoding=\"ISO-8859-1\" ?>");	
	out.println("<rows>");
%>
<%@ page import = "ezc.ezparam.*,ezc.ezutil.FormatDate,java.util.*,ezc.ezbasicutil.*" %>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%!
	public static String replaceChar(String s,char c)
	{
		StringBuffer r = new StringBuffer(s.length());
		r.setLength(s.length());
		int current = 0;
		for(int i=0;i<s.length();i++)
		{
			char cur=s.charAt(i);
			if(cur==c)
			{
				r.setLength(s.length()+4);
				//r.setCharAt(current++,cur);
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
	String rem		= request.getParameter("RefDocType");
	String datesFlag	= request.getParameter("DatesFlag");
	ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
	String forkey 		= (String)session.getValue("formatKey");
	if(forkey==null) forkey ="/";

	//out.println("<?xml version=\"1.0\"?>");		
	//out.println("<rows>");
	//String base = request.getParameter("FromForm");
	String fd 	= request.getParameter("FromDate");
	String td 	= request.getParameter("ToDate");
	String sttd 	= td;
	String tfd 	= fd;
	String monthOpt	= request.getParameter("ezMonths");
	int p = 0;
	datesFlag=( (datesFlag==null) || ("null".equals(datesFlag)))?"DATES":datesFlag;
	datesFlag=(((monthOpt==null) || ("null".equals(monthOpt))) && (!("MONTHS".equals(datesFlag))))?"DATES":"MONTHS";

	if("P".equals(rem))
	{
		if(session.getValue("customers")!= null);
			session.removeValue("customers");
	}

	String UserRole 	= (String)session.getValue("UserRole");
	ReturnObjFromRetrieve retCustList = new ReturnObjFromRetrieve();
	String salesAreaCode=(String)session.getValue("SalesAreaCode");
	
	// Added By Balu
		String custStr 	= request.getParameter("custStr");
		
		if(custStr!=null){
			custStr =custStr.replace('@','&'); 
		}
		java.util.StringTokenizer custNo = null;
		java.util.Vector custVec = new java.util.Vector(); 

		log4j.log("custStrcustStr111:"+custStr,"W");
		if(custStr!=null)
		{
			int Count = 0;
			custNo 	= new java.util.StringTokenizer(custStr,",");
			Count 	= custNo.countTokens();
			
			log4j.log("CountCountCountCount:"+Count,"W");
			
			for(int i=0;i<Count;i++)
			{
				custVec.add(custNo.nextToken());
			}
			session.putValue("custStr",custStr);
		}	
	//
	
%>
<%@ include file="../../../Includes/JSPs/Sales/iGetGroupCustomers.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iGetProductGroups.jsp"%>
<%

int custcount		= retCustList.getRowCount();
String agentCode	= (String)session.getValue("AgentCode");
String[] customer	= request.getParameterValues("customer");
String[] customerDate 	= request.getParameterValues("customerDate");

if(customer == null){
	if(session.getValue("customers") != null){
		customer=(String[])session.getValue("customers");
	}else{
		if(agentCode.indexOf(",")==-1){
			customer=new String[1];
			customer[0]=agentCode;
		}
	}
}else{
	session.putValue("customers",customer);
}
//added by kp for two between date
if(customerDate == null){
	if(session.getValue("customersdate") != null){
		customerDate=(String[])session.getValue("customersdate");
	}else{
		if(agentCode.indexOf(",")==-1){
			customerDate=new String[1];
			customerDate[0]=agentCode;
		}
	}
}else{
	session.putValue("customersdate",customerDate);
}
//Finished

	ReturnObjFromRetrieve orderList = new ReturnObjFromRetrieve();
	ReturnObjFromRetrieve returnStruct=null;
	ReturnObjFromRetrieve oH =null;
	ReturnObjFromRetrieve so=null;

	EzcSalesOrderParams  ezcSalesOrderParams = new EzcSalesOrderParams();
	EziSalesOrderSearchParams iParams = new EziSalesOrderSearchParams();
	EziExtSalesOrderSearchParams iExtParams = new EziExtSalesOrderSearchParams();
	EzBapicustselectTable custtable = new EzBapicustselectTable();
	EzBapicustselectTableRow custtableRow =null;

	EzBapiordersTable ordtable= new EzBapiordersTable();
	EzBapiordersTableRow ordtableRow =null;

try{
			ArrayList duplicate = new ArrayList();
			String EzDocTypes = "ORD";	
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
					}else{
						for(int linall=0;linall<doctypesCt;linall++)
						{
				String docT = (String)doctypesSt.getTokens().elementAt(linall);
				docT=docT.trim();

						if(docT.length()==4)
						{
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

}catch(Exception e){}

	iParams.setSalesOrders(ordtable);
	iParams.setStatusFlag("C");
	//if(base!=null && !"null".equals(base) && !"".equals(base))
	//{

		int ffy=Integer.parseInt(fd.substring(6,10))-1900;
		int ffd=Integer.parseInt(fd.substring(3,5));
		int ffm=Integer.parseInt(fd.substring(0,2))-1;
		int tty=Integer.parseInt(td.substring(6,10))-1900;
		int ttd=Integer.parseInt(td.substring(3,5));
		int ttm=Integer.parseInt(td.substring(0,2))-1;

	 	Date fromDate = new Date(ffy,ffm,ffd);
	 	Date toDate = new Date(tty,ttm,ttd);

		iParams.setDocumentDate(fromDate);
		iParams.setDocumentDateTo(toDate);

		ezcSalesOrderParams.setObject(iParams);
		ezcSalesOrderParams.setObject(iExtParams);
		Session.prepareParams(ezcSalesOrderParams);
		if(custVec != null)
		{
  			//ArrayList duplicate = new ArrayList();
			int custLen = custVec.size();
			for(int i=0;i<custLen;i++)
			{
				//if(!duplicate.contains(customer[i]) &&( allCust.contains(customer[i]) || "CU".equals(UserRole)))
				//{
					log4j.log("custStrcustStr223344111:"+(String)custVec.get(i),"W");
					
					
					//duplicate.add((String)custVec.get(i));
					custtableRow = new EzBapicustselectTableRow();
					custtableRow.setCustomer((String)custVec.get(i));
					custtable.appendRow(custtableRow);
				//}
			}
			iParams.setCustomerSelection(custtable);
		        EzoSalesOrderList params =(EzoSalesOrderList) EzSalesOrderManager.ezuSalesOrderListWithStatus(ezcSalesOrderParams);
		 	returnStruct = params.getReturn();
			if ( returnStruct.getRowCount() > 0 )
			{
				String errType = String.valueOf(returnStruct.getFieldValue(0,"Type"));
			 	if (errType.equalsIgnoreCase("E"))
				{
					//strMaterial = " Unable to get the List of Sales Orders";
					orderList = params.getSalesOrders();
				}
			}else{
				// Get the list Of Orders
				//strMaterial = " ";
				orderList = params.getSalesOrders();

			}
			oH = params.getOrderStatusHeaderOut();
		}
	//}


	log4j.log("orderListorderListorderListorderListorderListorderList","W");
	//orderList.toEzcString();	
	log4j.log("orderListorderListorderListorderListorderListorderList","W");

	int cnt=orderList.getRowCount();
	String pono = "";
	String roleBO	=(String)session.getValue("UserRole");

//if(base!=null && !"null".equals(base) && !"".equals(base))
//{
	if(cnt==0)
	{
		out.println("<row id='"+cnt+"'></row>");
	}else{
			String sortCols[]= new String[1];
			sortCols[0]="SdDoc";
			orderList.sort(sortCols,false);
			oH.sort(sortCols,false);
	
			Vector types = new Vector();
			types.addElement("date");
			types.addElement("date");
			EzGlobal.setColTypes(types);
	
			Vector names = new Vector();
			names.addElement("ValidFrom");
			names.addElement("DocDate");
			EzGlobal.setColNames(names);
			ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(orderList);
			String agent=(String)session.getValue("Agent");
			FormatDate fD=new FormatDate();
			for(int i=0;i<cnt;i++)
			{
				p++;
				String tempsoNumber = "";
				String soNumber=orderList.getFieldValueString(i,"SdDoc");
				String podate=ret.getFieldValueString(i,"ValidFrom");
				String netValue=orderList.getFieldValueString(i,"NetValHd");
				String cuname=orderList.getFieldValueString(i,"Name");
				cuname=(cuname == null || "null".equals(cuname))?"":cuname;
				String soCust=orderList.getFieldValueString(i,"SoldTo");
				
				if(podate == null || "null".equals(podate))
					podate = "";
					
				podate=(podate.length()>10)?" ":podate;
				pono = orderList.getFieldValueString(i,"PurchNo");
				
				if( (pono == null ) || (pono.trim().length() == 0) )
					pono ="N/A";
				else
					pono = replaceChar(pono,'&');
				String docDate = ret.getFieldValueString(i,"DocDate");
				try{
					tempsoNumber = (Long.parseLong(soNumber))+"";	
				}
				catch(Exception e)
				{	
					tempsoNumber = soNumber;
				}
				if(cuname.length()>24)
				{
					cuname = cuname.substring(0,23)+"..";
				}
				cuname = replaceChar(cuname,'&');
				if((podate==null)||(podate=="null")||(podate.trim().length() == 0))
				{
					podate ="N/A";
				}
				if((tempsoNumber==null)||(tempsoNumber=="null")||(tempsoNumber.trim().length() == 0))
				{
					podate ="N/A";
				}
				if((soNumber==null)||(soNumber=="null")||(soNumber.trim().length() == 0))
				{
					soNumber ="N/A";
				}


				if((pono==null)||(pono=="null")||(pono.trim().length() == 0))
				{
					pono ="N/A";
				}
				if((netValue==null)||(netValue=="null")||(netValue.trim().length() == 0))
				{
					netValue ="N/A";
				}
				if((docDate==null)||(docDate=="null")||(docDate.trim().length() == 0))
				{
						docDate ="N/A";
				}				
				String anchBegin ="";
				anchBegin ="<a href=\"JavaScript:funShowDetails('"+soNumber+"','"+tfd+"','"+sttd+"','"+soCust+"','C','BackOrder','','Open','')\" style=\"cursor:hand\">"; 
				
				if("CU".equals(roleBO))
				{
					out.println("<row id='"+soNumber+"'><cell><![CDATA[<nobr>"+anchBegin+tempsoNumber+"</a></nobr>]]></cell><cell>"+docDate+"</cell><cell>"+pono+"</cell><cell>"+podate+"</cell><cell>"+netValue+"</cell></row>");
				}
				else
				{
					out.println("<row id='"+soNumber+"'><cell><![CDATA[<nobr>"+anchBegin+tempsoNumber+"</a></nobr>]]></cell><cell>"+docDate+"</cell><cell>"+pono+"</cell><cell>"+podate+"</cell><cell>"+netValue+"</cell><cell>"+cuname+"</cell></row>");
				}
							
				
			}
		}
		
//}		
	out.println("</rows>");
%>
