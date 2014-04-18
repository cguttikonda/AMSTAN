
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iUserAuthList.jsp"%>
<html>
<head>


<script language = "javascript">
</script>

<Title>Business User Authorizations</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<script src="../../Library/JavaScript/User/ezUserAuthList.js">

</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

</head>
<body bgcolor="#FFFFF7" onLoad='scrollInit()' onResize='scrollInit()' scroll="no">
<br>
<%
int userRows = retuser.getRowCount();
String userName = null;
if ( userRows > 0 )
{
%>

<form name=myForm method=post action="ezSaveUserAuthList.jsp">


    <Table  width="41%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <Tr>
      <Th width="48%" class="labelcell">
        <div align="right">User:</div>
      </Th>
      <Td width="40%">
      <div id = listBoxDiv><select name="BusUser" onChange="myalert()" >
<%
	for ( int i = 0 ; i < userRows ; i++ )
	{
		userName = (String)retuser.getFieldValue(i,USER_ID);
		userName = userName.trim();
		String isSel = "";
		if ( bus_user.trim().equals(userName) )isSel="selected";
%>
	        <option <%=isSel%> value=<%=retuser.getFieldValue(i,USER_ID)%> >
<%
		if (userName != null)
		{
%>
			<%=userName%>
<%
		}
%>
	        </option>
<%
	}//End for
%>
    	</select></div>

	</Td>

    </Tr>
  </Table>

<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">User Authorizations</Td>
  </Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    <Tr>
      <Th width="100%" colspan="2" >The following authorizations are dependent
        on the system.<font color="#0066CC"><font color="#FFFFFF"> </font></font><br>
        For a list of other authorizations
			<a class = "subclass" href="ezUserEzcAuthList.jsp?BusUser=<%=bus_user%>" >

        Click Here
		</a>

      </Th>
    </Tr>
    </Table>

<%@ include file="ezCommonUserAuth.jsp" %>
<%



  if ( sysRows > 0 ) { %>


  <div id="ButtonDiv" style="position:absolute;;visibility:visible;top:90%;width:100%">

        <a href="javascript:void(0)"><img src = "../../Images/Buttons/<%= ButtonDir%>/selectall.gif" border=none  onClick=setChecked(1) ></a>
        <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Submit" value="Update">
        <a href="javascript:void(0)"><img src = "../../Images/Buttons/<%= ButtonDir%>/clearall.gif" border=none onClick=setChecked(0)></a>
        <a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()"></a>

  </div>

<%	} else { %>
	<div align="center">No authorizations available</div>
<%	} %>
<%
}

else
{
%>
<br><br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	  <Tr align="center">
	    <Td class="displayheader">There are no users to list</Td>
	  </Tr>
	</Table>
	<br>
	<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<%
} //end If



%>
</form>

<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('User Authorization(s) updated successfully');
		</script>
<%
	} //end if
%>

</body>
</html>
