<%@ page import = "ezc.ezparam.*" %>
<%@ page import="ezc.ezadmin.busspartner.params.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page"></jsp:useBean>

<%
	ReturnObjFromRetrieve ret = null;
	ReturnObjFromRetrieve retuser = null;
	ReturnObjFromRetrieve retbp = null;
	ReturnObjFromRetrieve retcat = null;
	ReturnObjFromRetrieve retcatuser = null;
	ReturnObjFromRetrieve retbpareas = null;
	ReturnObjFromRetrieve retbpSAreas = null;

	int retRows = 0;
	int retCSRows = 0;

	String catalog_number = null;
	String user_id = request.getParameter("UserID");
	String moduser=request.getParameter("BusinessUser");

	String fromListByRole=request.getParameter("fromListByRole");
	String roleVal=request.getParameter("role");
	String sysVal=request.getParameter("sysKey");
	if(sysVal==null || "null".equals(sysVal))
		sysVal = request.getParameter("BPsyskey");
	

	if(moduser!=null)
	{
		user_id=moduser;
	}
	String BusPartner = "";

	String Show = request.getParameter("Show");
	if ( Show == null )
		Show = "No";
		
	String display = "";
	String checDisp = "";
	if ( Show.equals("Yes") )
	{
		display = "disabled";
		checDisp = "disabled";
	}

	EzcBussPartnerParams bparams = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bNKParams = new EzcBussPartnerNKParams();
	bNKParams.setLanguage("EN");
	bparams.setObject(bNKParams);
	Session.prepareParams(bparams);
	retbp = (ReturnObjFromRetrieve)BPManager.getBussPartners(bparams);

	EzcUserParams uparams1= new EzcUserParams();
	EzcUserNKParams ezcUserNKParams1 = new EzcUserNKParams();
	uparams1.setUserId(user_id);
	boolean result_flag1 = uparams1.setObject(ezcUserNKParams1);
	Session.prepareParams(uparams1);
	ret = (ReturnObjFromRetrieve)UserManager.getUserData(uparams1);
      	BusPartner = ret.getFieldValueString(0,"EU_BUSINESS_PARTNER");

	EzcUserParams uparamsN= new EzcUserParams();
	EzcUserNKParams ezcUserNKParamsN = new EzcUserNKParams();
	ezcUserNKParamsN.setLanguage("EN");
	uparamsN.setUserId(user_id);
	uparamsN.setObject(ezcUserNKParamsN);
	Session.prepareParams(uparamsN);
	retcatuser = (ReturnObjFromRetrieve)UserManager.getUserCatalogs(uparamsN);

	if(retcatuser.getFieldValue(0,CATALOG_DESC_NUMBER) != null)
      	{
		catalog_number = ((java.math.BigDecimal)(retcatuser.getFieldValue(0,CATALOG_DESC_NUMBER))).toString();
	}

	ReturnObjFromRetrieve retcatsys, retcatareas;
	if ( catalog_number != null )
	{
		EzCatalogParams ecp = new EzCatalogParams();
	      	ecp.setLanguage("EN");
		ecp.setCatalogNumber(catalog_number);
		Session.prepareParams(ecp);
		retcatareas = (ReturnObjFromRetrieve)catalogObj.getCatalogAreas(ecp);
		retcatsys = (ReturnObjFromRetrieve)catalogObj.getCatSysNos(ecp);
	      	retRows = retcatareas.getRowCount();
		retCSRows = retcatsys.getRowCount();
	}
	else
	{
		retcatareas = new ReturnObjFromRetrieve();
		retcatsys = new ReturnObjFromRetrieve();
		catalog_number = "0";
	}

	EzcBussPartnerParams bparams4 = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparams4 = new EzcBussPartnerNKParams();
	bparams4.setBussPartner(BusPartner);
	bnkparams4.setLanguage("EN");
	bparams4.setObject(bnkparams4);
	Session.prepareParams(bparams4);
	retbpareas = (ReturnObjFromRetrieve)BPManager.getBussPartnerAreas(bparams4);
      	int retbpRows = retbpareas.getRowCount();

      	EzBussPartnerAreaTable ebpt = new EzBussPartnerAreaTable();
	EzBussPartnerAreaTableRow ebptrow = new EzBussPartnerAreaTableRow();
	ebptrow.setEbpaClient("200");
	ebptrow.setEbpaUserId(user_id);		
      	ebpt.appendRow(ebptrow);
	uparamsN.setObject(ebpt);
	retbpSAreas = (ReturnObjFromRetrieve) UserManager.getInranetUserAreas(uparamsN);
%>