<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>  
<%
	ReturnObjFromRetrieve retCat=null;
	int retCatCnt = 0;

	EzCatalogParams catalogParamsCRI = new ezc.ezparam.EzCatalogParams();  
	EzCustomerItemCatParams ecicCRI = new EzCustomerItemCatParams(); 

	catalogParamsCRI.setType("GET_CRI_CAT");
	ecicCRI.setExt1("");
	catalogParamsCRI.setLocalStore("Y");
	catalogParamsCRI.setObject(ecicCRI);
	Session.prepareParams(catalogParamsCRI);

	
	retCat = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(catalogParamsCRI);
	//out.println("retCat>>>>"+retCat.toEzcString());
	if(retCat!=null)
		retCatCnt = retCat.getRowCount();
	
%>