<%

	String userId = request.getParameter("userId");
	String retStr = "";
	ezc.ezbasicutil.EzADAuthenticator adAuth = new ezc.ezbasicutil.EzADAuthenticator();
	java.util.Map userDataMap = adAuth.checkForUser(userId);
	if(userDataMap == null)
	{
		retStr = "$N$";
	}
	else
	{
		retStr = "$Y$";
		ezc.ezcommon.EzLog4j.log("user present in ADS>>>>>"+userDataMap,"I");
	}
	out.print(retStr);
%>