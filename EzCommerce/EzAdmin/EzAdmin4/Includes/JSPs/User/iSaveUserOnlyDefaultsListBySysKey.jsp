<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%

String BusUser = request.getParameter("BusUser");
String websyskey=request.getParameter("WebSysKey");
String Area =request.getParameter("Area");
String[] values=request.getParameterValues("DefaultsValue");
String[] keys=request.getParameterValues("DefaultsKey");
String lang=request.getParameter("lang");
String curr=request.getParameter("currency");


int k=0;
if ( keys != null )
{
	for ( int j = 0  ; j < keys.length; j++ )
	{

		EzKeyValueStructure in = new EzKeyValueStructure();

		in.setPKey(BusUser.trim());
		in.setKey(keys[j].trim());
		if((keys[j].trim()).equals("LANGUAGE"))
			in.setValue(lang.trim());
		else if((keys[j].trim()).equals("CURRENCY"))
			in.setValue(curr.trim());
		else
		{
			in.setValue(values[k].trim());
			k++;
		}

		EzcUserParams uparams = new EzcUserParams();
		EzcUserNKParams userNKParams = new  EzcUserNKParams();
		userNKParams.setEzKeyValueStructure(in);
		userNKParams.setIsUserAKey("Y");
		uparams.createContainer();
		uparams.setObject(userNKParams);
		Session.prepareParams(uparams);

		UserManager.setUserDefaults(uparams);

	}
}

response.sendRedirect("../User/ezUserOnlyDefaultsListBySysKey.jsp?saved=Y&BusUser=" + BusUser +"&Area="+Area +"&WebSysKey="+websyskey);


%>