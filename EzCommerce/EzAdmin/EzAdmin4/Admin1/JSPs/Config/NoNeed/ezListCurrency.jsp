<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListCurrency.jsp"%>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<BODY >
<Table  width="40%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader">List of Currencies</Td>
  </Tr>
</Table>
<br>
<Table  width="60%" align="center">
  <Tr align="left"> 
    <Th width="44%"> Currency Key </Th>
    <Th width="56%"> Currency Description </Th>
  </Tr>
  <%
int curRows = ret.getRowCount();
if ( curRows > 0 ) {
	for ( int i = 0 ; i < curRows; i++ ){		
%>

  <Tr align="left"> 
    <Td><%
	String curDescription = (String)ret.getFieldValue(i,CURRENCY_LONG_DESC);
	out.println(ret.getFieldValue(i,CURRENCY_KEY)); 
%></Td>

    <Td><%
	if ( curDescription != null){
	      out.println(ret.getFieldValue(i,CURRENCY_LONG_DESC)); 
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