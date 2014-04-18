<%@ page import ="ezc.ezparam.*" %>
<%@ include file="../../Lib/PurchaseBean.jsp"%>
<%@ page import="ezc.client.*" %>


<%
	String type = request.getParameter("type");
	EzPurchaseManager PoManager=new EzPurchaseManager();

	EzPurchHdrXML hdrXML =null;
	EzPSIInputParameters iparams = new EzPSIInputParameters();
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	ezc.ezpurchase.params.EziPurchaseInputParams testParams = new ezc.ezpurchase.params.EziPurchaseInputParams();
	
	///iparams.setWithDefaults("N");
	testParams.setDocType("AN");
	testParams.setSelectionFlag("A");
	newParams.createContainer();
	newParams.setObject(iparams);
	newParams.setObject(testParams);
	Session.prepareParams(newParams);

	if(type.equalsIgnoreCase("New")){
		hdrXML = (EzPurchHdrXML)PoManager.ezGetNewPurchaseOrderList(newParams);
	}
	else{
		hdrXML = (EzPurchHdrXML)PoManager.ezGetAllPurchaseOrderList(newParams);
		ezc.ezcommon.EzLog4j.log("==hdrXML ilistrfq "+hdrXML.toEzcString(),"I");
	}

	String[] sortKey = {"ORDER"};
	hdrXML.sort( sortKey, false );//false for descending

	int Count = hdrXML.getRowCount();
	
   
%>

