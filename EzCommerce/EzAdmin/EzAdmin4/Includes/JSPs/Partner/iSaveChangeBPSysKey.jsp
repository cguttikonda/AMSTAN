<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>

<%


// Get the input parameters from the User Entry screen
String area=request.getParameter("Area");
String flag=request.getParameter("flag");
String websyskey=request.getParameter("WebSysKey");
String BPartner = request.getParameter("BusPartner");
String Company = request.getParameter("Company");
String BPDescription = request.getParameter("BPDescription");
String ContactName = request.getParameter("ContactName");
String Email = request.getParameter("Email");
String WebAddress = request.getParameter("WebAddress");
String Address1 = request.getParameter("Address1");
String Address2 = request.getParameter("*Address2");
String City = request.getParameter("City");
String State = request.getParameter("State");
String Zip = request.getParameter("Zip");
String Country = request.getParameter("Country");

String Phone1  = request.getParameter("Phone1");

String Phone2  = request.getParameter("*Phone2");

String Fax = request.getParameter("Fax");


String NumUsers = request.getParameter("NumUsers");
String CatalogNumber = request.getParameter("CatalogNumber");

String ChkSys = null; 
String SysNum = null; 

String pChkSys = null; 
String pSysNum = null; 

String [] Systems = null;

String UnlimitedUsers = null;
String MultipleSales = null;

// Transfer Structure for the Descriptions
EzBussPartnerInfoStructure in = new EzBussPartnerInfoStructure ();

// Set the Structer Values
in.setBussPartner(BPartner);
in.setListboxDesc(BPDescription);
in.setLang("EN");
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
		NumUsers="0";
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

/** Commented by Venkat on 4/23/2001
	// Fill the Systems Array
	Systems = new String[selCount];
	selCount = 0;
	
	for ( int i = 0  ; i < TotalCount; i++ )
      {
		ChkSys = "ChkSys_"+i;
		SysNum = "SysNum_"+i;
	
		pChkSys = request.getParameter(ChkSys);
		if ( pChkSys != null )
		{
			// Get Data from The Local Database
			pSysNum = request.getParameter(SysNum);
			Systems[selCount] = new String(pSysNum);
			selCount++;
		}
	}//End For
**/
}// End if TotalCount not null

Object[] config_data = new Object[6]; 
	config_data[0] = BPartner; // 1. Buss Partner
	config_data[1] = CatalogNumber; // 2. Catalog Number
	config_data[2] = MultipleSales; // 3. Multiple Sales Areas
	config_data[3] = "N"; // 4. Price Selection Flag default to  = "N";
	config_data[4] = UnlimitedUsers; // 5. Unlimited Users 
	config_data[5] = NumUsers; // 6. Number Of Users

// Save Changes for the Business Partner 

EzcBussPartnerParams bparams = new EzcBussPartnerParams();
EzcBussPartnerNKParams bnkparams= new EzcBussPartnerNKParams();
EzAddBussPartnerStructure bpaddstruct = new EzAddBussPartnerStructure();
bnkparams.setLanguage("EN");
bpaddstruct.setEzBussPartnerInfoStructure(in);
//bpaddstruct.setSys_no(Systems);  //Commented by Venkat on 4/23/2001
bpaddstruct.setConfig_data(config_data);
bparams.setObject(bnkparams);
bparams.setObject(bpaddstruct);
Session.prepareParams(bparams);
String BusPartnerNumber = (String)BPManager.changeBussPartner(bparams); 
//String BusPartnerNumber = BPManager.changeBussPartner(servlet, in, config_data, Systems); 
//String BusPartnerNumber = AdminObject.changeBussPartner(servlet, in, config_data, Systems); 


/** Commented by Venkat on 4/23/2001 
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


//response.sendRedirect("../Partner/ezShowBPInfo.jsp?BusPartner="+BusPartnerNumber);
response.sendRedirect("../Partner/ezChangeBPInfoBySysKey.jsp?saved=Y&BusinessPartner="+BusPartnerNumber+"&WebSysKey="+websyskey+"&Area="+area+"&BusPartner="+BPartner+"&flag="+flag);

%>