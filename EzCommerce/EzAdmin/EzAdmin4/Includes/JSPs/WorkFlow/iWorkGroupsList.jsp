<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%@ page import="ezc.ezcommon.arms.params.*" %>
<jsp:useBean id="ArmsManager" class="ezc.ezcommon.arms.client.EzcUserRolesManager" />
<%
	EzcParams inParams = new EzcParams(false);
	Session.prepareParams( inParams );
	ReturnObjFromRetrieve retRoles = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( inParams );

	String role = request.getParameter("role");
	String flag=request.getParameter("flag");
	ReturnObjFromRetrieve listRet = null;

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWorkGroupsParams params= new ezc.ezworkflow.params.EziWorkGroupsParams();
	if(role!=null)
		params.setRoleNo(role);
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	listRet=(ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupsList(mainParams);
	listRet.toEzcString();
	String wgType = "";
	if(listRet.getRowCount()>0)
		wgType = listRet.getFieldValueString(0,"WGTYPE");
	String myAreaFlag = "";
	if("VN".equals(wgType) || "IV".equals(wgType))
		myAreaFlag = "V";
	else if("AG".equals(wgType) || "IC".equals(wgType))
		myAreaFlag = "C";
	java.util.TreeSet alphaTree = new java.util.TreeSet();
	String alphaName = null;
	int rowCount = 0;
	if(role!=null && !"null".equals(role))
	{
		rowCount = listRet.getRowCount();
		for(int i=0;i<rowCount;i++)
		{
			alphaName = listRet.getFieldValueString(i,"DESCRIPTION");
			alphaTree.add((alphaName.substring(0,1)).toUpperCase());
		}
	}
	String searchPartner=request.getParameter("searchcriteria");
	if(alphaTree.size()>0 && "$".equals(searchPartner))
		searchPartner=(String)alphaTree.first()+"*";	
%>
