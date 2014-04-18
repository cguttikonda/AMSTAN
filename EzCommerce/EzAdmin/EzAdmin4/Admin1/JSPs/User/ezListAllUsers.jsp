<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<%@ include file="../../../Includes/JSPs/User/iListAllUsers.jsp"%>

<%@ include file="../../../Includes/Lib/AdminUser.jsp" %>
<html>
<head>
<Title>List Of All Users</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<script src="../../Library/JavaScript/User/ezListAllUsers.js">
</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script src="../../Library/JavaScript/ezSortTableData.js"></script>
</head>
<body bgcolor="#FFFFF7" onLoad='scrollInit()' onresize='scrollInit()' scroll=no>

<form name=myForm method=post action="">
<br>
<%
int rCount = ret.getRowCount();
if ( rCount > 0 )
{
%>
  <Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <Tr align="center">
    <Td class="displayheader">List Of Users</Td>
  </Tr>
</Table>
<div id="theads">
  <Table id="tabHead" width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <Tr align="left">
  	<Th width="5%">M</Th>
    <Th width="26%" >UserId</Th>
    <Th width="50%" >User Name</Th>
    <Th width="16%" >Type</Th>
  </Tr>
  </Table>
  </div>
 

<DIV id="InnerBox1Div">
    <Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
  <%

	for (int i = 0 ; i < ret.getRowCount() ; i++)
	{
%>
  <Tr align="left">
  <Td width="5%">
  	<input type="checkbox" name="chk1" value="<%=ret.getFieldValueString(i,USER_ID)%>" >
  </Td>
    <Td width="26%">
<%

	String uType = ret.getFieldValueString(i,"EU_TYPE");
	String userUrl = "ezUserDetails.jsp?UserID="+(String) ret.getFieldValue(i,USER_ID);
	String userType = "Business";

	if ( uType.equals("2") ) //intranet user
	{
%>
		<input type="hidden" name="interuser" value="IU">
		<input type="hidden" name="UserID" value=<%=((String)ret.getFieldValue(i,USER_ID)).trim()%> >
<%
		userUrl = "ezViewIntranetUserData.jsp?UserID="+((String)ret.getFieldValue(i,USER_ID)).trim()+"&Show=Yes";
		userType="Intranet";
	}
		// Bussiness User
	else
	{
%>
		<input type="hidden" name="interuser" value="BU">
<%
	}
%>

	<a href=<%=userUrl%> >
	<%=( (String) ret.getFieldValue(i,USER_ID) )%>
	</a>

    </Td>
    <Td width="50%">
<%

 	String fname = (String) ret.getFieldValue(i,USER_FIRST_NAME);
	if(fname != null) fname = fname.trim(); else fname="";
 	String mname = (String) ret.getFieldValue(i,USER_MIDDLE_INIT);
	if(mname !=null) mname = mname.trim(); else  mname = " ";
 	String lname = (String) ret.getFieldValue(i,USER_LAST_NAME);
	if(lname!=null) lname=lname.trim(); else lname = " ";
	String Name  = fname +" "+ mname +" "+  lname;
	// User Full Name
%>
	<%=((String)Name).toUpperCase()%>

    </Td>
    <Td width="16%"><%=userType%></Td>
  </Tr>

  	
<%
	}//End for
%>
</Table>
</div>

<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	<a href="javascript:funCheckBoxSingleModify()"><img src="../../Images/Buttons/<%= ButtonDir%>/modify.gif" border=none></a>
	<a href="javascript:funCheckBoxSingleDelete()"><img src="../../Images/Buttons/<%= ButtonDir%>/delete.gif" border=none></a>
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</div>

<%
} else {
%>
	<br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	  <Tr align="center">
	    <Td class="displayheader">There are no users to list</Td>
	  </Tr>
	</Table><br>
	<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<% } //if rCount > 0 %>

<%
	String saved = request.getParameter("saved");
	String uid = request.getParameter("uid");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('Password is reset for <%=uid%>');
		</script>
<%
	} //end if
%>
<input type="hidden" name="BusinessUser" value="" >
</form>
</body>
</html>
