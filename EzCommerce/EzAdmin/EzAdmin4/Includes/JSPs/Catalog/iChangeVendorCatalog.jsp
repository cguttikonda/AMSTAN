<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>
<jsp:useBean id="ezsc" class="ezc.client.EzSystemConfigManager" scope="page">
</jsp:useBean>


<%
// Key Variables
ReturnObjFromRetrieve retpurarea = null;
ReturnObjFromRetrieve retcatdesc = null;
ReturnObjFromRetrieve retcatarea = null;  //Added by Venkat on 3/13/2001

// System Configuration Class
//EzSystemConfig ezsc = new EzSystemConfig();
EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
sparams.setObject(snkparams);
Session.prepareParams(sparams);

String catNum = request.getParameter("catNum");
String catDesc = "";
if(catNum != null){
	EzCatalogParams catalogParams = new EzCatalogParams();
	Session.prepareParams(catalogParams);
	catalogParams.setCatalogNumber(catNum);
	catalogParams.setLanguage("EN");
	retcatdesc = (ReturnObjFromRetrieve)catalogObj.getCatalogNumberDesc(catalogParams);
	retcatdesc.check();
	//retcatdesc = AdminObject.getCatalogNumberDesc(servlet, catNum);
	//catdesc = AdminObject.getCatalogNumberDesc(servlet, catalog_number);
	catDesc = (String)(retcatdesc.getFieldValue(0,CATALOG_DESC));	
      
      //Added on 3/13/2001 by Venkat
        EzCatalogParams catAreaParams = new EzCatalogParams();
        catAreaParams.setLanguage("EN");
	  catAreaParams.setCatalogNumber(catNum); 
        Session.prepareParams(catAreaParams);
	  retcatarea = (ReturnObjFromRetrieve)catalogObj.getCatalogAreas(catAreaParams);
	  retcatarea.check();
      //Venkats changes end here
}

// Get List Of Purchase Areas
//retpurarea = (ReturnObjFromRetrieve)ezsc.getSystemKeyDesc(sparams);
retpurarea = (ReturnObjFromRetrieve)ezsc.getPurchaseAreas(sparams);
retpurarea.check();


//Number of purchase areas
int purAreaRows = retpurarea.getRowCount();
%>