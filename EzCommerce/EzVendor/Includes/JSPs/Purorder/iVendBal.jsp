<%@ page import ="ezc.ezparam.*"%>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ include file="../../../Includes/Lib/Address.jsp"%>
<%@ page import="ezc.client.*" %>

<jsp:useBean id="VendManager" class ="ezc.ezvendor.client.EzVendorManager" scope="page">
</jsp:useBean>

<jsp:useBean id="OrderedDictionary" class="ezc.record.util.EzOrderedDictionary" scope = "session">
</jsp:useBean>


<%
	final String ORDBAL = "ORDERBALANCE";
	final String INVBAL = "INVOICEBALANCE";
	final String ORDER = "PURCHASEORDER";   

	ReturnObjFromRetrieve ret = null;
	ret = (ReturnObjFromRetrieve)OrderedDictionary.get("VENDORADDRESS");
	ReturnObjFromRetrieve retcatarea = null;
	ret = (ReturnObjFromRetrieve)OrderedDictionary.get("VENDORADDRESS");

	ezc.client.EzcPurchaseUtilManager ezUtil = new ezc.client.EzcPurchaseUtilManager(Session);

	retcatarea = (ReturnObjFromRetrieve) ezUtil.getUserPurAreas();

	EzSupplBalance supplbal = null;
	EzVendorParams vendparams = null;

	vendparams = new EzVendorParams();
	String dt = request.getParameter("todate");

	if(dt == null)
	{
		dt = new ezc.ezutil.FormatDate().getStringFromDate(new Date(),".", ezc.ezutil.FormatDate.DDMMYYYY);
	}
	
	int yr = (new Integer(dt.substring(6))).intValue();
	int mm = (new Integer(dt.substring(3,5))).intValue();
	int dd = (new Integer(dt.substring(0,2))).intValue();


	java.util.GregorianCalendar gc = new java.util.GregorianCalendar(yr,mm,dd);

	Date dt1 =  new Date(2001,10,24);

	vendparams.setToDate(dt1);

	supplbal = new EzSupplBalance();
	ezc.ezparam.EzcVendorParams newParams = new ezc.ezparam.EzcVendorParams();

	newParams.createContainer();
	newParams.setObject(vendparams);
	Session.prepareParams(newParams);

	supplbal = (EzSupplBalance)VendManager.getVendorBalance(newParams);
		
	
	String ordToCompName="",addrLine2="",addrLine3="",ordToCity="",ordToState="",ordToCountry="",ordTozip="",ordECANum="";
		String payToCompName="",payaddrLine2="",payaddrLine3="",payToCity="",payToState="",payToCountry="",payToZip="",payECANum="";

	boolean hasOrderTo = false,hasPayTo = false,ordToisPayTo=false;

	String defOrderTo 	= ezUtil.getUserDefOrdAddr();
	String defCatArea 	= ezUtil.getDefaultPurArea();
	String defPayTo 	= ezUtil.getUserDefPayTo();
	String defErpVendor 	= ezUtil.getUserDefErpVendor();	
	String defEzcVendor 	= ezUtil.getUserDefEzcVendor();
	String defPurArea 	= ezUtil.getDefaultPurArea();
	

	String defPurchaseAreaDescription=null;
	
	if(defCatArea!=null){
		defCatArea=defCatArea.trim();
		for(int j=0;j<retcatarea.getRowCount();j++)
		{	
			if(defCatArea.equals(retcatarea.getFieldValueString(j,"ESKD_SYS_KEY").trim()))
			{
				defPurchaseAreaDescription=retcatarea.getFieldValueString(j,"ESKD_SYS_KEY_DESC");
				if ("Bulk Eng".equals(defPurchaseAreaDescription.trim()))
					defPurchaseAreaDescription="Bulk Actives";
		
			}
		}
	}
	
	//out.println("PurArea************:"+defPurchaseAreaDescription);

	ReturnObjFromRetrieve retsoldto = (ReturnObjFromRetrieve) ezUtil.getUserVendors(defPurArea);	
	int vendCount = retsoldto.getRowCount();

	//out.println("+++++++++++++++ AFTER GETTING VENDOR COUNT ++++++");	
	ReturnObjFromRetrieve listOfPayTos = (ReturnObjFromRetrieve) ezUtil.getListOfPayTos(defCatArea);
	ReturnObjFromRetrieve listOfOrderTos = (ReturnObjFromRetrieve) ezUtil.getListOfOrdAddr(defCatArea);
	int orderToCount = -1,payToCount = -1;

        //out.println("defPayTodefPayTo>>"+defPayTo);
        //out.println("listOfPayToslistOfPayTos>>"+listOfPayTos.toEzcString());
        
	if (listOfOrderTos != null)
		orderToCount = listOfOrderTos.getRowCount();
	if (listOfPayTos != null)
		payToCount = listOfPayTos.getRowCount();

	if ( defOrderTo != null) defOrderTo.trim();
	if ( defPayTo != null) defPayTo.trim();		

	if ( defPayTo != null && listOfPayTos.find("EC_PARTNER_NO",defPayTo) ){
		hasPayTo = true;
		int rId = listOfPayTos.getRowId("EC_PARTNER_NO",defPayTo);
		payToCompName = listOfPayTos.getFieldValueString(rId,EC_COMPANY_NAME_X).trim();

		if (payToCompName.equalsIgnoreCase("null")) payToCompName="";
		payaddrLine2 = listOfPayTos.getFieldValueString(rId,EC_ADDR_1_X).trim();
		if (payaddrLine2.equalsIgnoreCase("null")) payaddrLine2="";
		payaddrLine3 = listOfPayTos.getFieldValueString(rId,EC_ADDR_2_X).trim();
		if (payaddrLine3.equalsIgnoreCase("null")) payaddrLine3 = "";
		payToCity = listOfPayTos.getFieldValueString(rId,EC_CITY_X).trim();
		if (payToCity.equalsIgnoreCase("null")) payToCity = "";
		payToState = listOfPayTos.getFieldValueString(rId,EC_STATE_X).trim();
		if (payToState.equalsIgnoreCase("null")) payToState = "";
		payToZip = listOfPayTos.getFieldValueString(rId,EC_PIN_X).trim();
		if (payToZip.equalsIgnoreCase("null")) payToZip = "";
		payToCountry = listOfPayTos.getFieldValueString(rId,EC_COUNTRY_X).toUpperCase().trim();
		if (payToCountry.equalsIgnoreCase("null")) payToCountry = "";
		payECANum = listOfPayTos.getFieldValueString(rId,EC_NO_X).trim();
	}

	if ( defOrderTo != null && listOfOrderTos.find("EC_PARTNER_NO",defOrderTo) )	{
		hasOrderTo = true;
		int rId = listOfOrderTos.getRowId("EC_PARTNER_NO",defOrderTo);
		ordToCompName = listOfOrderTos.getFieldValueString(rId,EC_COMPANY_NAME_X).trim();
		if (ordToCompName.equalsIgnoreCase("null")) ordToCompName="";
		addrLine2 = listOfOrderTos.getFieldValueString(rId,EC_ADDR_1_X).trim();
		if (addrLine2.equalsIgnoreCase("null")) addrLine2="";
		addrLine3 = listOfOrderTos.getFieldValueString(rId,EC_ADDR_2_X).trim();
		if ( addrLine3 == null || addrLine3.equals("null") ) addrLine3 = "";
		ordToCity = listOfOrderTos.getFieldValueString(rId,EC_CITY_X).trim();
		if (ordToCity.equalsIgnoreCase("null")) ordToCity="";
		ordToState = listOfOrderTos.getFieldValueString(rId,EC_STATE_X).trim();
		if (ordToState.equalsIgnoreCase("null")) ordToState="";
		ordTozip = listOfOrderTos.getFieldValueString(rId,EC_PIN_X).trim();
		if (ordTozip.equalsIgnoreCase("null")) ordTozip="";
		ordToCountry = listOfOrderTos.getFieldValueString(rId,EC_COUNTRY_X).toUpperCase().trim();
		if (ordToCountry.equalsIgnoreCase("null")) ordToCountry="";
		ordECANum = listOfOrderTos.getFieldValueString(rId,EC_NO_X).trim();
	}

	if (ordECANum.equals(payECANum)) ordToisPayTo = true;

%>

