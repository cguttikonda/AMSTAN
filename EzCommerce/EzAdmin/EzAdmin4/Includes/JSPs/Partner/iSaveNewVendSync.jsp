<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%
// Get the input parameters
String BusPartner = null;
String SysNum = null;
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
String pSoldTo = null;
String CustName = null;
String pCustName = null;

String ERPSoldTo = null;
String pERPSoldTo = null;
String PartNum = null;
String pPartNum = null;
String PartFun = null;
String pPartFun = null;
String PEzcCustomer = null;
String pEzcCustomer = null;

int intBPCount = 0;
int intAddCount = 0;

BusPartner = request.getParameter("BusPartner");	
SysNum = request.getParameter("SysNum");
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

//Structure for Customer
EzCustomerStructure custin = new EzCustomerStructure();

//Structure for Customer Address
EzCustomerAddrStructure in = new EzCustomerAddrStructure();

if ( strTcount != null ){
int TotalCount = (new Integer(strTcount)).intValue();  

for ( int i = 0  ; i < TotalCount; i++ ){


		ERPSoldTo = "ERPSoldTo_"+i;
		PartNum = "PartNum_"+i;
		PartFun = "PartFun_"+i;

		pERPSoldTo = request.getParameter(ERPSoldTo);
		pPartNum = request.getParameter(PartNum);
		pPartFun = request.getParameter(PartFun);

		//custin.setCustomerNo(pERPSoldTo);	
		custin.setCustomerNo(pEzcCustomer);	
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
		ReturnObjFromRetrieve retSBPSave = (ReturnObjFromRetrieve) VendorManager.SaveEzcCustomer(vparams); 

		String genNewEzc = retSBPSave.getFieldValueString(0,"EZC_NUMBER");	

		CheckBox = "CheckBox_"+i;	
		SoldTo = "SoldTo_"+i;
		CustName = "CustName_"+i;
		Addr1 = "Addr1_"+i;
		City = "City_"+i;
		State = "State_"+i;
		Zip = "Zip_"+i;

			// Get the parameters
			pSoldTo = request.getParameter(SoldTo);
			pCustName = request.getParameter(CustName);
			pAddr1 = request.getParameter(Addr1);
			pCity = request.getParameter(City);
			pState = request.getParameter(State);
			pZip = request.getParameter(Zip);

			//in.setCustomerNo(pSoldTo);
			in.setCustomerNo(genNewEzc);
			in.setLanguage("EN");
			in.setRefNo(10);
			in.setCompanyName(" ");
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
			in.setShipAddr1(" ");
			in.setShipAddr2(" ");
			in.setShipCity(" ");
			in.setShipState(" ");
			in.setShipCountry(" ");
			in.setShipPin(" ");
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

}//End For
}// End if TotalCount not null

//response.sendRedirect("../Partner/ezNewCustSync.jsp");
response.sendRedirect("../Partner/ezNewVendSync.jsp");
%>