<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iUserDefaultsList.jsp"%>

<html>
<head>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>



<script language = "javascript">

function myalert1()
{

	document.location.href="ezUserDefaultsList.jsp?BusUser="+document.UserDef.BusUser.value;
}

</script>

<Title>Business User Defaults</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body OnLoad='scrollInit()' onResize = "scrollInit()" scroll="no">

<br>
<%
int userRows = retuser.getRowCount();
String userName = null;
if ( userRows > 0 )
{
%>


<form name=myForm method=post action="ezSaveUserDefaultsList.jsp">


  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="50%">
    <Tr>
      <Th width="43%" class="labelcell">
        <div align="right">User:</div>
      </Th>
      <Td width="57%">
      <div id = listBoxDiv1>
      <select name="BusUser" onChange="myalert1()">
<%
	for ( int i = 0 ; i < userRows ; i++ )
	{

		userName = (String)retuser.getFieldValue(i,USER_ID);
		userName = userName.trim();

		String isSel = "";
		if ( bus_user.trim().equals(userName) )
			isSel="selected";
%>
	        <option <%=isSel%> value="<%=retuser.getFieldValue(i,USER_ID)%>">
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
	}
%>
	</select></div>
      </Td>
    </Tr>
    <Tr>
      <Th width="43%" class="labelcell">
        <div align="right">Business Area:</div>
      </Th>
      <Td width="57%">
        <%@ include file="../../../Includes/Lib/ListBox/LBCatalogArea.jsp"%>
      </Td>
    </Tr>
  </Table>
  <br>
  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">User Defaults</Td>
  </Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    <Tr>
      <Th colspan="3" >The following user defaults are dependent on the business
        area.For a list of user only defaults
	<a class = "subclass" href="ezUserOnlyDefaultsList.jsp?BusUser= <%=bus_user%>" >
		Click Here
	</a>

      </Th>
    </Tr>
<%
int defRows = reterpdef.getRowCount();
String defDescription = null;
if ( defRows > 0 ) {
%>
    <Tr>
      <Th width="37%" align="left" >Default</Th>
      <Th width="38%" align="left" > Value </Th>

    </Tr>
<%
	for ( int i = 0 ; i < defRows; i++ ){
%>

	<Tr align="center">
	<Td align="left" width="37%">
<%
	defDescription = (String)(reterpdef.getFieldValue(i,"EUDD_DEFAULTS_DESC"));
	if (defDescription != null)
	{
%>
		<%=defDescription%>
<%
	}
%>

<input type="hidden" name="DefaultsKey" value="<%=reterpdef.getFieldValueString(i,USER_DEFAULT_KEY)%>">

      </Td>

      <Td align="left" width="38%">
<%
	String defValue = (String)reterpdef.getFieldValue(i,USER_DEFAULT_VALUE);
	if (defValue != null)
		defValue=defValue.trim();
	else
		defValue="";
%>
<input type=text class = "InputBox" name="DefaultsValue" size="20" value="<%=defValue%>">
      </Td>

    </Tr>
<%
	}
%>
</Table>
  <div align="center"><input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Submit" value="Save"></div>
<%
}
else
{
%>
	</Table>
	<div align="center">There are no user defaults</div>
<%
}
%>
</form>

<%
}
else{
%>
<br><br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	  <Tr align="center">
	    <Td class="displayheader">There are no Users</Td>
	  </Tr>
	</Table>
	<br>
	<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>


<% }%>

<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('Updated successfully');
		</script>
<%
	}
%>

</body>
</html>
