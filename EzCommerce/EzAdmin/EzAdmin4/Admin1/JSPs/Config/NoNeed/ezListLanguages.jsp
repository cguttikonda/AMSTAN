<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListLanguages.jsp"%>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<BODY >
<Table  width="40%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader">List Of Languages</Td>
  </Tr>
</Table>
<br>
<br>
<Table  width="60%" align="center">
  <Tr align="left"> 
    <Th width="44%"> ISO Language Key</Th>
    <Th width="56%"> Language Description </Th>
  </Tr>
  <%
int langRows = ret.getRowCount();
if ( langRows > 0 ) {
	for ( int i = 0 ; i < langRows; i++ ){		
%>

  <Tr align="center"> 
    <Td align="left"><%
	out.println(ret.getFieldValue(i,LANG_ISO)); 
%></Td>

    <Td align="left"><%
	out.println(ret.getFieldValue(i,LANG_DESC)); 
%></Td>
  </Tr>

<%
	}//End for
}//End If
%> 
</Table>
<div align="center"><br>
  <form method="post" action="ezAddLang.jsp" name="">
    <input type="submit" name="Submit" value="Add Language">
  </form>
</div>
</body>
</html>