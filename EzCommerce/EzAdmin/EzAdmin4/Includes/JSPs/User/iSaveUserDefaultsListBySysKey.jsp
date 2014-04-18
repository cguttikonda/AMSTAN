<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%
String SysKey=null;
String BusUser = request.getParameter("BusUser");
String Area = request.getParameter("Area");
String websyskey=request.getParameter("WebSysKey");
String[] values=request.getParameterValues("DefaultsValue");
String[] keys=request.getParameterValues("DefaultsKey");


if (values != null )
{
	for ( int j = 0  ; j < values.length; j++ )
	{
	    if(values[j]!=null)
	    {

		EzKeyValueStructure in = new EzKeyValueStructure();

		in.setPKey(BusUser.trim());
		in.setKey(keys[j].trim());
		in.setValue(values[j].trim());

		EzcUserParams uparams = new EzcUserParams();
		EzcUserNKParams userNKParams = new  EzcUserNKParams();
		userNKParams.setEzKeyValueStructure(in);
		userNKParams.setSys_Key(websyskey);
		userNKParams.setIsUserAKey("Y");
		uparams.createContainer();
		uparams.setObject(userNKParams);
		Session.prepareParams(uparams);

		UserManager.setUserDefaults(uparams);
	    }
	}
}

response.sendRedirect("../User/ezUserDefaultsListBySysKey.jsp?saved=Y&BusUser=" + BusUser +"&Area="+Area +"&WebSysKey="+websyskey);
%>