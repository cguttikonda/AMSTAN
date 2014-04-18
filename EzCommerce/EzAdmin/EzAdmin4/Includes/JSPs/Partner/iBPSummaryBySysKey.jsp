<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import="ezc.ezadmin.busspartner.params.*" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="esManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session" />
<%
	String CatalogNumber = "";
	String CatalogNumberDesc = "";

	int retRows = 0;
	int retOrgRows = 0;
	int numBP = 0;
	int numBPUsers = 0;
	String Bus_Partner="";

	String areaStr	= request.getParameter("Area");

	ReturnObjFromRetrieve retCatAreas = null;
	ReturnObjFromRetrieve retCatDesc = null;
	ReturnObjFromRetrieve retOrgs = null;
	ReturnObjFromRetrieve retsum = null;
	ReturnObjFromRetrieve retbp = null;
	ReturnObjFromRetrieve retconfig = null;
	ReturnObjFromRetrieve retbpsys = null;
	ReturnObjFromRetrieve retbpareas = null;
	ReturnObjFromRetrieve retbpinfo = null;
	ReturnObjFromRetrieve retbpusers = null;
	ReturnObjFromRetrieve[] retSoldTo = null;
	ReturnObjFromRetrieve[] retUserAreas = null;

	Bus_Partner = request.getParameter("BusinessPartner");
	if(Bus_Partner!=null && !"sel".equals(Bus_Partner))
	{
		EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
		bparams2.setBussPartner(Bus_Partner);
		bnkparams2.setLanguage("EN");
		bparams2.setObject(bnkparams2);
		Session.prepareParams(bparams2);
		retconfig = (ReturnObjFromRetrieve)BPManager.getBussPartnerConfig(bparams2);

		EzcBussPartnerParams bparamsa = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparamsa = new EzcBussPartnerNKParams();
		bparamsa.setBussPartner(Bus_Partner);
		bnkparamsa.setLanguage("EN");
		bparamsa.setObject(bnkparamsa);
		Session.prepareParams(bparamsa);
		retbpinfo = (ReturnObjFromRetrieve)BPManager.getBussPartnerInfo(bparamsa);


		ezc.client.EzUserAdminManager UserManager = new ezc.client.EzUserAdminManager();
		EzcUserParams uparams= new EzcUserParams();
		EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
		ezcUserNKParams.setLanguage("EN");
		uparams.setBussPartner(Bus_Partner);
		uparams.setObject(ezcUserNKParams);
		Session.prepareParams(uparams);
		retbpusers = (ReturnObjFromRetrieve) UserManager.getUsers(uparams);
		numBPUsers = retbpusers.getRowCount();
		
		
		CatalogNumber = ((java.math.BigDecimal)(retconfig.getFieldValue(0,BP_CATALOG))).toString();
		if ( CatalogNumber != null )
		{
			EzCatalogParams cparams1 = new EzCatalogParams();
			cparams1.setLanguage("EN");
			cparams1.setCatalogNumber(CatalogNumber);
			Session.prepareParams(cparams1);
			retCatDesc = (ReturnObjFromRetrieve)catalogObj.getCatalogNumberDesc(cparams1);
			if ( retCatDesc.getRowCount() > 0 )
			{
				CatalogNumberDesc = retCatDesc.getFieldValueString(0,CATALOG_DESC);
				EzCatalogParams ecp = new EzCatalogParams();
				ecp.setLanguage("EN");
				ecp.setCatalogNumber(CatalogNumber);
				Session.prepareParams(ecp);
				retCatAreas = (ReturnObjFromRetrieve) catalogObj.getCatalogAreas(ecp);
				retCatAreas.check();
				retRows = retCatAreas.getRowCount();
				retsum = (ReturnObjFromRetrieve)catalogObj.getCatSysNos(ecp);
			}
			else
			{
				CatalogNumber = "0";
				CatalogNumberDesc = "No Catalogs Selected";
				retsum = new ReturnObjFromRetrieve();
				retCatAreas = new ReturnObjFromRetrieve();
			}
		}
		/**
		EzCatalogParams ecp = new EzCatalogParams();
		ecp.setLanguage("EN");
		ecp.setCatalogNumber(CatalogNumber);
		Session.prepareParams(ecp);
		retCatAreas = (ReturnObjFromRetrieve) catalogObj.getCatalogAreas(ecp);
		retCatAreas.check();
		retRows = retCatAreas.getRowCount();
		retsum = (ReturnObjFromRetrieve)catalogObj.getCatSysNos(ecp);
		**/

		EzcSysConfigParams sparamssum = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparamsssum = new EzcSysConfigNKParams();
		snkparamsssum.setLanguage("EN");
		sparamssum.setObject(snkparamsssum);
		Session.prepareParams(sparamssum);
		retOrgs = (ReturnObjFromRetrieve) esManager.getAllOrganizations(sparamssum);
		retOrgRows = retOrgs.getRowCount();

		EzcBussPartnerParams bparams3 = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams3 = new EzcBussPartnerNKParams();
		bparams3.setBussPartner(Bus_Partner);
		bnkparams3.setLanguage("EN");
		bparams3.setObject(bnkparams3);
		Session.prepareParams(bparams3);
		retbpsys = (ReturnObjFromRetrieve)BPManager.getBussPartnerSystems(bparams3);

		EzcBussPartnerParams bparams4 = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams4 = new EzcBussPartnerNKParams();
		bparams4.setBussPartner(Bus_Partner);
		bnkparams4.setLanguage("EN");
		bparams4.setObject(bnkparams4);
		Session.prepareParams(bparams4);
		retbpareas = (ReturnObjFromRetrieve)BPManager.getBussPartnerAreas(bparams4);

		retSoldTo = new ReturnObjFromRetrieve[numBPUsers];
		for ( int i = 0; i < numBPUsers; i++)
		{
			String user_id = retbpusers.getFieldValueString(i,"EU_ID");
			EzcUserParams uparams2= new EzcUserParams();
			EzcUserNKParams ezcUserNKParams2 = new EzcUserNKParams();
			ezcUserNKParams2.setLanguage("EN");
			uparams2.setUserId(user_id);

			String[] partFunctions = {"AG","VN"};
			ezcUserNKParams2.setPartnerFunctions(partFunctions);
			uparams2.createContainer();
			uparams2.setObject(ezcUserNKParams2);
			Session.prepareParams(uparams2);

			retSoldTo[i] = (ReturnObjFromRetrieve)UserManager.getUserCustomers(uparams2);
		}

		retUserAreas = new ReturnObjFromRetrieve[numBPUsers];
		for ( int i = 0; i < numBPUsers; i++)
		{
			String user_id = retbpusers.getFieldValueString(i,"EU_ID");
			EzcUserParams uparams2= new EzcUserParams();
			EzcUserNKParams ezcUserNKParams2 = new EzcUserNKParams();
			ezcUserNKParams2.setLanguage("EN");
			uparams2.setUserId(user_id);
			uparams2.createContainer();
			uparams2.setObject(ezcUserNKParams2);
			EzBussPartnerAreaTable ebpt = new EzBussPartnerAreaTable();
			EzBussPartnerAreaTableRow ebptrow = new EzBussPartnerAreaTableRow();
			ebptrow.setEbpaClient("200");
			//ebptrow.setEbpaBussPartner("");
			ebptrow.setEbpaUserId(user_id);
			ebpt.appendRow(ebptrow);
			uparams2.setObject(ebpt);
			Session.prepareParams(uparams2);

			retUserAreas[i] = (ReturnObjFromRetrieve) UserManager.getInranetUserAreas(uparams2);
		}
	}
%>