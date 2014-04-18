<%@ page import ="ezc.ezparam.*,ezc.ezworkflow.params.*,java.util.*"%>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%
	String name 		= "";
	String fname	=	(String)session.getValue("FIRST_NAME");
	String mname	=	(String)session.getValue("MIDDLE_INITIAL");
	String lname	=	(String)session.getValue("LAST_NAME");
	if(fname==null||"null".equals(fname))fname="";
	if(mname==null||"null".equals(mname))mname="";
	if(lname==null||"null".equals(lname))lname="";
	
	String userType = (String)session.getValue("UserType");
	
	String fullName = "";
	if("3".equals(userType))
		fullName = (String)session.getValue("Vendor");
	else
		fullName = fname+" "+lname;
	//out.println((String)session.getValue("Vendor"));
	String callPreWelcomePage = "N";
	if(request.getParameter("callPreWelcomePage") != null)
		callPreWelcomePage = request.getParameter("callPreWelcomePage");

	String init = ""; 
	if(request.getParameter("INIT") != null)
		init = request.getParameter("INIT");
		
	/*---FOR PAGE REFRESH CHECKING REF AT iPurMgrWelcome.jsp---*/
	if("FIRST".equals(init))
		session.putValue("INITVAL",init);
	/*--------------------------END--------------------------*/
		
	
	String changePurArea = "N";
	if(request.getParameter("changePurArea") != null)
		changePurArea = request.getParameter("changePurArea");

	String purchaseArea = request.getParameter("CatalogArea");
	String vendorCode   = request.getParameter("VENDOR_CODE");
	String vendorName   = request.getParameter("VENDOR_NAME");

	if(vendorCode == null)
		vendorCode = (String)session.getValue("SOLDTO");
	if(vendorName == null)
		vendorName = (String)session.getValue("Vendor");
	
	if(purchaseArea == null)
		purchaseArea = (String)session.getValue("SYSKEY");
	//purchaseArea = "999990";
		
	ezc.ezcommon.EzLog4j.log(vendorCode+":::::"+vendorName+":::::::"+callPreWelcomePage+"<<<<<<<<<<CHECKOOOOOOOOOOO","I");	

	
	
	
	int catareaRows = 0;
	ezc.client.EzcPurchaseUtilManager PurManager 	= new ezc.client.EzcPurchaseUtilManager(Session);
	ReturnObjFromRetrieve retUserPurAreas 		= (ReturnObjFromRetrieve)PurManager.getUserPurAreas();
	if(retUserPurAreas != null)
	{
		catareaRows = retUserPurAreas.getRowCount();
		if(catareaRows > 0)
		{
			retUserPurAreas.sort(new String[]{"ESKD_SYS_KEY_DESC"},true);
		}	
	}
	
	java.util.Hashtable  purGroupsHash = new java.util.Hashtable();
	java.util.Hashtable templatehash   = new java.util.Hashtable();
	java.util.Hashtable ccHash		= new java.util.Hashtable();
	java.util.Vector catAreas 	   = new java.util.Vector();

	
	if(retUserPurAreas!=null)
	{
		String catAreaTemp	= null;
		String prgGrpTemp	= null;
		String templateTemp	= null;
		String ccodeTemp	= null;
		boolean getCompCode = true;
		for(int c=0;c<retUserPurAreas.getRowCount();c++)
		{
			if("3".equals(userType))
				catAreaTemp=retUserPurAreas.getFieldValueString(c,"ESKD_SYS_KEY");
			else
				catAreaTemp=retUserPurAreas.getFieldValueString(c,"EBPA_SYS_KEY");

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
				int defsCount = retdef.getRowCount();
				for(int i=0;i<defsCount;i++)
				{
					
					if("PURGROUP".equals(retdef.getFieldValueString(i,"ECAD_KEY")))
					{
						
						prgGrpTemp = retdef.getFieldValueString(i,"ECAD_VALUE");
						purGroupsHash.put(catAreaTemp,prgGrpTemp);

					}
					else if("WFTEMPLATE".equals((retdef.getFieldValueString(i,"ECAD_KEY")).toUpperCase()))
					{
						templateTemp = retdef.getFieldValueString(i,"ECAD_VALUE");
						templatehash.put(catAreaTemp,templateTemp);
					}
					else if("COMPCODE".equals((retdef.getFieldValueString(i,"ECAD_KEY")).toUpperCase()))
					{
						ccodeTemp = retdef.getFieldValueString(i,"ECAD_VALUE");
						ccHash.put(catAreaTemp,ccodeTemp);
						if(getCompCode && "FIRST".equals(init))
						{
							if("1200".equals(ccodeTemp))
							{
								purchaseArea = catAreaTemp;
								getCompCode = false;
							}
						}
					}	
				}
			}
		}
	}	
	
	
	ezc.ezparam.ReturnObjFromRetrieve retsoldto = null;
	if(!userType.equals("3"))
	{
		String participant 		= (String)session.getValue("USERGROUP");
		String role			= (String)session.getValue("ROLE");
		java.util.Hashtable tempHash 	= (java.util.Hashtable)session.getValue("TEMPLATES");
		String template	= "111111";
		if(tempHash != null )
		{
			if(tempHash.get(purchaseArea) != null)
			{
				template = (String)tempHash.get(purchaseArea);
			}
		}


		ArrayList desiredSteps=new ArrayList();
		int templateStep = 0;
		ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziTemplateStepsParams params1= new ezc.ezworkflow.params.EziTemplateStepsParams();
		params1.setCode(template);
		mainParams1.setObject(params1);
		Session.prepareParams(mainParams1);
		ezc.ezparam.ReturnObjFromRetrieve retTemplateStepsList=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplateStepsList(mainParams1);
		if(retTemplateStepsList!=null)
		{
			for(int i=0;i<retTemplateStepsList.getRowCount();i++)
			{
				if(role.equals((retTemplateStepsList.getFieldValueString(i,"ROLE")).trim()))
				{
					templateStep = 	Integer.parseInt(retTemplateStepsList.getFieldValueString(i,"STEP"));
					desiredSteps.add(templateStep-1+"");
				}
			}
		}	

		ezc.ezcommon.EzLog4j.log(">>>>>>>>>>>>>>>>>>>>>>>Inside BANNER SOLD TO Template is 	:"+template,"I");
		ezc.ezcommon.EzLog4j.log(">>>>>>>>>>>>>>>>>>>>>>>Inside BANNER SOLD TO Desiredstep is 	:"+desiredSteps.get(0),"I");
		if("VP".equals((String)session.getValue("USERROLE")))
			participant = role;
		
		if("Y".equals(callPreWelcomePage) || "S".equals(callPreWelcomePage))
		{
			ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
			params.setTemplate(template);
			params.setSyskey(purchaseArea);
			params.setParticipant(participant);
			params.setDesiredSteps(desiredSteps);
			params.setPartnerFunction("VN");
			mainParams.setObject(params);
			Session.prepareParams(mainParams);
			retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParams);
		}	
	}
	else
	{
		if("Y".equals(callPreWelcomePage) || "S".equals(callPreWelcomePage))
		{
			retsoldto = (ReturnObjFromRetrieve)PurManager.getUserVendors(purchaseArea);
		}	
	}

	if("Y".equals(callPreWelcomePage) || "S".equals(callPreWelcomePage))
	{
		int soldtoRows = retsoldto.getRowCount();
		if(soldtoRows>0 && "Y".equals(callPreWelcomePage))
		{
			vendorCode	= retsoldto.getFieldValueString(0,"EC_ERP_CUST_NO");
			vendorName	= retsoldto.getFieldValueString(0,"ECA_NAME");
		}
		PurManager.setPurAreaAndVendor(purchaseArea,vendorCode); 
		session.putValue("SYSKEY", purchaseArea);
		session.putValue("Catalog",purchaseArea);
		session.putValue("SOLDTO",vendorCode);	
		session.putValue("Vendor",vendorName);
		
		java.util.Hashtable vendorsHT 		= new java.util.Hashtable();
		java.util.Vector loginUsrSoldtos	= new java.util.Vector();
		String soldToInStr	= "";
		
		for(int i=0;i<soldtoRows;i++)
		{
			String tempSoldto=(retsoldto.getFieldValueString(i,"EC_ERP_CUST_NO")).trim();
			loginUsrSoldtos.add(tempSoldto);
			if(i==0)
				soldToInStr=tempSoldto;
			else
				soldToInStr+="','"+tempSoldto;
			vendorsHT.put(retsoldto.getFieldValue(i,"EC_ERP_CUST_NO"),retsoldto.getFieldValue(i,"ECA_NAME"));
		}	
		session.putValue("VENDORHT",vendorsHT);
		session.putValue("SOLDTOVECT",loginUsrSoldtos); // Vector for getting all vendors which are synchronized
		session.putValue("SOLDTOS",soldToInStr);	// SoldTos String in the query format with single quotes 
		session.putValue("PURGRPSHASH",purGroupsHash);	// whref:pos filtering if login as mgr we need ccodes pgrps for syskey in ipurmgrwelcome.jsp 
		session.putValue("CCODEHASH",ccHash);		// whref:pos filtering if login as mgr we need ccodes pgrps for syskey in ipurmgrwelcome.jsp 
	}	
%>