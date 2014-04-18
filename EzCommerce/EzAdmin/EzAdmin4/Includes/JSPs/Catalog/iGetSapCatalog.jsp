<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<jsp:useBean id="ezut" class="ezc.client.EzUtilityManager" scope="page"></jsp:useBean>
<%

	ReturnObjFromRetrieve ret = null;
	String Sys_Key = request.getParameter("SystemKey");
	String syncInd = "G";

	EzCatalogParams catalogParams = new EzCatalogParams();
	catalogParams.setSysKey(Sys_Key);
	catalogParams.setIndicator(syncInd);
	//catalogParams.setConnectionType("IBM");
	catalogParams.setLanguage("EN");
	Session.prepareParams(catalogParams);
	

	ret = (ReturnObjFromRetrieve)catalogObj.getSyncHierarchies(catalogParams);
	
	//ezc.ezcommon.EzLog4j.log(ret.toEzcString(),"D");

	String[] sortFields = {"EPG_NO"};
	ret.sort(sortFields,true);
	
%>
