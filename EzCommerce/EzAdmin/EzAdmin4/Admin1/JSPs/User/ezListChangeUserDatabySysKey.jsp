<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iListAllUsersBySysKey.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUser.jsp" %>
<html>
<head>
<Title>List Of All Users</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/User/ezListChangeUserDatabySysKey.js">

</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

</head>
<BODY onLoad='scrollInit()' onResize = "scrollInit()" scroll="no">
<%
	int sysRows = ret.getRowCount();
	if ( sysRows > 0 )
		{
%>
	<br>

<form name=myForm method=post action="">
	<input type=hidden name="Area" value=<%=areaFlag%>>
	<input type="hidden" name="chkField">
	<Table  width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
	    <Th width="20%" >Select</Th>
		<Td><div id = "listBoxDiv">
<select name="WebSysKey"   style="width:100%;" >
		<option value="sel">Select <%=areaLabel.substring(0,areaLabel.length()-1)%></option>


<%
				StringBuffer all=new StringBuffer("");
				for(int i=0;i<ret.getRowCount();i++)
				{

					if(websyskey!=null)
					{
						if(!websyskey.equals("sel"))
						{
							if(websyskey.equals(ret.getFieldValueString(i,SYSTEM_KEY)))
							{
%>
								<option value=<%=ret.getFieldValue(i,SYSTEM_KEY)%>  selected> <%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> </option>

<%							}
							else
							{
%>
								<option value=<%=ret.getFieldValue(i,SYSTEM_KEY)%> > <%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> </option>
<%							}
						}
						else
						{
%>
								<option value=<%=ret.getFieldValue(i,SYSTEM_KEY)%> > <%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> </option>
<%						}
					}
					else
					{

%>
								<option value=<%=ret.getFieldValue(i,SYSTEM_KEY)%> > <%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> </option>

<%
					}
				}
%>
			</select>
			</div>
		</Td>
		<Td width="20%">
			<img src = "../../Images/Buttons/<%= ButtonDir%>/show.gif" style = "cursor:hand" onClick = "funsubmit1('<%=areaLabel.substring(0,areaLabel.length()-1)%>')">
		</Td>
	</Tr>
	</Table>
	<br>
<%
	if(websyskey!=null)
		{
			if(!websyskey.equals("sel"))
			{
%>

<%

	int rCount = retUsers.getRowCount();
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
		for (int i = 0 ; i < retUsers.getRowCount() ; i++)
			{
			String userUrl = "";
			String userid = (String) retUsers.getFieldValue(i,USER_ID);
			String userType = retUsers.getFieldValueString(i,"EU_TYPE");
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
			<a href=<%=userUrl%> >
			<%=userid%>
			</a>

			</Td>
			<Td width = "56%">
<%
 			String fname = (String) retUsers.getFieldValue(i,USER_FIRST_NAME);
			if(fname != null) fname = fname.trim(); else fname="";
 			String mname = (String) retUsers.getFieldValue(i,USER_MIDDLE_INIT);
			if(mname !=null) mname = mname.trim(); else  mname = " ";
 			String lname = (String) retUsers.getFieldValue(i,USER_LAST_NAME);
			if(lname!=null) lname=lname.trim(); else lname = " ";
			String Name  = fname +" "+ mname +" "+  lname;
			// User Full Name
%>
			<%=(((String)Name).toUpperCase())%>

			</Td>
  		</Tr>
<%
			}//End for
%>
		</Table>
		</div>

<%
		}
	else
		{
%>
		<br><br><br>
		<div id="theads">
	<Table id="tabHead" border=0 align='center'  cellPadding=0 cellSpacing=0   width="80%">
		<Tr>
			<Td class = "blankcell"></Td>
		</Tr>
		</Table>
		</div>

		<DIV id="InnerBox1Div">
		<Table  id="InnerBox1Tab" border=0 align='center'  cellPadding=0 cellSpacing=0   width="100%">
		<Tr align="center">
			<Td class="displayheader">There are no users to list</Td>
		</Tr>
		</Table>
		</div>
<%
		} //if rCount > 0 %>
<%
		}

	%>
		<br><br>
<%
		}
		else
		{

%>
			<br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
				<Td class = "labelcell">
	      		<div align="center"><b>Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%>
	      		  to continue.</b></div>
	    	</Td>
			</Tr>
			</Table>

<%
		}
		}
	else
		{
%>
		<br><br><br><br><center><b>No <%=areaLabel%>  To List</b></center>
<%
		}
%>

</form>
</body>
</html>
