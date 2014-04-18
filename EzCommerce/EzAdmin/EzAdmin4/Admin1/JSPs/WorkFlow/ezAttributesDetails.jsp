<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session"/>
<%@ include file="../../../Includes/JSPs/WorkFlow/iAttributesDetails.jsp"%>
<%
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
        snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	ReturnObjFromRetrieve retlang = (ReturnObjFromRetrieve)sysManager.getAllLangKeys(sparams);

	String myLang=detailsRet.getFieldValueString("LANG");
	for(int i=0;i<retlang.getRowCount();i++)
	{
		if(myLang.equals(retlang.getFieldValueString(i,"ELK_ISO_LANG")))
		{
			myLang=retlang.getFieldValueString(i,"ELK_LANG_DESC");
			break;
		}
	}

%>
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body>
<form name=myForm method=post>
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td class="displayheader" align=center>Details Of Attributes</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
	<Tr>
		<Td align=right class=labelcell width=50%>AttributeId</Td>
		<Td width=50%><%= detailsRet.getFieldValue("ATTRIBUTE") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Language</Td>
		<Td width=50%><%= myLang %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Description</Td>
		<Td width=50%><%= detailsRet.getFieldValue("DESCRIPTION") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Container</Td>
		<Td width=50%><%= detailsRet.getFieldValue("CONTAINER") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Struct Field</Td>
		<Td width=50%><%= detailsRet.getFieldValue("STRUCTFIELD") %>&nbsp;</Td>
	</Tr>
	<Tr>
		<Td align=right class=labelcell width=50%>Type</Td>
		<Td width=50%><%= detailsRet.getFieldValue("TYPE") %>&nbsp;</Td>
	</Tr>
</Table>

<br>
<center>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


</center>
</form>
</body>
</html>
