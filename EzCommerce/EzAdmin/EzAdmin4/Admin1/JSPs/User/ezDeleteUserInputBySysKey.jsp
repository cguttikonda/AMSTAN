<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iListAllUsersBySysKey.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUser.jsp" %>
<%
	session.putValue("myAreaFlag",areaFlag);
%>
<html>
<head>
<Title>ezDeleteUserInput</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/User/ezDeleteUserInputBySysKey.js">

</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

</head>
<BODY onLoad='scrollInit()' onResize = "scrollInit()" scroll="no">

<form name=myForm method=post action="ezDeleteUser.jsp">

<br>
<script language="JavaScript" src="../../../Includes/Lib/JavaScript/Users.js">
</script>
<%
	int sysRows = ret.getRowCount();
	if ( sysRows > 0 )
		{
%>
	<input type=hidden name="Area" value=<%=areaFlag%>>
	<input type="hidden" name="chkField">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr align="center">
	    <Th width="20%">Select</Th>
		<Td>
			<div id = "listBoxDiv0">
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
	int userRows = retUsers.getRowCount();

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
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
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
			<a href="ezUserDetails.jsp?UserID=<%=(String) retUsers.getFieldValue(i,USER_ID)%>" >
			<%=( (String) retUsers.getFieldValue(i,USER_ID) )%>
			</a>
			<input type="hidden" name="UserName_<%=i%>" value=<%=(String) retUsers.getFieldValue(i,USER_ID)%> >

			</Td>
      			<Td align="left" width="58%">
<%
			// User Full Name
			String fname = (String) retUsers.getFieldValue(i,USER_FIRST_NAME);
			if(fname!=null) fname=fname.trim(); else fname ="";
			String mname = (String) retUsers.getFieldValue(i,USER_MIDDLE_INIT);
			if(mname!=null) mname=mname.trim(); else mname =" ";
			String lname = (String) retUsers.getFieldValue(i,USER_LAST_NAME);
			if(lname!=null) lname=lname.trim(); else lname =" ";
			String Name  = fname+" "+mname+" "+lname ;
			out.println (((String)Name).toUpperCase());
%>
			</Td>
		</Tr>
<%
		}//End for
%>
		<input type="hidden" name="TotalCount" value=<%=userRows%>>
		</Table>
		</div>

		<div id="ButtonDiv"  align="center" style="position:absolute;;visibility:visible;top:90%;width:100%">
			<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/delete.gif" name="Submit" value="Delete" onClick="checkDelRows(<%= userRows%>,'UserList');return document.returnValue;">
		</div>
<%
		}
	else
		{
%>
		<br><br><br>
		<div id="theads">
		<Table id="tabHead" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
		<Tr>
			<Td></Td>
		</Tr>
		</Table>
		</div>

		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
		<Tr align="center">
			<Td class="displayheader">There are no users to list</Td>
		</Tr>
		</Table>

    </div>

			} //if rCount > 0
			%>

<%
		}//End if
%>
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
          and press Go to continue.</b></div>
      </Td>
			</Tr>
			</Table>

<%
		}
		}
	else
		{
%>
		<br><br><br><br><center><b>No <%=areaLabel%> To List</b></center>
<%
		}
%>
</form>
</body>
</html>
