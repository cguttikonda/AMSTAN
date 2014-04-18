<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.ezmisc.params.*" %>

<%
	
	EzcParams prodParamsRepMisc = new EzcParams(false);
	EziMiscParams prodRepParams = new EziMiscParams();

	ReturnObjFromRetrieve prodReplaceRetObj = null;

	prodRepParams.setIdenKey("MISC_SELECT");
	String queryRep="select EZP_PRODUCT_CODE,EZP_DISCONTINUED,EZP_DISCONTINUE_DATE,EZP_REPLACES_ITEM FROM ezc_products where EZP_PRODUCT_CODE='"+prodCode+"'";

	prodRepParams.setQuery(queryRep);

	prodParamsRepMisc.setLocalStore("Y");
	prodParamsRepMisc.setObject(prodRepParams);
	Session.prepareParams(prodParamsRepMisc);	

	try
	{
		prodReplaceRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsRepMisc);
	}
	catch(Exception e){}
	
	
	out.println("prodReplaceRetObj:::"+prodReplaceRetObj.toEzcString());
	
	String disProd  = "",repProd = "";
	String replaced = "N",discon = "";
	
	if(prodReplaceRetObj!=null && prodReplaceRetObj.getRowCount()>0)
	{
		disProd = prodReplaceRetObj.getFiledValueString(0,"EZP_DISCONTINUED");
		repProd = prodReplaceRetObj.getFiledValueString(0,"EZP_REPLACES_ITEM");
	}
	
	if(!prodCode.equals(repProd) && repProd!=null && !"null".equals(repProd) && !"".equals(repProd)) 
		replaced = "Y";
		
%>