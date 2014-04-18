<%@include file="../../../Includes/Jsps/Rfq/iPieReportGenerator.jsp" %>

<Div>
	<center>
	<Table >
		<Tr><Th align="center">VENDOR STATSTICS</Th></Tr>
	</Table>
	</center>
	<Div>
	<Table border=0>
<%
	double total = 0;
	for(int i=0;i<data.length;++i)
	total += data[i];	
	
	out.println("<Tr><Td><b>VENDOR</b></Td><Td><b>QUOTES</b></Td><Td><b>PERCENTAGE</b></Td></Tr>");
	
	for(int i=0;i<labels.length;++i)
	{
%>
		<Tr><Td><%=labels[i]%></Td><Td align="center"><%=data[i]%></Td><Td  align="center"><%=Math.round(((data[i]/total)*100))%>%</Td></Tr>		
<%
	}
%>
	</Table>
	<Div id="MenuSol"></Div>
</Div>