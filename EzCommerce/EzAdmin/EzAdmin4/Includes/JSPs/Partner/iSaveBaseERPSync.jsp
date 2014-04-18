<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%
// Get the input parameters
String BusPartner = null;
String SysKey = null;

String CheckBox = null; 
String pCheckBox = null; 

String Addr1 = null;
String City = null;
String State = null;
String Zip = null;

String pAddr1 = null;
String pCity = null;
String pState = null;
String pZip = null;

String SoldTo = null;
String pSoldTo = null;String CustName = null;
String pCustName = null;

String ERPSoldTo = null;
String pERPSoldTo = null;
String PartNum = null;
String pPartNum = null;
String PartFun = null;
String pPartFun = null;

int intBPCount = 0;
int intAddCount = 0;BusPartner = request.getParameter("BusPartner");	
SysKey = request.getParameter("SysKey");	
String strTcount =  request.getParameter("TotalCount");

String strBPCount =  request.getParameter("BPCount");
if(strBPCount != null){
	intBPCount = (new Integer(strBPCount)).intValue();  
}
String strAddCount =  request.getParameter("AddCount");
if(strAddCount != null){
	intAddCount = (new Integer(strAddCount)).intValue();  
}

// Structure for Customer
EzCustomerStructure custin = new EzCustomerStructure();

// Structure for Customer Address
EzCustomerAddrStructure in = new EzCustomerAddrStructure();


if ( strTcount != null ){
int TotalCount = (new Integer(strTcount)).intValue();  

for ( int i = 0  ; i < TotalCount; i++ ){

	for ( int j = 0  ; j < intBPCount; j++ ){

		ERPSoldTo = "ERPSoldTo"+i+"_"+j;
		PartNum = "PartNum"+i+"_"+j;
		PartFun = "PartFun"+i+"_"+j;
		pERPSoldTo = request.getParameter(ERPSoldTo);
		pPartNum = request.getParameter(PartNum);
		pPartFun = request.getParameter(PartFun);

		custin.setCustomerNo(pERPSoldTo);	
		custin.setSysKey(SysKey);	
		custin.setPartnerFunc(pPartFun);	
		custin.setPartnerNo(pPartNum);	
		custin.setErpSoldTo(pERPSoldTo);	
		custin.setBussPartner(BusPartner);	
		custin.setDelFlag("N");	

		// Customer Synchronization
		EzcVendorParams vparams = new EzcVendorParams();
		EzVendorParams  vnkparams = new EzVendorParams();
		vnkparams.setLanguage("EN");
		vnkparams.setEzCustomerStructure(custin);
		vparams.setObject(vnkparams);
		Session.prepareParams(vparams);
		VendorManager.SaveEzcCustomer(vparams); 
		//AdminObject.SaveEzcCustomer(servlet, custin); 

	}//End for BPCount

	for ( int k = 0  ; k < intAddCount; k++ ){

		CheckBox = "CheckBox"+i+"_"+k;	
		SoldTo = "SoldTo"+i+"_"+k;
		CustName = "CustName"+i+"_"+k;
		Addr1 = "Addr1"+i+"_"+k;
		City = "City"+i+"_"+k;
		State = "State"+i+"_"+k;
		Zip = "Zip"+i+"_"+k;

		pCheckBox = request.getParameter(CheckBox);
		if ( pCheckBox != null ){
			// Get the parameters
			pSoldTo = request.getParameter(SoldTo);
			pCustName = request.getParameter(CustName);
			pAddr1 = request.getParameter(Addr1);pCity = request.getParameter(City);
			pState = request.getParameter(State);
			pZip = request.getParameter(Zip);

			in.setCustomerNo(pSoldTo);
			in.setLanguage("EN");
			in.setRefNo(10);
			in.setCompanyName(pCustName);
			in.setName(pCustName);
			in.setAddr1(pAddr1);
			in.setCity(pCity);
			in.setState(pState);
			in.setPin(pZip);
			in.setIsBussPartner("N");
			in.setPhone(" ");
			in.setWebAddr(" ");
			in.setEmail(" ");
			in.setAddr2(" ");
			in.setCountry(" ");
			in.setShipAddr1(pAddr1);
			in.setShipAddr2(" ");
			in.setShipCity(pCity);
			in.setShipState(pState);
			in.setShipCountry(" ");
			in.setShipPin(pZip);
			in.setDelFlag(" ");
		

			// Address Synchronization
		EzcVendorParams vparams1 = new EzcVendorParams(false);
		EzVendorParams  vnkparams1 = new EzVendorParams();
		vnkparams1.setLanguage("EN");
		vnkparams1.setEzCustomerAddrStructure(in);
		vparams1.setObject(vnkparams1);
		Session.prepareParams(vparams1);
		VendorManager.SaveEzcCustomerAddr(vparams1); 
		//AdminObject.SaveEzcCustomerAddr(servlet, in); 
	}//End if
	}//End for AddCount
}//End For
}// End if TotalCount not null

response.sendRedirect("../Partner/ezBaseERPSync.jsp");
%>