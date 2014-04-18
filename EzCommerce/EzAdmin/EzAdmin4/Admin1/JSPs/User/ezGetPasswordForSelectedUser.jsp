<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUser.jsp" %>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iListAllUsersBySysKey.jsp"%>
<%@ page import="java.util.*" %>
<%
	session.putValue("myUserType",myUserType);
	session.putValue("myWebSyskey",websyskey);
	session.putValue("myAreaFlag",areaFlag);
	session.putValue("mySearchCriteria",searchPartner);
%>
<html>
<head>
<Title>Find Password Page</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/User/ezGetPasswordForSelectedUser.js">
</script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<body onLoad='bodyInit()' onresize='scrollInit()' scroll="no">

<form name=myForm method=post>
<input type="hidden" name="myUserType" value = "<%=myUserType%>">
<%
	int sysRows = ret.getRowCount();
	if ( sysRows > 0 )
	{
%>
		<br>
		<input type=hidden name="Area" value=<%=areaFlag%>>
		<input type="hidden" name="chkField">
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr  align="center">
		    <Th width="30%"><%=areaLabel.substring(0,areaLabel.length()-1)%></Th>
			<Td width="70%">
			    <select name="WebSysKey"   style="width:100%;" id = "FullListBox" onChange="funsubmit1('<%=areaLabel.substring(0,areaLabel.length()-1)%>')">
				<option value="sel">--Select <%=areaLabel.substring(0,areaLabel.length()-1)%>--</option>
<%
				StringBuffer all=new StringBuffer("");
				ret.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
				for(int i=0;i<ret.getRowCount();i++)
				{

					if(websyskey!=null)
					{
						if(!websyskey.equals("sel"))
						{
							if(websyskey.equals(ret.getFieldValueString(i,SYSTEM_KEY)))
							{
%>
								<option value=<%=ret.getFieldValue(i,SYSTEM_KEY)%>  selected> <%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>

<%							}
							else
							{
%>
								<option value=<%=ret.getFieldValue(i,SYSTEM_KEY)%> > <%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%							}
						}
						else
						{
%>
								<option value=<%=ret.getFieldValue(i,SYSTEM_KEY)%> > <%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%						}
					}
					else
					{
%>
								<option value=<%=ret.getFieldValue(i,SYSTEM_KEY)%> > <%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>

<%
					}
				}
%>
			</select>

		</Td>
	</Tr>
	</Table>
	<%@ include file="../../../Includes/Lib/AlphabetBean.jsp" %>
	<input type="hidden" name="searchcriteria" value="$">
<%

	if(websyskey!=null )
	{
		if(!websyskey.equals("sel"))
		{

			if(retUsers!=null && alphaTree.size()>0)
			{
				ezc.ezbasicutil.EzSearchReturn mySearch = new ezc.ezbasicutil.EzSearchReturn();
				if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=3)
				{
				  mySearch.search(retUsers,USER_FIRST_NAME,searchPartner.toUpperCase());
				}
			}

			int rCount = retUsers.getRowCount();
			Vector vuserId=new Vector();
			Vector vfirstName=new Vector();
			Vector vmiddleIntial=new Vector();
			Vector vlastName=new Vector();
			Vector vuserType=new Vector();
			retUsers.sort(new String[]{USER_FIRST_NAME},true);
			for(int i=0;i<rCount;i++)
			{
					if(!vuserId.contains((String) retUsers.getFieldValue(i,USER_ID)))
					{
						String usr_id = ((String) retUsers.getFieldValue(i,USER_ID)).trim();
						vuserId.addElement(usr_id);
						vfirstName.addElement((String) retUsers.getFieldValue(i,USER_FIRST_NAME));
						vmiddleIntial.addElement((String)retUsers.getFieldValue(i,USER_MIDDLE_INIT));
						vlastName.addElement((String) retUsers.getFieldValue(i,USER_LAST_NAME));
						vuserType.addElement((String)retUsers.getFieldValueString(i,"EU_TYPE"));

					}
			}

			if ( vuserId.size() > 0 )
			{
%>
				<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
				<Tr align="center">
					<Td class="displayheader">List Of Users</Td>
				</Tr>
				</Table>
				<div id="theads">
				<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
				<Tr align="left">
					<Th width="15%" align = "center">UserId</Th>
					<Th width="68%" align = "center">User Name</Th>
					<Th width="12%" align = "center">Password</Th>
				</Tr>
				</Table>
				</div>
				<Div id="InnerBox1Div">
					<Table id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
						String fname = "",mname = "",lname = "",Name = "";  
						for (int i = 0 ; i < vuserId.size(); i++)
						{
							fname = (String) vfirstName.elementAt(i);
							if(fname != null) fname = fname.trim(); else fname="";
							mname = (String) vmiddleIntial.elementAt(i);
							if(mname !=null) mname = mname.trim(); else  mname = " ";
							lname = (String) vlastName.elementAt(i);
							if(lname!=null) lname=lname.trim(); else lname = " ";
							Name  = fname +" "+ mname +" "+  lname;
%>
							<Tr align="left">
							<label for="cb_<%=i%>">
								<Td width="15%">
									<%=(String)vuserId.elementAt(i)%>
								</Td>
								<Td width="68%" id="myUserName">
									<%=((String)Name).toUpperCase()%>
								</Td>
								<Td width="12%">
									<a href="JavaScript:funOpenPWWin('<%=(String)vuserId.elementAt(i)%>')" title="Click To See Password For This UserId"><Font color="red">Click</Font></a>
								</Td>
							</label>
							</Tr>
<%
						}
%>
					</Table>
				</Div>
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
					</Table><br>
					<center>
						<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
					</center>
<%
				}
			}
	}
	else
	{
%>
		<br><br><br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr>
			      <Td class = "labelcell">
				<div align="center"><b>Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%>
				  to continue.</b></div>
			      </Td>
			</Tr>
<%
	}
	}
	else
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr>
				<Td class = "displayheader">
					<div align="center">No <%=areaLabel%> To List</div>
				</Td>
			</Tr>
		</Table><br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
	}
%>
<input type="hidden" name="Area" value=<%=areaFlag%> >
<input type="hidden" name="BusinessUser" value="" >
<input type="hidden" name="userName" value = "">
</form>
</body>
</html>
