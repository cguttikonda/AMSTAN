
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ page import ="ezc.ezparam.*,java.util.*"%>
<%@ page import ="ezc.ezparam.ReturnObjFromRetrieve"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%
        String urlPage = request.getParameter("urlPage");
	String viewPage=request.getParameter("viewPage");
	String orderStatus=request.getParameter("orderStatus");
	String msg=(String)session.getValue("EzMsg");
	String welcome=(String)session.getValue("welcome");
	String footer = request.getParameter("footer");
	String str=request.getParameter("newFilter");


	System.out.println("msg=-====="+msg);
	System.out.println("viewPage=-====="+viewPage);
	System.out.println("orderStatus=-====="+orderStatus);
	System.out.println("welcome=-====="+welcome);
	System.out.println("footer=-====="+footer);
	System.out.println("urlPage=-====="+urlPage);
	System.out.println("str=-====="+str);



	if(session.getValue("welcome")!= null)
		session.removeValue("welcome");
	if(welcome == null)
		welcome="";
	

	String ref=request.getParameter("RefDocType");

	if ("dso".equals(urlPage))
                urlPage = "../Sales/ezListSalesOrders.jsp?orderStatus='NEW'&RefDocType=P";
	else
	if ("dro".equals(urlPage))
                urlPage = "../Sales/ezListSalesOrders.jsp?orderStatus='RETNEW'&RefDocType=R";
	else if("listPage".equalsIgnoreCase(urlPage))
	{
		urlPage="../Sales/ezListSalesOrders.jsp?orderStatus="+orderStatus+"&RefDocType=P&newFilter=" +str ;
	}
	else if("OpenBackEndList".equalsIgnoreCase(urlPage))
	{
		urlPage ="ezListWait.jsp?urlString=../Sales/ezBackEndSOList.jsp&RefDocType="+ref;
	}
	else if("ClosedBackEndList".equalsIgnoreCase(urlPage))
	{
		String fromDate=request.getParameter("FromDate");
		String toDate=request.getParameter("ToDate");
		String fromForm=request.getParameter("FromForm");

		String[] customer = request.getParameterValues("customer");
		String[] customerDate=request.getParameterValues("customerDate");
		if(customer != null)
		session.putValue("customer",customer);
		else
		session.removeValue("customer");

		if(customerDate != null)
		session.putValue("customerDate",customerDate);
		else
		session.removeValue("customerDate");

		String datesFlag=request.getParameter("DatesFlag");
 		String monthOpt= request.getParameter("ezMonths");

		String concat="../Sales/ezBackEndClosedSOList.jsp&RefDocType="+ref;
		if((fromDate != null)&&(toDate != null)&&(fromForm != null))
		{
			if(fromDate.length()>5)
				concat+="&FromDate="+ fromDate +"&ToDate=" + toDate + "&FromForm=" + fromForm+"&customer="+customer+"&customerDate="+customerDate+"&DatesFlag="+datesFlag+"&ezMonths="+monthOpt;

		}

		urlPage="ezListWait.jsp?urlString="+concat;

	}else if("ClosedReturnBackEndList".equalsIgnoreCase(urlPage))
	{
		urlPage ="ezListWait.jsp?urlString=../Sales/ezBackEndClosedReturnList.jsp&RefDocType=ref";

	}else if("OpenReturnBackEndList".equalsIgnoreCase(urlPage))
	{
		urlPage ="ezListWait.jsp?urlString=../Sales/ezBackEndOpenReturnList.jsp&RefDocType=ref";

	}else if("OpenFRSBackEndList".equalsIgnoreCase(urlPage))
	{
		urlPage ="ezListWait.jsp?urlString=../Sales/ezBackEndFRSList.jsp&RefDocType=ref";
	}else if("ezOP".equalsIgnoreCase(urlPage))
	{
		urlPage ="ezListWait.jsp?urlString=../Sales/ezOpenInvoices.jsp";
	}else if("ezCP".equalsIgnoreCase(urlPage))
	{
		String fromDate=request.getParameter("FromDate");
		String toDate=request.getParameter("ToDate");
		String fromForm=request.getParameter("FromForm");

	
		String monthOpt= request.getParameter("ezMonths");
		String datesFlag=request.getParameter("DatesFlag");

		String concat="../Sales/ezClosedInvoices.jsp";
		if((fromDate != null)&&(toDate != null)&&(fromForm != null))
		{
			if(fromDate.length()>5)
				concat+="&FromDate="+ fromDate +"&ToDate=" + toDate + "&FromForm=" + fromForm+"&ezMonths="+monthOpt+"&DatesFlag="+datesFlag;
		}

		urlPage="ezListWait.jsp?urlString="+concat;

	}else if("ezIA".equalsIgnoreCase(urlPage))
	{
		urlPage ="ezListWait.jsp?urlString=../Sales/ezInvoicesAging.jsp";
	}else
	{
		if("1".equals(welcome))
		{

			urlPage = "ezListWait.jsp?urlString=ezWelcome.jsp";
		}
		else
		{
			if( ("Y").equals(footer) )
				urlPage = "ezListWait.jsp?urlString=ezWelcome.jsp";
			else
				urlPage = "ezWelcome.jsp";   // ezWelcomeNoAlerts.jsp";
		}
	}

	
	if(msg!=null)
	{
		urlPage="ezOutMsg.jsp";
	}
	

	int banWidth=18;


%>
<html>
<head>
<title>Welcome to Continental Resources Web Portal</title>
</head>
<frameset rows="20,*" cols="*" border="0" framespacing="0"  marginheight=0 margintop=0>
	<frame src="ezSalesCUMenu.jsp" scrolling="no" name="menu" frameborder="NO" marginwidth="0"  marginheight=0 margintop=0>
	<frame src="<%= urlPage %>" name="display" frameborder="NO" marginwidth="0"  marginheight=0 margintop=0>
</frameset>
<noframes>
<body bgcolor="#FFFFFF">
</body>
</noframes>
<Div id="MenuSol"></Div>
</html>