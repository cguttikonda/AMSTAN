<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iListAllUsers.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUser.jsp" %>


<html>
<head>
<Title>List Of All Users</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/User/ezListChangeUserDate.js">

</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<BODY onLoad='scrollInit()' onResize = "scrollInit()" scroll="no">
<br>
<%
int rCount = ret.getRowCount();
if ( rCount > 0 )
{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">Select User</Td>
  </Tr>
</Table>
<div id="theads">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">

  <Tr align="left">
    <Th width="44%">User</Th>
    <Th width="56%">Description</Th>
  </Tr>
</Table>
</div>

<DIV id="InnerBox1Div">

<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">

<%
	for (int i = 0 ; i < ret.getRowCount() ; i++)
	{
		String userUrl = "";
		String userid = (String) ret.getFieldValue(i,USER_ID);
		String userType = ret.getFieldValueString(i,"EU_TYPE");
		if ( userType.equals("2") )
		{
		     userUrl = "ezChangeIntranetUserData.jsp?UserID=";
		}
		else
		{
		     userUrl = "ezChangeUserData.jsp?BusinessUser=";
		}
		userUrl = userUrl+userid;
%>
  <Tr align="left">
    <Td width = "44%">
<%
		out.println("<a href=\""+userUrl+"\" >");
		out.println (userid);
		out.println ("</a>");
%>
	</Td>
    <Td width = "56%">
<%
 	String fname = (String) ret.getFieldValue(i,USER_FIRST_NAME);
	if(fname != null) fname = fname.trim(); else fname="";
 	String mname = (String) ret.getFieldValue(i,USER_MIDDLE_INIT);
	if(mname !=null) mname = mname.trim(); else  mname = " ";
 	String lname = (String) ret.getFieldValue(i,USER_LAST_NAME);
	if(lname!=null) lname=lname.trim(); else lname = " ";
	String Name  = fname +" "+ mname +" "+  lname;
	// User Full Name
	out.println (((String)Name).toUpperCase());
%>
	</Td>
  </Tr>
<%
	}//End for
%>
</Table></div>
<%
} else {
%>
	<br><br><br>
	<Table  width="40%" border="0" align="center">
	  <Tr align="center">
	    <Td class="displayheader">There are no users to change</Td>
	  </Tr>
	</Table>

<%
}
%>
</body>
</html>
