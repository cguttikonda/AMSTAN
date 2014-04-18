<jsp:useBean id="inparams" class="ezc.ezcommon.arms.params.EziUserRolesParams" />
<%
        ReturnObjFromRetrieve retRoleDetails=null;
	inparams.setRoleNr(roleNr);
	EzcParams params=new EzcParams(false);
	params.setObject(inparams);
	Session.prepareParams(params);
        retRoleDetails=(ReturnObjFromRetrieve) ArmsManager.ezUserRoleDetails(params);
%>