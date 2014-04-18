<%@ include file="../Misc/iBlockControl.jsp"%>
<%@ page import="ezc.ezparam.*"%>
<%@ page import="ezc.sales.params.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="SalesManager" class="ezc.sales.local.client.EzSalesManager" scope="page" />
<%
	EzcSalesOrderParams ezcParams = new EzcSalesOrderParams();
	ezcParams.setLocalStore("Y");
	Session.prepareParams(ezcParams);
	String OrderNoarr = request.getParameter("chk2");
	String[] OrderNo = OrderNoarr.split("#");
	String listUrl=request.getParameter("ordType");

	if("'RETNEW'".toUpperCase().equals(listUrl.toUpperCase()))
		listUrl	="dro";
	else
		listUrl	="dso";
		
	String OrderNos="";
	
	for(int i=0;i<OrderNo.length;i++)
	{
		try
		{
			OrderNo[i] = OrderNo[i].substring(0,OrderNo[i].indexOf(","));
		}
		catch(Exception e)
		{
		}
		if(i==0)
			OrderNos=OrderNo[i].trim();
		else
			OrderNos=OrderNos+"','"+OrderNo[i].trim();
	}
	EziSalesLinesParams iSLParams=new EziSalesLinesParams();
	ezcParams.setObject(iSLParams);
	iSLParams.setDocNumber(OrderNos);
	SalesManager.ezDeleteSOPer(ezcParams);

%>
<html>
<body>
<form method=post >
<input type=hidden name="urlPage"  value="<%=listUrl%>">
<input type=hidden name="orderStatus"  value="'NEW'">
<input type=hidden name="RefDocType"  value="P">

</form>
<script>
	document.forms[0].action="ezSavedOrdersList.jsp"
	document.forms[0].submit();
</script>
</body>
</html>
<%@ include file="../Misc/iReleaseControl.jsp"%>