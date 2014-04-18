<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/AdminCatalog.jsp"%>

<%
	ReturnObjFromRetrieve retcat = null;
	int retCatCount =0;
	String cat_num=null;

	EzCatalogParams catalogParams = new EzCatalogParams();
	Session.prepareParams(catalogParams);
	catalogParams.setLanguage("EN");
	retcat = (ReturnObjFromRetrieve)catalogObj.getCatalogList(catalogParams);
	retcat.check();


	if(retcat!=null){
		retCatCount= retcat.getRowCount();
	}
       
       ezc.ezcommon.EzLog4j log4j = new  ezc.ezcommon.EzLog4j();

       log4j.log("ret Cat -->"+retcat.toEzcString(),"I");
       
%>