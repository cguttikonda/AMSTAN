<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<%
	EzcParams mainParamsMisc= new EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();

	miscParams.setIdenKey("MISC_SELECT");
	String query="SELECT ECC_CATALOG_ID,ECC_CATEGORY_ID,ECD_DESC FROM EZC_CATALOG_CATEGORIES,EZC_CATEGORY_DESCRIPTION WHERE ECC_CATALOG_ID = '10010' AND ECC_CATEGORY_ID = ECD_CODE";
	//String query="SELECT  EC_CODE,ECD_DESC,EC_PARENT FROM EZC_CATEGORIES,EZC_CATEGORY_DESCRIPTION WHERE EC_PARENT = 'BATHFAUCACCESORIES' AND EC_CODE = ECD_CODE";
	//String query="select ECP_CATEGORY_CODE,ECP_PRODUCT_CODE,EZP_BRAND from EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS WHERE ECP_CATEGORY_CODE = 'BATHFAUCETS' AND ECP_PRODUCT_CODE = EZP_PRODUCT_CODE";
	
	miscParams.setQuery(query);

	mainParamsMisc.setLocalStore("Y");
	mainParamsMisc.setObject(miscParams);
	Session.prepareParams(mainParamsMisc);	

	try
	{		
		ReturnObjFromRetrieve retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
		out.println(retObjMisc.toEzcString());

	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}

%> 