<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iUserAuthListBySysKey.jsp"%>
<html>
<head>
<script src="../../Library/JavaScript/User/ezUserAuthListBySysKey.js"></script>

<Title>Business User Authorizations</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

</head>
<body bgcolor="#FFFFF7" onLoad='scrollInit()' onResize='scrollInit()' scroll="no">
<form name=myForm method=post action="ezSaveUserAuthListBySysKey.jsp">
<br>
<%

	if(ret.getRowCount()==0)
	{

%>

			<br><br><br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
			<Tr>
		    <Td class="displayheader">
	      <div align="center">No <%=areaLabel%> To List Authorizations</div>
	        </Td>
	  </Tr></Table>
	  <center><br>
	  	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	  </center>
	  		<input type="hidden" name="Area" value="<%=areaFlag%>">
	  		<input type ="hidden" name="flag" value="1">

<% return;
	}

%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
  <Tr align="center">
    <Td class="displayheader">User Authorizations</Td>
  </Tr>
</Table>


<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr align="center">
	<Th width="10%" class="labelcell">
        <div align="right"><nobr><%=areaLabel.substring(0,areaLabel.length()-1)%>&nbsp;:
        </div></nobr>
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
      <Th width="10%" class="blankcell">
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
		<br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr>
				<Td class = "labelcell">
					<div align="center"><b>No User Present Under This <%=areaLabel.substring(0,areaLabel.length()-1)%></b></div>
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

 
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
    <Tr>
      <Th width="89%" colspan="2" >The following authorizations are dependent
        on the system.<br>
      <!--
      For a list of other authorizations

			<a class = subclass href="ezUserEzcAuthListBySysKey.jsp?BusUser=<%=bus_user%>&Area=<%=areaFlag%>&WebSysKey=<%=websyskey%>" >

        Click Here

		</a>
	-->
      </Th>
    </Tr>
    </Table>
<%@ include file="ezCommonUserAuth.jsp" %>

<% if ( sysRows > 0 ) { %>


  <div id="ButtonDiv"  align="center" style="position:absolute;visibility:visible;top:90%;width:100%">

        
        <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Submit" value="Update">
        
        <a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
        <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


  </div>

<%
	}
	else
	{

%>

				<br><br>
					<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
					<Tr>
						<Td class = "labelcell">
							<div align="center"><b>No authorizations available</b></div>
						</Td>
					</Tr>
				</Table>
		<center><br>
	  	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

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

%>



<%
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
			alert('User Authorization(s) updated successfully');
			history.go(-2);
		</script>
<%
	} //end if
%>
</body>
</html>
