<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>

<%@ include file="../../../Includes/JSPs/WorkFlow/iWorkGroupsDetails.jsp"%>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iGetLangKeys.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iRollList.jsp"%>
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<script>
 function checkOption(filename)
 {
	var FieldNames=new Array;
	var CheckType=new Array;
	var Messages=new Array;

		FieldNames[0]="Role";
		CheckType[0]="MNull";
		Messages[0]="Please Select Role";
		FieldNames[1]="Lang";
		CheckType[1]="MNull";
		Messages[1]="Please Select Language";
		FieldNames[2]="Desc";
		CheckType[2]="MNull";
		Messages[2]="Please enter Desc";
			

	if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
	{
		document.myForm.action=filename
		return true
	}else{
		return false
	}
}
</script>
</head>
<body onLoad="document.myForm.Desc.focus();">
<form name=myForm method=post onSubmit="return checkOption('ezEditSaveWorkGroups.jsp')">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
		<Td class="displayheader" align=center>Edit Work Group</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
		<Td align=right class=labelcell width=30%>Work Group</Td>
		<Td width=70%><input type=hidden name=GroupId value="<%= detailsRet.getFieldValue("GROUP_ID") %>"><%= removeNull(detailsRet.getFieldValue("GROUP_ID")) %></Td>
	</Tr>
	<Tr>
	<%
		String wtype=detailsRet.getFieldValueString("WGTYPE");
		String wtype1=(wtype.equals("VN"))?"Vendor":(wtype.equals("AG")?"Customer":"Internal User");
	%>
		<Td align=right class=labelcell>Type</Td>
		<Td>
			<%=wtype1%>
			<input type=hidden name=wgType value="<%=wtype%>">
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell >Language</Td>
		<Td >
	<%
			String myLang=null;
			for(int i=0;i<langRet.getRowCount();i++)
			{
				if(langRet.getFieldValue(i,LANG_ISO).equals(detailsRet.getFieldValue("LANG")))
				{
					myLang=langRet.getFieldValueString(i,LANG_DESC);
					break;
				}
			}
%>
		<%=myLang%>
		<input type=hidden name=Lang value="<%=detailsRet.getFieldValue("LANG")%>">
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell >Role No*</Td>
		<Td >

				<select name="Role" style="width:100%" id=FullListBox>
				<option value="">--Select Role--</option>
		<%
					retRoles.sort(new String[]{"DESCRIPTION"},true);
					for(int i=0;i<retRoles.getRowCount();i++)
					{
						if(retRoles.getFieldValue(i,"ROLE_NR").equals(detailsRet.getFieldValue("ROLE")))
						{
		%>
						<option value="<%=retRoles.getFieldValue(i,"ROLE_NR")%>" selected><%=retRoles.getFieldValue(i,"DESCRIPTION")%></option>

		<%				}
						else{
		%>
						<option value="<%=retRoles.getFieldValue(i,"ROLE_NR")%>"><%=retRoles.getFieldValue(i,"DESCRIPTION")%></option>
		<%
						}
					}
		%>
				</select>

		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell >Description*</Td>
		<Td ><input type=text class = "InputBox" size=45 style = "width:100%" name=Desc maxlength="50" value="<%= removeNull(detailsRet.getFieldValue("DESCRIPTION"))%>"></Td>
	</Tr>
	

	
</Table>
<br>
<center>
<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()"></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
</form>
</body>
</html>
