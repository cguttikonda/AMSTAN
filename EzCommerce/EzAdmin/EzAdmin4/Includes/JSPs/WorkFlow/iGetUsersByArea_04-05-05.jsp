<%@ page import = "ezc.ezparam.*" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<jsp:useBean id="URManager" class="ezc.ezcommon.arms.client.EzcUserRolesManager" scope="session" />
<%
	String websyskey= request.getParameter("area");
	ezc.ezparam.EzcParams detailsMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWorkGroupsParams detailsParams= new ezc.ezworkflow.params.EziWorkGroupsParams();
	detailsParams.setGroupId(grpid);
	detailsParams.setLang("EN");
	detailsMainParams.setObject(detailsParams);
	Session.prepareParams(detailsMainParams);
	ezc.ezparam.ReturnObjFromRetrieve detailsRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupDetails(detailsMainParams);

	String role=detailsRet.getFieldValueString(0,"ROLE");
	String groupType=detailsRet.getFieldValueString(0,"WGTYPE");

	
	ReturnObjFromRetrieve listRet1=null;

	ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWorkGroupUsersParams paramsu= new ezc.ezworkflow.params.EziWorkGroupUsersParams();
	paramsu.setGroupId("'"+grpid+"'");
    
	mainParamsu.setObject(paramsu);
	Session.prepareParams(mainParamsu);
	listRet1=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupUsers(mainParamsu);



ezc.ezparam.ReturnObjFromRetrieve retUsers  = null;
if(websyskey != null)
{
	if((websyskey.equals("All")))
	{
		String allKeys="";
		int allCnt=ret1.getRowCount();
		for(int i=0;i<allCnt;i++)
		{
			allKeys += "'"+ret1.getFieldValueString(i,"ESKD_SYS_KEY")+"',";
		}
		if("IC".equals(groupType) || "IV".equals(groupType))
		{
			if(allCnt>0)
				allKeys=allKeys.substring(0,allKeys.length()-1);
			ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
			ezc.ezcommon.arms.params.EziRolesByUserParams params=new ezc.ezcommon.arms.params.EziRolesByUserParams();
			params.setSysKey(allKeys);
			params.setRoleNr("'"+role+"'");
			mainParams.setObject(params);
			Session.prepareParams(mainParams);
			retUsers=(ezc.ezparam.ReturnObjFromRetrieve)URManager.ezUsersListByRoleAndArea(mainParams);
		}
		else
		{
			if(allCnt>0)
				allKeys=allKeys.substring(1,allKeys.length()-2);
			ezc.ezparam.EzcParams mainParamsus = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWorkGroupUsersParams paramsus= new ezc.ezworkflow.params.EziWorkGroupUsersParams();
			paramsus.setSyskey(allKeys);

			paramsus.setPartnerFunction(groupType);
			mainParamsus.setObject(paramsus);
			Session.prepareParams(mainParamsus);
			retUsers=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupUsers(mainParamsus);
		}
	}
	else
	{
	
		if("IC".equals(groupType) || "IV".equals(groupType))
		{
			ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
			ezc.ezcommon.arms.params.EziRolesByUserParams params=new ezc.ezcommon.arms.params.EziRolesByUserParams();
			params.setSysKey("'"+websyskey+"'");
			params.setRoleNr("'"+role+"'");
			mainParams.setObject(params);
			Session.prepareParams(mainParams);
			retUsers=(ezc.ezparam.ReturnObjFromRetrieve)URManager.ezUsersListByRoleAndArea(mainParams);
		}
		else
		{
			ezc.ezparam.EzcParams mainParamsus = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWorkGroupUsersParams paramsus= new ezc.ezworkflow.params.EziWorkGroupUsersParams();
			paramsus.setSyskey(websyskey);
			paramsus.setPartnerFunction(groupType);
			//paramsus.setGroupId(grpid);
			mainParamsus.setObject(paramsus);
			Session.prepareParams(mainParamsus);
			retUsers=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupUsers(mainParamsus);
		}	
	}	

}

if(retUsers!=null)
{
	String user="",sys="",sold="";
	int myCount=listRet1.getRowCount();
	for(int i=0;i<myCount;i++)
	{
		user=listRet1.getFieldValueString(i,"USERID");
		if(user != null)
			user=user.trim();
		sys=listRet1.getFieldValueString(i,"SYSKEY");
		if(sys != null)
			sys=sys.trim();
		sold=listRet1.getFieldValueString(i,"SOLDTO");
		if(sold != null)
			sold=sold.trim();
		int uCount=retUsers.getRowCount();
		//Added by Suresh Parimi on 19th Aug 2003 to Delete Existing Internal Work Group user from Ezc Users.
		if("IC".equals(groupType) || "IV".equals(groupType))
		{
			for(int j=uCount-1;j>=0;j--)
			{
				if(user.equals((retUsers.getFieldValueString(j,"EU_ID")).trim()) && sys.equals(websyskey))
				{
					retUsers.deleteRow(j);
					break;
				}
			}
		}
		else
		{
			for(int j=uCount-1;j>=0;j--)
			{
				if((user.equals((retUsers.getFieldValueString(j,"EU_ID")).trim())) && sys.equals((retUsers.getFieldValueString(j,"EC_SYS_KEY")).trim()) && sold.equals((retUsers.getFieldValueString(j,"EC_ERP_CUST_NO")).trim()))
				{
					retUsers.deleteRow(j);
					break;
				}
			}
		}
	}
}
	java.util.TreeSet alphaTree = new java.util.TreeSet();
	String alphaName = null;
	int myRowCount = 0;
	if(websyskey!=null && !"null".equals(websyskey))
	{
		myRowCount = retUsers.getRowCount();
		for(int i=0;i<myRowCount;i++)
		{
			alphaName = retUsers.getFieldValueString(i,"EU_FIRST_NAME");
			alphaTree.add((alphaName.substring(0,1)).toUpperCase());
		}
	}
	String searchPartner=request.getParameter("searchcriteria");
	if(alphaTree.size()>0 && "$".equals(searchPartner))
		searchPartner=(String)alphaTree.first()+"*";	
%>
