<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iShowGraph.jsp"%>
<%
    if(infoRet.getRowCount() != 0)
    {
    
%>

	<%@ taglib uri="CreateGraph" prefix="Ezc" %>
	<html>
	<head>
	        <Title>EzCommerce Graphs</Title>
	        
	</head>
	<body>
	<Ezc:Graph width="500" height="300" />

	<Table align="center">
	  <Tr><Td>
		<img src="../../../../../../tmpImgs/<%=fileName%>.jpg">
	  </Td></Tr>
	  </Table>
  
	</body>
	</html>
<%
    }	
%>