<%@ include file="../../Lib/ArmsConfig.jsp" %>
<%@ include file="../../Lib/ArmsBean.jsp" %>
<jsp:useBean id="urparams" class="ezc.ezcommon.arms.params.EziUserRolesParams" />
<jsp:useBean id="rbuparams" class="ezc.ezcommon.arms.params.EziRolesByUserParams" />
<jsp:useBean id="raparams" class="ezc.ezcommon.arms.params.EziRoleAuthParams" />
<%
	EzcParams params=new EzcParams(false);
	String[] roles = request.getParameterValues("RoleNr");
	java.util.StringTokenizer stk = null;
	String roleNr = null;
	for(int i=0;i<roles.length;i++)
	{
		stk = new java.util.StringTokenizer(roles[i],"#");
		roleNr = stk.nextToken();
		urparams.setRoleNr(roleNr);
		
		urparams.setLanguage("EN");
		urparams.setDelFlag("Y");
		rbuparams.setRoleNr(roleNr);
		rbuparams.setSysKey("0");
		raparams.setRoleNo(roleNr);
		raparams.setSysKey("0");
		params.setObject(urparams);
		params.setObject(rbuparams);
		params.setObject(raparams);
		Session.prepareParams(params);
		
		ArmsManager.ezDeleteUserRole(params);
		ArmsManager.ezDeleteRoleAuth(params);
	}
%>