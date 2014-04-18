<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>

<%@ include file="../../../Includes/JSPs/WorkFlow/iAttributesDetails.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session"/>
<%
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
        snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	ReturnObjFromRetrieve retlang = (ReturnObjFromRetrieve)sysManager.getAllLangKeys(sparams);

%>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<script>
 function checkOption(filename)
 {
	var FieldNames=new Array;
	var CheckType=new Array;
	var Messages=new Array;
 
		FieldNames[0]="Description";
		CheckType[0]="MNull";
		Messages[0]="Please enter Description";
		FieldNames[1]="Container";
		CheckType[1]="MNull";
		Messages[1]="Please enter Container";
		FieldNames[2]="StructField";
		CheckType[2]="MNull";
		Messages[2]="Please enter StructField";

	if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
	{
		document.myForm.action=filename
		return true
	}else{
		return false
	}
}
function funSet()
{
	for(i=0;i<document.myForm.Lang.options.length;i++)
	{
		if(document.myForm.Lang.options[i].value=="<%= removeNull(detailsRet.getFieldValue("LANG"))%>")
		{
			document.myForm.Lang.options[i].selected=true;
			break;
		}
	}
	for(i=0;i<document.myForm.Type.options.length;i++)
	{
		if(document.myForm.Type.options[i].value=="<%= removeNull(detailsRet.getFieldValue("TYPE"))%>")
		{
			document.myForm.Type.options[i].selected=true;
			break;
		}
	}
}
</script>
</head>
<body onLoad="document.myForm.Lang.focus();funSet()">
<form name=myForm method=post onSubmit="return checkOption('ezEditSaveAttributes.jsp')">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=90%>
	<Tr>
		<Td class="displayheader" align=center>Edit Attributes</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width="90%">
	<Tr>
		<Td align=right class=labelcell width=50%>AttributeId</Td>
		<Td width=50%><input type=hidden name=AttributeId value="<%= detailsRet.getFieldValue("ATTRIBUTE") %>"><%= removeNull(detailsRet.getFieldValue("ATTRIBUTE")) %></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Lang</Td>
		<Td width=50%><div id="ListBoxDiv1">
			<select name="Lang" id=ListBoxDiv>
		<%
		
					for(int i=0;i<retlang.getRowCount();i++)
					{
		%>
						<option value="<%=retlang.getFieldValue(i,LANG_ISO)%>"><%=retlang.getFieldValue(i,LANG_DESC)%></option>
		
		<%
					}
		%>
		</select></div>

		</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Description*</Td>
		<Td width=50%><input type=text class = "InputBox" size=18  name=Description maxlength="255" value="<%= removeNull(detailsRet.getFieldValue("DESCRIPTION"))%>"></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Container*</Td>
		<Td width=50%><input type=text class = "InputBox" size=70  name=Container maxlength="50" value="<%= removeNull(detailsRet.getFieldValue("CONTAINER"))%>"></Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Struct Field*</Td>
		<Td width=50%><input type=text class = "InputBox" size=70  name=StructField maxlength="100" value="<%= removeNull(detailsRet.getFieldValue("STRUCTFIELD"))%>"></Td>
	</Tr>
	<Tr>
	
	<Tr>
		<Td align=right class=labelcell width=50%>Type*</Td>
		<Td width=50%><div id="ListBoxDiv2">
		<select name=Type id=ListBoxDiv>
			<option value="">Select Type</option>
			<option value="Number">Number</option>
			<option value="String">String</option>
			<option value="Date">Date</option>
		</select></div>

		</Td>
	</Tr>
</Table>
<br>
<center>
<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset();funSet()"></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


</center>
</form>
</body>
</html>
