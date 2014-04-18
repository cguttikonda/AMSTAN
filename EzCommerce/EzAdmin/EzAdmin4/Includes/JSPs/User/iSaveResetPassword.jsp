<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "java.util.*" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"/>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	String UserId = request.getParameter("BusUser"); // User Id
	String NewPassword = request.getParameter("password2"); // New Password

	EzcUserParams uparams= new EzcUserParams();
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setPassword(NewPassword);

	uparams.createContainer();
	uparams.setUserId(UserId);
	boolean result_flag = uparams.setObject(ezcUserNKParams);
	Session.prepareParams(uparams);

	UserManager.changeUserPassword(uparams);
%>
<script>
	history.go(-2);
</script>