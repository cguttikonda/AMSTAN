<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<%//@ include file="../../../Includes/Lib/AdminBean.jsp"%>
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
ReturnObjFromRetrieve retcat = null;
ReturnObjFromRetrieve retcatdesc = null;
ReturnObjFromRetrieve retbpinfo = null;
ReturnObjFromRetrieve retcatareas = null;
ReturnObjFromRetrieve retcatsys = null;

int retRows, retCSRows = 0;

String FirstName = null;
String MiddleInit = null;
String LastName = null;
String Email = null;
String BusPartner = null;
String BPDesc = null;
String CatalogNumber = null;

// Get Basic Info
String UserId = request.getParameter("UserID");
BusPartner = request.getParameter("BusPartner");

//Added by Venkat on 4/24/2001
	if ( BusPartner != null )BusPartner = BusPartner.substring(0,BusPartner.length()-1);
//Venkats changes end here

if(UserId != null)
{     UserId = UserId.toUpperCase();
	UserId = UserId.trim();
}
/****** Added by Venkat on 4/9/2001 *********************/
	EzcUserParams uparams= new EzcUserParams();
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
      uparams.setUserId(UserId);
      uparams.setBussPartner(BusPartner);
	uparams.setObject(ezcUserNKParams);
	Session.prepareParams(uparams);

	ReturnObjFromRetrieve retU =	(ReturnObjFromRetrieve)UserManager.getUserData(uparams);
	retU.check();
	int retURows = retU.getRowCount();
      if ( retURows > 0 )
      {
		response.sendRedirect("../User/ezAddUserData.jsp?UserID="+UserId);
          	return;
      }

      retU = (ReturnObjFromRetrieve) UserManager.getUsers(uparams);
      retURows = retU.getRowCount();
/****** Changes end here ********************************/

String Password = request.getParameter("InitialPassword");
String UserType = request.getParameter("UserType");
String UserGroup = request.getParameter("UserGroup");

String AdminUser = request.getParameter("Admin"); //added by Venkat
AdminUser = (AdminUser==null)?"N":"Y"; //adde by Venkat

FirstName = request.getParameter("FirstName");
//MiddleInit = request.getParameter("*MidInit"); //Commented by Venkat on 5/2/2001
MiddleInit = request.getParameter("MidInit");

LastName = request.getParameter("LastName");
Email = request.getParameter("Email");
String bussuser = request.getParameter("UserType");

EzcBussPartnerParams bparams = new EzcBussPartnerParams();
EzcBussPartnerNKParams bNKParams = new EzcBussPartnerNKParams();
bparams.setBussPartner(BusPartner);
bNKParams.setLanguage("EN");

bparams.createContainer();
bparams.setObject(bNKParams);
Session.prepareParams(bparams);

// Get Business Partner Basic Information
retbpinfo = (ReturnObjFromRetrieve) BPManager.getBussPartnerInfo(bparams);
BPDesc = ((retbpinfo.getFieldValue(0,BP_COMPANY_NAME)).toString());


EzcBussPartnerParams bparamsNEW = new EzcBussPartnerParams();
EzcBussPartnerNKParams bNKParamsNEW = new EzcBussPartnerNKParams();
bparamsNEW.setBussPartner(BusPartner);
bNKParamsNEW.setLanguage("EN");

bparamsNEW.createContainer();
bparamsNEW.setObject(bNKParamsNEW);
Session.prepareParams(bparamsNEW);



// Get Business Partner Catalog
retcat =(ReturnObjFromRetrieve)BPManager.getBussPartnerConfig(bparamsNEW);
retcat.check();

/***** Added by Venkat on 4/17/2001 *******/
String unlimUsers = retcat.getFieldValueString(0,"EBPC_UNLIMITED_USERS");
if ( !unlimUsers.equals("Y") )
{
     String maxBusUsers = retcat.getFieldValueString(0,"EBPC_NUMBER_OF_USERS");
     Integer mBusUsers = new Integer(maxBusUsers);
     int mbu = mBusUsers.intValue();

     if ( mbu < retURows )
     {
         out.println("<BR><BR><BR><BR><CENTER><B>Cannot Add User to this Business Partner</B></CENTER>");
         out.println("<CENTER><B>Either change the max users for this Business Partner or</B></CENTER>");
         out.println("<CENTER><B>Select a different Business Partner</B></CENTER>");
         out.println("<center><input type=\"button\" name=\"back\" value = \"Back\" onClick=\"history.back()\"></center>");
         return;
     }
}


/***** Venkats changes end here ***********/

//Get Catalog Number
String catalog_number = ((java.math.BigDecimal)(retcat.getFieldValue(0,BP_CATALOG))).toString();
String catalog_description = null;
	EzCatalogParams catparams = new EzCatalogParams();

if ( catalog_number != null ) {
//	retcatdesc = AdminObject.getCatalogNumberDesc(servlet, catalog_number);
	//retcatdesc = AdminObject.getCatalogNumberDesc(servlet, catalog_number);
	catparams.setLanguage("EN");
	catparams.setCatalogNumber(catalog_number);
	Session.prepareParams(catparams);
	retcatdesc = (ReturnObjFromRetrieve)catalogObj.getCatalogNumberDesc(catparams);
	retcatdesc.check();
	catalog_description = (String)(retcatdesc.getFieldValue(0,CATALOG_DESC));	
}

/** Added by Venkat on 4/24/2001 **/
/** Call to get all Systems and related Catalog, Purchase, Service and whatever areas from Nitin**/
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

      ReturnObjFromRetrieve retbpareas = null;
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
/** Venkats changes end here **/

%>