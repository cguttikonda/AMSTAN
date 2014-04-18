<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%

String BusUser = request.getParameter("BusUser");	
String[] checks=request.getParameterValues("Check");

String FromAdd = request.getParameter("FromAdd");
java.util.StringTokenizer stk=null;
String authKey="";
String roleInd="";
String authDesc="";
if(checks != null)
{
	for(int i=0;i<checks.length;i++)
	{
		stk=new java.util.StringTokenizer(checks[i],"#");
		authKey=stk.nextToken();
		authDesc=stk.nextToken();
		roleInd=stk.nextToken();
	
		EzKeyValueStructure in = new EzKeyValueStructure();
		in.setPKey(BusUser.trim());
		in.setKey(authKey.trim());
		in.setValue(authDesc.trim());
		in.setRoleIndicator(roleInd);
		EzcUserParams uparams= new EzcUserParams();
		EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
		ezcUserNKParams.setEzKeyValueStructure(in);
		uparams.createContainer();
		boolean result_flag = uparams.setObject(ezcUserNKParams);
		Session.prepareParams(uparams);
	
		UserManager.setUserMasterAuth(uparams); 				//AdminObject.setUserMasterAuth(servlet, in); 
	}	
}


if ( FromAdd != null && FromAdd.equals("Yes") )
{
	response.sendRedirect("../User/ezAddUserDefaults.jsp?BusinessUser=" + BusUser);
}
else
{
	response.sendRedirect("../User/ezUserEzcAuthList.jsp?&saved=Y&BusUser=" + BusUser);
}


%>