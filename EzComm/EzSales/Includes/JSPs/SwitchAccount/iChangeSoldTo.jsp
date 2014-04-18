<%@ page import ="ezc.ezparam.*"%>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="ezc.ezutil.csb.*" %>
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");

	ezc.client.EzcUtilManager UtilManagerSA = new ezc.client.EzcUtilManager(Session);

	String userGroup=(String)session.getValue("UserGroup");
	String userRoleSA=(String)session.getValue("UserRole");
	
	String salesOffice=(String)session.getValue("SalesOffice");

	boolean USER_GROUP_EXISTS=false;//(userGroup!=null  && !"null".equals(userGroup) && !"".equals(userGroup.trim()));
	
	ReturnObjFromRetrieve retcatarea = null;
	ReturnObjFromRetrieve retsoldtoSA = null;
	ReturnObjFromRetrieve rettempsoldto = null;

	String catalog_areaSA = request.getParameter("CatalogArea");
	String selSoldToSA = request.getParameter("selSoldTo");
	String selShipToSA = (String)session.getValue("ShipCode");
	String syskey=(String)session.getValue("SalesAreaCode");
	
	int catareaRows = 0;
	int soldtoRows = 0;

	//Get all catalog areas
	retcatarea = (ReturnObjFromRetrieve)UtilManagerSA.getUserCatalogAreas();
	
	ezc.ezcommon.EzLog4j.log("<<<retcatarea>>>>>>>>"+retcatarea.toEzcString(),"I");

	catalog_areaSA =(catalog_areaSA == null)?syskey:catalog_areaSA;
	catalog_areaSA.trim();
	
	//out.println("retcatarea:::"+catalog_areaSA);

	String templateSA=(String)session.getValue("Templet");
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
	
		
	String participantSA=(String)session.getValue("UserGroup");
	
	if("CM".equals(userRole))
	{
      		if(catalog_areaSA.indexOf(",")!=-1)
      		{
      			String catalog_area1 = null;

      			if(USER_GROUP_EXISTS)
			{
				for(int rc=1;rc<retcatarea.getRowCount();rc++)
				{
					catalog_area1 = (String)(retcatarea.getFieldValue(rc,"ESKD_SYS_KEY"));
					//Starts
					ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
					ezc.ezworkflow.params.EziWFParams paramsu= new ezc.ezworkflow.params.EziWFParams();
					paramsu.setTemplate(templateSA);
					paramsu.setSyskey(catalog_area1); //999602
					paramsu.setPartnerFunction("AG");
					paramsu.setParticipant(participantSA);
					//paramsu.setDesiredStep(desiredStep);
					paramsu.setDesiredSteps(desiredSteps);
					mainParamsu.setObject(paramsu);
					Session.prepareParams(mainParamsu);
					rettempsoldto =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParamsu);
					//Ends
					retsoldtoSA.append(rettempsoldto);
				}
			}
			else
			{
				for(int rc=1;rc<retcatarea.getRowCount();rc++)
				{
					catalog_area1 = (String)(retcatarea.getFieldValue(rc,"ESKD_SYS_KEY"));
					rettempsoldto = (ReturnObjFromRetrieve)UtilManagerSA.getUserCustomers(catalog_area1);
					retsoldtoSA.append(rettempsoldto);
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
				paramsu.setTemplate(templateSA);
				paramsu.setSyskey(catalog_areaSA); //999602
				paramsu.setPartnerFunction("AG");
				paramsu.setParticipant(participantSA);
				//paramsu.setDesiredStep(desiredStep);
				paramsu.setDesiredSteps(desiredSteps);
				mainParamsu.setObject(paramsu);
				Session.prepareParams(mainParamsu);
				retsoldtoSA=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParamsu);
				
				ezc.ezcommon.EzLog4j.log("<<<retcatarea>>>>>>>>"+retcatarea.toEzcString(),"I");
				
				
				//Ends
			}
			else
			{	
				retsoldtoSA = (ReturnObjFromRetrieve)UtilManagerSA.getUserCustomers(catalog_areaSA);
				
				ezc.ezcommon.EzLog4j.log("<<<retcatarea--ELSE>>>>>>>>"+retcatarea.toEzcString(),"I");
			}
		}
		
		//out.println("retsoldtoSA:::"+retsoldtoSA.toEzcString());
	}
	else if( "BP".equals(userRole) || "INDREG".equals(userRole)) 
	{
		retsoldtoSA = (ReturnObjFromRetrieve)UtilManagerSA.getUserCustomers(catalog_areaSA);
		
		ezc.ezcommon.EzLog4j.log("<<<retsoldtoSA--ELSEIF>>>>>>>>"+retsoldtoSA.toEzcString(),"I");
	}
	else if("LF".equals(userRole)|| "BP".equals(userRole) || "DM".equals(userRole) || "SM".equals(userRole) || "SBU".equals(userRole) )
	{
		//starts
		//ezc.ezworkflow.client.EzWorkFlowManager EzWorkFlowManager = new ezc.ezworkflow.client.EzWorkFlowManager();
		ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams params1= new ezc.ezworkflow.params.EziWFParams();
		params1.setTemplate(templateSA);
		params1.setSyskey(catalog_areaSA); //999602
		params1.setPartnerFunction("AG");
		params1.setParticipant(participantSA);
		//params1.setDesiredStep(desiredStep);
		params1.setDesiredSteps(desiredSteps);
		mainParams1.setObject(params1);
		Session.prepareParams(mainParams1);
		try{
			retsoldtoSA =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParams1);
			ezc.ezcommon.EzLog4j.log("<<<retsoldtoSA--ELSEIF2>>>>>>>>"+retsoldtoSA.toEzcString(),"I");
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
					retsoldtoSA.append(retTemp);
				}catch(Exception e)
				{		
				}
			}
		}
		//Ends
		
		
	}else
	{		

		retsoldtoSA = (ReturnObjFromRetrieve) UtilManagerSA.getUserCustomers(catalog_areaSA);
		ezc.ezcommon.EzLog4j.log("<<<retsoldtoSA--ELSEIF-ELSE>>>>>>>>"+retsoldtoSA.toEzcString(),"I");
		//out.println("retsoldtoSA:::"+retsoldtoSA.toEzcString());
		
		

	}
	
	String viewAllCust = (String)session.getValue("VIEWALLCUST");
	
	if("CM".equals(userRole) && viewAllCust!=null && !"Y".equalsIgnoreCase(viewAllCust) && false)	//Commented - Unwanted code
	{
		String logInUserId = Session.getUserId();

		String userId="",bPart="";
		java.util.ArrayList bpAuth = new java.util.ArrayList();
		ezc.ezparam.EzcParams mainParam_SU = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams param_SU = new ezc.ezworkflow.params.EziWFParams();
		param_SU.setTemplate(templateSA);
		param_SU.setSyskey(catalog_areaSA);
		param_SU.setParticipant(participantSA);
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
		/*for(int i=retsoldtoSA.getRowCount()-1;i>=0;i--)
		{
			String bPartner=retsoldtoSA.getFieldValueString(i,"EC_BUSINESS_PARTNER");
			if(!bpAuth.contains(bPartner))
				retsoldtoSA.deleteRow(i);
		}*/
		//out.println("bpAuth:::"+bpAuth);
	}

	if(retcatarea != null)
		catareaRows = retcatarea.getRowCount();
	else 
		catareaRows =0;
	if(retsoldtoSA != null)
		soldtoRows = retsoldtoSA.getRowCount();
	else 
		soldtoRows =0;
%>
	<%//@ include file="../../../Includes/JSPs/SwitchAccount/iGetShipTo.jsp"%>	
<%	
	/*UtilManager.setSysKeyAndSoldTo(catalog_areaSA,selSoldToSA);
	ReturnObjFromRetrieve  listShipTosCS =null;
	if(!"Y".equals((String)session.getValue("IsSubUser")))
		listShipTosCS = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(selSoldToSA);
	else
		listShipTosCS = (ReturnObjFromRetrieve)getListOfShipTos(Session.getUserId(),catalog_areaSA,Session);
	UtilManager.setSysKeyAndSoldTo((String)session.getValue("SalesAreaCode"),(String)session.getValue("AgentCode"));*/
		
		//out.println("listShipTosCS:::"+listShipTosCS.toEzcString());

%>
