<%@ page import = "ezc.shopping.cart.client.*" %>
<%@ page import = "ezc.shopping.cart.params.*" %>
<%@ page import = "ezc.ezvendor.csb.*" %>
<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.ezparam.*,java.util.*,java.text.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import = "ezc.ezalerts.params.*" %>
<%@ page import = "ezc.sales.params.*"%>
<%@ page import = "ezc.sales.local.params.*"%>
<%@ page import = "ezc.ezdispatch.params.*"%>

<%@ include file="../../../Includes/Lib/ezAddress.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>

<jsp:useBean id="CustomerManager" class="ezc.ezcustomer.client.EzCustomerManager" scope = "page"/>
<jsp:useBean id="Manager" class="ezc.sales.client.EzSalesOrderManager"/>
<jsp:useBean id="DispatchInfoManager" class="ezc.ezdispatch.client.EzDispatchInfoManager"/>
<jsp:useBean id="AlertManager" class="ezc.ezalerts.client.EzAlertsManager" />

<%

	if(session.getValue("customers") != null)
		session.removeValue("customers");
	if(session.getValue("ViewStockMonthYear")!=null)
		session.removeValue("ViewStockMonthYear");
	if(session.getValue("StockReturnObject")!=null)
		session.removeValue("StockReturnObject");		
	if(session.getValue("InvoiceReturnObject")!=null)
		session.removeValue("InvoiceReturnObject");
		

/* ------------------ Get Persistent Cart  -----------------
	EzShoppingCartManager scManager = new EzShoppingCartManager(Session);
	EzcShoppingCartParams scParams = new EzcShoppingCartParams();
	EziShoppingCartParams eziParams = new EziShoppingCartParams();
	scParams.setObject(eziParams);

	Session.prepareParams(scParams);
	try{
	scManager.getPersistentCartToLocalCart(scParams);
}
catch(Exception e){}
 ----------------------------------------------------------*/

		
