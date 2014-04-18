<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%@ page import="ezc.ezcommon.arms.params.*" %>
<jsp:useBean id="ArmsManager" class="ezc.ezcommon.arms.client.EzcUserRolesManager" />
<%

	EzcParams inParams = new EzcParams(false);
	Session.prepareParams( inParams );
	ReturnObjFromRetrieve retRoles = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( inParams );
	
	String roleId=request.getParameter("Role");
	if(roleId == null && retRoles.getRowCount() > 0)
	{
		for(int i=0;i<retRoles.getRowCount();i++)
		{
		    if(((String)retRoles.getFieldValue(i,"DELETE_FLAG")).equals("N"))
		    {
			roleId=retRoles.getFieldValueString(i,"ROLE_NR");
			break;
		    }	
		}	
	}
	
	ezc.ezparam.ReturnObjFromRetrieve listRet=null;
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziRoleConditionsParams params= new ezc.ezworkflow.params.EziRoleConditionsParams();
	params.setRoleNo(roleId);
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getConditionsList(mainParams);
	
%>
