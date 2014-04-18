<%@ include file="../Includes/AdminConfig.jsp"%>

<%!
// Start Declarations

//End Declarations
%>

// Key Variables
ReturnObjFromRetrieve ret = null;

<%@ page import = "ezc.ezparam.EzDescStructure" %>
<%@ page import = "ezc.ezparam.EzUserStructure" %>
<%@ page import = "ezc.ezadmin.EzSystemConfig" %>

//Get All Catalog Areas
//Get All Languages
//Get All Currencies
//Get All Master Authorizations
//Get Catalog Description
//Get Product Groups for the Catalog Number
//Get All Users


<%@ include file="../Includes/CatalogArea.jsp"%>
<%@ include file="../Includes/Defaults.jsp"%>

<%@ include file="../Includes/Systems.jsp"%>

<%@ include file="../Includes/Language.jsp"%>
<%@ include file="../Includes/Currency.jsp"%>

<%@ include file="../Includes/ServerFunctions.jsp"%>

<%@ include file="../../Includes/AdminConfig.jsp"%>
<%@ include file="../Includes/AdminConfig.jsp"%>
<%@ include file="../Includes/AdminBean.jsp"%>
<%@ include file="../Includes/BusinessPartner.jsp"%>
<%@ include file="../Includes/AdminUser.jsp"%>
<%@ include file="../Includes/AdminCatalog.jsp"%>

<%@ page import = "ezc.ezcommon.EzGlobalConfig" %>
<%@ page import = "ezc.ezparam.EzKeyValueStructure" %>
<%@ page import = "ezc.ezparam.EzBussPartnerInfoStructure" %>
<%@ page import = "ezc.ezsap.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezcsm.EzUser" %>
<%@ page import = "ezc.ezsap.RsparamsTable" %>
<%@ page import = "ezc.ezsap.RsparamsTableRow" %>


//List Boxes in the JSP

<%@ include file="../Includes/ListBox/LBCatalog.jsp"%>

<%@ include file="../Includes/ListBox/LBCatalogArea.jsp"%>

<%@ include file="../Includes/ListBox/LBUser.jsp"%>

<%@ include file="../Includes/ListBox/LBSystem.jsp"%>





try{

}catch(ezc.ezcommon.EzNoAuthException e){
	response.sendRedirect("../JSPs/ezLoginError.jsp");
	String errMessage = e.getMessage();
}


