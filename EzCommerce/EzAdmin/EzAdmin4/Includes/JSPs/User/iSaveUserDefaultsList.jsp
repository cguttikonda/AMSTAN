<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%

String BusUser = request.getParameter("BusUser");	
String SysKey = request.getParameter("SystemKey");

String[] values=request.getParameterValues("DefaultsValue");
String[] keys=request.getParameterValues("DefaultsKey");

if ( values != null )
{
	for ( int j = 0  ; j < values.length; j++ )
	{
	
		EzKeyValueStructure in = new EzKeyValueStructure();

		in.setPKey(BusUser.trim());
		in.setKey(keys[j].trim());
		in.setValue(values[j].trim());

		EzcUserParams uparams = new EzcUserParams();
		EzcUserNKParams userNKParams = new  EzcUserNKParams();
		userNKParams.setEzKeyValueStructure(in);
		userNKParams.setSys_Key(SysKey);
		userNKParams.setIsUserAKey("Y");
		uparams.createContainer();
		uparams.setObject(userNKParams);
		Session.prepareParams(uparams);

		UserManager.setUserDefaults(uparams); 
	}
}

response.sendRedirect("../User/ezUserDefaultsList.jsp?saved=Y&BusUser=" + BusUser);
%>