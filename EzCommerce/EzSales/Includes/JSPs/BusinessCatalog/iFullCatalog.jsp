<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"/>



<%
   // Key Variables
   ReturnObjFromRetrieve ret 	= null;
   String userId		= Session.getUserId();
   String skey			= (String) session.getValue("SalesAreaCode");
   String catalogCode		= (String) session.getValue("CatalogCode");

   EzCatalogParams ezcpparams = new EzCatalogParams();
   ezcpparams.setLanguage("EN");
   ezcpparams.setSysKey(skey);
   ezcpparams.setCatalogNumber(catalogCode);
   Session.prepareParams(ezcpparams);
   ret = (ReturnObjFromRetrieve)EzCatalogManager.readCatalogSelected(ezcpparams);
   int retCount= 0;
   if(ret!=null) retCount= ret.getRowCount();
 
 /*
  // ret = (ReturnObjFromRetrieve) EzCatalogManager.getProductGroups(ezcpparams);
  // ret = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogFirstLevel(ezcpparams);
  // ReturnObjFromRetrieve catdesc = (ReturnObjFromRetrieve)EzCatalogManager.getCatalogNumberDesc(ezcpparams);
  //ReturnObjFromRetrieve catdesc = (ReturnObjFromRetrieve)EzCatalogManager.getCatalogList(ezcpparams);
  // catdesc.check();
 */
 
  

	 ReturnObjFromRetrieve retcat=null;
	 EzcUserParams uparams= new EzcUserParams();
	 uparams.setUserId(userId);
	 EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	 ezcUserNKParams.setLanguage("EN");
	 uparams.createContainer();
	 uparams.setObject(ezcUserNKParams);
	 Session.prepareParams(uparams);
	 // Get User Catalog Number
	 retcat = (ReturnObjFromRetrieve)UserManager.getUserCatalogs(uparams);
	 String CatalogDescription ="Catalog";
	 
	 if( retcat != null) CatalogDescription = retcat.getFieldValueString(0,"EPC_NAME");
	 if(CatalogDescription== null) CatalogDescription = "Catalog";
  

 //Code change ends here
%>
