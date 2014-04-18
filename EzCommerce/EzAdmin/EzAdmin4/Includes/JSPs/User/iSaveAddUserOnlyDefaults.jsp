<%@ page import = "ezc.ezparam.*" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	String myUserType = (String)session.getValue("myUserType");
	String myWebSyskey = (String)session.getValue("myWebSyskey");
	String myAreaFlag = (String)session.getValue("myAreaFlag");
	String mySearchCriteria = (String)session.getValue("mySearchCriteria");

	String BusUser = request.getParameter("BusUser");
	String lang=request.getParameter("DefaultsLanguage");
	String currency=request.getParameter("DefaultsCurrency");
	String[] defValues=request.getParameterValues("DefaultsValue");
	String[] defKeys=request.getParameterValues("DefaultsKey");

	if ( defKeys != null )
	{
		int k=0;
		for ( int j = 0  ; j < defKeys.length; j++ )
		{
	    		EzKeyValueStructure in = new EzKeyValueStructure();
			in.setPKey(BusUser.trim());
			in.setKey(defKeys[j].trim());
			if((defKeys[j].trim()).equals("LANGUAGE"))
				in.setValue(lang);
			else if((defKeys[j].trim()).equals("CURRENCY"))
				in.setValue(currency.trim());
			else
			{
				in.setValue(defValues[k].trim());
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
	response.sendRedirect("../User/ezListAllUsersBySysKey.jsp?WebSysKey="+myWebSyskey+"&Area="+myAreaFlag+"&myUserType="+myUserType+"&searchcriteria="+mySearchCriteria);
%>
