<%@page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@include file="../../../Includes/JSPs/WorkFlow/iAddEscalation.jsp" %>
<%@include file="../../../Includes/JSPs/WorkFlow/iRollList.jsp" %>
<%@include file="../../../Includes/JSPs/WorkFlow/iGetLangKeys.jsp" %>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">

<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<script>
var groups = new Array() 
 
 
function setGroupsData(groupCode,groupDesc)
{
	this.groupCode= groupCode
	this.groupDesc= groupDesc
}
 
var x = 0;
<%
	String vn="";
	if(listTemplateRet != null)
	{
		for(int i=0;i<count;i++)
		{
%>			
			groups[x]=new setGroupsData("<%=listTemplateRet.getFieldValueString(i,"EWOD_PARTICIPANT_TYPE")%>","<%=listTemplateRet.getFieldValueString(i,"EWOD_PARTICIPANT")%>");	
			x++;
<%			
		}
	} 
%>
 
 
function funsubmit()
{
	document.myForm.submit();
}


 
function save()
{ 	
	if(checkOption())
 	{
 		document.myForm.action="ezAddSaveEscalation.jsp";
 		document.myForm.submit();
 	}
}
function checkOption()
{
	if(document.myForm.docType.value=="")
	{
		alert("Please enter Doc. Type");
		document.myForm.docType.focus()
		return false
	}

	if(document.myForm.tcode.value=="")
	{
		alert("Please enter Template");
		document.myForm.tcode.focus()
		return false
	}

	if(document.myForm.GroupId.selectedIndex==0)
	{
		alert("Please Select GroupId");
		document.myForm.GroupId.focus()
		return false
	}
	if(document.myForm.Level.selectedIndex==0)
	{
		alert("Please Select Level")
		document.myForm.Level.focus()
		return false
	}
	if(document.myForm.Duration.value=="")
	{
		alert("Please enter Duration");
		document.myForm.Duration.focus()
		return false
	}	
	if(document.myForm.Description.value=="")
	{
		alert("Please enter Description");
		document.myForm.Description.focus()
		return false
	}
	return true
}
function setDefaultValue()
{
	var sourceDesc = document.myForm.GroupId.value
	
	var sourceLevl = "";
	for(i=0;i<groups.length;i++)
	{
		if(sourceDesc == groups[i].groupDesc)
		{
			sourceLevl = groups[i].groupCode;
			break;
		}
	}
	document.myForm.Level.value = sourceLevl
}
</script>
</head>
<body onLoad='setDefaultValue()'>
<form name=myForm method=post">

<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
			<Td align=right class=labelcell>Doc Type*</Td>
			<Td>
			<select name="docType" id=ListBoxDiv style="width:100%">
			<option value="-">--Select--</option>
			<%
				String docsel = "";
				for(int i=0;i<authCount;i++)
				{
					if(authRet.getFieldValueString(i,"EUAD_AUTH_KEY").equals(docType))
						docsel = "selected";
					else 
						docsel = "";
			%>
					<option value=<%=authRet.getFieldValueString(i,"EUAD_AUTH_KEY")%> <%=docsel%>><%=authRet.getFieldValueString(i,"EUAD_AUTH_DESC")%></option>
			<%
				}
			%>
			</select>
			</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell>Template*</Td>
		<Td >
		<select name="tcode" id=ListBoxDiv style="width:100%" onchange='funsubmit()'>
		<option value="-">--Select--</option>
<%
		for(int i=0;i<listRet.getRowCount();i++)
		{
			if(listRet.getFieldValueString(i,"TCODE").equals(tcode))
				docsel = "selected";
			else 
				docsel = "";
%>
			<option value='<%=listRet.getFieldValueString(i,"TCODE")%>' <%=docsel%>><%=listRet.getFieldValueString(i,"DESCRIPTION")%></option>
<%
		}
%>
		</select>
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell >Source*</Td>
		<Td >
		<select name=GroupId id=ListBoxDiv onchange='funsubmit()'>
		<option value="-">--Select--</option>
<%
		for(int i=0;i<count;i++)
		{
			if(listTemplateRet.getFieldValueString(i,"EWOD_PARTICIPANT").equals(GroupId))
				docsel = "selected";
			else 
				docsel = "";
%>
			<option value='<%=listTemplateRet.getFieldValueString(i,"EWOD_PARTICIPANT")%>' <%=docsel%>><%=listTemplateRet.getFieldValueString(i,"EWOD_PARTICIPANT")%></option>
<%
		}
%>
		</select>
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell>Level*</Td>
		<Td >
		<select name="Level" id=ListBoxDiv style="width:100%">
		<option value="-">--Select--</option>
		<option value="U">User</option>
		<option value="G">Group</option>
		<option value="R">Role</option>
		</select>
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width="20%">Duration*</Td>
		<Td width="80%"><input type=text class = "InputBox" style="width:100%"  name=Duration maxlength="20" value='<%=duration%>'></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=20%>Description*</Td>
		<Td width=80%><input type=text class = "InputBox" style="width:100%"  name=Description maxlength="50" value='<%=desc%>'></Td>
	</Tr>

	
</Table>
<br>
<center>
<a href="javascript:save()"><img src="../../Images/Buttons/<%=ButtonDir%>/save.gif"  alt="Click Here To Save" border=no></a>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/clear.gif" border=none onClick="document.myForm.reset()"></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<Div id="MenuSol">
</Div>
</form>
</body>
</html>
