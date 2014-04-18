
<%@ page import="ezc.ezparam.*,java.util.*,ezc.ezcommon.EzGlobalConfig" %>
<%
	try
	{
		Enumeration enum11=session.getAttributeNames();
		while(enum11.hasMoreElements())
		{
			session.removeAttribute((String)enum11.nextElement());
		}
	}catch(Exception e){}
%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="esManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />

<%
	
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	String forwardURL = "";
	
	String userId 	= request.getParameter("USERNAME");
	String passWord = request.getParameter("PASSWORD");
	String hUrl 	= request.getParameter("HOOK_URL");
	String language = "ENGLISH";
	String site 	= "200";

	if(userId != null)
		userId =  userId.toUpperCase();

	ezc.session.EzLogonStructure logs = new ezc.session.EzLogonStructure();		
	
	logs.setUserId(userId);
	logs.setPassWd(passWord);
        logs.setConnGroup(site);
	session.putValue("Site",site);
	ezc.ezparam.EzLogonStatus LogonStatus =  (ezc.ezparam.EzLogonStatus)Session.logon(logs);
	
	if(LogonStatus.IsSuccess())
	{
		
		
		/**************To get user web status for Lock check Starts***********************************/
		
		ezc.ezwebstats.client.EzWebStatsManager webstatMgr=new ezc.ezwebstats.client.EzWebStatsManager();
		ezc.ezparam.EzcParams ezcparam=new ezc.ezparam.EzcParams(false);
		ezc.ezwebstats.params.EziWebStatsParams webParams=new ezc.ezwebstats.params.EziWebStatsParams();
		webParams.setSysKey("USERWEBSTATS");
		webParams.setUserId(userId);
		ezcparam.setObject(webParams);
		Session.prepareParams(ezcparam);
		ReturnObjFromRetrieve userWeb=null;
		try{
			userWeb=(ReturnObjFromRetrieve)webstatMgr.getWebStatsList(ezcparam);

			//ezc.ezcommon.EzLog4j.log(":::::salescm-Jagan::::::::::"+userWeb.toEzcString(),"D");

		}catch(Exception e){}

		if(userWeb!=null && userWeb.getRowCount() > 0)
		{
			String skey=userWeb.getFieldValueString(0,"SYSKEY");

			if("LOCKED".equals(skey))
			{
				//response.sendRedirect("ezLoginLock.jsp");
				forwardURL = "ezLoginLock.jsp";
			}
		}
		
		/**************To get user web status for Lock check End***********************************/
		
		
		try
		{
			ReturnObjFromRetrieve ret = LogonStatus.getUserInfo();
			session.putValue("LAST_LOGIN_TIME",ret.getFieldValueString("EU_LAST_LOGIN_TIME"));
			session.putValue("LAST_LOGIN_DATE",ret.getFieldValueString("EU_LAST_LOGIN_DATE"));
		}
		catch(Exception e){}
		session.putValue("userLang",language);
		ezc.ezparam.EzDefReturn ezDefSales 	= Session.isValidSalesUser();
		ezc.ezparam.EzDefReturn ezDef 		= Session.isValidSimUser();
		ezc.ezparam.EzDefReturn ezDefAdmin	= Session.isValidAdminUser();
		if(ezDefSales.isValidSalesUser())
		{
			ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
			ReturnObjFromRetrieve retCat1= (ReturnObjFromRetrieve)UtilManager.getUserCatalogAreas();			
			String sys_key =(String)(retCat1.getFieldValue(0,"ESKD_SYS_KEY"));
			EzcSysConfigParams sparams1 = new EzcSysConfigParams();
			EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
			snkparams1.setLanguage("EN");
			snkparams1.setSystemKey(sys_key);
			snkparams1.setSiteNumber(200);
			sparams1.setObject(snkparams1);
			Session.prepareParams(sparams1);
			ReturnObjFromRetrieve retdef = (ReturnObjFromRetrieve)esManager.getCatAreaDefaults(sparams1);
			retdef.check();
			String SalesType=null;
			for(int z=0;z<retdef.getRowCount();z++)
			{
				if("S_AREATYPE".equals( retdef.getFieldValueString(z,"ECAD_KEY").trim()))
				{
					SalesType=retdef.getFieldValueString(z,"ECAD_VALUE");
					session.putValue("SalesType",SalesType);
				}
				if("WFTEMPLATE".equals(retdef.getFieldValueString(z,"ECAD_KEY")))
				{
					String templet=retdef.getFieldValueString(z,"ECAD_VALUE");
					session.putValue("Templet",templet);
				}
			}
			ezc.ezparam.EzcUserParams uparams= new ezc.ezparam.EzcUserParams();
			EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
			ezcUserNKParams.setLanguage("EN");
			ezcUserNKParams.setSys_Key("0");
			uparams.createContainer();
			uparams.setUserId(Session.getUserId());
			uparams.setObject(ezcUserNKParams);
			Session.prepareParams(uparams);
			ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)(UManager.getAddUserDefaults(uparams));
			
			String userStyle=null;
			String userRole=null;
			String salesOffice=null;


			for(int i=0;i<retobj.getRowCount();i++)
			{
				if("STYLE".equals(retobj.getFieldValueString(i,"EUD_KEY")))
				{
					userStyle=retobj.getFieldValueString(i,"EUD_VALUE");
				}
				if("USERROLE".equals(retobj.getFieldValueString(i,"EUD_KEY")))
				{
					userRole=retobj.getFieldValueString(i,"EUD_VALUE");
				}
			}
			session.putValue("userStyle",userStyle);
			session.putValue("UserRole1",userRole);
			session.putValue("UserRole",userRole);
			
			
			session.putValue("ValidSalesUser","Y");
			session.putValue("IsCatUser","Y");
			session.putValue("SalesAreaCode",sys_key);
			session.putValue("HookURL",hUrl);
			
			if(userRole!=null && "CUSR".equals(userRole))
			{
				UtilManager.setSysKeyAndSoldTo(sys_key,"0000011001");
				//response.sendRedirect("../../EzSales/Sales2/JSPs/CatUser/ezPreCUFrameset.jsp");
				forwardURL = "ezPreCUFrameset.jsp";
				
			}
			else
			{
				//response.sendRedirect("ezCULoginError.jsp");
				forwardURL = "ezCULoginError.jsp";
			}
		}
		else
		{
			//response.sendRedirect("ezCULoginError.jsp");
			forwardURL = "ezCULoginError.jsp";
		}
	}
	else
	{
		//response.sendRedirect("ezCULoginError.jsp");
		forwardURL = "ezCULoginError.jsp";
	}
%>
<jsp:forward page="<%=forwardURL%>"/>