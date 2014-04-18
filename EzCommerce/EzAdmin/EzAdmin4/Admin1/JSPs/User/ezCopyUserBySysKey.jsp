<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iCopyUserBySysKey.jsp"%>
<html>
<head>
<script src="../../Library/JavaScript/User/ezCopyUserBySysKey.js"> 
</script>
<%
	String userType = null;
	String userValue =null;
%>
<Title>Copy User</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body onLoad="document.myForm.NewUser.focus()">
<form name=myForm method=post onSubmit="return chkCopyUser()">
<br>
<%
if(ret.getRowCount()==0)
{
%>
	<br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
			<Td class = "displayheader">
				<div align="center">No Areas To Copy Users.</div>
			</Td>
		</Tr>
	</Table>
	<br>
	<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</center>
<%
	return;
}
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
  	<Tr align="center">
    	<Td class="displayheader">Copy User</Td>
  	</Tr>
</Table>
<Table  width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
<!--
	<Th width="20%" class="labelcell">
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
	<%=wsk%>
	</Td>
-->
      	<Th width="10%" class="blankcell">
        <div align="right">Source User:</div>
      	</Th>
      	<Td width="20%" align = "left">
<a href = "../User/ezUserDetails.jsp?UserID=<%=bus_user%>"><%=bus_user%></a>


 <%

	String userName="";
	for ( int i = 0 ; i < retuser.getRowCount() ; i++ )
	{
		userName = (String)retuser.getFieldValue(i,"EU_ID");
		userType = retuser.getFieldValueString(i,"EU_TYPE");
		if (userName != null)
		{
			if((userName.trim()).equals(bus_user.trim()))
			{
				userName = userName.trim();
				userType = userType.trim();
				userValue = userType+";"+userName;
			}
		}
	}
%>
	</Td>
	</Tr>
<%
  	if(websyskey!=null && !"sel".equals(websyskey) )
  	{
  		if( !"sel".equals(bus_user))
  		{
%>
		<Tr>
		<Th width="43%" class="labelcell">
		<div align="right">Target User:*</div>
		</Th>
		<Td width="57%">
		<input type=text class = "InputBox" name="NewUser" size="16" maxlength="10">
		</Td>
		</Tr>
		</Table>
		<br>
		<div id="buttons" align = center>
			<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/copy.gif" name="Submit" value="Copy">
			<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset();document.myForm.NewUser.focus()" ></a>
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
<input type="hidden" name="BusUser" value="<%=userValue%>">
</form>
</body>
</html>
