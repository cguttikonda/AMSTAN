
<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>


<%
	ezc.client.EzSystemConfigManager sysManager = new ezc.client.EzSystemConfigManager();
%>

<%
/** Get the Parameters from ezAddBPInfo.jsp **/

String Company = request.getParameter("Company");
String BPDescription = request.getParameter("BPDescription");
String ContactName = request.getParameter("ContactName");
String Email = request.getParameter("Email");
String WebAddress = request.getParameter("WebAddress");
String Address1 = request.getParameter("Address1");
String Address2 = request.getParameter("Address2");
String City = request.getParameter("City");
String State = request.getParameter("State");
String Zip = request.getParameter("Zip");
String Country = request.getParameter("Country");

String Phone11 = request.getParameter("Phone11");
String Phone12 = request.getParameter("Phone12");
String Phone13 = request.getParameter("Phone13");

String Phone21 = request.getParameter("Phone21");
String Phone22 = request.getParameter("Phone22");
String Phone23 = request.getParameter("Phone23");

String Fax1 = request.getParameter("Fax1");
String Fax2 = request.getParameter("Fax2");
String Fax3 = request.getParameter("Fax3");


String UnlimitedUsers = request.getParameter("UnlimitedUsers");
String NumUsers = request.getParameter("NumUsers");
String busIntUser = request.getParameter("busintuser");
busIntUser = (busIntUser==null)?"N":"Y";


/** End getting parameters **/

String CatalogNumber = request.getParameter("CatalogNumber");
String CatalogNumberDesc = "";
	
int retRows = 0;
int retOrgRows = 0;

ReturnObjFromRetrieve retCatAreas = null;
ReturnObjFromRetrieve retCatDesc = null;
ReturnObjFromRetrieve retOrgs = null;
ReturnObjFromRetrieve ret = null;

/** Call to get all Systems and related Catalog, Purchase, Service and whatever areas from Nitin**/
	if ( CatalogNumber != null && !CatalogNumber.equals("0"))
	{
		EzCatalogParams ecp = new EzCatalogParams();
	      ecp.setLanguage("EN");
	      ecp.setCatalogNumber(CatalogNumber);
	      Session.prepareParams(ecp);
	      retCatAreas = (ReturnObjFromRetrieve) catalogObj.getCatalogAreas(ecp);
		retCatAreas.check();
      	retRows = retCatAreas.getRowCount();

            if ( retRows > 0 )
		{
			ret = (ReturnObjFromRetrieve)catalogObj.getCatSysNos(ecp);
			ret.check();
		}

/** Call to get all Systems and related Catalog, Purchase, Service and whatever areas from Nitin**/
	      retCatDesc = (ReturnObjFromRetrieve) catalogObj.getCatalogNumberDesc(ecp);
		retCatDesc.check();
	      CatalogNumberDesc = (String) retCatDesc.getFieldValue(0,CATALOG_DESC);
	}
	else
	{
		retCatAreas = new ReturnObjFromRetrieve();
		retCatDesc = new ReturnObjFromRetrieve();
		ret = new ReturnObjFromRetrieve();
		CatalogNumberDesc = "No Catalogs Selected";
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
%>
