
<%@ page import="ezc.ezparam.*" %>
<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
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


		FieldNames[0]="GroupId";
		CheckType[0]="MNull";
		Messages[0]="Please enter Work Group";
		FieldNames[1]="Role";
		CheckType[1]="MNull";
		Messages[1]="Please Select Role";
		FieldNames[2]="Lang";
		CheckType[2]="MNull";
		Messages[2]="Please Select Language";
		FieldNames[3]="Desc";
		CheckType[3]="MNull";
		Messages[3]="Please enter Description";
		FieldNames[4]="wgType";
		CheckType[4]="MNull";
		Messages[4]="Please Select Type";


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
<body onLoad="document.myForm.GroupId.focus();">
<form name=myForm method=post onSubmit="return checkOption('ezAddSaveWorkGroups.jsp')">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=70%>
	<Tr>
		<Td class="displayheader" align=center>Add Work Group</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=70%>
	<Tr>
		<Td align=right class=labelcell width=30%>Work Group*</Td>
		<Td width=70%><input type=text class = "InputBox" size=18  name=GroupId maxlength="10"></Td>
	</Tr>

	<Tr>
		<Td align=right class=labelcell width=30%>Role*</Td>
		<Td width=70%>
		<select name="Role" style="width:100%" id=FullListBox>
		<option value="">--Select Role--</option>
<%
			retRoles.sort(new String[]{"DESCRIPTION"},true);
			for(int i=0;i<retRoles.getRowCount();i++)
			{
				if("N".equals(retRoles.getFieldValueString(i,"DELETE_FLAG")))
				{
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
		<Td align=right class=labelcell width=30%>Language*</Td>
		<Td width=70%>
		<select name="Lang" style="width:100%" id=FullListBox>
		<option value="">--Select Language--</option>
<%
			for(int i=0;i<langRet.getRowCount();i++)
			{
				if(langRet.getFieldValueString(i,LANG_ISO).equals("EN"))
				{
%>
					<option value="<%=langRet.getFieldValue(i,LANG_ISO)%>" selected>
						<%=langRet.getFieldValue(i,LANG_DESC)%>
					</option>
<%
				}
				else
				{
%>
					<option value="<%=langRet.getFieldValue(i,LANG_ISO)%>">
						<%=langRet.getFieldValue(i,LANG_DESC)%>
					</option>
<%
				}
			}
%>
		</select>
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=30%>Description*</Td>
		<Td width=70%><input type=text class = "InputBox" size=60  name=Desc maxlength="50"></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell>Type*</Td>
		<Td>
			<select name=wgType style="width:100%" id=FullListBox>
			<option value="">--Select Type--</option>
			<option value="AG">Customers</option>
			<option value="IC">Internal Customer</option>
			<option value="VN">Vendors</option>
			<option value="IV">Internal Vendor</option>
			</select>
		</Td>
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
