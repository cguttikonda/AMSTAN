<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>

<jsp:useBean id="ezsc" class="ezc.client.EzSystemConfigManager" scope="page">
</jsp:useBean>

<%
   //Following include will bring sales areas and lang list
%>   
   <%@ include file="iListSalesArea&Lang.jsp" %>
<%
// Key Variables : Globals in the page
ReturnObjFromRetrieve ret = null;

if(numCatArea > 0)
{

	//Get System Number from the list box
	sys_key = request.getParameter("SystemKey");
	//Get Language from the list box
	lang = request.getParameter("Language");

	if(sys_key!=null && !"sel".equals(sys_key))
	{
		EzCatalogParams catalogParams = new EzCatalogParams();
		Session.prepareParams(catalogParams);
		catalogParams.setSysKey(sys_key);
		catalogParams.setLanguage("EN");
		ret = (ReturnObjFromRetrieve)catalogObj.getProductGroups (catalogParams);
		ret.check();
	}

}//end if
%>
