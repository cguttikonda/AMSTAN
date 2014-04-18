<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<html>      
<head>       

<Title>Delete Synchronized ERPs</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<br>
<body bgcolor="#FFFFF7"> 

<form name=myForm method=post action="">
<%@ include file="../../../Includes/JSPs/Partner/iDelCustSync.jsp"%>

<%
	if ( !deleteError )         
	{
  		response.sendRedirect("ezBPDelCustSync.jsp?saved=Y&BusinessPartner="+Bus_Partner+"&FUNCTION="+FUNCTION);
  	} //end if   
%>

</form>
</body>
</html>   
