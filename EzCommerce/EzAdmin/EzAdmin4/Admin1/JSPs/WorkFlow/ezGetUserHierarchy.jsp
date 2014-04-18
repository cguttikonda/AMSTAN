<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iGetUserHierarchy.jsp"%>
<html>
<head>
<Title>User Hierarchy</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<Script>

	function funSave()
	{
		if(document.myForm.participant.value == "")
		{
			if("SOLDTO" == document.myForm.userType.value)
				alert("Please Enter Sold To Code to Continue");
			else
				alert("Please Enter User Id to Continue");
			document.myForm.participant.focus();	
			return;
		}
		else
		{
			document.myForm.action="ezGetUserHierarchy.jsp";
			document.myForm.submit();
		}
	}
	function funBack()
	{
		document.myForm.action="../Config/ezListSystems.jsp";
		document.myForm.submit();
	}
	function funReset()
	{
		document.myForm.reset();
		document.myForm.participant.focus();
	}	
	
	
</Script>

<body onLoad="document.myForm.participant.focus()">
<form name=myForm method=post>
<input type=hidden name="userType" value="<%=userType%>">

	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr align="center">
    		<Td class="displayheader">User Hierarchy</Td>
  	</Tr>
	</Table>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr>
		<Th align = "right">
			<%=lable1%>*
		</Th>
		<td width = "60%">
			<input type = "text" class = "InputBox" Style = "width:100%" name = "participant" value = "<%=user%>" size = "20" maxlength = "20">
		</td>
  	</Tr>  	
	</Table>
<br>
<%
	if(listRet == null || "null".equals(listRet))
	{
%>	
		<Div id="ButtonDiv" align="center" style="position:absolute;top:30%;width:100%">
			<a href="javascript:funSave()"><img src="../../Images/Buttons/<%= ButtonDir%>/continue.gif" border = "none"></a>
			<a href="javascript:funReset()"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none ></a>
			<a href="JavaScript:funBack()"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</Div>	

<%
	}
	if(user!=null && !"".equals(user))
	{
		if(listRetCount == 0)
		{
%>		
			<br><br><br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr align="center">
				<Td class="displayheader">There is no <%=lable1%> exist with <%=user%></Td>
			</Tr>
			</Table><br>
			<center><a href="JavaScript:funBack()"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
<%			
			return;
		}
	}
	if(listRetCount >0)
	{
%>
		<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="90%">
		<Tr class=trClass>
			<Th class=thClass align=center width="9%"><%=lable2%></Th>
			<Th class=thClass align=center width="20%" >User Name</Th>
			<Th class=thClass align=center width="35%" >Business Area</Th>
			<Th class=thClass align=center width="9%" >User Group</Th>
			<Th class=thClass align=center width="9%" >User HQ</Th>
			<Th class=thClass align=center width="9%" >User DM</Th>
			<Th class=thClass align=center width="9%" >User RM</Th>

		</Tr>
		</Table>
		</Div>
		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="90%">
<%
				String salesArea="";
				for(int i=0;i<listRetCount;i++)
				{
%>				
		
					<Tr>
<%
						if("SOLDTO".equals(userType) || "SOLDTO"==userType)
							userId 		= listRet.getFieldValueString(i,"USERID");
						else
							userId 		= listRet.getFieldValueString(i,"SOLDTO");
							
						userName	= listRet.getFieldValueString(i,"FNAME")+" "+listRet.getFieldValueString(i,"MNAME")+" "+listRet.getFieldValueString(i,"LNAME");
						salesArea	= listRet.getFieldValueString(i,"SYSKEY_DESC")+"("+listRet.getFieldValueString(i,"SYSKEY")+")";
%>

						<Td class=tdClass align=center width="9%"><%=userId%></Td>
						<Td class=tdClass align=center width="20%"><%=userName%></Td>
						<Td class=tdClass align=center width="35%"><%=salesArea%></Td>
						<Td class=tdClass align=center width="9%"><%=listRet.getFieldValueString(i,"UGROUP")%></Td>
						<Td class=tdClass align=center width="9%"><%=listRet.getFieldValueString(i,"SALES_HQ")%></Td>
						<Td class=tdClass align=center width="9%"><%=listRet.getFieldValueString(i,"SALES_DM")%></Td>
						<Td class=tdClass align=center width="9%"><%=listRet.getFieldValueString(i,"SALES_RM")%></Td>
					</Tr>
<%
				}
%>
			
		</Table>
		</Div>
		<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
			<img src = "../../Images/Buttons/<%= ButtonDir%>/back.gif" style = "cursor:hand" onClick = "JavaScript:funBack()">
		</Div>		
<%
	}
%>
</form>
</body>
</html>
