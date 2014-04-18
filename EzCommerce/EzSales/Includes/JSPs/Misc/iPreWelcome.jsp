<%@ page import ="ezc.ezparam.*"%>
<%@ page import="ezc.ezutil.csb.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="ezc.personalization.params.EzcPersonalizationParams" %>
<%@ page import="ezc.personalization.params.EziPersonalizationParams" %>

<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>

<jsp:useBean id="ConfigManager" class="ezc.client.EzSystemConfigManager" scope="session"/>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"/>
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="EzcPersonalizationManager" class="ezc.personalization.client.EzcPersonalizationManager"/>
<%
	ezc.ezcommon.EzLog4j log4j = new ezc.ezcommon.EzLog4j();
	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	ReturnObjFromRetrieve checkcatarea = (ReturnObjFromRetrieve) UtilManager.getUserCatalogAreas();
	int catareaRows 	= checkcatarea.getRowCount(); 
	String catalogArea 	= request.getParameter("CatalogArea");
	String soldTo 		= request.getParameter("SoldTo");
	
	if(soldTo!=null && soldTo.indexOf("@")>=0)
		soldTo = soldTo.replaceAll("@","&"); 
	
	
	
        out.println("================>"+soldTo);

	boolean catchek= false;
	for(int c = 0 ;c < catareaRows;c++)
	{
		String val = checkcatarea.getFieldValueString(c,"ESKD_SYS_KEY").trim();
		if (val.equals(catalogArea.trim()))
		{
			catchek=true;
			break;
		}
	}
	if(!catchek) 
		catalogArea=null;

	session.putValue("SalesAreaCode",catalogArea);
	session.putValue("AgentCode",soldTo);
	UtilManager.setSysKeyAndSoldTo(catalogArea,soldTo);
	
	// This is added by Balu on 30th October for getting default carrier name of the customer
	
	log4j.log("balusoldTosoldTo:"+soldTo,"W");
	
	log4j.log("balu1111soldTosoldTo:"+soldTo,"W");
	ReturnObjFromRetrieve carrierName = (ReturnObjFromRetrieve)UtilManager.getListOfBillTos(soldTo+"¥");
	String carrierStr  = "";
	if(carrierName!=null)
	{
		carrierStr  =carrierName.getFieldValueString(0,"EC_PARTNER_NO").trim();
		session.putValue("CARRIERNAME",carrierStr);
		
	}
	
	// Ends Here
	
	
	ReturnObjFromRetrieve retcatarea = null;
	ReturnObjFromRetrieve retsoldto = null;
	retcatarea = (ReturnObjFromRetrieve) UtilManager.getUserCatalogAreas();
	retsoldto  = (ReturnObjFromRetrieve) UtilManager.getUserCustomers(catalogArea);

	
	
	catareaRows = retcatarea.getRowCount(); 
	for(int c = 0;c < catareaRows;c++)
	{		
		String val = retcatarea.getFieldValueString(c,"ESKD_SYS_KEY").trim();	
		if (val.equals(catalogArea.trim()))
		{
	        	String catArea = retcatarea.getFieldValueString(c,"ESKD_SYS_KEY_DESC");
			session.putValue("Country",catArea);
			break;		
		}
	}

	if(soldTo.indexOf(",")==-1)
	{
		int soldtoRows =retsoldto.getRowCount() ;
		if(soldtoRows > 0) 
		{
			for(int j = 0;j < soldtoRows;j++)
			{		
				String custNum  =retsoldto.getFieldValueString(j,"EC_ERP_CUST_NO").trim();
				String custName =retsoldto.getFieldValueString(j,"ECA_NAME");
				if(custNum.equals(soldTo.trim()))
				{
					ReturnObjFromRetrieve listOfBillTos = (ReturnObjFromRetrieve)UtilManager.getListOfBillTos(soldTo);
					
					if(listOfBillTos != null)
					{
						String billTo =listOfBillTos.getFieldValueString(0,"EC_PARTNER_NO");
						billTo=billTo.trim();
						UtilManager.setDefBillTo(billTo);
						session.putValue("DefBillTO",billTo);
					}
					session.putValue("Agent",custName);
					break;
				}	
			}
		}
	}
	else
	{
		session.putValue("Agent","All Customers");
		int soldtoRows =retsoldto.getRowCount() ;
		if(soldtoRows > 0) 
		{
			ReturnObjFromRetrieve listOfBillTos = (ReturnObjFromRetrieve) UtilManager.getListOfBillTos(soldTo);
			
			
			
			if(listOfBillTos != null)
			{
				String billTo =listOfBillTos.getFieldValueString(0,"EC_PARTNER_NO");
				billTo=billTo.trim();
				UtilManager.setDefBillTo(billTo);
				session.putValue("DefBillTO",billTo);
			}
		}
	}

	

	EzcSysConfigParams sparams2 	= new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams2 = new EzcSysConfigNKParams();
	snkparams2.setLanguage("EN");
	snkparams2.setSystemKey((String)session.getValue("SalesAreaCode"));
	snkparams2.setSiteNumber(200);
	sparams2.setObject(snkparams2);
	Session.prepareParams(sparams2);
	ReturnObjFromRetrieve retde = (ReturnObjFromRetrieve)ConfigManager.getCatAreaDefaults(sparams2);
	retde.check();
	for(int z=0;z<retde.getRowCount();z++)
	{
		if("DOCTYPE".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String docType = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("docType",docType);
		}
		if("DIVISION".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String division = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("division",division);
		}
		if("DISTRIBUTION".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String distributionChannel = retde.getFieldValueString(z,"ECAD_VALUE");
		 	session.putValue("dc",distributionChannel);
		}
		if("SALESORG".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String salesOrg = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("salesOrg",salesOrg);
		}
		if("WFTEMPLATE".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String template = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("Template",template);
		}
		if("DEFSAPPRDCODE".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String defSapMatCode  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("SAPPRDCODE",defSapMatCode);
		}
		if("SUBUSERLIMIT".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String subUserLimit  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("SUBUSERLIMIT",subUserLimit);
		}
		if("PLANT".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String plantVal  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("PLANT",plantVal);
		}
		if("SOCONDTYPE".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String soCondType  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("SOCONDTYPE",soCondType);
		}
		if("QUOTECONDTYPE".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String quoteCondType  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("QUOTECONDTYPE",quoteCondType);
		}
		if("FREIGHTCONDTYPE".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String fCondType  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("FREIGHTCONDTYPE",fCondType);
		}
		if("PROFITCENTER".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String profitCenter  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("PROFITCENTER",profitCenter);
		}
		if("FREIGHTINS".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String freightIns  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("FREIGHTINS",freightIns);
		}
		if("PAGESIZE".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String pageSize  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("PAGESIZE",pageSize);
		}
		if("FRINSVAL".equals(retde.getFieldValueString(z,"ECAD_KEY")) )
		{
			String frInsVal  = retde.getFieldValueString(z,"ECAD_VALUE");
			session.putValue("FRINSVAL",frInsVal);
		}
	}

	EzcUserParams uparams= new EzcUserParams();
	uparams.setUserId(Session.getUserId());
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
 	ezcUserNKParams.setLanguage("EN");
 	uparams.createContainer();
 	uparams.setObject(ezcUserNKParams);
 	Session.prepareParams(uparams);

	//Get User Catalog Number
	ReturnObjFromRetrieve  catalogno = (ReturnObjFromRetrieve)UserManager.getUserCatalogs(uparams);


	for(int i=0;i<catalogno.getRowCount();i++)
	{
		if("USERCATALOG".equals(catalogno.getFieldValueString(i,"EUD_KEY")) )
		{
			String CatalogCode = catalogno.getFieldValueString(i,"EUD_VALUE");
			session.putValue("CatalogCode",CatalogCode);
			break;
		}
	}
	
	String userRole =(String)session.getValue("UserRole");
	if("CU".equals(userRole))
	{
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWorkGroupsParams wparams= new ezc.ezworkflow.params.EziWorkGroupsParams();
		wparams.setSoldTo(soldTo);
		wparams.setSysKey(catalogArea);
		mainParams.setObject(wparams);
		Session.prepareParams(mainParams);
		ezc.ezparam.ReturnObjFromRetrieve ret=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupsList(mainParams);
		if(ret.getRowCount() >0)
		{
			String userGroup=ret.getFieldValueString(0,"GROUP_ID");
			session.putValue("UserGroup",userGroup);
			session.putValue("Participant",userGroup);
		}
	} 
	
	
	
	EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
	adminUtilsParams.setSyskeys(catalogArea);
	adminUtilsParams.setPartnerValueBy(soldTo);

	EzcParams mainParams_A = new EzcParams(false);
	mainParams_A.setObject(adminUtilsParams);
	Session.prepareParams(mainParams_A);

	ReturnObjFromRetrieve partnersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams_A);

	if(partnersRet!=null && partnersRet.getRowCount()>0)
	{
		for(int l=0;l<partnersRet.getRowCount();l++)
		{
			String tmpUser = partnersRet.getFieldValueString(l,"EU_ID");
			

			if(tmpUser!=null && !"null".equals(tmpUser)) 
			{
				tmpUser = tmpUser.trim();

				ezc.ezparam.EzcUserParams uparams_A= new ezc.ezparam.EzcUserParams();
				EzcUserNKParams ezcUserNKParams_A = new EzcUserNKParams();
				ezcUserNKParams_A.setLanguage("EN");
				ezcUserNKParams_A.setSys_Key("0");
				uparams_A.createContainer();
				uparams_A.setUserId(tmpUser);
				uparams_A.setObject(ezcUserNKParams_A);
				Session.prepareParams(uparams_A);
				ReturnObjFromRetrieve retObjSubUser = (ReturnObjFromRetrieve)(UserManager.getAddUserDefaults(uparams_A));

				String isSubUser = "";
				String salesRepRes = "";
				String salesOffice = "";
				String salesGroup = "";
				String shipID = "";

				if(retObjSubUser!=null && retObjSubUser.getRowCount()>0)
				{
					for(int i=0;i<retObjSubUser.getRowCount();i++)
					{
						if("ISSUBUSER".equals(retObjSubUser.getFieldValueString(i,"EUD_KEY")))
						{
							isSubUser=retObjSubUser.getFieldValueString(i,"EUD_VALUE");
						}
						if("SALESREPRES".equals(retObjSubUser.getFieldValueString(i,"EUD_KEY")))
						{
							salesRepRes=retObjSubUser.getFieldValueString(i,"EUD_VALUE");
						}
						if("SALESOFFICE".equals(retObjSubUser.getFieldValueString(i,"EUD_KEY")))
						{
							salesOffice=retObjSubUser.getFieldValueString(i,"EUD_VALUE");
						}
						if("SALESGROUP".equals(retObjSubUser.getFieldValueString(i,"EUD_KEY")))
						{
							salesGroup=retObjSubUser.getFieldValueString(i,"EUD_VALUE");
						}
						if("SHIPID".equals(retObjSubUser.getFieldValueString(i,"EUD_KEY")))
						{
							shipID=retObjSubUser.getFieldValueString(i,"EUD_VALUE");
						}
					}
					if(!"Y".equals(isSubUser))
					{
						session.putValue("SALESREPRES",salesRepRes);
						session.putValue("CU_SALESOFFICE",salesOffice);
						session.putValue("CU_SALESGROUP",salesGroup);
						session.putValue("SHIPID",shipID);
						break;
					}
				}
			}
		}
	}
	
	
	EzcPersonalizationParams ezget = new EzcPersonalizationParams();
	EziPersonalizationParams izget = new EziPersonalizationParams();
	izget.setLanguage("EN");
	izget.setUserId(Session.getUserId());
	ezget.setObject(izget);
	Session.prepareParams(ezget);
	ReturnObjFromRetrieve retprodfav = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezget);
	int retprodfavCount=retprodfav.getRowCount();
	if(retprodfavCount>0)
	{
		String favGroup = retprodfav.getFieldValueString(0,"EPG_NO");
		String favDesc  = retprodfav.getFieldValueString(0,"EPGD_DESC");
		session.putValue("USR_FAV_GRP",favGroup);
		session.putValue("USR_FAV_DESC",favDesc);
	}
	else
	{
		
		EzcPersonalizationParams ezpparams = new EzcPersonalizationParams();
		EziPersonalizationParams iparams = new EziPersonalizationParams();
		iparams.setLanguage("EN");
		iparams.setUserId(Session.getUserId());
		iparams.setProductFavGroupDesc("MYFAVOURITES");
		iparams.setProductFavGroupWebDesc("My Favourites");
		ezpparams.setObject(iparams);
		Session.prepareParams(ezpparams);
		EzcPersonalizationManager.addUserProdFavDesc(ezpparams);

		String groupNumber = "";
		ezget = new EzcPersonalizationParams();
		izget = new EziPersonalizationParams();
		izget.setLanguage("EN");
		izget.setUserId(Session.getUserId());
		ezget.setObject(izget);
		Session.prepareParams(ezget);
		ReturnObjFromRetrieve retFAV = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezget);
		String favGroup = retFAV.getFieldValueString(0,"EPG_NO");
		String favDesc  = retFAV.getFieldValueString(0,"EPGD_DESC");
		
		session.putValue("USR_FAV_GRP",favGroup);
		session.putValue("USR_FAV_DESC",favDesc);
	
	}
	

	
	
	
	
	
%>