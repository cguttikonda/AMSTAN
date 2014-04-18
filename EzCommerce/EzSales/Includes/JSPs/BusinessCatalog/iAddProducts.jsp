<%@ page import="ezc.ezparam.*,java.util.*"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%
	String skey=(String) session.getValue("SalesAreaCode");
	String FavGroup =  request.getParameter("FavGroup");
	String pGroupDesc =request.getParameter("GroupDesc");
	
	ReturnObjFromRetrieve retpro = null,retpro1=null,retcat=null;	
	int retproCount=0;
	EzCatalogParams ezcpparams = new EzCatalogParams();
	
	/*
	ezcpparams.setLanguage("EN");
	ezcpparams.setCatalogNumber((String) session.getValue("CatalogCode"));
	ezcpparams.setSysKey(skey);
	Session.prepareParams(ezcpparams);
	retpro = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogSelected(ezcpparams);
	int retproCount=retpro.getRowCount();
	*/
		
	ezcpparams.setLanguage("EN");
	Session.prepareParams(ezcpparams);
	retpro = (ReturnObjFromRetrieve)EzCatalogManager.getCatalogList(ezcpparams);
	retpro.check();

	if(retpro!=null){
		retproCount= retpro.getRowCount();
	}
       
%>
