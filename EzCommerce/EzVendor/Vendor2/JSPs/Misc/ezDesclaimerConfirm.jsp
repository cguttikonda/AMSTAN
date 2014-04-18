<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ page import = "ezc.ezparam.*,ezc.ezshipment.client.*" %>
<%@ page import="ezc.ezcommon.arms.params.*" %>
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%
	if(session.isNew())
	{
		response.sendRedirect("../../Htmls/EzCookieHelp.htm");
	}
	
	String userId 		= Session.getUserId();
	String redirectfile 	= "";
	if(userId != null)
	{
		EzcUserParams uparamsN= new EzcUserParams();
		EzcUserNKParams ezcUserNKParamsN = new EzcUserNKParams();
		ezcUserNKParamsN.setLanguage("EN");
		uparamsN.setUserId(userId);
		uparamsN.createContainer();
		uparamsN.setObject(ezcUserNKParamsN);
		Session.prepareParams(uparamsN);
		ReturnObjFromRetrieve retUserData = (ReturnObjFromRetrieve)UManager.getUserData(uparamsN);
		out.println(retUserData.toEzcString());
		int retUserDataCount = 0;
		if(retUserData != null)
		{
			retUserDataCount = retUserData.getRowCount();
		}
		
		if(retUserDataCount > 0)
		{
			String userStyle = "";
			String userRole  = "";
			String userGroup = "";
			String role 	 = "";
			String lang1     = "ENGLISH";
			
			String UserType  = retUserData.getFieldValueString(0,"EU_TYPE");
			String firstName = retUserData.getFieldValueString(0,"EU_FIRST_NAME");
			String middleName= retUserData.getFieldValueString(0,"EU_MIDDLE_INITIAL");
			String lastName  = retUserData.getFieldValueString(0,"EU_LAST_NAME");

			if(Session.getUserPreference("STYLE")	!= null)
				userStyle = (String)Session.getUserPreference("STYLE");

			if(Session.getUserPreference("USERROLE")!= null)
				userRole  = (String)Session.getUserPreference("USERROLE");

			/*ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWorkGroupsParams params= new ezc.ezworkflow.params.EziWorkGroupsParams();
			params.setUserId(Session.getUserId());
			mainParams.setObject(params);
			Session.prepareParams(mainParams);
			ezc.ezparam.ReturnObjFromRetrieve retWorkGroupsList = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupsList(mainParams);


			if(retWorkGroupsList != null)
			{
				int workGroupCount = retWorkGroupsList.getRowCount();
				if(workGroupCount > 0)
				{
					userGroup = retWorkGroupsList.getFieldValueString(0,"GROUP_ID");
					role 	  = retWorkGroupsList.getFieldValueString(0,"ROLE");
				}
			}*/
			
			java.util.Vector wgVector = new java.util.Vector();
			java.util.Hashtable wgHashTable = new java.util.Hashtable();
			ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWorkGroupsParams params= new ezc.ezworkflow.params.EziWorkGroupsParams();
			params.setUserId(Session.getUserId());
			mainParams.setObject(params);
			Session.prepareParams(mainParams);
			ezc.ezparam.ReturnObjFromRetrieve retWorkGroupsList = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupsList(mainParams);
			if(retWorkGroupsList != null)
			{
				int workGroupCount = retWorkGroupsList.getRowCount();
				if(workGroupCount > 0)
				{
					userGroup = retWorkGroupsList.getFieldValueString(0,"GROUP_ID");
					role 	  = retWorkGroupsList.getFieldValueString(0,"ROLE");
				}
				for(int i=0;i<workGroupCount;i++)
				{
					if(!wgVector.contains(retWorkGroupsList.getFieldValueString(i,"GROUP_ID")))
					{
						wgVector.addElement(retWorkGroupsList.getFieldValueString(i,"GROUP_ID"));
					}
					wgHashTable.put(retWorkGroupsList.getFieldValueString(i,"SYSKEY"),retWorkGroupsList.getFieldValueString(i,"GROUP_ID"));
				}
			}

			session.putValue("WGSVECTOR",wgVector);
			session.putValue("WGHASHTABLE",wgHashTable);			


		/*********************Getting Configured Authorizations for the user*******************/
			ezc.ezparam.EzcParams myConfigParams = new ezc.ezparam.EzcParams(true);
			Session.prepareParams(myConfigParams);
			try
			{
				java.util.Vector authVect=new java.util.Vector();
				ezc.ezcommon.arms.client.EzcUserRolesManager ezcUserRolesManager = new ezc.ezcommon.arms.client.EzcUserRolesManager();
				EzcParams roleParams=new EzcParams(false);
				EziRoleAuthParams roleAuthParams = new EziRoleAuthParams();
				roleAuthParams.setRoleNo(role);
				roleAuthParams.setSysKey("0");
				roleParams.setObject(roleAuthParams);
				Session.prepareParams(roleParams);
				ezc.ezparam.ReturnObjFromRetrieve roleAuthRetObj = (ezc.ezparam.ReturnObjFromRetrieve)ezcUserRolesManager.ezRoleAuthList(roleParams);
				if(roleAuthRetObj != null)
				{
					int roleAuthRetCount = roleAuthRetObj.getRowCount();
					for(int i=0;i<roleAuthRetCount;i++)
					{
						authVect.add(roleAuthRetObj.getFieldValueString(i,"AUTH_KEY"));
					}
					session.putValue("USERAUTHS",authVect);
				}
			}
			catch(Exception e){}
			/**************************************************************************************/			

			session.putValue("UserType",UserType);
			session.putValue("FIRST_NAME",firstName);
			session.putValue("MIDDLE_INITIAL",middleName);
			session.putValue("LAST_NAME",lastName);
			session.putValue("userStyle",userStyle);
			session.putValue("USERROLE",userRole);
			session.putValue("USERGROUP",userGroup);
			session.putValue("ROLE",role);
			session.putValue("LOCALE",new java.util.Locale("en","US"));
			session.putValue("CURRENCY","$");
			session.putValue("CPOSITION",new Boolean("true"));
			session.putValue("SREQUIRED",new Boolean("false"));
			session.putValue("DATEFORMAT",String.valueOf(ezc.ezutil.FormatDate.MMDDYYYY));
			session.putValue("DATESEPERATOR","/");
			session.putValue("TITLE","Welcome to EzCommerce Suite");


			if (UserType.equals("3"))
			{
				redirectfile = "ezDisclaimer.jsp";
			}
			else if (UserType.equals("2"))
			{
				redirectfile = "ezSelectSoldTo.jsp";
			}
			else
			{
				redirectfile = "ezLoginError.jsp";
			}
		}
		else
			redirectfile = "ezLoginError.jsp";
	}		
	else
		redirectfile = "ezLoginError.jsp";
	response.sendRedirect(redirectfile);
%>
<Div id="MenuSol"></Div>
