<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%

String roleInd = null;
String sysNo=null;
String key=null;
String val=null;

String BusUser = request.getParameter("BusUser");
//String Area=request.getParameter("Area");
//String websyskey=request.getParameter("WebSysKey");

String[] chk=request.getParameterValues("Check");
String[] stat=request.getParameterValues("Stat");
String[] allKeys=request.getParameterValues("allKeys");

if(chk != null)
{
	java.util.StringTokenizer stk=null;
	for(int i=0;i<chk.length;i++)
	{
		stk=new java.util.StringTokenizer(chk[i],"#");

		sysNo=stk.nextToken();
		key=stk.nextToken();
		val=stk.nextToken();
		roleInd=stk.nextToken();

		EzKeyValueStructure in = new EzKeyValueStructure();

		in.setPKey(BusUser.trim());
		in.setKey(key.trim());
		in.setValue(val.trim());
		in.setRoleIndicator( roleInd );

		EzcUserParams uparams= new EzcUserParams();
		EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
		ezcUserNKParams.setLanguage("EN");
		ezcUserNKParams.setEzKeyValueStructure(in);
		ezcUserNKParams.setSys_Number(sysNo);
		uparams.createContainer();
		boolean result_flag = uparams.setObject(ezcUserNKParams);
		Session.prepareParams(uparams);

		UserManager.setUserAuth(uparams);

	}
}
if(allKeys != null)
{
	java.util.StringTokenizer stk=null;
	for(int i=0;i<allKeys.length;i++)
	{
		if(stat!=null)
		{
			for(int j=0;j<stat.length;j++)
			{
				stk=new java.util.StringTokenizer(stat[j],"#");

				sysNo=stk.nextToken();
				key=stk.nextToken();
				val=stk.nextToken();
				roleInd=stk.nextToken();

			    if(key.equals(allKeys[i]))
			    {
				EzKeyValueStructure in = new EzKeyValueStructure();

				in.setPKey(BusUser.trim());
				in.setKey(key.trim());
				in.setValue(val.trim());
				in.setRoleIndicator( roleInd );

				EzcUserParams uparams= new EzcUserParams();
				EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
				ezcUserNKParams.setLanguage("EN");
				ezcUserNKParams.setEzKeyValueStructure(in);
				ezcUserNKParams.setSys_Number(sysNo);
				uparams.createContainer();
				boolean result_flag = uparams.setObject(ezcUserNKParams);
				Session.prepareParams(uparams);

				UserManager.setUserAuth(uparams);
			    }
			}
		}
	}
}


response.sendRedirect("../User/ezUserAuthList.jsp?saved=Y&BusUser=" + BusUser);
%>