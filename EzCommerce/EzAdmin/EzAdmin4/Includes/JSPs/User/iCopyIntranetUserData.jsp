<%@ page import = "ezc.ezparam.*" %>
<%@ page import="ezc.ezadmin.busspartner.params.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>

<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"> 
</jsp:useBean> 
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"> 
</jsp:useBean>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page">
</jsp:useBean>


<%
// Key Variables
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
String newuser_id = request.getParameter("NewUserID");
String BusPartner = "";

String Show = request.getParameter("Show");
if ( Show == null )Show = "No"; //to show user details

String display = "";
String checDisp = "";
if ( Show.equals("Yes") )
{
	display = "disabled";
	checDisp = "disabled";
}

// Get Business Partners
	EzcBussPartnerParams bparams = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bNKParams = new EzcBussPartnerNKParams();
	bNKParams.setLanguage("EN");
	bparams.setObject(bNKParams);
	Session.prepareParams(bparams);
	retbp = (ReturnObjFromRetrieve)BPManager.getBussPartners(bparams);
	retbp.check();

//Get User Data
	EzcUserParams uparams1= new EzcUserParams();
	EzcUserNKParams ezcUserNKParams1 = new EzcUserNKParams();
	uparams1.setUserId(user_id);
	boolean result_flag1 = uparams1.setObject(ezcUserNKParams1);
	Session.prepareParams(uparams1);
	// Get Basic User Information
	ret = (ReturnObjFromRetrieve)UserManager.getUserData(uparams1);
	ret.check();
      BusPartner = ret.getFieldValueString(0,"EU_BUSINESS_PARTNER");

//Get User Catalogs
	EzcUserParams uparamsN= new EzcUserParams();
	EzcUserNKParams ezcUserNKParamsN = new EzcUserNKParams();
	ezcUserNKParamsN.setLanguage("EN");
	uparamsN.setUserId(user_id);
	uparamsN.setObject(ezcUserNKParamsN);
	Session.prepareParams(uparamsN);
	// Get User Catalog Number
	retcatuser = (ReturnObjFromRetrieve)UserManager.getUserCatalogs(uparamsN);
	retcatuser.check();

	if(retcatuser.getFieldValue(0,CATALOG_DESC_NUMBER) != null)
      {
		catalog_number = ((java.math.BigDecimal)(retcatuser.getFieldValue(0,CATALOG_DESC_NUMBER))).toString();
	}

/** Call to get all Systems and related Catalog, Purchase, Service and whatever areas from Nitin**/
	ReturnObjFromRetrieve retcatsys, retcatareas;
	if ( catalog_number != null )
	{
		EzCatalogParams ecp = new EzCatalogParams();
	      ecp.setLanguage("EN");
	      ecp.setCatalogNumber(catalog_number);
	      Session.prepareParams(ecp);
		retcatareas = (ReturnObjFromRetrieve)catalogObj.getCatalogAreas(ecp);
	      retcatareas.check();
		retcatsys = (ReturnObjFromRetrieve)catalogObj.getCatSysNos(ecp);
	      retcatsys.check();

	      retRows = retcatareas.getRowCount();
	      retCSRows = retcatsys.getRowCount();
	}
	else
	{
		retcatareas = new ReturnObjFromRetrieve();
		retcatsys = new ReturnObjFromRetrieve();
		catalog_number = "0";
	}

	//Get the areas for the BP
	EzcBussPartnerParams bparams4 = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparams4 = new EzcBussPartnerNKParams();
	bparams4.setBussPartner(BusPartner);
	bnkparams4.setLanguage("EN");
	bparams4.setObject(bnkparams4);
	Session.prepareParams(bparams4);
	retbpareas = (ReturnObjFromRetrieve)BPManager.getBussPartnerAreas(bparams4);
	retbpareas.check();
      int retbpRows = retbpareas.getRowCount();


      EzBussPartnerAreaTable ebpt = new EzBussPartnerAreaTable();
      EzBussPartnerAreaTableRow ebptrow = new EzBussPartnerAreaTableRow();
      ebptrow.setEbpaClient("200"); //TBD
      //ebptrow.setEbpaBussPartner("");
      ebptrow.setEbpaUserId(user_id);
      ebpt.appendRow(ebptrow);
      uparamsN.setObject(ebpt);

      retbpSAreas = (ReturnObjFromRetrieve) UserManager.getInranetUserAreas(uparamsN);
%>