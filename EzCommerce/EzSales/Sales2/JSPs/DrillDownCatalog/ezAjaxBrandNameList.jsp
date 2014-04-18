<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>

<%

	EzCatalogParams ezcpparams = new EzCatalogParams();
	ReturnObjFromRetrieve retcat = null;
	ReturnObjFromRetrieve retPerCat = null;
	int retCatCount=0;

	Session.prepareParams(ezcpparams);
	ezcpparams.setLanguage("EN");
	retcat = (ReturnObjFromRetrieve)EzCatalogManager.getCatalogList(ezcpparams);
	retcat.check();

	if(retcat!=null){
	retCatCount= retcat.getRowCount();
	}
	
	
	
%>