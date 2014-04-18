<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<%
	ReturnObjFromRetrieve retUsers  = null;
	String websyskey=request.getParameter("WebSysKey");
	String myUserType = request.getParameter("myUserType");

	String partnerValue = request.getParameter("partnerValue");
	if(!(websyskey==null || partnerValue==null || "".equals(partnerValue) || partnerValue.equals("")))
	{
		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setSyskeys(websyskey);
		adminUtilsParams.setPartnerValueBy(partnerValue);
		EzcParams mainParams = new EzcParams(false);
		mainParams.setObject(adminUtilsParams);
		Session.prepareParams(mainParams);
		retUsers = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams);
	}
	
	if((websyskey!=null && "".equals(partnerValue)))
	{
		if(!websyskey.equals("sel") && !websyskey.equals("All"))
		{
			EzcUserParams uparams= new EzcUserParams();
			Session.prepareParams(uparams);

			EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
			ezcUserNKParams.setLanguage("EN");
			ezcUserNKParams.setSys_Key(websyskey);
			uparams.createContainer();
			boolean result_flag = uparams.setObject(ezcUserNKParams);

			retUsers =	(ReturnObjFromRetrieve)UserManager.getUsersForSalesArea(uparams);
		}
		else
		{
			if(websyskey.equals("All"))
			{
				int myRetCount=ret.getRowCount();
				String allWebSysKeys="";
				if(myRetCount==0)
					allWebSysKeys="NONE";	
				else
					allWebSysKeys=ret.getFieldValueString(0,SYSTEM_KEY);
				for(int k=1;k<myRetCount;k++)
				{
					allWebSysKeys += "','"+ret.getFieldValueString(k,SYSTEM_KEY);
				}
				EzcUserParams uparams= new EzcUserParams();
				Session.prepareParams(uparams);	
				EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
				ezcUserNKParams.setLanguage("EN");
				ezcUserNKParams.setSys_Key(allWebSysKeys);
				uparams.createContainer();
				boolean result_flag = uparams.setObject(ezcUserNKParams);
				retUsers =	(ReturnObjFromRetrieve)UserManager.getUsersForSalesArea(uparams);
			}
		}
	}
	if(myUserType!=null && !"null".equals(myUserType) && websyskey!=null && !"null".equals(websyskey))
	{
		int deleteCount = retUsers.getRowCount();
		for(int i=deleteCount-1;i>=0;i--)
		{
			if(!(myUserType.equals(retUsers.getFieldValueString(i,"EU_TYPE"))))
			{
				retUsers.deleteRow(i);
			}
		}
	}
%>
