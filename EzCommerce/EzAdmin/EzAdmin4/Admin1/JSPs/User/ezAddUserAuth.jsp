<%
	String myUser = "Business User";
	if("2".equals((String)session.getValue("myUserType")))
		myUser = "Intranet User";
%>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/JSPs/User/iUserAuthList.jsp" %>
<html>
<head>
<Title>Business User Authorizations</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/User/ezAddUserAuth.js"></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<body  onLoad='scrollInit()' onResize = "scrollInit()">
<form name=myForm method=post action="ezSaveAddUserAuth.jsp">
<br>
<div id="theads">
<Table id="tabHead"  align="center" bordercolordark=#ffffff bordercolorlight=#000000 border=1 cellspacing=0 cellpadding=2 width="89%">
  	<Tr align="center">
    		<Td class="displayheader">User Authorizations</Td>
  	</Tr>
</Table>
<Table border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
<Tr>
	<Th width="30%" align = "right"><%=myUser%>:</Th>
	<Td width="70%">
	<input type="hidden" readonly name="BusUser" size="15" value=<%=bus_user.trim()%> >
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
</Tr>
</Table>
<%@ include file="ezCommonUserAuth.jsp" %>
<%
	if ( sysRows > 0 )
	{
%>
		<div id="ButtonDiv" align=center style="position:absolute;top:80%;width:100%">
			<input type="image" src = "../../Images/Buttons/<%=ButtonDir%>/save.gif" name="Submit" value="Update">
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
		</div>
<%

	}
	else
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
			<Tr>
				<Td class = "labelcell">
					<div align="center"><b>No Authorizations available</b></div>
				</Td>
			</Tr>
		</Table>
		<div id="Buttondiv"  align="center" style="position:absolute;top:90%;width:100%;">
			<input type="image" src = "../../Images/Buttons/<%=ButtonDir%>/continue.gif" name="Submit" value="Continue">
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</div>
<%
	}
%>
</form>
</body>
</html>