
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	String myUserType = (String)session.getValue("myUserType");
	String myWebSyskey = (String)session.getValue("myWebSyskey");
	String myAreaFlag = (String)session.getValue("myAreaFlag");
	String mySearchCriteria = (String)session.getValue("mySearchCriteria");

	String websyskey=request.getParameter("WebSysKey");
	String Area=request.getParameter("Area");
	
	String fromListByRole=request.getParameter("fromListByRole");
	String roleVal=request.getParameter("role");
	String sysVal=request.getParameter("sysKey");
	String pCheckBox = request.getParameter("BusinessUser");
	
	myUserType = myUserType.trim();

	if("3".equals(myUserType))
	{
%>	
		<%@ include file="iDeleteExternalUser.jsp"%>
<%		
	}
	else
	{
		//for ( int i = 0 ; i < pCheckBox.length; i++ ) 
		{
			EzcUserParams uparams= new EzcUserParams();
			uparams.setUserId(pCheckBox);
			EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
			ezcUserNKParams.setLanguage("EN");
			uparams.createContainer();
			uparams.setObject(ezcUserNKParams);
			Session.prepareParams(uparams);
			UserManager.deleteUsers(uparams);
			
			
		}
	}	
	if(Area!=null && !"".equals(Area.trim()))
	{
		response.sendRedirect("../User/ezListAllUsersBySysKey.jsp?WebSysKey="+myWebSyskey+"&Area="+myAreaFlag+"&myUserType="+myUserType+"&searchcriteria="+mySearchCriteria);
	}
	else if(fromListByRole != null)
	{
		response.sendRedirect("ezListUsersByRole.jsp?role="+roleVal+"&sysKey="+sysVal+"&fromMod=Yes");
	}
	else
	{
		response.sendRedirect("../User/ezListAllUsers.jsp");
	}
%>
