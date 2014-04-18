<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<html>
<head>
<Title>Delete Synchronized ERPs</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<br>
<body>
<form name=myForm method=post action="">
<%@ include file="../../../Includes/JSPs/Partner/iDelCustSyncBySysKey.jsp"%>
<%
	if (!deleteError)
	{
  		response.sendRedirect("ezBPDelCustSyncBySysKey.jsp?saved=Y&BusinessPartner="+Bus_Partner+"&BusParCompName="+buspar+"&FUNCTION="+FUNCTION+"&Area="+Area+"&WebSysKey="+websyskey);
  	}
%>
</form>
</body>
</html>
