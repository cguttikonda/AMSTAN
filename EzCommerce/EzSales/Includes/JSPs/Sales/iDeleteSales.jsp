<%@ page import="ezc.ezparam.*"%>
<%@ page import="ezc.sales.params.*,java.util.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="SalesManager" class="ezc.sales.local.client.EzSalesManager" scope="page" />


<%
	EzcSalesOrderParams ezcParams = new EzcSalesOrderParams();
	ezcParams.setLocalStore("Y");
	Session.prepareParams(ezcParams);

	String Lines = request.getParameter("chk");
	String netValue=request.getParameter("netValue");
	String subValue =request.getParameter("TotalValue");
	String status = request.getParameter("status");
	String soldTo=request.getParameter("soldTo");
	String sysKey =request.getParameter("sysKey");
	
	if(netValue!=null && !"null".equals(netValue) && netValue.indexOf(",")!=-1)
	{
		StringBuffer sb = new StringBuffer(netValue);
		sb.deleteCharAt(netValue.indexOf(","));
		while(sb.indexOf(",")!=-1)
		{
			sb.deleteCharAt(sb.indexOf(","));
		
		}
		netValue = sb.toString();
	
	}

if("NEW".equals(status))


	if(   (netValue == null) || (netValue.trim().length() ==0) )
		netValue="0";
	if(   (subValue == null) || (subValue.trim().length() ==0) )
		subValue="0";

	double netV =0;
	double subV =0;
	double totv=0;
	try{
	 netV = Double.parseDouble(netValue);
	 subV = Double.parseDouble(subValue);
	}catch(Exception e)
	{}

        	
	totv=subV-netV;
	
	StringTokenizer myTokens= new StringTokenizer(Lines,",");
	String[] LineNos= new String[myTokens.countTokens()];
	int c=0;
	while(myTokens.hasMoreTokens())
	{
		 LineNos[c]=myTokens.nextToken();
		 c++;
	}
	
	String OrderNo = request.getParameter("SONO");
	int totLines = 0;
	
	try{
	     totLines = Integer.parseInt(request.getParameter("total"));
	}catch(Exception e)
	{
	     totLines = 0;
	}
	
	if(totLines != LineNos.length)
	{
		EziSalesLinesParams iSLParams=new EziSalesLinesParams();
		EziDeliverySchedulesParams iDSParams = new EziDeliverySchedulesParams();

		ezcParams.setObject(iSLParams);
		ezcParams.setObject(iDSParams);

		iSLParams.setDocNumber(OrderNo);
		iSLParams.setLineNos(LineNos);
		iSLParams.setNetValue(netValue);	

		iDSParams.setSalesDocNumber(OrderNo);
		iDSParams.setLineNos(LineNos);

		SalesManager.ezDeleteSOLine(ezcParams);
	}
	else
	{
		EziSalesHeaderParams iSHParams=new EziSalesHeaderParams();
		iSHParams.setDocNumber(OrderNo);
		ezcParams.setObject(iSHParams);
		SalesManager.ezDeleteSOHeader(ezcParams);
	}
	
	
%>

		
<jsp:forward page="ezEditSales.jsp" >
		<jsp:param name='webOrNo' value='<%=OrderNo%>' />
</jsp:forward>	
	