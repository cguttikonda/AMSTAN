<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%
	String fd=request.getParameter("fromDate");
	String td=request.getParameter("toDate");
	String WebSysKey= request.getParameter("WebSysKey");
	String fromDate=request.getParameter("fromDate");
	String toDate=request.getParameter("toDate");
	if(WebSysKey!=null)
		{
%>	
			<%@ include file="../../../Includes/JSPs/WebStats/iClearWebStats.jsp"%>		
<%
		}
%>
<html>
<head>  
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<BODY>
<br><br><br><br>
<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th>Web Statistics are cleared sucessfully.</Th>
	</Tr>
	</Table>
	<br>
	<Table  align=center>
	<Tr>
	   <Td align=center class=blankcell>
	   <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</Td>
	</Tr>
	</Table>
 
</body>
</html>
