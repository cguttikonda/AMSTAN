<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>

<%
// Key Variables
ReturnObjFromRetrieve retcat = null;

EzCatalogParams catalogParams = new EzCatalogParams();
Session.prepareParams(catalogParams);
catalogParams.setLanguage("EN");
retcat = (ReturnObjFromRetrieve)catalogObj.getCatalogList(catalogParams);
retcat.check();

String pChange = request.getParameter("pChange");
if(pChange == null)
	pChange = " ";

%>