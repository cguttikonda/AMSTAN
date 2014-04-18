<%@ page import="java.util.*,ezc.ezparam.*,ezc.fedex.freight.params.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="EzFreightManager" class="ezc.fedex.freight.client.EzFreightManager" scope="page"/>
<%

	String chkSt = request.getParameter("chkSt");
	boolean error = false;

	EziServiceTypeParams eziStParams = new EziServiceTypeParams();
	EzcParams params = new EzcParams(false);
	
	eziStParams.setType("DELETE_SERVICE_TYPE");
	eziStParams.setServiceType(chkSt);
	params.setObject(eziStParams);
	Session.prepareParams(params);

	
	try
	{
		EzFreightManager.ezUpdateType(params);
	}
	catch(Exception e)
	{
		error = true;
	}	
	String dispData = "Service Type deleted successfully";
	
	if(error)
	{
		dispData = "Problem occured while deleting Service Type";
	}
	
%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<%@ include file="../../Library/Globals/CacheControl.jsp"%>
</head>
<body>
	<br><br><br><br>
	<Table width="60%" border="1" align="center" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
	<Tr>
		<Th align=center><%=dispData%></Th>
	</Tr>
	</Table>
	<br><br>
	<Center>
		<a href="ezListServiceType.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none></a>
	</Center>
</body>
</html>