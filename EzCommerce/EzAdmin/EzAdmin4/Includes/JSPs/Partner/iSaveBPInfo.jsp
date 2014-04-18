



<%@ page import="ezc.ezadmin.busspartner.params.*" %>
<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>

<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>

<%

// Get the input parameters from the User Entry screen
String Company = request.getParameter("Company");
String BPDescription = request.getParameter("BPDescription");
String ContactName = request.getParameter("ContactName");
String Email = request.getParameter("Email");
String WebAddress = request.getParameter("WebAddress");
String Address1 = request.getParameter("Address1");
String Address2 = request.getParameter("Address2");
String City = request.getParameter("City");
String State = request.getParameter("State");
if((State == null)||("null".equals(State)))
	State=" ";
String Zip = request.getParameter("Zip");
String Country = request.getParameter("Country");
if((Country == null)||("null".equals(Country)))
	Country=" ";

String Phone11 = request.getParameter("Phone11");
String Phone12 = request.getParameter("Phone12");
String Phone13 = request.getParameter("Phone13");
String Phone1  = Phone11 + Phone12 + Phone13;

String Phone21 = request.getParameter("Phone21");
String Phone22 = request.getParameter("Phone22");
String Phone23 = request.getParameter("Phone23");
String Phone2  = Phone21 + Phone22 + Phone23;
if(Phone21 == null || "null".equals(Phone21))
	Phone2 = " ";
	
String Fax1 = request.getParameter("Fax1");
String Fax2 = request.getParameter("Fax2");
String Fax3 = request.getParameter("Fax3");
String Fax = Fax1 + Fax2 + Fax3;



String NumUsers = request.getParameter("NumUsers");
String busIntUser = request.getParameter("busintuser");
String CatalogNumber = request.getParameter("CatalogNumber");


String ChkSys = null;
String SysNum = null;

String pChkSys = null;
String pSysNum = null;

String [] Systems = null;

String UnlimitedUsers = null;
String MultipleSales = null;

// Transfer Structure for the Descriptions
EzBussPartnerInfoStructure in = new EzBussPartnerInfoStructure();
EzBussPartnerAreaTable ebpt = new EzBussPartnerAreaTable();

// Set the Structer Values

in.setListboxDesc(BPDescription);
in.setName(ContactName);
in.setCompanyName(Company);
in.setPhone(Phone1);
in.setEmail(Email);
in.setWebAddr(WebAddress);
in.setAddr1(Address1);
in.setAddr2(Address2);
in.setStreet(Address1);
in.setCountry(Country);
in.setPostalCode(Zip);
in.setCity(City);
in.setState(State);
in.setTel1(Phone1);
in.setTel2(Phone2);
in.setFax1(Fax);
in.setPin(Zip);

String strTcount =  request.getParameter("TotalCount");

//Added by Venkat on 4/21/2001
	String areCount = request.getParameter("AreaCount");
	int AreaCount = 0;
	if ( areCount != null )
	{
		AreaCount = (new Integer(areCount)).intValue();
	}
//changes end here


