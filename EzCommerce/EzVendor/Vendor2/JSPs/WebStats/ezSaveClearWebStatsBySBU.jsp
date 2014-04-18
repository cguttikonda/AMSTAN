<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%
	String fd=request.getParameter("fromDate");
	String td=request.getParameter("toDate");
	String WebSysKey= request.getParameter("WebSysKey");
	String fromDate=request.getParameter("fromDate");
	String toDate=request.getParameter("toDate");
	out.println(WebSysKey);

	

%>	
		<%
		if(WebSysKey!=null)
		{
		%>	
			<%@ include file="../../../Includes/JSPs/WebStats/iClearWebStats.jsp"%>		
		<%
		}
		%>

<html>
<head>  
<link rel="stylesheet" href="../../Library/Styles/Theme1.css">
</head>
<BODY>
<br><br>

	<Table align=center>
	<Tr>
		<Td>Web Statistics are cleared sucessfully.</Td.
	</Tr>
	</Table>
	<br><br>
	<Table align=center>
	<Tr>
	   <Td align=center class=blankcell><img src="../../Images/Buttons/GO.GIF" height="20" style="cursor:hand"></Td>
	</Tr>
	</Table>
	 
</body>
</html>
