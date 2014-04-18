<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iTemplateCodeDetails.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iGetLangKeys.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iWFAuthList.jsp"%>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<script>
 function checkOption(filename)
 {
	var FieldNames=new Array;
	var CheckType=new Array;
	var Messages=new Array;
 
		FieldNames[0]="desc";
		CheckType[0]="MNull";
		Messages[0]="Please enter Description";
		
	if(document.myForm.aKey.selectedIndex==0)
	{
		alert("Please select Transaction")
		return false
	}
	if(document.myForm.lang.selectedIndex==0)
	{
		alert("Please select Language")
		return false
	}	
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
<body onLoad="document.myForm.desc.focus()">
<form name=myForm method=post onSubmit="return checkOption('ezEditSaveTemplateCode.jsp')">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
		<Td class="displayheader" align=center>Edit Template</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
		<Td align=right class=labelcell width=30%>TemplateCode*</Td>
		<Td width=70%><%=tCode%></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell >Transaction*</Td>
		<Td >
			<select name=aKey style="width:100%" id=FullListBox>
			<option>--Select Transaction--</option>
<%
			ret.sort(new String[]{AUTH_DESC},true);
			int authRows=ret.getRowCount();
			for(int i=0;i<authRows;i++)
			{
				if((ret.getFieldValue(i,AUTH_KEY)).equals(detailsRet.getFieldValueString(0,"AUTHKEY")))
				{
%>
					<option value="<%=ret.getFieldValue(i,AUTH_KEY)%>" selected><%=ret.getFieldValue(i,AUTH_DESC)%></option>
<%
				} else {
%>
					<option value="<%=ret.getFieldValue(i,AUTH_KEY)%>"><%=ret.getFieldValue(i,AUTH_DESC)%></option>
<%
				}
			}
%>			
			</select>
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell >Language*</Td>
		<Td >
		<select name=lang style="width:100%" id=FullListBox>
		<option>--Select Language--</option>
<%
		int langRows=langRet.getRowCount();
		for(int i=0;i<langRows;i++)
		{
			if((langRet.getFieldValueString(i,LANG_ISO)).equals(language))
			{
%>
				<option value="<%=langRet.getFieldValueString(i,LANG_ISO)%>" selected><%=langRet.getFieldValueString(i,LANG_DESC)%></option>	
<%
			} else {
%>
				<option value="<%=langRet.getFieldValueString(i,LANG_ISO)%>"><%=langRet.getFieldValueString(i,LANG_DESC)%></option>	
<%
			}
		}
%>
		</select>
		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell >Description*</Td>
		<Td ><input type=text class = "InputBox" style = "width:100%" size=50  name=desc maxlength="255" value="<%=detailsRet.getFieldValueString(0,"DESCRIPTION")%>"></Td>
	</Tr>
	
</Table>
		<input type=hidden name=tempCode value="<%=tCode%>">
<br>
<center>
<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()"></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</a>
</center>
</form>
</body>
</html>
