<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>


<%
// Key Variables
String error = "";
ReturnObjFromRetrieve retuser = null;
ReturnObjFromRetrieve retarea= null;
String websyskey=request.getParameter("WebSysKey");
EzcUserParams uparams= new EzcUserParams();
if(websyskey!=null)
{
	if(!"sel".equals(websyskey))
	{


		EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
		ezcUserNKParams.setLanguage("EN");
		uparams.createContainer();
		ezcUserNKParams.setSys_Key(websyskey);
		boolean result_flag = uparams.setObject(ezcUserNKParams);
		Session.prepareParams(uparams);

		//Get All Users
		retuser = (ReturnObjFromRetrieve) UserManager.getUsersForSalesArea(uparams);

		retuser.check();
	}
}
//Get Selected User Value

String bus_user = request.getParameter("BusinessUser");
if(websyskey!=null && !"sel".equals(websyskey))
{
		if(bus_user!=null && !"sel".equals(bus_user))
		{

				uparams.setUserId(bus_user);
				retarea= (ReturnObjFromRetrieve)UserManager.getUserData(uparams);
				ret.check();
				String oldPasswd = (String) (ret.getFieldValue(0,USER_PASSWORD));
		String mypwd = request.getParameter("oldpasswd");

		if ((!(mypwd == null)) && (mypwd.equals(oldPasswd))) {
			error = "";
		} else {
			if(mypwd == null){
				error = "";
				} else {
				error = "E";
				mypwd = "";

		}
	}
}
}
%>