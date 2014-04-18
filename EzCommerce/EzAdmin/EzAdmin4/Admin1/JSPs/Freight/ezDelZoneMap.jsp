<%@ page import="java.util.*,ezc.ezparam.*,ezc.fedex.freight.params.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="EzFreightManager" class="ezc.fedex.freight.client.EzFreightManager" scope="page"/>
<%

	String chkMap = request.getParameter("chkMap");
	boolean error = false;
	
	EziZoneMapParams eziZoneMapParams = new EziZoneMapParams();
	EzcParams params = new EzcParams(false);
	
	eziZoneMapParams.setType("DELETE_BY_ID");
	eziZoneMapParams.setId(chkMap);
	params.setObject(eziZoneMapParams);
	Session.prepareParams(params);
	
	try
	{
		EzFreightManager.ezUpdateZoneMap(params);
	}
	catch(Exception e)
	{
		error = true;
	}	
	String dispData = "Zone Mapping deleted successfully";
	
	if(error)
	{
		dispData = "Problem occured while deleting Zone Mapping";
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
		<a href="ezListZoneMap.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</Center>
</body>
</html>