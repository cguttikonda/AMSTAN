
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
<%
	ezc.client.EzSystemConfigManager esManager = new ezc.client.EzSystemConfigManager();

	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	
	String userId 	= request.getParameter("username");
	String passWord = request.getParameter("password");
	String language = request.getParameter("language");
	String site 	= request.getParameter("site");
	if(site 	== null|| "null".equals(site) )	site = "200" ;
	if(language 	== null|| "null".equals(language))	language = "ENGLISH" ;
        language = language.toUpperCase();
	if(userId != null)
	{
		userId =  userId.trim();
		userId =  userId.toUpperCase();
	}
	ezc.ezcommon.EzLog4j.log(":::::salescm-Jagan::::::::::"+userId,"D");

	long start = System.currentTimeMillis();

	/************** ADS Auth Start ************************/
	
	if(!"EZCADMIN".equals(userId) && !"EZCADMIN2".equalsIgnoreCase(userId))
	{
		ezc.ezbasicutil.EzMisc ezMisc = new ezc.ezbasicutil.EzMisc();
		ezc.ezcommon.EzCipher ci = new ezc.ezcommon.EzCipher();
		String userData = ezMisc.getUserDetails(userId,site);
		if(userData!=null && userData.indexOf("¥")!=-1)
		{
			try
			{
				String[] ud =  userData.split("¥");
				if("2".equals(ud[0].trim()))
				{
					ezc.ezbasicutil.EzADAuthenticator adAuth = new ezc.ezbasicutil.EzADAuthenticator();
					java.util.Map userDataMap = adAuth.authenticate(userId,passWord);
					if(userDataMap == null)
					{
						response.sendRedirect("ezLoginError.jsp");
						//response.sendRedirect("../../../EzComm/EzSales/Sales/JSPs/Misc/ezConfirm.jsp");
					}
					else
					{
						passWord = ci.ezDecrypt(ud[1].trim());

					}
				}
			}
			catch(Exception e)
			{
				ezc.ezcommon.EzLog4j.log("Exception occured while parsing user data>>>>"+e,"E");
				e.printStackTrace();
				response.sendRedirect("ezLoginError.jsp");
				//response.sendRedirect("../../../EzComm/EzSales/Sales/JSPs/Misc/ezConfirm.jsp");
			}
		}
		else
		{
			String userDataEmail = ezMisc.getUserDetailsFromEmail(userId,site);

			if(userDataEmail!=null && userDataEmail.indexOf("¥")!=-1)
			{
				try
				{
					String[] udEmail =  userDataEmail.split("¥");

					if("3".equals(udEmail[1].trim()))
					{
						 if(Integer.parseInt(udEmail[0])==1)
						 {
						 	userId = udEmail[2].trim();
						 }
						 else if(Integer.parseInt(udEmail[0])>1)
						 {
						 	response.sendRedirect("ezLoginError.jsp");
						 }
					}
				}
				catch(Exception e){}
			}
			else
			{
				response.sendRedirect("ezLoginError.jsp");
			}
		}
	}
	
	/************** ADS Auth End **************************/

	long finish = System.currentTimeMillis();
	ezc.ezcommon.EzLog4j.log("Time taken to execute ADS authentication in ezApplicationAreas.jsp>>>"+(finish-start)/1000+" secs","F");

	ezc.ezcommon.EzLog4j.log(":::::ADS CHK Chaitanya::::::::::"+userId,"D");

	long start1 = System.currentTimeMillis();

	ezc.session.EzLogonStructure logs = new ezc.session.EzLogonStructure();		
	
	logs.setUserId(userId);
	logs.setPassWd(passWord);
        logs.setConnGroup(site);
	session.putValue("Site",site);
	ezc.ezparam.EzLogonStatus LogonStatus =  (ezc.ezparam.EzLogonStatus)Session.logon(logs);

	long finish1 = System.currentTimeMillis();
	ezc.ezcommon.EzLog4j.log("Time taken to execute EzLogonStatus in ezApplicationAreas.jsp>>>"+(finish1-start1)/1000+" secs","F");
	
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

			ezc.ezcommon.EzLog4j.log(":::::salescm-Jagan::::::::::"+userWeb.toEzcString(),"D");

		}catch(Exception e){}

		if(userWeb!=null && userWeb.getRowCount() > 0)
		{
			String skey=userWeb.getFieldValueString(0,"SYSKEY");

			if("LOCKED".equals(skey))
				response.sendRedirect("ezLoginLock.jsp");
		}
		
		/**************To get user web status for Lock check End***********************************/
		
		
		try
		{
			ReturnObjFromRetrieve ret = LogonStatus.getUserInfo();
			session.putValue("LAST_LOGIN_TIME",ret.getFieldValueString("EU_LAST_LOGIN_TIME"));
			session.putValue("LAST_LOGIN_DATE",ret.getFieldValueString("EU_LAST_LOGIN_DATE"));
			session.putValue("USEREMAIL",ret.getFieldValueString("EU_EMAIL"));
			session.putValue("FIRSTNAME",ret.getFieldValueString("EU_FIRST_NAME"));
			session.putValue("LASTNAME",ret.getFieldValueString("EU_LAST_NAME"));
			/**** Added for SubUser functionality ******/
			session.putValue("BussPart",ret.getFieldValueString("EU_BUSINESS_PARTNER"));
		}
		catch(Exception e){}
		session.putValue("userLang",language);
		session.putValue("userPass",passWord);
		ezc.ezparam.EzDefReturn ezDefSales 	= Session.isValidSalesUser();
		ezc.ezparam.EzDefReturn ezDef 		= Session.isValidSimUser();
		ezc.ezparam.EzDefReturn ezDefAdmin	= Session.isValidAdminUser();
		//if (ezDef.isValidSimUser())
		{
			//session.putValue("ValidVendorUser","Y");
			//response.sendRedirect("../../EzVendor/Vendor2/JSPs/Misc/ezDesclaimerConfirm.jsp");
		}
		//else if(ezDefSales.isValidSalesUser())
		if(!"EZCADMIN".equalsIgnoreCase(userId) && !"EZCADMIN2".equalsIgnoreCase(userId))
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
			session.putValue("ValidSalesUser","Y");
			String offlineReq= request.getParameter("offlineReq");
			String webOrNo   = request.getParameter("webOrNo");
			String soldTo    = request.getParameter("soldTo");
			String syskey    = request.getParameter("syskey");
			String docStat	 = request.getParameter("docStat");
			String salesOrder = request.getParameter("salesOrder");
			String shipTo = request.getParameter("shipTo");
			String urlLink = request.getParameter("urlLink");

			if(urlLink!=null && !"null".equalsIgnoreCase(urlLink) && !"".equals(urlLink))
				session.putValue("URLLINK",urlLink);

			if(!"null".equals(offlineReq) && !"".equals(offlineReq))
			{
				session.putValue("OFFLINE",offlineReq);
				session.putValue("webOrNo",webOrNo);
				session.putValue("DocSoldTo",soldTo);
				session.putValue("DocSysKey",syskey);
				session.putValue("DocStatus",docStat);
				session.putValue("DocSalesOrder",salesOrder);
				session.putValue("DocShipTo",shipTo);
			}
			ezc.ezcommon.EzLog4j.log(">>>>>>>offlineReq in APPLICATION AREAS>>>>>>>>>>>>>>>>>>>>>>"+offlineReq,"D");
			//response.sendRedirect("../../EzSales/Sales2/JSPs/Misc/ezConfirm.jsp");
			response.sendRedirect("../../../EzComm/EzSales/Sales/JSPs/Misc/ezConfirm.jsp");
		}
		else if ("EZCADMIN".equalsIgnoreCase(userId) || "EZCADMIN2".equalsIgnoreCase(userId))
		{
			session.putValue("ValidAdminUser","Y");
			response.sendRedirect("../../EzAdmin/EzAdmin4/Admin1/JSPs/Misc/ezAdminConfirm.jsp?username="+userId+"&password="+passWord+"&ConnGroup="+site);
		}
		else
		{
			response.sendRedirect("ezLoginError.jsp");
		}
	}
	else
	{
		response.sendRedirect("ezLoginError.jsp");
	}
%>