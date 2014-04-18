<%@ page import ="ezc.ezparam.*,ezc.sales.local.params.*,ezc.client.*" %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ page import = "ezc.ezbasicutil.EzReplace" %>

<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%

	String webOrNo =request.getParameter("Back");
	String formPath =request.getParameter("formPath");
	String soldTO =request.getParameter("SoldTo");
	String orderType=request.getParameter("orderType");
	
	ReturnObjFromRetrieve mainRet = null;

	ReturnObjFromRetrieve retHeader = null;
	ReturnObjFromRetrieve retLines = null;
	ReturnObjFromRetrieve retDeliverySchedules = null;

	ReturnObjFromRetrieve sdHeader = null;
	ReturnObjFromRetrieve sdSoldTo = null;
	ReturnObjFromRetrieve sdShipTo = null;


	EzcSalesOrderParams ezcSOParams = new EzcSalesOrderParams();
	ezcSOParams.setLocalStore("Y");
	Session.prepareParams(ezcSOParams);

	EziSalesOrderStatusParams iSOStatusParams = new EziSalesOrderStatusParams();
	EziSalesHeaderParams iSOHeader = new EziSalesHeaderParams();
	EzSalesOrderStructure SOStrut = new EzSalesOrderStructure();

	ezcSOParams.setObject(iSOStatusParams);
	ezcSOParams.setObject(iSOHeader);
	ezcSOParams.setObject(SOStrut);

	SOStrut.setDeliverySchedules("X");

	int rowCount = 0;
	String soldToCheck =(String)session.getValue("AgentCode");
	String SoldToCheck1="";
	String salesAreaCheck1="";

	StringTokenizer stoken=new StringTokenizer(soldToCheck,",");
	
	if (stoken.countTokens()>1)
	{
		while(stoken.hasMoreTokens())
			SoldToCheck1+="'"+stoken.nextToken()+"',";
		SoldToCheck1=SoldToCheck1.substring(0,SoldToCheck1.length()-1);
	}
	else
		SoldToCheck1="'"+soldToCheck+"'";	
	
	String salesAreaCheck =  (String)session.getValue("SalesAreaCode");
	StringTokenizer stokenSales=new StringTokenizer(salesAreaCheck,",");
	
	if (stokenSales.countTokens()>1)
	{
		while(stokenSales.hasMoreTokens())
			salesAreaCheck1+="'"+stoken.nextToken()+"',";
		salesAreaCheck1=salesAreaCheck1.substring(0,salesAreaCheck1.length()-1);
	}
	else
	{
		salesAreaCheck1="'"+salesAreaCheck+"'";	
	}
	

	


	String UserIdCheck = Session.getUserId();
	
	
	iSOHeader.setType("");
	iSOHeader.setCol("SalesOrder");
	iSOHeader.setBackEndNumber(webOrNo);
	iSOHeader.setDocNumber(webOrNo);
	iSOHeader.setSoldTo(SoldToCheck1);
	iSOHeader.setSalesArea(salesAreaCheck1);
	
		

		
		try{
		EzoSalesOrderStatus soStatus  = (EzoSalesOrderStatus)EzSalesOrderManager.ezSalesOrderStatus(ezcSOParams);
		mainRet = soStatus.getReturn();

		retHeader = (ReturnObjFromRetrieve)mainRet.getObject("SALES_HEADER");
		retLines = (ReturnObjFromRetrieve)mainRet.getObject("SALES_LINES");
		retDeliverySchedules = (ReturnObjFromRetrieve)mainRet.getObject("DELIVERY_LINES");
		rowCount = retLines.getRowCount();
		sdHeader = (ReturnObjFromRetrieve)retHeader.getObject("SdHeader");
		sdSoldTo = (ReturnObjFromRetrieve)retHeader.getObject("SdSoldTo");
		sdShipTo = (ReturnObjFromRetrieve)retHeader.getObject("SdShipTo");
		}catch(Exception e){}
		if(rowCount == 0 || sdHeader== null ||  sdHeader.getRowCount() == 0)
		{
			 String webOrNoVal = webOrNo;
	                 String statusVal = request.getParameter("status");

			// out.println("*********"+formPath);
			 if(formPath==null || "null".equals(formPath))
				response.sendRedirect("ezWebSalesError.jsp?FromDate="+fromDate+"&ToDate="+toDate+"&status="+orderStatus+"&newFilter="+newFilter+"&webOrNo="+webOrNo);
			 else
			  	response.sendRedirect("ezPrintError.jsp?SoldTo="+soldTO+"&status="+orderStatus+"&SONumber="+webOrNo+"&orderType="+orderType);

		}
		else{
			session.putValue("EzDeliveryLines",retDeliverySchedules);
		}
		//out.println(""+sdHeader.toEzcString());

%>
