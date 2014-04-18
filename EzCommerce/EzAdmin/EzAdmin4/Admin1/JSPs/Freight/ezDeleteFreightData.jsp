<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import = "ezc.ezcommon.*" %>
<%@page import="javax.jms.*,java.util.*,javax.naming.*,java.io.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ page import="java.util.*,ezc.ezparam.*,ezc.fedex.freight.params.*"%>
<jsp:useBean id="EzFreightManager" class="ezc.fedex.freight.client.EzFreightManager" scope="page"/>

<%
	String strTemp[] 	= request.getParameterValues("chk1");
	boolean error = false;
	
	EziFreightMasterTable efmTab = new EziFreightMasterTable();
	EziFreightMasterParams efmParams = new EziFreightMasterParams();
	EzcParams params = new EzcParams(false);
	EziFreightMasterRow efmRow = null;
	
	for(int i=0;i<strTemp.length;i++)
	{
		ezc.ezbasicutil.EzStringTokenizer EzToken = new ezc.ezbasicutil.EzStringTokenizer(strTemp[i],"¥");
		java.util.Vector Tokens = EzToken.getTokens();	
		
		efmParams.setType("DELETE_FREIGHT");
		efmParams.setServiceType((String)Tokens.elementAt(0));
		efmParams.setZone((String)Tokens.elementAt(1));
		efmParams.setCountryCode((String)Tokens.elementAt(2));
		efmParams.setPackType((String)Tokens.elementAt(3));
		efmParams.setWeight((String)Tokens.elementAt(4));
		efmParams.setKey((String)Tokens.elementAt(5));
		
	}	
	params.setObject(efmParams);
	Session.prepareParams(params);

	
	try
	{
		EzFreightManager.ezUpdateFreightMaster(params);
	}
	catch(Exception e)
	{
		error = true;
	}	
	String dispData = "Freight Master updated successfully";
	
	if(error)
	{
		dispData = "<font color=red>Problem occured while deleting Freight Master</font>";
	}
%>
<html>
<head>
<title>Message</title>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script>
		
	function DisableRightButton()
	{	
	}
	
	function funOK()
	{
		document.myForm.action="../Config/ezListSystems.jsp";
		document.myForm.submit();
	}
	
</Script>	
</head>
<body onContextMenu="DisableRightButton(); return false" bgcolor="#FFFFF7">
<form name="myForm" method="post">
<br><br><br><br>
<table width="50%" align="center" border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
	<tr align="center">
		<th><%=dispData%></th>
	</tr>
</table>
<br><br><br><br>
<center>
	<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none onClick="funOK()"> 
</center>
<Div id="MenuSol"></Div>
</form>
</body>
</html>