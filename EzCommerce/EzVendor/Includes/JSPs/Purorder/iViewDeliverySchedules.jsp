<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>

<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page"></jsp:useBean>

<%@page import="ezc.ezparam.*"%>

<%

	String userRole	= (String) session.getValue("USERROLE");
        String poNum = request.getParameter("PurchaseOrder");
        
        String sysKey = request.getParameter("poSysKey");
        String show  = request.getParameter("show");
        String vendor = request.getParameter("vendorNo");
        String purGrp 	= "";
	String cCode  	= "";
	
	EzcParams ezcparams= new EzcParams(false);

	EzPSIInputParameters iparams = new EzPSIInputParameters();
	
	if("PH".equals(userRole) && "ALL".equals(show))
	{
		java.util.Hashtable  purGroupsHash = (Hashtable) session.getValue("PURGRPSHASH");//REFFROM: iloginbanner.jsp
		java.util.Hashtable  ccHash	   = (Hashtable) session.getValue("CCODEHASH");  //REFFROM: iloginbanner.jsp
		
		purGrp = (String)purGroupsHash.get(sysKey);
		cCode  = (String)ccHash.get(sysKey) ;
		
		iparams.setWithDefaults("N");
		iparams.setCompanyCode(cCode);
		iparams.setpurchaseGroup(purGrp);
		
	}	
	iparams.setCostCenter(vendor);
	iparams.setOrderNumber(poNum);
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	ezc.ezpurchase.params.EziPurOrderDetailsParams testparams = new ezc.ezpurchase.params.EziPurOrderDetailsParams();
	newParams.createContainer();
	newParams.setObject(iparams);
	newParams.setObject(testparams);
	Session.prepareParams(newParams);
	ReturnObjFromRetrieve retObj =  (ReturnObjFromRetrieve)PoManager.ezPurchaseOrderDeliverySchedule(newParams);
        
        int Count = retObj.getRowCount();
%>