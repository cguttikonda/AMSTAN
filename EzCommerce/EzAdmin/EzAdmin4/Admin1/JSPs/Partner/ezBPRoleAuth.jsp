<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPRoleAuth.jsp"%>

<html>
<head>
<Title>Role Authorizations</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>

<body>
<Table  width="50%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader">List Role Authorizations</Td>
  </Tr>
</Table>
<br>
<%
if( retRoleAuth.getRowCount() > 0)
{
%>

<form name=myForm method=post action="">

  <Table  border="1" align="center" width="45%">
    <Tr> 
      <Td width="48%" class="labelcell">Role :</Td>
      <Td width="52%" class="blankcell"> <%=request.getParameter("roledesc")%> 
      </Td>
    </Tr>
  </Table>
  <br>
  <Table  width="60%" border="1" align="center" class="blankcell">
    <Tr> 
      <Th colspan="2">The following authorizations are for on the system <%=systemNo%>. 
      </Th>
    </Tr>
    <Tr align="left"> 
      <Th width="11%" class="labelcell" >Selected</Th>
      <Th width="89%" class="labelcell" >Authorizations</Th>
    </Tr>
<%



	int sysRows = retSysAuth.getRowCount();
	int roleRows = retRoleAuth.getRowCount();
	for ( int i = 0; i < roleRows; i++)
	{
		String roleAuthKey = retRoleAuth.getFieldValueString(i,"AUTH_KEY").trim();
		if ( retSysAuth.find("ESA_AUTH_KEY",roleAuthKey) )
		{
%>
	    
      <Td width="11%"> 
        <input type="checkbox" name="ChkDel_<%=i%>" value="Selected" checked>
	    </Td>
	    
      <Td align="left" width="89%"> 
        <%
	    out.println(retRoleAuth.getFieldValueString(i,"AUTH_VALUE").trim()); 
	    %>
      </Td>
	    </Tr>

<%

		} //end if
	} //end for
	
%>	
  </Table>
</form>
<%
}
else
{
%>
	</Table>
	<div align="center">No Authorizations available</div>
<%
}
%>
</body>
</html>