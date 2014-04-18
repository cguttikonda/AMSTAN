<%@ page import = "ezc.ezparam.*" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%
	ReturnObjFromRetrieve retUsers  = null;
	String websyskey=request.getParameter("WebSysKey");
	String myUserType = request.getParameter("myUserType");
	String searchPartner=request.getParameter("searchcriteria");
	//out.println("searchPartner::::::"+searchPartner);
	
	String websys="";
	if("All".equals(websyskey))
		websys=websyskey;
	
	//out.println("websyskey::::::"+websyskey);
	if((websyskey!=null))
	{
		if(!websyskey.equals("sel") && !websyskey.equals("All"))
		{
			/*EzcUserParams uparams= new EzcUserParams();
			Session.prepareParams(uparams);

			EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
			ezcUserNKParams.setLanguage("EN");
			ezcUserNKParams.setSys_Key(websyskey);
			uparams.createContainer();
			boolean result_flag = uparams.setObject(ezcUserNKParams);
			retUsers =	(ReturnObjFromRetrieve)UserManager.getUsersForSalesArea(uparams);
			ezc.ezcommon.EzLog4j.log("DE1:End Get BizPartners1111111"+retUsers,"I");*/

			if(searchPartner==null || "null".equalsIgnoreCase(searchPartner) || "$".equalsIgnoreCase(searchPartner)) searchPartner = "";

			String query_SA="";
			if("3".equals(myUserType))
				query_SA="select a.EU_ID, a.EU_DELETION_FLAG, a.EU_FIRST_NAME, a.EU_MIDDLE_INITIAL, a.EU_LAST_NAME, a.EU_EMAIL, a.EU_CREATED_DATE, a.EU_CHANGED_DATE, a.EU_CHANGED_BY, a.EU_VALID_TO_DATE, a.EU_LAST_LOGIN_TIME, a.EU_LAST_LOGIN_DATE, a.EU_TYPE, EUG_ID, a.EU_BUSINESS_PARTNER,a.EU_IS_BUILT_IN_USER, a.EU_CURRENT_NUMBER  from EZC_USERS a where a.EU_ID IN (select distinct(EUD_USER_ID) from EZC_USER_DEFAULTS where EUD_SYS_KEY IN ('"+websyskey+"'))  AND EU_FIRST_NAME LIKE '"+searchPartner+"%'  and a.EU_TYPE='3' order by a.EU_ID";
			else if("2".equals(myUserType))
				query_SA="select a.EU_ID, a.EU_DELETION_FLAG, a.EU_FIRST_NAME, a.EU_MIDDLE_INITIAL, a.EU_LAST_NAME, a.EU_EMAIL, a.EU_CREATED_DATE, a.EU_CHANGED_DATE, a.EU_CHANGED_BY, a.EU_VALID_TO_DATE, a.EU_LAST_LOGIN_TIME, a.EU_LAST_LOGIN_DATE, a.EU_TYPE, EUG_ID, a.EU_BUSINESS_PARTNER,a.EU_IS_BUILT_IN_USER, a.EU_CURRENT_NUMBER  from EZC_USERS a where a.EU_ID IN (select distinct(EBPA_USER_ID) from EZC_BUSS_PARTNER_AREAS where EBPA_SYS_KEY IN ('"+websyskey+"'))  AND EU_FIRST_NAME LIKE '"+searchPartner+"%' and a.EU_TYPE='2' order by a.EU_ID";
			else
				query_SA="select a.EU_ID, a.EU_DELETION_FLAG, a.EU_FIRST_NAME, a.EU_MIDDLE_INITIAL, a.EU_LAST_NAME, a.EU_EMAIL, a.EU_CREATED_DATE, a.EU_CHANGED_DATE, a.EU_CHANGED_BY, a.EU_VALID_TO_DATE, a.EU_LAST_LOGIN_TIME, a.EU_LAST_LOGIN_DATE, a.EU_TYPE, EUG_ID, a.EU_BUSINESS_PARTNER,a.EU_IS_BUILT_IN_USER, a.EU_CURRENT_NUMBER  from EZC_USERS a where a.EU_ID IN (select distinct(EBPA_USER_ID) from EZC_BUSS_PARTNER_AREAS where EBPA_SYS_KEY IN ('"+websyskey+"'))  AND EU_FIRST_NAME LIKE '"+searchPartner+"%' order by a.EU_ID";

			if(!"".equals(query_SA))
			{
				ezc.ezparam.EzcParams mainParams_SA=new ezc.ezparam.EzcParams(false);
				ezc.ezmisc.params.EziMiscParams miscParams_SA = new ezc.ezmisc.params.EziMiscParams();

				miscParams_SA.setIdenKey("MISC_SELECT");
				miscParams_SA.setQuery(query_SA);

				mainParams_SA.setLocalStore("Y");
				mainParams_SA.setObject(miscParams_SA);
				Session.prepareParams(mainParams_SA);

				try
				{
					retUsers = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_SA);
				}
				catch(Exception e){}
			}
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
				/*EzcUserParams uparams= new EzcUserParams();
				Session.prepareParams(uparams);	
				EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
				ezcUserNKParams.setLanguage("EN");
				ezcUserNKParams.setSys_Key(allWebSysKeys);
				uparams.createContainer();
				boolean result_flag = uparams.setObject(ezcUserNKParams);
				ezc.ezcommon.EzLog4j.log("DE1:Start Get BizUsers","I");
				retUsers =	(ReturnObjFromRetrieve)UserManager.getUsersForSalesArea(uparams);
				ezc.ezcommon.EzLog4j.log("DE1:End Get BizPartners"+retUsers,"I");*/

				if(searchPartner==null || "null".equalsIgnoreCase(searchPartner) || "$".equalsIgnoreCase(searchPartner)) searchPartner = "";

				String query_SA="";
				if("3".equals(myUserType))
					query_SA="select a.EU_ID, a.EU_DELETION_FLAG, a.EU_FIRST_NAME, a.EU_MIDDLE_INITIAL, a.EU_LAST_NAME, a.EU_EMAIL, a.EU_CREATED_DATE, a.EU_CHANGED_DATE, a.EU_CHANGED_BY, a.EU_VALID_TO_DATE, a.EU_LAST_LOGIN_TIME, a.EU_LAST_LOGIN_DATE, a.EU_TYPE, EUG_ID, a.EU_BUSINESS_PARTNER,a.EU_IS_BUILT_IN_USER, a.EU_CURRENT_NUMBER  from EZC_USERS a where a.EU_ID IN (select distinct(EUD_USER_ID) from EZC_USER_DEFAULTS where EUD_SYS_KEY IN ('"+allWebSysKeys+"'))  AND EU_FIRST_NAME LIKE '"+searchPartner+"%'  and a.EU_TYPE='3' order by a.EU_ID";
				else if("2".equals(myUserType))
					query_SA="select a.EU_ID, a.EU_DELETION_FLAG, a.EU_FIRST_NAME, a.EU_MIDDLE_INITIAL, a.EU_LAST_NAME, a.EU_EMAIL, a.EU_CREATED_DATE, a.EU_CHANGED_DATE, a.EU_CHANGED_BY, a.EU_VALID_TO_DATE, a.EU_LAST_LOGIN_TIME, a.EU_LAST_LOGIN_DATE, a.EU_TYPE, EUG_ID, a.EU_BUSINESS_PARTNER,a.EU_IS_BUILT_IN_USER, a.EU_CURRENT_NUMBER  from EZC_USERS a where a.EU_ID IN (select distinct(EBPA_USER_ID) from EZC_BUSS_PARTNER_AREAS where EBPA_SYS_KEY IN ('"+allWebSysKeys+"'))  AND EU_FIRST_NAME LIKE '"+searchPartner+"%' and a.EU_TYPE='2' order by a.EU_ID";
				else
					query_SA="select a.EU_ID, a.EU_DELETION_FLAG, a.EU_FIRST_NAME, a.EU_MIDDLE_INITIAL, a.EU_LAST_NAME, a.EU_EMAIL, a.EU_CREATED_DATE, a.EU_CHANGED_DATE, a.EU_CHANGED_BY, a.EU_VALID_TO_DATE, a.EU_LAST_LOGIN_TIME, a.EU_LAST_LOGIN_DATE, a.EU_TYPE, EUG_ID, a.EU_BUSINESS_PARTNER,a.EU_IS_BUILT_IN_USER, a.EU_CURRENT_NUMBER  from EZC_USERS a where a.EU_ID IN (select distinct(EBPA_USER_ID) from EZC_BUSS_PARTNER_AREAS where EBPA_SYS_KEY IN ('"+allWebSysKeys+"'))  AND EU_FIRST_NAME LIKE '"+searchPartner+"%' order by a.EU_ID";

				if(!"".equals(query_SA))
				{
					ezc.ezparam.EzcParams mainParams_SA=new ezc.ezparam.EzcParams(false);
					ezc.ezmisc.params.EziMiscParams miscParams_SA = new ezc.ezmisc.params.EziMiscParams();

					miscParams_SA.setIdenKey("MISC_SELECT");
					miscParams_SA.setQuery(query_SA);

					mainParams_SA.setLocalStore("Y");
					mainParams_SA.setObject(miscParams_SA);
					Session.prepareParams(mainParams_SA);

					try
					{
						retUsers = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_SA);
					}
					catch(Exception e){}
				}
			}
		}
	}
	java.util.TreeSet alphaTree = new java.util.TreeSet();
	String alphaName = null;
	String initAlpha = "";
	int deleteCount = 0;
	
	/*if(myUserType!=null && !"null".equals(myUserType) && websyskey!=null && !"null".equals(websyskey))
	{
		deleteCount = retUsers.getRowCount();
		for(int i=deleteCount-1;i>=0;i--)
		{
			if(!(myUserType.equals(retUsers.getFieldValueString(i,"EU_TYPE"))))
			{
				retUsers.deleteRow(i);
			}
		}
	}
	
	if(websyskey!=null && !"null".equals(websyskey))
	{
		deleteCount = retUsers.getRowCount();
		for(int i=0;i<deleteCount;i++)
		{
			alphaName = retUsers.getFieldValueString(i,"EU_FIRST_NAME");
			alphaTree.add((alphaName.substring(0,1)).toUpperCase());
		}
		//if(alphaTree.size()>0)
		//initAlpha = (String)alphaTree.first()+"*";
	}
	
	if(alphaTree.size()>0 && "$".equals(searchPartner))
		searchPartner=(String)alphaTree.first()+"*";*/	
		
	//if(retUsers!=null)
	//out.println("retUsers>>>"+retUsers.getRowCount());
	
%>
