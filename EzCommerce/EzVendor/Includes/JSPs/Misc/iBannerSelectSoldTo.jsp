<%--*************************************************************************************

       /* Copyright Notice ===================================================
	* This file contains proprietary information of Answerthink Ind Ltd.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2005-2006 =====================================*/
		Author: smaddipati
		Team:   EzcSuite
		Date:   05/12/2005
*****************************************************************************************--%>


<%@ page import ="ezc.ezparam.*,ezc.ezworkflow.params.*,java.util.*"%>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<jsp:useBean id="ConfigManager" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>

<%!
	final String SYSTEM_KEY 		= "ESKD_SYS_KEY";
	final String SYSTEM_KEY_DESC_LANGUAGE 	= "ESKD_LANG";
	final String SYSTEM_KEY_DESCRIPTION 	= "ESKD_SYS_KEY_DESC";
	final String ERP_CUST_NAME 		= "ECA_NAME";
	final String ERP_CUST_NUM 		= "EC_ERP_CUST_NO";
%>

<%
	String name 		= "";
	String fname	=	(String)session.getValue("FIRST_NAME");
	String mname	=	(String)session.getValue("MIDDLE_INITIAL");
	String lname	=	(String)session.getValue("LAST_NAME");
	if(fname==null||"null".equals(fname))fname="";
	if(mname==null||"null".equals(mname))mname="";
	if(lname==null||"null".equals(lname))lname="";

	
	String userType 	= (String)session.getValue("UserType");
	String catAreaPre	= (String)session.getValue("SYSKEY");
	String participant 	= (String)session.getValue("USERGROUP");
	String userRole 	= (String)session.getValue("USERROLE");
	String ErpVendor 	= (String) session.getValue("SOLDTO");
	String ven		= (String)session.getValue("Vendor");
	String cat		= (String)session.getValue("Catalog");
	String PurArea 		= (String)session.getValue("SYSKEY");	
	
	String catalog_area 	= request.getParameter("CatalogArea");
	String soldToSel 	= request.getParameter("SoldTo");
	String soldToName 	= request.getParameter("SoldToName");
	String callPre		= request.getParameter("callPreWelcome");

	if(!userType.equals("3"))
		name=fname+ " "+ mname + " " +lname;
	else
		name=" M/s. "+fname;
	
	
	
	String role 		= "";
	String soldToInStr	= "";
	String template		= "";
	String purLoc		= "";
	String userGroup	= "";	
	int catareaRows 	= 0;
	int soldtoRows  	= 0;
	
	if(catalog_area  ==null || "null".equals(catalog_area))
		catalog_area = (String)session.getValue("SYSKEY");
	
	ezc.ezparam.ReturnObjFromRetrieve retsoldto	=	null;
	
	java.util.Vector loginUsrSoldtos 	= new java.util.Vector();
	
	java.util.Hashtable  purGroupsHash	= (java.util.Hashtable)session.getValue("PURGROUPS");
	java.util.Hashtable  templatesHash	= (java.util.Hashtable)session.getValue("TEMPLATES");
	java.util.Hashtable  purlocHash		= (java.util.Hashtable)session.getValue("PURLOCS");
	
	if(templatesHash == null) templatesHash	= new java.util.Hashtable();
	if(purGroupsHash == null) purGroupsHash	= new java.util.Hashtable();
	if(purlocHash 	 == null) purlocHash	= new java.util.Hashtable();
	
	if(soldToSel==null || "null".equals(soldToSel)) soldToSel="";
	
	ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
	ReturnObjFromRetrieve retcatarea = (ReturnObjFromRetrieve)PurManager.getUserPurAreas();
	if(retcatarea!=null)
	{
		catareaRows = retcatarea.getRowCount(); 
		if(catareaRows>0)
		{
			retcatarea.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
		}	
	}	
	
	template	=	(String)templatesHash.get(catalog_area);
	purLoc		=	(String)purlocHash.get(catalog_area);
	
	if(template==null || "null".equals(template))
	{
		EzcSysConfigParams sparams2 = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams2 = new EzcSysConfigNKParams();
		snkparams2.setLanguage("EN");
		snkparams2.setSystemKey(catalog_area);
		snkparams2.setSiteNumber(200);
		sparams2.setObject(snkparams2);
		Session.prepareParams(sparams2);
		ReturnObjFromRetrieve retTemplate = (ReturnObjFromRetrieve)ConfigManager.getCatAreaDefaults(sparams2);
		int retcnt=retTemplate.getRowCount();
		for(int z=0;z<retcnt;z++)
		{
			if("WFTEMPLATE".equals((retTemplate.getFieldValueString(z,"ECAD_KEY")).toUpperCase()))
			{
				template = retTemplate.getFieldValueString(z,"ECAD_VALUE");
				
			}else if("PURLOC".equals((retTemplate.getFieldValueString(z,"ECAD_KEY")).toUpperCase()))
			{
				purLoc = retTemplate.getFieldValueString(z,"ECAD_VALUE");
				
			}

		}
	}
	if(template != null && !"null".equals(template) && !"".equals(template))
	{
		session.putValue("TEMPLATE",template);
	}

	session.setAttribute("PURLOC",purLoc);
	
	if(!userType.equals("3"))
	{
		java.util.Hashtable userhash = (java.util.Hashtable)session.getValue("WGHASH");
		if(userhash != null)
		{
			participant = (String)userhash.get(catalog_area);
			if(session.getValue("USERGROUP")!=null)
				session.removeValue("USERGROUP");
			session.putValue("USERGROUP",participant);
		}	
		else
			participant = (String)session.getValue("USERGROUP");
			
		
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
			role= (String)session.getValue("ROLE");
			for(int i=0;i<listRet.getRowCount();i++)
			{
				if(role.equals((listRet.getFieldValueString(i,"ROLE")).trim()))
				{
					templateStep = 	Integer.parseInt(listRet.getFieldValueString(i,"STEP"));
					desiredSteps.add(templateStep-1+"");
					if(i == listRet.getRowCount()-1)
						session.putValue("FINAL","Y");
					else	
						session.putValue("FINAL","N");

					if(i == 1)
						session.putValue("FIRST","Y");
					else	
						session.putValue("FIRST","N");
				}
			}
			role = "";
		}
		
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>Inside SOLD TO Template is 		:"+template);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>Inside SOLD TO Participant is 	:"+participant);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>Inside SOLD TO Desiredstep is 	:"+desiredSteps.get(0));
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>Inside SOLD TO UserRole is 		:"+userRole);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>Inside SOLD TO Syskey is 		:"+catalog_area);
		
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
		params.setTemplate(template);
		params.setSyskey(catalog_area);
		params.setParticipant(participant);
		params.setDesiredSteps(desiredSteps);
		params.setPartnerFunction("VN");
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		if("S".equals(callPre) || "Y".equals(callPre))
		{
			retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParams);
		}	
	}
	else
	{
		if("S".equals(callPre) || "Y".equals(callPre) )
		{
			retsoldto = (ReturnObjFromRetrieve)PurManager.getUserVendors(catalog_area);	
		}	
	}
		
	if(retsoldto!=null)
	{	
		soldtoRows = retsoldto.getRowCount();
		if(soldtoRows>0)
		{
			String str[]={ERP_CUST_NAME};
			boolean b=retsoldto.sort(str,true);
		}	
	}	
	
	
	java.util.Hashtable vendorsHT =  new java.util.Hashtable();
	if(soldtoRows > 0)
	{
		for(int v=0;v<soldtoRows;v++)
			vendorsHT.put(retsoldto.getFieldValue(v,"EC_ERP_CUST_NO"),retsoldto.getFieldValue(v,"ECA_NAME"));
		session.putValue("VENDORHT",vendorsHT);
	}
	
	if("S".equals(callPre) || "Y".equals(callPre))
	{
		if(soldtoRows>0 && "Y".equals(callPre))
		{
			soldToSel	=retsoldto.getFieldValueString(0,"EC_ERP_CUST_NO");
			soldToName	=retsoldto.getFieldValueString(0,"ECA_NAME");
			
		}	
	
		PurManager.setPurAreaAndVendor(catalog_area,soldToSel); 
		session.putValue("SYSKEY", catalog_area);
		session.putValue("Catalog",catalog_area);
		session.putValue("SOLDTO",soldToSel);	
		session.putValue("Vendor",soldToName);
		
		
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWorkGroupsParams params= new ezc.ezworkflow.params.EziWorkGroupsParams();
		params.setSysKey(catalog_area);
		params.setUserId(Session.getUserId());
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		ezc.ezparam.ReturnObjFromRetrieve ret=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupsList(mainParams);
		if(ret!=null && ret.getRowCount()>0)
		{
			userGroup = ret.getFieldValueString(0,"GROUP_ID");
			if(!"".equals(userGroup))
				session.putValue("USERGROUP",userGroup);
				
			role      = ret.getFieldValueString(0,"ROLE");
			if(!"".equals(role))
				session.putValue("ROLE",role);
			
		}	
			
		for(int i=0;i<soldtoRows;i++)
		{
			String tempSoldto=(retsoldto.getFieldValueString(i,"EC_ERP_CUST_NO")).trim();
			loginUsrSoldtos.add(tempSoldto);
			if(i==0)
			{
				soldToInStr = tempSoldto;
			}
			else
			{
				soldToInStr += "','"+tempSoldto;
			}
		}

		session.putValue("SOLDTOVECT",loginUsrSoldtos);	
		if(session.getValue("SOLDTOS") != null)
			session.removeValue("SOLDTOS");
		session.putValue("SOLDTOS",soldToInStr);
		
	}
	session.putValue("SYSKEY",catalog_area);
%>