<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%

String BusUser = request.getParameter("BusUser");
String SysKey = request.getParameter("SysKey");
session.putValue("myWebSyskey",SysKey);
String[] defValues=request.getParameterValues("DefaultsValue");
String[] defKeys=request.getParameterValues("DefaultKey");

if(defValues != null)
{
	EzcUserParams uparams = new EzcUserParams();
	EzcUserNKParams userNKParams = new  EzcUserNKParams();

	for ( int j = 0  ; j < defValues.length; j++ )
	{

	    if(defValues[j] != null)	
	    {

		EzKeyValueStructure in = new EzKeyValueStructure();

		in.setPKey(BusUser.trim());
		in.setKey(defKeys[j].trim());
		in.setValue(defValues[j].trim());

		userNKParams.setEzKeyValueStructure(in);
		userNKParams.setSys_Key(SysKey);
		userNKParams.setIsUserAKey("Y");
		uparams.createContainer();
		uparams.setObject(userNKParams);
		Session.prepareParams(uparams);

		UserManager.setUserDefaults(uparams); 

	    }	
	
	}
}

response.sendRedirect("../User/ezAddUserOnlyDefaults.jsp?BusinessUser=" + BusUser);
%>
