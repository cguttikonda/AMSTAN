<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iListforDefaults.jsp"%>

<html>
<head>
<Title>List Business Partners </Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>

<body bgcolor="#FFFFF7">
<Table  width="50%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader">Select a Partner for Setting Defaults</Td>
  </Tr>
</Table>
<br>
<Table  width="60%" hspace="20" align="center">
  <Tr> 
    <Th width="51%" class="labelcell"> 
      <div align="center" class="labelcell">Partner Number</div>
    </Th>
    <Th width="49%" class="labelcell"> 
      <div align="center">Partner Description</div>
    </Th>
  </Tr>
  <%
int bpRows = ret.getRowCount();
String companyName = null;
if ( bpRows > 0 ) {
	for ( int i = 0 ; i < bpRows; i++ ){		
 %> 
  <Tr> 
    <Td align="center"> <%
		out.println("<a href = ezBPDefaultsList.jsp?BusinessPartner=" + (ret.getFieldValue(i,BP_NUMBER))+" >" );
	      out.println(ret.getFieldValue(i,BP_NUMBER)); 
        	out.println("</a>");
 %> </Td>
    <Td align="center"> <%
		companyName = (String)ret.getFieldValue(i,BP_COMPANY_NAME);
		if (companyName != null)
			out.println(companyName);
 %> </Td>
  </Tr>
  <%
	}//End for
}//End If
%> 
</Table>
</body>
</html>