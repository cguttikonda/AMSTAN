<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<%@ include file="../../../Includes/Lib/ArmsConfig.jsp" %>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%
	EzcParams inParams = new EzcParams(false);
	Session.prepareParams( inParams );
	ReturnObjFromRetrieve retRoles = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( inParams );

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziTemplateCodeParams params= new ezc.ezworkflow.params.EziTemplateCodeParams();
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve templatesRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplatesList(mainParams);
	
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	ReturnObjFromRetrieve sysRet = (ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);

	ReturnObjFromRetrieve ret1 = (ReturnObjFromRetrieve) sysManager.getPurchaseAreas(sparams);

	ezc.ezparam.EzDescStructure eds = new ezc.ezparam.EzDescStructure();
	eds.setAreaFlag("S");
	eds.setSyncFlag("N");
	snkparams.setEzDescStructure(eds);
	ReturnObjFromRetrieve ret2 = (ReturnObjFromRetrieve) sysManager.getBusinessAreas(sparams);

	sysRet.append(ret1);
	sysRet.append(ret2);
%>
<html>
<head>
<Script>
function funFocus()
{
	if(document.myForm.syskey!=null)
	{
		document.myForm.syskey.focus();
	}
}
function trim( inputStringTrim)
{
	fixedTrim = "";
	lastCh = " ";

	for( x=0;x < inputStringTrim.length; x++)
	{
   		ch = inputStringTrim.charAt(x);
 		if ((ch != " ") || (lastCh != " "))
 		{ fixedTrim += ch; }
		lastCh = ch;
	}

	if (fixedTrim.charAt(fixedTrim.length - 1) == " ")
	{
		fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1);
	}
	return fixedTrim
}
function funCheck()
{
	if(document.myForm.syskey.selectedIndex==0)
	{
		alert("Please Select Syskey");
		document.myForm.syskey.focus();
	}
	else if(document.myForm.template.selectedIndex==0)
	{
		alert("Please Select Template");
		document.myForm.template.focus();	
	}
	else if(document.myForm.participant.selectedIndex==0)
	{
		alert("Please Select Participant");
		document.myForm.participant.focus();	
	}
	else if(trim(document.myForm.desiredStep.value)=='')
	{
		alert("Please Enter Desired Step Value");
		document.myForm.desiredStep.focus();	
	}
	else
	{
		document.myForm.action = "ezShowWFUsers.jsp";
		document.myForm.submit();
	}
}
</Script>
</head>
<body onLoad = "funFocus()">
<form name=myForm >
<%
if(sysRet.getRowCount() == 0)
{
%>
	<br><br><br><br>
	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
	<Tr>
		<Th width="100%" align=center>
			No Business Areas to List.
		</Th>
	</Tr>
	</Table>
	<br>
	<center>
		<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  style = "cursor:hand" alt="Click here to go to previous page" border=no onClick="JavaScript:history.go(-1)">
	</center>
<%
		return;
}
else if(templatesRet.getRowCount() == 0)
{
%>
	<br><br><br><br>
	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
	<Tr>
		<Th width="100%" align=center>
			No Templates to List.
		</Th>
	</Tr>
	</Table>
	<br>
	<center>
		<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  style = "cursor:hand" alt="Click here to go to previous page" border=no onClick="JavaScript:history.go(-1)">
	</center>
<%
		return;
}
else
{
%>

<br>
	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
	<Tr>
		<Td class = "displayheader" align = "center">View WorkFlow Users</Th>
	</Tr>
	</Table>
	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
	<Tr>
		<Th align = "right">Syskey*</Th>
		<Td>
			<select name=syskey id = "listBoxDiv">
			<option value = "">--Select Business Area--</option>
<%
			for(int i=0;i<sysRet.getRowCount();i++)
			{
%>
				<option value="<%=sysRet.getFieldValueString(i,"ESKD_SYS_KEY")%>"><%=sysRet.getFieldValueString(i,"ESKD_SYS_KEY_DESC")%></option>
<%
			}
%>
			</select>
		</Td>
		</Tr>
		<Tr>
		<Th align = "right">Template*</Th>
		<Td>
			<select name=template id = "listBoxDiv0">
			<option value = "">--Select Template--</option>
<%
			for(int i=0;i<templatesRet.getRowCount();i++)
			{
%>
				<option value="<%=templatesRet.getFieldValueString(i,"TCODE")%>"><%=templatesRet.getFieldValueString(i,"DESCRIPTION")%></option>
<%
			}
%>
			</select>
		</Td>
	</Tr>
	<Tr>
		<Th align = "right">Participant*</Th>
		<Td>
		<select name = "participant" Style = "width:100%" id = "listBoxDiv1">
			<option value = "">--Select Participant--</option>
<%
		int roleCount = retRoles.getRowCount();
		for(int i=0;i<roleCount;i++)
		{
		if(!retRoles.getFieldValueString(i,"DELETE_FLAG").equals("Y"))
			{
%>
				<option value = "<%=retRoles.getFieldValueString(i,"ROLE_NR")%>"><%=retRoles.getFieldValueString(i,"DESCRIPTION")%></option>
<%
			}
		}
%>
		</select>		
		<!-- input type=text name=participant -->
		</Td>
		</Tr>
		<Tr>
		<Th align = "right">Desired Step*</Th>
		<Td><input type=text name=desiredStep maxlength = "3"></Td>
		</Tr>
		<Tr>
		<Th align = "right">User type</Th>		
		<Td>
			<Select name = "userType" id = "listBoxDiv2">
			<option value = "U">Users</option>
			<option value = "VN">Vendors</option>
			<option value = "AG">Customers</option>
		</Td>
	</Tr>
	</Table>
	<br>
	<center>
		<a href = "JavaScript:funCheck()"><img src = "../../Images/Buttons/<%= ButtonDir%>/show.gif"  style = "cursor:hand" border = "none"></a>
		<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  style = "cursor:hand" alt="Click here to go to previous page" border=no onClick="JavaScript:history.go(-1)">	
	</center>
	<br><br><br><br>
&nbsp;&nbsp;&nbsp;&nbsp;<font size = 1 face = "arial">Note : For Desired Step -N for N<sup>th</sup> Level Superior and +N for N<sup>th</sup> Level Sub-ordinate.</font>
<%
}
%>
</form>		
</body>
</html>
