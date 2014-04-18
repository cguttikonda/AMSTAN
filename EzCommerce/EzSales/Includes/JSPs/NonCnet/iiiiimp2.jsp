<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<%
	/*ReturnObjFromRetrieve retCat=null;
	int retCatCnt = 0;

		
	EzCatalogParams ezcpparams = new ezc.ezparam.EzCatalogParams(); 
	EzCustomerItemCatParams cnetParams=new EzCustomerItemCatParams();

	ezcpparams.setType("GET_PRDS_BY_CATEGORY");
	cnetParams.setExt1("5");
	cnetParams.setExt2("5");
	cnetParams.setQuery("and EMM_MANUFACTURER = 'man12' ");
	cnetParams.setCategoryID("special");
	
	ezcpparams.setLocalStore("Y");
	ezcpparams.setObject(cnetParams);
	Session.prepareParams(ezcpparams);
	
	retCat = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(ezcpparams);
	out.println("retCat>>>>"+retCat.toEzcString());
	
	
	
	ReturnObjFromRetrieve retCat=null;
	int retCatCnt = 0,itemsCnt=0;


	EzCatalogParams ezcpparams = new ezc.ezparam.EzCatalogParams(); 
	EzCustomerItemCatParams cnetParams=new EzCustomerItemCatParams();

	ezcpparams.setType("GET_PRDS_COUNT_BY_CATEGORY");
	
	//cnetParams.setQuery("and EMM_MANUFACTURER = 'man12' ");
	cnetParams.setQuery("");
	cnetParams.setCategoryID("test");

	ezcpparams.setLocalStore("Y");
	ezcpparams.setObject(cnetParams);
	Session.prepareParams(ezcpparams);

	retCat = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(ezcpparams);
	out.println("retCat>>>>"+retCat.toEzcString());
	
	
	
	ReturnObjFromRetrieve retCat=null;
	int retCatCnt = 0,itemsCnt=0;


	EzCatalogParams ezcpparams = new ezc.ezparam.EzCatalogParams(); 
	EzCustomerItemCatParams cnetParams=new EzCustomerItemCatParams();

	ezcpparams.setType("GET_PRDS_CATEGORY");

	cnetParams.setQuery("and EMM_MANUFACTURER = 'man12' and (MM.EMM_NO like '%234%' or MD.EMD_DESC like '%we%')");	
	//cnetParams.setQuery("");
	cnetParams.setCategoryID("special");

	ezcpparams.setLocalStore("Y");
	ezcpparams.setObject(cnetParams);
	Session.prepareParams(ezcpparams);

	retCat = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(ezcpparams);
	out.println("retCat>>>>"+retCat.toEzcString());
	
	
	ReturnObjFromRetrieve retCat=null;
	int retCatCnt = 0,itemsCnt=0;


	EzCatalogParams ezcpparams = new ezc.ezparam.EzCatalogParams(); 
	EzCustomerItemCatParams cnetParams=new EzCustomerItemCatParams();

	ezcpparams.setType("GET_PRDS_CAT_ATTR_ATTRVAL");

	cnetParams.setQuery("and EMM_MANUFACTURER = 'man12'");	
	//cnetParams.setQuery("");
	cnetParams.setCategoryID("special");

	ezcpparams.setLocalStore("Y");
	ezcpparams.setObject(cnetParams);
	Session.prepareParams(ezcpparams);

	retCat = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(ezcpparams);
	out.println("retCat>>>>"+retCat.toEzcString());*/
	
	
	EzCatalogParams ezcpparams = new ezc.ezparam.EzCatalogParams(); 
	EzCustomerItemCatParams cnetParams=new EzCustomerItemCatParams();


	ezcpparams.setType("NONCNET_GET_DIGITALCONTENT_PROD");
	cnetParams.setProdID("'123456','123457','123458','123459'");
	cnetParams.setQuery("");			
	ezcpparams.setObject(cnetParams);
	ezcpparams.setLocalStore("Y");
	Session.prepareParams(ezcpparams);
	ReturnObjFromRetrieve imgRet = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(ezcpparams);
	out.println("imgRet>>>>"+imgRet.toEzcString());
	
	
	
	
	
%>


