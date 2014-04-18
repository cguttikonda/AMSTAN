<%@ include file="../../Lib/ArmsBean.jsp" %>
<%@ include file="../../Lib/ArmsConfig.jsp" %>
<jsp:useBean id="inparams" class="ezc.ezcommon.arms.params.EzUserRolesStructure" />
<%
	ReturnObjFromRetrieve values=null;
	EzcParams param=new EzcParams(false);
        inparams.setRoleNr(roleNr);
        inparams.setRoleType(roleType);
	inparams.setLanguage("EN");
	inparams.setRoleDescription(roleDesc);
       	inparams.setDeletedFlag(roleDel);
       	inparams.setBusinessDomain(busDom);
       	inparams.setComponent(busComp);
        param.setObject(inparams);
	Session.prepareParams(param);	
        ArmsManager.ezUpdateUserRole(param);  
	response.sendRedirect("ezListUserRoles.jsp");
%>