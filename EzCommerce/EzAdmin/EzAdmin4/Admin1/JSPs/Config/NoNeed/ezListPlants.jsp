<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListPlants.jsp"%>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<BODY >
<Table  width="40%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader">List of Plants</Td>
  </Tr>
</Table>
<br>
<Table  width="60%" align="center">
  <Tr align="left"> 
    <Th width="44%"> Plant Name </Th>
    <Th width="56%"> Plant Description </Th>
  </Tr>
  <%
int plantRows = ret.getRowCount();
if ( plantRows > 0 ) {
	for ( int i = 0 ; i < plantRows ; i++ ){		
%>

  <Tr align="left"> 
    <Td><%
	String plantDescription = (String)ret.getFieldValue(i,PLANT_DESC);
	out.println(ret.getFieldValue(i,PLANT_NAME)); 
%></Td>

    <Td><%
		if ( plantDescription != null){
		      out.println(plantDescription); 
		}
%></Td>
  </Tr>

<%
	}//End for
}//End If
%> 
</Table>
</BODY>
</HTML>