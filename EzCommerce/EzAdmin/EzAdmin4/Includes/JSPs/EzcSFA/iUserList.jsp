<%@ page import = "ezc.ezparam.*" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session" />
<%
	String currentUser = Session.getUserId();
	String[] userList = null;
	EzcUserParams uparams= new EzcUserParams();
	Session.prepareParams(uparams);
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	ezcUserNKParams.setSys_Key("999999");
	uparams.createContainer();
	boolean result_flag = uparams.setObject(ezcUserNKParams);
	ReturnObjFromRetrieve retUsers = (ReturnObjFromRetrieve)UserManager.getUsersForSalesArea(uparams);
	int userCount=0;
	if(retUsers != null)
	{
		userCount = retUsers.getRowCount();  
		userList = new String[userCount];
		for(int i=0;i<userCount;i++)
		{
			userList[i] = retUsers.getFieldValueString(i,"EU_ID");	
		}
	}	
%>
