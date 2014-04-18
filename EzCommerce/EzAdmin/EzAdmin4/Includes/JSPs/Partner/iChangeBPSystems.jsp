<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<%
	String websyskey=request.getParameter("WebSysKey");
	String Area1=request.getParameter("Area");

	String CatalogNumber = "";
	String CatalogNumberDesc = "";

	int retRows = 0;
	int retOrgRows = 0;
	int numBP = 0;
	String Bus_Partner="";

	ReturnObjFromRetrieve retCatAreas = null;
	ReturnObjFromRetrieve retCatDesc = null;
	ReturnObjFromRetrieve retOrgs = null;
	ReturnObjFromRetrieve ret = null;
	ReturnObjFromRetrieve retbp = null;
	ReturnObjFromRetrieve retconfig = null;
	ReturnObjFromRetrieve retbpsys = null;
	ReturnObjFromRetrieve retbpareas = null;

	// Get Business Partners
	EzcBussPartnerParams bparams = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
	bnkparams.setLanguage("EN");
	bparams.setObject(bnkparams);
	Session.prepareParams(bparams);
	retbp = (ReturnObjFromRetrieve)BPManager.getBussPartners(bparams);
	retbp.check();

	numBP = retbp.getRowCount();
	//Get Business Partner Value
	Bus_Partner = request.getParameter("chk1");
	String BPDesc=request.getParameter("BPDesc");
	if(numBP>0)
	{
		if (Bus_Partner == null)
		{
			Bus_Partner = (retbp.getFieldValue(0,BP_NUMBER)).toString();
		}

		// Get Business Partner Config
		EzcBussPartnerParams bparams2 = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams2 = new EzcBussPartnerNKParams();
		bparams2.setBussPartner(Bus_Partner);
		bnkparams2.setLanguage("EN");
		bparams2.setObject(bnkparams2);
		Session.prepareParams(bparams2);
		retconfig = (ReturnObjFromRetrieve)BPManager.getBussPartnerConfig(bparams2);
		retconfig.check();

		CatalogNumber = ((java.math.BigDecimal)(retconfig.getFieldValue(0,BP_CATALOG))).toString();

		if ( CatalogNumber != null )
		{
			EzCatalogParams cparams1 = new EzCatalogParams();
			cparams1.setLanguage("EN");
			cparams1.setCatalogNumber(CatalogNumber);
			Session.prepareParams(cparams1);
			retCatDesc = (ReturnObjFromRetrieve)catalogObj.getCatalogNumberDesc(cparams1);
			retCatDesc.check();
			if ( retCatDesc.getRowCount() > 0 )
			{
				CatalogNumberDesc = retCatDesc.getFieldValueString(0,CATALOG_DESC);
				/** Call to get all Systems and related Catalog, Purchase, Service and whatever areas from Nitin**/
			   	EzCatalogParams ecp = new EzCatalogParams();
			   	ecp.setLanguage("EN");
			   	ecp.setCatalogNumber(CatalogNumber);
			   	Session.prepareParams(ecp);
			   	retCatAreas = (ReturnObjFromRetrieve) catalogObj.getCatalogAreas(ecp);
			   	retCatAreas.check();
			   	retRows = retCatAreas.getRowCount();
			   	ret = (ReturnObjFromRetrieve)catalogObj.getCatSysNos(ecp);
			   	ret.check();
			}
			else
			{
				CatalogNumber = "0";
				CatalogNumberDesc = "No Catalogs Selected";
				ret = new ReturnObjFromRetrieve();
				retCatAreas = new ReturnObjFromRetrieve();
			}
		}
		/** Call to get all Systems and related Catalog, Purchase, Service and whatever areas from Nitin**/
		EzcSysConfigParams sparams = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
		snkparams.setLanguage("EN");
		sparams.setObject(snkparams);
		Session.prepareParams(sparams);
		retOrgs = (ReturnObjFromRetrieve) sysManager.getAllOrganizations(sparams);
		retOrgs.check();
      		retOrgRows = retOrgs.getRowCount();

		//Get the systems for the BP
		EzcBussPartnerParams bparams3 = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams3 = new EzcBussPartnerNKParams();
		bparams3.setBussPartner(Bus_Partner);
		bnkparams3.setLanguage("EN");
		bparams3.setObject(bnkparams3);
		Session.prepareParams(bparams3);
		retbpsys = (ReturnObjFromRetrieve)BPManager.getBussPartnerSystems(bparams3);
		retbpsys.check();

		//Get the areas for the BP
		EzcBussPartnerParams bparams4 = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams4 = new EzcBussPartnerNKParams();
		bparams4.setBussPartner(Bus_Partner);
		bnkparams4.setLanguage("EN");
		bparams4.setObject(bnkparams4);
		Session.prepareParams(bparams4);
		retbpareas = (ReturnObjFromRetrieve)BPManager.getBussPartnerAreas(bparams4);
		retbpareas.check();
	}
%>