/*
	String responseURL = "";
	System.out.println("\n\n\n++++++++++++++++>>>WELCOME + response = "+responseURL);
	String defShipTo,defBillTo;
	String shpToCompName="",addrLine2="",addrLine3="",shpToCity="",shpToState="",shpToCountry="",shpTozip="",shpECANum="";
	String billToCompName="",billaddrLine2="",billaddrLine3="",billToCity="",billToState="",billToCountry="",billToZip="",billECANum="";
	boolean hasShipTo = false,hasBillTo = false,shpToisBillTo=false,isFine=false;
	EzcUtilManager ezUtil = new EzcUtilManager(Session);

	defShipTo = ezUtil.getUserDefErpShipTo();
	defBillTo = ezUtil.getUserDefErpBillTo();
	
	ezc.ezutil.EzSystem.out.println("\n\n\n++++++++++++++++++++++++++>>>>defshpto"+defShipTo);
	ezc.ezutil.EzSystem.out.println("\n\n\n++++++++++++++++++++++++++>>>>defBillTo"+defBillTo);
	
	
	
	String defErpSoldTo = ezUtil.getUserDefErpSoldTo();
	String defEzcSoldTo = ezUtil.getUserDefEzcSoldTo();
	String defCatArea = ezUtil.getCurrSysKey();
	
	System.out.println("\n\n\n++++++++++++++++++++++++++++++++++++++>>>>defCatArea"+defCatArea);
	
	ReturnObjFromRetrieve listOfBillTos = (ReturnObjFromRetrieve) ezUtil.getListOfBillTos(defCatArea);
	ReturnObjFromRetrieve listOfShipTos = (ReturnObjFromRetrieve) ezUtil.getListOfShipTos(defCatArea);
	
	
	int shipToCount = -1,billToCount = -1;
	
	if (listOfShipTos != null) shipToCount = listOfShipTos.getRowCount();
	if (listOfBillTos != null) billToCount = listOfBillTos.getRowCount();

	System.out.println("\n\n\n++++++++++++++++++++++++++++++++++++++>>>>listOfBillTos"+billToCount);
	System.out.println("\n\n\n++++++++++++++++++++++++++++++++++++++>>>>listOfShipTos"+shipToCount);
	
	if ( defBillTo != null) 
		defBillTo.trim();
	else {
		if ( billToCount > 1 ){
				//response.sendRedirect("ezSelectBillTo.jsp?CatalogArea="+defCatArea);
				responseURL = "ezSelectBillTo.jsp?CatalogArea="+defCatArea;
		//	} else if (billToCount == 1) {
			//	defBillTo = listOfBillTos.getFieldValueString(0,"EC_PARTNER_NO");
			//	defBillTo = defBillTo.trim();
				ezUtil.setDefBillTo(defBillTo);
			//}
		}
	if ( defShipTo != null) 
		defShipTo.trim();
	else {
			if ( shipToCount > 1 ){
				//response.sendRedirect("ezSelectShipTo.jsp?CatalogArea="+defCatArea);
				responseURL = "ezSaveChangeSoldTo.jsp?CatalogArea="+defCatArea;
			} else if ( shipToCount == 1 ) {
				defShipTo = listOfShipTos.getFieldValueString(0,"EC_PARTNER_NO");
				defShipTo = defShipTo.trim();
				ezUtil.setDefShipToParty(defShipTo);
			}
		}*/
		
	// if (responseURL.length()>0) response.sendRedirect(responseURL);
	/**********************************************************************************************************************
	*	Suggestion in the next version. it would be better to have the html tags etc built for each cell rahter than have 
	*	too many CPU intensive if calls again in the ezWelcome page. 
	*																					- Sanjiv 21 June 2001
	**********************************************************************************************************************/
	
	/*System.out.println("HELLO WORLDd");
	if ( defBillTo != null && listOfBillTos!=null && listOfBillTos.find("EC_PARTNER_NO",defBillTo) ){
		//listOfBillTos.toEzcString();
		hasBillTo = true;
		int rId = listOfBillTos.getRowId("EC_PARTNER_NO",defBillTo);
		billECANum = listOfBillTos.getFieldValueString(rId,EC_NO_X).trim();
		billToCompName = listOfBillTos.getFieldValueString(rId,EC_COMPANY_NAME_X).trim();
		if (billToCompName.equalsIgnoreCase("null")) billToCompName="";
		billaddrLine2 = listOfBillTos.getFieldValueString(rId,EC_ADDR_1_X).trim();
		if (billaddrLine2.equalsIgnoreCase("null")) billaddrLine2="";
		billaddrLine3 = listOfBillTos.getFieldValueString(rId,EC_ADDR_2_X).trim();
		if (billaddrLine3.equalsIgnoreCase("null")) billaddrLine3 = "";
		billToCity = listOfBillTos.getFieldValueString(rId,EC_CITY_X).trim();
		if (billToCity.equalsIgnoreCase("null")) billToCity = "";
		billToState = listOfBillTos.getFieldValueString(rId,EC_STATE_X).trim();
		if (billToState.equalsIgnoreCase("null")) billToState = "";
		billToZip = listOfBillTos.getFieldValueString(rId,EC_PIN_X).trim();
		if (billToZip.equalsIgnoreCase("null")) billToZip = "";
		billToState = (billToState + " " + billToZip).trim();
		billToCountry = listOfBillTos.getFieldValueString(rId,EC_COUNTRY_X).toUpperCase().trim();
		if (billToCountry.equalsIgnoreCase("null")) billToCountry = "";		
	}

	if (defShipTo != null && listOfShipTos!=null && listOfShipTos.find("EC_PARTNER_NO",defShipTo) )	{
		//listOfShipTos.toEzcString();
		hasShipTo = true;
		int rId = listOfShipTos.getRowId("EC_PARTNER_NO",defShipTo);
		shpECANum = listOfShipTos.getFieldValueString(rId,"ECA_NO").trim();
		shpToCompName = listOfShipTos.getFieldValueString(rId,EC_COMPANY_NAME_X).trim();
		if (shpToCompName.equalsIgnoreCase("null")) shpToCompName="";
		addrLine2 = listOfShipTos.getFieldValueString(rId,EC_ADDR_1_X).trim();
		if (addrLine2.equalsIgnoreCase("null")) addrLine2="";
		addrLine3 = listOfShipTos.getFieldValueString(rId,EC_ADDR_2_X).trim();
		if ( addrLine3 == null || addrLine3.equals("null") ) addrLine3 = "";
		shpToCity = listOfShipTos.getFieldValueString(rId,EC_CITY_X).trim();
		if (shpToCity.equalsIgnoreCase("null")) shpToCity="";
		shpToState = listOfShipTos.getFieldValueString(rId,EC_STATE_X).trim();
		if (shpToState.equalsIgnoreCase("null")) shpToState="";
		shpTozip = listOfShipTos.getFieldValueString(rId,EC_PIN_X).trim();
		if (shpTozip.equalsIgnoreCase("null")) shpTozip="";
		shpToState = (shpToState + " " + shpTozip).trim();
		shpToCountry = listOfShipTos.getFieldValueString(rId,EC_COUNTRY_X).toUpperCase().trim();
		if (shpToCountry.equalsIgnoreCase("null")) shpToCountry="";
		if (defBillTo.equalsIgnoreCase(defShipTo))
			shpToisBillTo = true;
	}	
	if (shpECANum.equals(billECANum)) shpToisBillTo = true;*/

System.out.println("<********************************-------*******************************>");
%>
