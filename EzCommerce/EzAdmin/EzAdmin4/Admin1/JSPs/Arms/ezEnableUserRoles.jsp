<%@ include file="../../../Includes/Lib/ArmsConfig.jsp" %>
<%@ include file="../../../Includes/Lib/ArmsBean.jsp" %>
<%
	ezc.ezparam.EzcParams params=new ezc.ezparam.EzcParams(false);
	EziUserRolesParams urparams = new EziUserRolesParams();
	EziRolesByUserParams rbuparams = new EziRolesByUserParams();
	EziRoleAuthParams raparams = new EziRoleAuthParams();

	String[] roles = request.getParameterValues("RoleNr");
	for(int i=0;i<roles.length;i++)
	{
		urparams.setRoleNr(roles[i]);
		
		urparams.setLanguage("EN");
		urparams.setDelFlag("N");
		rbuparams.setRoleNr(roles[i]);
		rbuparams.setSysKey("0");
		raparams.setRoleNo(roles[i]);
		raparams.setSysKey("0");
		params.setObject(urparams);
		params.setObject(rbuparams);
		params.setObject(raparams);
		Session.prepareParams(params);
		
		ArmsManager.ezDeleteUserRole(params);
		ArmsManager.ezDeleteRoleAuth(params);
	}
	response.sendRedirect("ezDeleteUserRoles.jsp");
%>