<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>


<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%
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

</head>
<body>
<form name=myForm method=post action="ezTestShowWFUsers.jsp">
<br>
	<Table align=center width=70%>
	<Tr>
		<Th>Syskey</Th>
		<Td>
			<select name=syskey>
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
		<Th>Template</Th>
		<Td>
			<select name=template>
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
		<Th>Participant</Th>
		<Td><input type=text name=participant></Td>
		<Th>Desired Step</Th>
		<Td><input type=text name=desiredStep></Td>
	</Tr>
	</Table><br><center>
	
		<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/show.gif">
</form>		
</body>
</html>
