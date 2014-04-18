<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="java.util.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezshipment.client.*" %>
<%@ page import = "ezc.ezshipment.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" /> 

<%
	

	String shipId=request.getParameter("shipId");
	String lineNo[]=request.getParameterValues("Chk");
	String opStat=request.getParameter("OpStat");	//Used to check Deelete Shipment or Shipment Line
	String poNo = request.getParameter("baseValue");
	String orderBase        = request.getParameter("orderBase");

	String base = request.getParameter("base");
	String OrderValue  = request.getParameter("OrderValue");
	String orderCurrency = request.getParameter("orderCurrency");
	String currency = request.getParameter("currency");
	String OrderDate = request.getParameter("OrderDate");

	String shLines="";
	for ( int i=0; i < lineNo.length ; i++) {
		shLines = shLines + lineNo[i] + ",";
	}
	
	EzShipmentManager shipManager = new EzShipmentManager();
	EziShipmentInfoParams inParams = new EziShipmentInfoParams();

	inParams.setShipId(shipId);
	inParams.setLineNumber(shLines.substring(0,shLines.length()-1));
	if ("All".equals(opStat))
		inParams.setSelection("A");	//To Delete Shipment
	else 
		inParams.setSelection("L");	//To Delete Lines 

	EzcParams shipParams=new EzcParams(true);
	shipParams.setLocalStore("Y");
	shipParams.setObject(inParams);
	Session.prepareParams(shipParams);
	shipManager.ezDeleteShipmentInfo(shipParams);
	if ("All".equals(opStat))
		response.sendRedirect("ezViewShipmentHeader.jsp?showData=Y&orderBase="+orderBase+"&ponum="+poNo+"&baseValues="+poNo+"&base="+base+"&OrderValue="+OrderValue+"&orderCurrency="+orderCurrency+"&currency="+currency+"&OrderDate="+OrderDate);
	else	
		response.sendRedirect("ezShipmentDetails.jsp?ShipId="+shipId+"&orderBase="+orderBase+"&ponum="+poNo+"&Status=N&base="+base+"&OrderValue="+OrderValue+"&orderCurrency="+orderCurrency+"&currency="+currency+"&OrderDate="+OrderDate);
%>
<Div id="MenuSol"></Div>	






