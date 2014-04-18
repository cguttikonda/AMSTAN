<%@ page import="ezc.ezparam.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session" />

<%
	int userDetCount=0;
	boolean result_flag;
	String usrId = request.getParameter("usrId");
	usrId =  (usrId.trim()).toUpperCase();
		
	ReturnObjFromRetrieve userDet=null;
	java.util.Hashtable ht= new java.util.Hashtable();
	EzcUserParams uparams= new EzcUserParams();
	ezc.ezcommon.EzCipher myCipher = new ezc.ezcommon.EzCipher();
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
		
	if(usrId!=null)
	{
		uparams.createContainer();
		result_flag = uparams.setObject(ezcUserNKParams);
		uparams.setUserId(usrId);
		Session.prepareParams(uparams);
		userDet = (ReturnObjFromRetrieve)UserManager.getUserData(uparams);
	}
	if(userDet!=null)
	{
		userDetCount=userDet.getRowCount();
	}
	
%>	