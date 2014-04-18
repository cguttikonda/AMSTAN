

<html>      
<head>   
<Title>Delete ERP SoldTos and Partner Functions</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body bgcolor="#FFFFF7">   

<form name=myForm method=post action="ezDisplaySyncError.jsp">


<%
	String errorArea = request.getParameter("ERRORAREA");
	String Rows = request.getParameter("Rows");

	
	if ( Rows == null ) Rows = "0";
	int errRows = (new Integer(Rows)).intValue();

	errRows = 1;
	
	out.println("Delete was not successfull");
	out.println("The Following users are assigned to this area"+errorArea);
	for (int j = 0; j < errRows; j++)
	{
		out.println(request.getParameter("Error_"+j));
	}
%>
</form>
</body>
</html>
