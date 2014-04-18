<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iUserDefaultsListBySysKey.jsp"%>

<html>
<head>
<script src="../../Library/JavaScript/User/ezUserDefaultsListBySysKey.js">

</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Title>Business User Defaults</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body OnLoad="placeFocus();scrollInit()" onResize = "scrollInit()" scroll="no">

<br>
<%

String userName ="";
%>

<form name=myForm method=post action="ezSaveUserDefaultsListBySysKey.jsp" onSubmit="return funSelect()">


<%

	if(ret.getRowCount()==0)
	{

%>

		<br>
		<br>
		<br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
		    <Td class="displayheader">
	      <div align="center">No <%=areaLabel%> To List Defaults</div>
	    </Td>
	  </Tr></Table>
	  		<input type="hidden" name="Area" value="<%=areaFlag%>">
	  		<input type ="hidden" name="flag" value="1">
<br>
<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>


<% return;
	}

%>

<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr align="center">
	<Th width="20%">
        <div align="right"><%=areaLabel.substring(0,areaLabel.length()-1)%>&nbsp;:
        </div>
      </Th>
<Td width="20%">

<%
		String wsk=null;
		for(int i=0;i<ret.getRowCount();i++)
		{
			if(websyskey.equals(ret.getFieldValue(i,SYSTEM_KEY)))
			{

				wsk=ret.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION);

			}
		}
%>
	<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=websyskey%>"><%= wsk %> (<%=websyskey%>)&nbsp;</a>
</Td>
      <Th width="10%">
        <div align="right">User:</div>
      </Th>
      <Td width="20%">
<%
			if("2".equals((String)session.getValue("myUserType")))
			{
%>
				<a href="../User/ezViewIntranetUserData.jsp?UserID=<%=bus_user%>"><%=bus_user%></a>
<%
			}
			else
			{
%>
				<a href="../User/ezUserDetails.jsp?UserID=<%=bus_user%>"><%=bus_user%></a>
<%
			}
%>
	</Td>
</Tr></Table>

<%

		if(retuser!=null && websyskey!=null)
		{
			if(!"sel".equals(websyskey))
			{
				if(retuser.getRowCount()==0 && !"sel".equals(websyskey))
				{
%>
					<input type="hidden" name="Area" value="<%=areaFlag%>">

		<br><br><br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr>
				<Td class = "labelcell">
					<center><b>No User Present Under This <%=areaLabel.substring(0,areaLabel.length()-1)%></b><br>
					</center>
				</Td>
			</Tr>
		</Table><br><center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<% 				return;
				}
			}
		}

%>
  <%

  if(websyskey!=null && !"sel".equals(websyskey) )
  {
    	if( !"sel".equals(bus_user))
  		{

  %>
<%
	int defRows = reterpdef.getRowCount();
	String defDescription = null;
	if ( defRows > 0 ) {
%>

  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">User Defaults</Td>
  </Tr>
</Table>

<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    <Tr>
      <Th colspan="3" >The following user defaults are dependent on the business
        area.
      </Th>
    </Tr>
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
<input type="hidden" name="DefaultsKey" value=<%=(reterpdef.getFieldValue(i,USER_DEFAULT_KEY)).toString()%> >

      </Td>

      <Td align="left" width="38%">
<%
	String defValue = (String)reterpdef.getFieldValue(i,"EUD_VALUE");       //USER_DEFAULT_VALUE);

	if (defValue != null)
		defValue=defValue.trim();
	else
		defValue="";
%>
<input type=text class = "InputBox" name="DefaultsValue" size="20" value=<%=defValue%> >
      </Td>

    </Tr>
	<%
	}//End for
%>
</Table><br>
  <div align="center"><input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" >
  	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
  	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

  </div>
<%
}
else
{
%>
	</Table>
	<br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
			<Td class = "labelcell">
				<div align="center"><b>There Are No User Defaults For This User</b></div>
			</Td>
		</Tr>
	</Table><br>
	<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<%
}
}
else
{
%>
<br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr>
				<Td class = "labelcell">
					<div align="center"><b>Please Select User to continue.</b></div>
				</Td>
			</Tr>
		</Table><br>
		<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<%
}
}
else
{
%>
		<br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr>
				<Td class = "labelcell">
					<div align="center"><b>Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%> and User to continue.</b></div>
				</Td>
			</Tr>
		</Table><br>
		<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<%
}
%>

<input type="hidden" name="Area" value="<%=areaFlag%>">
<input type="hidden" name="WebSysKey" value="<%=websyskey%>">
<input type="hidden" name="BusUser" value="<%=bus_user%>">
</form>


<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('Updated successfully');
			history.go(-2);
		</script>
<%
	} //end if
%>

</body>
</html>
