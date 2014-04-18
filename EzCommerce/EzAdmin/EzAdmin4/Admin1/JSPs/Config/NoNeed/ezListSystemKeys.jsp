<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListSystemKeys.jsp"%>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<BODY >
<Table  width="40%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader">List of Catalog Areas</Td>
  </Tr>
</Table>
<br>
<Table  width="60%" align="center">
  <Tr align="left"> 
    <Th width="44%"> Catalog Areas </Th>
    <Th width="56%"> Description </Th>
  </Tr>
  <%
int sysRows = ret.getRowCount();
if ( sysRows > 0 ) {
	for ( int i = 0 ; i < sysRows; i++ ){		
%>

  <Tr align="left"> 
    <Td><%
	String sysDescription = (String)ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION);
	out.println(ret.getFieldValue(i,SYSTEM_KEY)); 
%></Td>

    <Td><%
	if ( sysDescription != null){
	      	out.println(sysDescription); 
	}
%></Td>
  </Tr>

<%
	}//End for
}//End If
%> 
</Table>
</body>
</html>