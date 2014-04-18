<%@ include file="../../Lib/ArmsConfig.jsp" %>
<%@ include file="../../Lib/ArmsBean.jsp" %>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<%@ include file="../../Lib/AdminUser.jsp" %>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="URManager" class="ezc.ezcommon.arms.client.EzcUserRolesManager" scope="session" />


<%@ page import="ezc.ezcommon.arms.params.*,ezc.ezparam.*" %>

<%
	String formObj=request.getParameter("formObj");
	String role=request.getParameter("role");

	EzcParams inParams = new EzcParams(false);
	Session.prepareParams( inParams );
	ReturnObjFromRetrieve rolesRet = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( inParams );	
	
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	ReturnObjFromRetrieve  sysRet = (ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);
	ReturnObjFromRetrieve ret1 = (ReturnObjFromRetrieve) sysManager.getPurchaseAreas(sparams);
	ezc.ezparam.EzDescStructure eds = new ezc.ezparam.EzDescStructure();
	eds.setAreaFlag("S");
	eds.setSyncFlag("N");
	snkparams.setEzDescStructure(eds);
	ReturnObjFromRetrieve ret2 = (ReturnObjFromRetrieve) sysManager.getBusinessAreas(sparams);
	sysRet.append(ret1);
	sysRet.append(ret2);
	
	int rolesCount=rolesRet.getRowCount();
	int sysCount=sysRet.getRowCount();
	String selRole=request.getParameter("roles");
	String selSysKey=request.getParameter("sysKey");
	
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezcommon.arms.params.EziRolesByUserParams params=new ezc.ezcommon.arms.params.EziRolesByUserParams();
		
	if(selRole == null && selSysKey == null)
	{
		selRole="";
		selSysKey="";
		if(rolesCount >0 && sysCount >0)
		{
			for(int i=0;i<rolesCount;i++)
			{
			    if("N".equals(rolesRet.getFieldValueString(i,"DELETE_FLAG")))
			    {
				selRole +="'"+rolesRet.getFieldValueString(i,"ROLE_NR")+"',";
			    }	
			}
			selRole=selRole.substring(0,selRole.length()-1);
			selSysKey="'"+sysRet.getFieldValueString(0,SYSTEM_KEY)+"'";
			for(int i=1;i<sysCount;i++)
			{
				selSysKey +=",'"+sysRet.getFieldValueString(i,SYSTEM_KEY)+"'";
			}
		}
	}
	else
	{
		if(selRole.equals("All") && rolesCount > 0)
		{
			selRole="";
			for(int i=0;i<rolesCount;i++)
			{
			    if("N".equals(rolesRet.getFieldValueString(i,"DELETE_FLAG")))
			    {
				selRole +="'"+rolesRet.getFieldValueString(i,"ROLE_NR")+"',";
			    }	
			}
			selRole=selRole.substring(0,selRole.length()-1);
		}
		else
		{
			selRole="'"+selRole+"'";
		}	
		if(selSysKey.equals("All") && sysCount > 0)
		{
			selSysKey="'"+sysRet.getFieldValueString(0,SYSTEM_KEY)+"'";
			for(int i=1;i<sysCount;i++)
			{
				selSysKey +=",'"+sysRet.getFieldValueString(i,SYSTEM_KEY)+"'";
			}
		}
		else
		{
			selSysKey="'"+selSysKey+"'";
		}	
	}
	
	params.setSysKey(selSysKey);
	params.setRoleNr(selRole);
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve usersRet=(ezc.ezparam.ReturnObjFromRetrieve) URManager.ezUsersListByRoleAndArea(mainParams);
%>

