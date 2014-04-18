<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iDeleteUserInput.jsp"%>

<html>
<head>

<Title>ezDeleteUserInput</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/User/ezDeleteUserInput.js">
</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>


</head>
<BODY onLoad='scrollInit()' onResize = "scrollInit()">
<br>
<script language="JavaScript" src="../../../Includes/Lib/JavaScript/Users.js">
</script>

<form name=myForm method=post action="ezDeleteUser.jsp">

<%
int userRows = ret.getRowCount();

/** Added by Venkat on 5/1/2001 to process only if number of users are more than zero **/

if ( userRows > 0 )
{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	  <Tr align="center">
	    <Td class="displayheader">Delete User</Td>
	  </Tr>
	</Table>
<div id="theads">
<Table id="theads" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    <Tr>
      <Th width="10%"> Delete </Th>
      <Th width="42%" align="left">User</Th>
      <Th width="58%" align="left">Description</Th>
    </Tr>
</Table>
</div>

<DIV id="InnerBox1Div">

<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>

<%
	for (int i = 0 ; i < userRows; i++)
	{
%>
    <Tr align="center">
      <Td width="10%">
       	<input type="checkbox" name="CheckBox_<%=i%>" value="Selected" unchecked>

	</Td>
      <Td align="left" width="42%">
		<a href="ezUserDetails.jsp?UserID=<%=(String) ret.getFieldValue(i,USER_ID)%>" >
		<%=( (String) ret.getFieldValue(i,USER_ID) )%>
		</a>
		<input type="hidden" name="UserName_<%=i%>" value=<%=(String) ret.getFieldValue(i,USER_ID)%> >

	</Td>
      <Td align="left" width="58%">
<%
		// User Full Name
		String fname = (String) ret.getFieldValue(i,USER_FIRST_NAME);
		if(fname!=null) fname=fname.trim(); else fname ="";
		String mname = (String) ret.getFieldValue(i,USER_MIDDLE_INIT);
		if(mname!=null) mname=mname.trim(); else mname =" ";
		String lname = (String) ret.getFieldValue(i,USER_LAST_NAME);
		if(lname!=null) lname=lname.trim(); else lname =" ";
		String Name  = fname+" "+mname+" "+lname ;
%>
		<%=((String)Name).toUpperCase()%>

	</Td>
    </Tr>
<%
	}//End for
%>
	<input type="hidden" name="TotalCount" value=<%=userRows%>>
</Table></div>
<div id="ButtonDiv" align="center" style="position:absolute;;visibility:visible;top:90%;width:100%">
<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/delete.gif" name="Submit" value="Delete" onClick="checkDelRows(<%= userRows%>,'UserList');return document.returnValue;">
  </div>
<%
}
else
{
%>
	<br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	  <Tr align="center">
	    <Td class="displayheader">There are no users to delete</Td>
	  </Tr>
	</Table>
<%
} //if userRows > 0
%>
</form>
</body>
</html>
