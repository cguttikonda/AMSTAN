<%@ page import="java.util.*,ezc.ezparam.*,ezc.fedex.freight.params.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="EzFreightManager" class="ezc.fedex.freight.client.EzFreightManager" scope="page"/>
<%

	String serviceTypeCode = request.getParameter("serviceTypeCode");
	String serviceTypeDesc = request.getParameter("serviceTypeDesc");
	boolean error = false;
	
	EziServiceTypeParams eziStParams = new EziServiceTypeParams();
	EzcParams params = new EzcParams(false);
	
	eziStParams.setType("ADD_SERVICE_TYPE");
	eziStParams.setServiceType(serviceTypeCode);
	eziStParams.setServiceDesc(serviceTypeDesc);
	eziStParams.setCreatedBy(Session.getUserId());
	eziStParams.setExt1("");
	eziStParams.setExt2("");
	eziStParams.setExt3("");
	
	params.setObject(eziStParams);
	Session.prepareParams(params);
	
	try
	{
		EzFreightManager.ezAddType(params);
	}
	catch(Exception e)
	{
		error = true;
	}	
	String dispData = "Service Type created successfully";
	
	if(error)
	{
		dispData = "<font color=red>Problem occured while creating Service Type</font>";
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
		<a href="../Config/ezListSystems.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none></a>
		<!--<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>-->
	</Center>
</body>
</html>