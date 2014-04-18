<%
	out.println("Mat Number :"+request.getParameter("matNo")+"<Br>");
	out.println("Mat Number :"+request.getParameter("plant")+"<Br>");
	out.println("Mat Number :"+request.getParameter("fromDate")+"<Br>");
	out.println("Mat Number :"+request.getParameter("toDate")+"<Br>");
	out.println("Mat Number :"+request.getParameter("Status")+"<Br>");
%>	
<html>
<body>
<Form  method="POST">
<input type=hidden name="selectedValues" value="<%=request.getParameter("selectedValues")%>">
<input type=button name="back" value="back" onClick="history.go(-1)">
</Form>
</Body>
</Html>
