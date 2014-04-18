<%@ page import="java.util.*,ezc.ezworkflow.params.*,ezc.ezparam.*"%>
<%@ include file="../Misc/iblockcontrol.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<jsp:useBean id="ConfigManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="PasswordManager" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<%!
	final String SYSTEM_KEY 		= "ESKD_SYS_KEY";
	final String SYSTEM_KEY_DESC_LANGUAGE 	= "ESKD_LANG";
	final String SYSTEM_KEY_DESCRIPTION 	= "ESKD_SYS_KEY_DESC";
	final String ERP_CUST_NAME 		= "ECA_NAME";
	final String ERP_CUST_NUM 		= "EC_ERP_CUST_NO";
%>
<%
	String userType = (String)session.getValue("UserType");
	String userRole = (String)session.getValue("USERROLE");
	
	String userGroup	= "";
	String role		= "";
	String catalog_area 	= "";
	String template		= "";
	String purLoc		= "";
	String soldToInStr	= "";
	int retcnt	= 0;	
	int soldtoRows 	= 0;
	
	java.util.Vector loginUsrSoldtos	= new java.util.Vector();
	java.util.Vector catAreas 		= new java.util.Vector(10,5);
	java.util.Hashtable purgrphash		= new java.util.Hashtable();
	java.util.Hashtable templatehash	= new java.util.Hashtable();
	java.util.Hashtable purlochash		= new java.util.Hashtable();
	java.util.Hashtable vendorsHT 		= new java.util.Hashtable();	

	//out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+(String)Session.getUserId());
	ezc.ezparam.ReturnObjFromRetrieve retsoldto=null;
	ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
	ReturnObjFromRetrieve retcatarea = (ReturnObjFromRetrieve)PurManager.getUserPurAreas();
	int catareaRows = retcatarea.getRowCount(); 
		
	if(catareaRows>0)
	{
		String s[]={SYSTEM_KEY_DESCRIPTION};
		boolean b=retcatarea.sort(s,true);
	}
	
	catalog_area = (String)retcatarea.getFieldValue(0,SYSTEM_KEY);
		
	EzcSysConfigParams sparams2 = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams2 = new EzcSysConfigNKParams();
	snkparams2.setLanguage("EN");
	snkparams2.setSystemKey(catalog_area);
	snkparams2.setSiteNumber(200);
	sparams2.setObject(snkparams2);
	Session.prepareParams(sparams2);
	ReturnObjFromRetrieve retTemplate = (ReturnObjFromRetrieve)ConfigManager.getCatAreaDefaults(sparams2);
	if(retTemplate!=null)
		retcnt=retTemplate.getRowCount();
	
	for(int z=0;z<retcnt;z++)
	{
		if("WFTEMPLATE".equals((retTemplate.getFieldValueString(z,"ECAD_KEY")).toUpperCase()) )
		{
			template = retTemplate.getFieldValueString(z,"ECAD_VALUE");
			session.setAttribute("TEMPLATE",template);
		}else if("PURLOC".equals((retTemplate.getFieldValueString(z,"ECAD_KEY")).toUpperCase()) )
		{
			purLoc = retTemplate.getFieldValueString(z,"ECAD_VALUE");
			session.setAttribute("PURLOC",purLoc);
		}
		
	}


	if(!userType.equals("3"))
	{
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWorkGroupsParams eziWorkGroupsParams = new ezc.ezworkflow.params.EziWorkGroupsParams();
		eziWorkGroupsParams.setSysKey(catalog_area);
		eziWorkGroupsParams.setUserId(Session.getUserId());
		mainParams.setObject(eziWorkGroupsParams);
		Session.prepareParams(mainParams);
		ezc.ezparam.ReturnObjFromRetrieve ret=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupsList(mainParams);
		if(ret!=null&&ret.getRowCount()>0)
		{
			userGroup = ret.getFieldValueString(0,"GROUP_ID");
			if(!"".equals(userGroup))	
				session.putValue("USERGROUP",userGroup);
			
			role      = ret.getFieldValueString(0,"ROLE");
			if(!"".equals(role))	
				session.putValue("ROLE",role);	
		}	
			
		
		String participant= (String)session.getValue("USERGROUP");
			
		ArrayList desiredSteps=new ArrayList();
		
		int templateStep = 0;
		ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziTemplateStepsParams params1= new ezc.ezworkflow.params.EziTemplateStepsParams();
		params1.setCode(template);
		mainParams1.setObject(params1);
		Session.prepareParams(mainParams1);
		ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplateStepsList(mainParams1);
		
		if(listRet!=null)
		{
			for(int i=0;i<listRet.getRowCount();i++)
			{
				role= (String)session.getValue("ROLE");
				if(role.equals((listRet.getFieldValueString(i,"ROLE")).trim()))
				{
					templateStep = 	Integer.parseInt(listRet.getFieldValueString(i,"STEP"));
					desiredSteps.add(templateStep-1+"");
				}
			}
		}	
		
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>Inside SOLD TO Template is 		:"+template);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>Inside SOLD TO Participant is 	:"+participant);
		//System.out.println(">>>>>>>>>>>>>>>>>>>>>>>Inside SOLD TO Desiredstep is 	:"+desiredSteps.get(0));
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>Inside SOLD TO UserRole is 		:"+userRole);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>Inside SOLD TO Syskey is 		:"+catalog_area);
		
		mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
		params.setTemplate(template);
		params.setSyskey(catalog_area);
		params.setParticipant(participant);
		params.setDesiredSteps(desiredSteps);
		params.setPartnerFunction("VN");
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParams);
	}
	else
	{
		retsoldto = (ReturnObjFromRetrieve)PurManager.getUserVendors(catalog_area);	
	}
	
	
	if(retsoldto!=null)
		soldtoRows=retsoldto.getRowCount();

	for(int i=0;i<soldtoRows;i++)
	{
		String tempSoldto=(retsoldto.getFieldValueString(i,"EC_ERP_CUST_NO")).trim();
		loginUsrSoldtos.add(tempSoldto);
		if(i==0)
			soldToInStr=tempSoldto;
		else
			soldToInStr+="','"+tempSoldto;
	}	
	

	if(soldtoRows > 0)
	{
		for(int v=0;v<soldtoRows;v++)
			vendorsHT.put(retsoldto.getFieldValue(v,"EC_ERP_CUST_NO"),retsoldto.getFieldValue(v,"ECA_NAME"));
		session.putValue("VENDORHT",vendorsHT);
	}

	session.putValue("SOLDTOVECT",loginUsrSoldtos); // Vector for getting all vendors which are synchronized
	session.putValue("SOLDTOS",soldToInStr);	// SoldTos String in the query format with single quotes 
		
	if(soldtoRows>0)
	{
		retsoldto.sort(new String[]{ERP_CUST_NAME},true);
	}
	
	
	if(retcatarea!=null)
	{
		String catAreaTemp=null;
		String prgGrpTemp=null;
		String templateTemp=null;
		String purLocTemp=null;
		
		for(int c=0;c<retcatarea.getRowCount();c++)
		{
			if("3".equals(userType))
				catAreaTemp=retcatarea.getFieldValueString(c,"ESKD_SYS_KEY");
			else
				catAreaTemp=retcatarea.getFieldValueString(c,"EBPA_SYS_KEY");
			catAreas.addElement(catAreaTemp); 
			
			ezc.client.EzSystemConfigManager esManager = new ezc.client.EzSystemConfigManager();
			ezc.ezparam.EzcSysConfigParams sparams1 = new ezc.ezparam.EzcSysConfigParams();
			ezc.ezparam.EzcSysConfigNKParams snkparams1 = new ezc.ezparam.EzcSysConfigNKParams();
			snkparams1.setLanguage("EN");
			snkparams1.setSystemKey(catAreaTemp);
			snkparams1.setSiteNumber(200);
			sparams1.setObject(snkparams1);
			Session.prepareParams(sparams1);
			ezc.ezparam.ReturnObjFromRetrieve retdef = (ezc.ezparam.ReturnObjFromRetrieve)esManager.getCatAreaDefaults(sparams1);	
			if(retdef != null)
			{
				int defsCount = 0;
				defsCount = retdef.getRowCount();
				for(int i=0;i<defsCount;i++)
				{
					if("PURGROUP".equals(retdef.getFieldValueString(i,"ECAD_KEY")))
					{
						prgGrpTemp = retdef.getFieldValueString(i,"ECAD_VALUE");
						purgrphash.put(catAreaTemp,prgGrpTemp);
						
					}
					else if("WFTEMPLATE".equals((retdef.getFieldValueString(i,"ECAD_KEY")).toUpperCase()))
					{
						templateTemp = retdef.getFieldValueString(i,"ECAD_VALUE");
						templatehash.put(catAreaTemp,templateTemp);
					}
				}
			}
			
		}

		/***********To speed up the process in login banner**************************/
		session.putValue("CATAREAS",catAreas);
		session.putValue("PURGROUPS",purgrphash);
		session.putValue("TEMPLATES",templatehash);
		session.putValue("PURLOCS",purlochash);
		/****************************************************************************/
	}
%>
<%@ include file="../Misc/ireleasecontrol.jsp" %>
