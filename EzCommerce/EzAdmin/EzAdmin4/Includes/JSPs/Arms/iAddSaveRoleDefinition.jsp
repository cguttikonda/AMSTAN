<%@ include file="../../Lib/ArmsBean.jsp" %>
<%@ include file="../../Lib/ArmsConfig.jsp" %>
<jsp:useBean id="inparams" class="ezc.ezcommon.arms.params.EzUserRolesStructure" />
<%
	ReturnObjFromRetrieve values=null;
	EzcParams param=new EzcParams(false);

        inparams.setRoleNr(roleNr.toUpperCase());
        inparams.setRoleType(roleType);
	inparams.setLanguage("EN");
	inparams.setRoleDescription(roleDesc);
       	inparams.setDeletedFlag("N");
       	inparams.setBusinessDomain(busDom);
       	inparams.setComponent(busComp);

        param.setObject(inparams);
	Session.prepareParams(param);
	
	ReturnObjFromRetrieve ret=(ReturnObjFromRetrieve)ArmsManager.ezAddUserRole(param); 
	String RoleNo=ret.getFieldValueString(0,"RoleNo");
	
	EzDescStructure descStru = new EzDescStructure();
	descStru.setDesc(roleDesc);
	if("C".equals(roleType))
		descStru.setSysAuthFlag("N");
	else
		descStru.setSysAuthFlag("Y");	
	descStru.setKey(roleNr);
	descStru.setLang("EN");
	descStru.setComponent("ROLE");
	descStru.setDomain("ROLE");
	descStru.setDeletionFlag("N");
	
	ezc.ezparam.EzcSysConfigNKParams sysNkParams = new ezc.ezparam.EzcSysConfigNKParams();
	sysNkParams.setEzDescStructure(descStru);
	
	ezc.ezparam.EzcSysConfigParams sysParams = new ezc.ezparam.EzcSysConfigParams();
	sysParams.setObject(sysNkParams);
	
	ezc.client.EzSystemConfigManager SysConfigMgr = new ezc.client.EzSystemConfigManager();
	Session.prepareParams(sysParams);
	SysConfigMgr.addAuthDesc(sysParams);
	
	response.sendRedirect("ezListUserRoles.jsp");
%>