if ( strTcount != null ){
int TotalCount = (new Integer(strTcount)).intValue();
int selCount =  0;

// This is to find the number of selected rows
for ( int i = 0 ; i < TotalCount; i++ ) {
	ChkSys = "ChkSys_"+i;
	pChkSys = request.getParameter(ChkSys);
	if ( pChkSys != null ){
		selCount = selCount + 1;
	}
}

//Checking for Unlimited Users Flag
String ChkUsers = request.getParameter("UnlimitedUsers");


if ( ChkUsers != null ){
	if(ChkUsers.equals("Unlimited"))
	{
		UnlimitedUsers = "Y";
	}else{
		UnlimitedUsers = "N";
	}
}


//Checking for Multiple Systems
if(selCount > 0){
	MultipleSales = "Y";
}else{
	MultipleSales = "N";
}

// Fill the Systems Array
Systems = new String[selCount];
selCount = 0;

for ( int i = 0  ; i < TotalCount; i++ ){
	ChkSys = "ChkSys_"+i;
	//SysNum = "SysNum_"+i; //Commented on 4/21/2001 by Venkat

	pChkSys = request.getParameter(ChkSys);
	if ( pChkSys != null ){
		// Get Data from The Local Database
		//pSysNum = request.getParameter(SysNum);
		//Systems[selCount] = new String(pSysNum);
		Systems[selCount] = new String(pChkSys);
		selCount++;
	}
}//End For

/** Added by Venkat on 4/21/2001 **/
	String GetAreaKey, GetAreaFlag, pGetAreaKey, pGetAreaFlag = "";
	int selAreaCnt = 0;

	for ( int m = 0; m < AreaCount; m++ )
	{
	     GetAreaKey = "OrgArea_"+m;
	     pGetAreaKey = request.getParameter(GetAreaKey);
	     if ( pGetAreaKey != null )selAreaCnt++;
	}

	for ( int i = 0  ; i < AreaCount; i++ )
	{
		GetAreaKey = "OrgArea_"+i;
		GetAreaFlag = "OrgAreaFlag_"+i;

	      pGetAreaKey = request.getParameter(GetAreaKey);

		if ( pGetAreaKey != null ){
			EzBussPartnerAreaTableRow ebptrow = new EzBussPartnerAreaTableRow();
			ebptrow.setEbpaClient("200"); // TBD
			pGetAreaFlag = request.getParameter(GetAreaFlag);
			ebptrow.setEbpaSysKey(pGetAreaKey);
			ebptrow.setEbpaAreaFlag(pGetAreaFlag);
			ebpt.appendRow(ebptrow);
		}
	}//End For

/** Changes end here **/

}// End if TotalCount not null

Object[] config_data = new Object[7];
	config_data[0] = " "; // 1. Buss Partner  // We will pass this field as Empty Field ***
	config_data[1] = CatalogNumber; // 2. Catalog Number
	config_data[2] = MultipleSales; // 3. Multiple Sales Areas
	config_data[3] = "N"; // 4. Price Selection Flag default to  = "N";
	config_data[4] = UnlimitedUsers; // 5. Unlimited Users
if(UnlimitedUsers.equals("N")){
	config_data[5] = NumUsers; // 6. Number Of Users
}else{
	config_data[5] = "0"; // 6. Number Of Users
}
      config_data[6] = busIntUser;

// Add Business Partner
//String BusPartnerNumber = AdminObject.addBussPartner (servlet, in, config_data, Systems);
//AdminObject.addBussPartnerSystems(servlet, BusPartnerNumber, Systems);

EzcBussPartnerParams bparams = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams= new EzcBussPartnerNKParams();
EzAddBussPartnerStructure bpaddstruct = new EzAddBussPartnerStructure();
bnkparams.setLanguage("EN");
bpaddstruct.setEzBussPartnerInfoStructure(in);
bpaddstruct.setSys_no(Systems);
bpaddstruct.setConfig_data(config_data);
bparams.setObject(bnkparams);
bparams.setObject(bpaddstruct);
bparams.setObject(ebpt); //Added by Venkat on 4/21/2001
Session.prepareParams(bparams);

//commented by Venkat on 4/21/2001
ReturnObjFromRetrieve retAddBP = (ReturnObjFromRetrieve)BPManager.addBussPartner(bparams);
String BusPartnerNumber = retAddBP.getFieldValueString(0,"BUSS_PARTNER");

/** Commented by Venkat on 4/21/2001 as this is called inside the addBussPartner Call itself
EzcBussPartnerParams bparams1 = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams1= new EzcBussPartnerNKParams();
EzAddBussPartnerStructure bpaddstruct1 = new EzAddBussPartnerStructure();
bnkparams1.setLanguage("EN");
bpaddstruct1.setSys_no(Systems);
bparams1.setBussPartner(BusPartnerNumber);
bparams1.setObject(bnkparams1);
bparams1.setObject(bpaddstruct1);
Session.prepareParams(bparams1);
BPManager.addBussPartnerSystems(bparams1);
**/

response.sendRedirect("../Partner/ezShowBPInfo.jsp?BusPartner="+BusPartnerNumber);
%>