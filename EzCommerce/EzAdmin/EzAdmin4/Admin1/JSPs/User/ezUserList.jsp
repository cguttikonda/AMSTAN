<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iUserList.jsp"%>

<html>
<head>
<Title>Business User Authorizations</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body>

<form name=myForm method=post action="ezUserAuthList.jsp" target="auth">

  <Table  width="41%" border="1" align="center">
    <Tr> 
      <Td width="48%" class="labelcell">Business User:</Td>
      <Td width="40%"> <% 
int userRows = retuser.getRowCount();
String userName = null;
	if ( userRows > 0 ) {
        out.println("<select name=\"BusUser\" >"); 
		for ( int i = 0 ; i < userRows ; i++ ){		
	        out.println("<option value="+retuser.getFieldValue(i,USER_ID)+">"); 
			userName = (String)retuser.getFieldValue(i,USER_ID);
			userName = userName.trim();
			if (userName != null){
				out.println(userName);
			}
	        out.println("</option>"); 
		}//End for
        out.println("</select>"); 
%> </Td>
      <Td width="12%" class="blankcell"> 
        <input type="submit" name="Submit" value="Go">
      </Td>
<%
}//end if users>0
%>
    </Tr>
  </Table>
</form>
</body>
</html>