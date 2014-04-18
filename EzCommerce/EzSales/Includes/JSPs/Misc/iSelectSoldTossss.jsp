<%@ page import ="ezc.ezparam.*"%>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="ezc.ezutil.csb.*" %>
<%@ include file="iBlockControl.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />

<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");

	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);

	String userGroup=(String)session.getValue("UserGroup");
	String userRole=(String)session.getValue("UserRole");
	
	String salesOffice=(String)session.getValue("SalesOffice");

	boolean USER_GROUP_EXISTS=(userGroup!=null  && !"null".equals(userGroup) && !"".equals(userGroup.trim()));
	
	ReturnObjFromRetrieve retcatarea = null;
	ReturnObjFromRetrieve retsoldto = null;
	ReturnObjFromRetrieve rettempsoldto = null;

	String catalog_area = request.getParameter("CatalogArea");
	int catareaRows = 0;
	int soldtoRows = 0;

	//Get all catalog areas
	retcatarea = (ReturnObjFromRetrieve)UtilManager.getUserCatalogAreas();	

	catalog_area =(catalog_area == null)?retcatarea.getFieldValueString(0,SYSTEM_KEY):catalog_area;
	catalog_area.trim();

	String template=(String)session.getValue("Templet");
	String UserRole = (String)session.getValue("UserRole");
	ArrayList desiredSteps=new ArrayList();
	if("CM".equals(UserRole))
		desiredSteps.add("1");
	else if("DM".equals(UserRole))
		desiredSteps.add("2");	
	else if("LF".equals(UserRole))
		desiredSteps.add("3");
	else if("SM".equals(UserRole))
		desiredSteps.add("4");	
	else if("SBU".equals(UserRole))
		desiredSteps.add("5");
	else if("INDREG".equals(UserRole))
		desiredSteps.add("6");	
	
		
	String participant=(String)session.getValue("UserGroup");
	String syskey=(String)session.getValue("SalesAreaCode");
	if("CM".equals(userRole))
	{
      		if(catalog_area.indexOf(",")!=-1)
      		{
      			String catalog_area1 = null;

      			if(USER_GROUP_EXISTS)
			{
				for(int rc=1;rc<retcatarea.getRowCount();rc++)
				{
					catalog_area1 = (String)(retcatarea.getFieldValue(rc,SYSTEM_KEY));
					//Starts
					ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
					ezc.ezworkflow.params.EziWFParams paramsu= new ezc.ezworkflow.params.EziWFParams();
					paramsu.setTemplate(template);
					paramsu.setSyskey(catalog_area1); //999602
					paramsu.setPartnerFunction("AG");
					paramsu.setParticipant(participant);
					//paramsu.setDesiredStep(desiredStep);
					paramsu.setDesiredSteps(desiredSteps);
					mainParamsu.setObject(paramsu);
					Session.prepareParams(mainParamsu);
					rettempsoldto =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParamsu);
					//Ends
					retsoldto.append(rettempsoldto);
				}
			}
			else
			{
				for(int rc=1;rc<retcatarea.getRowCount();rc++)
				{
					catalog_area1 = (String)(retcatarea.getFieldValue(rc,SYSTEM_KEY));
					rettempsoldto = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(catalog_area1);
					retsoldto.append(rettempsoldto);
				}
			}
		}
		else
		{
			if(USER_GROUP_EXISTS)
			{
				//Starts
				ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
				ezc.ezworkflow.params.EziWFParams paramsu= new ezc.ezworkflow.params.EziWFParams();
				paramsu.setTemplate(template);
				paramsu.setSyskey(catalog_area); //999602
				paramsu.setPartnerFunction("AG");
				paramsu.setParticipant(participant);
				//paramsu.setDesiredStep(desiredStep);
				paramsu.setDesiredSteps(desiredSteps);
				mainParamsu.setObject(paramsu);
				Session.prepareParams(mainParamsu);
				retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParamsu);
				//Ends
			}
			else
			{	
				retsoldto = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(catalog_area);
			}
		}
	}
	else if( "BP".equals(userRole) || "INDREG".equals(userRole)) 
	{
		retsoldto = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(catalog_area);
	}
	else if("LF".equals(userRole)|| "BP".equals(userRole) || "DM".equals(userRole) || "SM".equals(userRole) || "SBU".equals(userRole) )
	{
		//starts
		//ezc.ezworkflow.client.EzWorkFlowManager EzWorkFlowManager = new ezc.ezworkflow.client.EzWorkFlowManager();
		ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams params1= new ezc.ezworkflow.params.EziWFParams();
		params1.setTemplate(template);
		params1.setSyskey(catalog_area); //999602
		params1.setPartnerFunction("AG");
		params1.setParticipant(participant);
		//params1.setDesiredStep(desiredStep);
		params1.setDesiredSteps(desiredSteps);
		mainParams1.setObject(params1);
		Session.prepareParams(mainParams1);
		try{
			retsoldto =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParams1);
		}catch(Exception e){}
			java.util.ArrayList aGroups=(java.util.ArrayList)session.getValue("AGROUPS");

		if(aGroups!=null)
		{
			for(int p=1;p<aGroups.size();p++)
			{
				try
				{	
					params1.setParticipant((String)aGroups.get(p));
					ReturnObjFromRetrieve retTemp=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParams1);
					if(retTemp!=null)
					retsoldto.append(retTemp);
				}catch(Exception e)
				{		
				}
			}
		}
		//Ends
	}else
	{		

		retsoldto = (ReturnObjFromRetrieve) UtilManager.getUserCustomers(catalog_area);

	}
	
	String viewAllCust = (String)session.getValue("VIEWALLCUST");
	
	if("CM".equals(userRole) && viewAllCust!=null && !"Y".equalsIgnoreCase(viewAllCust))
	{
		String logInUserId = Session.getUserId();

		String userId="",bPart="";
		java.util.ArrayList bpAuth = new java.util.ArrayList();
		ezc.ezparam.EzcParams mainParam_SU = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams param_SU = new ezc.ezworkflow.params.EziWFParams();
		param_SU.setTemplate(template);
		param_SU.setSyskey(catalog_area);
		param_SU.setParticipant(participant);
		param_SU.setDesiredSteps(desiredSteps);
		mainParam_SU.setObject(param_SU);
		Session.prepareParams(mainParam_SU);

		ReturnObjFromRetrieve retsoldtoUid = (ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParam_SU);
		if(retsoldtoUid!=null)
		{
			for(int k=0;k<retsoldtoUid.getRowCount();k++)
			{
				userId = retsoldtoUid.getFieldValueString(k,"EU_ID");
				bPart = retsoldtoUid.getFieldValueString(k,"EU_BUSINESS_PARTNER");

				ezc.ezparam.EzcUserParams uparams= new ezc.ezparam.EzcUserParams();
				EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
				ezcUserNKParams.setLanguage("EN");
				ezcUserNKParams.setSys_Key("0");
				uparams.createContainer();
				uparams.setUserId(userId);
				uparams.setObject(ezcUserNKParams);
				Session.prepareParams(uparams);
				ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)(UManager.getAddUserDefaults(uparams));
				if(retobj!=null)
				{
					String isSubUser = "";
					String ecadVal = "";
				
					for(int j=0;j<retobj.getRowCount();j++)
					{
						if("ISSUBUSER".equals(retobj.getFieldValueString(j,"EUD_KEY")))
						{
							isSubUser = retobj.getFieldValueString(j,"EUD_VALUE");
						}
						if("SALESREPRES".equals(retobj.getFieldValueString(j,"EUD_KEY")))
						{
							ecadVal = retobj.getFieldValueString(j,"EUD_VALUE");
						}
					}
					if(!"Y".equals(isSubUser))
					{
						try
						{
							StringTokenizer stEcadVal = new StringTokenizer(ecadVal,"¥");

							while(stEcadVal.hasMoreTokens())
							{
								String salesRep_A = (String)stEcadVal.nextElement();
								String salesRep_AId = salesRep_A.split("¤")[0];

								if(logInUserId.equalsIgnoreCase(salesRep_AId.trim()))
								{
									bpAuth.add(bPart);
								}
							}
						}
						catch(Exception e){}
					}
				}
			}
		}
		for(int i=retsoldto.getRowCount()-1;i>=0;i--)
		{
			String bPartner=retsoldto.getFieldValueString(i,"EC_BUSINESS_PARTNER");
			if(!bpAuth.contains(bPartner))
				retsoldto.deleteRow(i);
		}
	}

	if(retcatarea != null)
		catareaRows = retcatarea.getRowCount();
	else 
		catareaRows =0;
	if(retsoldto != null)
		soldtoRows = retsoldto.getRowCount();
	else 
		soldtoRows =0;

%>
