<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="CustomerManager" class="ezc.ezcustomer.client.EzCustomerManager" scope="session"></jsp:useBean>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<%@ include file="../../../Includes/Lib/AdminUtilsBean.jsp"%>
<jsp:useBean id="AdminUtilsManager" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<%@ page import="ezc.ezparam.*,java.sql.*" %>

<%
        String SysKey="",BusPartner="",pSoldTo="";

	//SysKey 	= "999630";
	//BusPartner 	= "24305";
	//pSoldTo	= "0000016929";
	
	SysKey 		= request.getParameter("salesArea");
	BusPartner 	= request.getParameter("partnerNo").trim();
	pSoldTo		= request.getParameter("soldTo");
	
	ReturnObjFromRetrieve busspartnerObj 	= null;
	ReturnObjFromRetrieve buss_cust_retObj	= null;
	ReturnObjFromRetrieve addressObj	= null;

//System.out.println("SysKey:"+SysKey+"BusPartner:"+BusPartner+pSoldTo);


	EzcCustomerParams custparams = new EzcCustomerParams();
	EzCustomerParams custnkparams = new EzCustomerParams();
	EzCustomerSyncParams ecsp = new EzCustomerSyncParams();
	custparams.setSysKey(SysKey);
	ecsp.setSystemKey(SysKey);
	ecsp.setBussPartnerNo("");
	ecsp.setCustomer(pSoldTo);
	ecsp.setLanguage("EN");
	ecsp.setPartnerFunc("");
	custnkparams.setEzCustomerSyncParams(ecsp);
	custparams.setObject(custnkparams);
	Session.prepareParams(custparams);	
	try{
		buss_cust_retObj = (ReturnObjFromRetrieve)CustomerManager.getCustomersFromErp(custparams);
	}catch(Exception e){
		System.out.print("Exception Occured while getting buss_cust_retObj:"+e);
	}
	//For customers
	try{
		busspartnerObj = (ReturnObjFromRetrieve)buss_cust_retObj.getObject("CUSTOMERDETAILS");
		busspartnerObj.check();
	}catch(Exception e){
		System.out.print("Exception Occured while getting busspartnerObj:"+e);
	}
	//For customer Addresses
	try{
		addressObj = (ReturnObjFromRetrieve)buss_cust_retObj.getObject("CUSTOMERADDRESSDETAILS");
	}catch(Exception e){
		System.out.print("Exception Occured while getting addressObj:"+e);
	}

	int AddRows 	= 0,bpObjRows=0;		
	if(busspartnerObj != null) 
	{
		bpObjRows = busspartnerObj.getRowCount();
		busspartnerObj.sort(new String[]{"PARTFUNCTIONID"},true);
	}	

	if ( addressObj != null ) 
		AddRows = addressObj.getRowCount();

	String PartNum[]	= new  String[bpObjRows]; 
	String PartFun[] 	= new  String[bpObjRows]; 		
	String ERPSoldTo[] 	= new  String[bpObjRows]; 
	
	for (int i = 0;i<bpObjRows;i++)
	{
		PartNum[i]	= busspartnerObj.getFieldValueString(i,"CUSTOMERNUMBER");
		PartFun[i] 	= busspartnerObj.getFieldValueString(i,"PARTFUNCTIONID");
		ERPSoldTo[i] 	= busspartnerObj.getFieldValueString(i,"PARTNERNUMBER");
	}	
		
	String CustName[]	= new  String[AddRows]; 
	String Addr1[] 		= new  String[AddRows]; 
	String City[] 		= new  String[AddRows]; 
	String State[] 		= new  String[AddRows]; 
	String Zip[] 		= new  String[AddRows]; 
	String Country[] 	= new  String[AddRows]; 
	String telephone1[] 	= new  String[AddRows]; 
	String telephone2[] 	= new  String[AddRows]; 
	String telEtexNo[] 	= new  String[AddRows]; 
	String telExNo[] 	= new  String[AddRows]; 
	String customerNo[] 	= new  String[AddRows]; 
	String title[]		= new  String[AddRows]; 
	String address2[] 	= new  String[AddRows]; 
	String countryCode[] 	= new  String[AddRows]; 
	String pobox[] 		= new  String[AddRows]; 
	String poboxCity[] 	= new  String[AddRows]; 
	String district[] 	= new  String[AddRows]; 
	String telBoxNo[] 	= new  String[AddRows]; 
	String faxNo[] 		= new  String[AddRows]; 
	String email[] 		= new  String[AddRows]; 
	String webAddr[] 	= new  String[AddRows]; 
	String indicator[] 	= new  String[AddRows]; 
	String transportZone[] 	= new  String[AddRows]; 
	String taxJdc[] 	= new  String[AddRows]; 

	for ( int i = 0 ; i < AddRows; i++ )
	{
		CustName[i] 	= addressObj.getFieldValueString(i,"NAME1");
		Addr1[i] 	= addressObj.getFieldValueString(i,"ADDRESS1");
		City[i] 	= addressObj.getFieldValueString(i,"CITY");
		State[i] 	= addressObj.getFieldValueString(i,"REGION");
		Zip[i] 		= addressObj.getFieldValueString(i,"POSTALCODE");
		Country[i] 	= addressObj.getFieldValueString(i,"COUNTRYKEY");
		telephone1[i] 	= addressObj.getFieldValueString(i,"TELEPHONE1");
		telephone2[i] 	= addressObj.getFieldValueString(i,"TELEPHONE2");
		telEtexNo[i] 	= addressObj.getFieldValueString(i,"TELETEXNUMBER");
		telExNo[i] 	= addressObj.getFieldValueString(i,"TELEXNUMBER");
		customerNo[i] 	= addressObj.getFieldValueString(i,"CUSTOMERNUMBER");
		title[i]	= addressObj.getFieldValueString(i,"TITLE");
		address2[i] 	= addressObj.getFieldValueString(i,"ADDRESS2");
		countryCode[i] 	= addressObj.getFieldValueString(i,"COUNTRYCODE");
		pobox[i] 	= addressObj.getFieldValueString(i,"POBOX");
		poboxCity[i] 	= addressObj.getFieldValueString(i,"POBOXCITY");
		district[i] 	= addressObj.getFieldValueString(i,"DISTRICT");
		telBoxNo[i] 	= addressObj.getFieldValueString(i,"TELBOXNUMBER");
		faxNo[i] 	= addressObj.getFieldValueString(i,"FAXNUMBER");
		email[i] 	= addressObj.getFieldValueString(i,"EMAIL");
		webAddr[i] 	= addressObj.getFieldValueString(i,"COMPANYWEBSITE");
		indicator[i] 	= addressObj.getFieldValueString(i,"INDICATOR");
		transportZone[i]= addressObj.getFieldValueString(i,"TRANSPORTZONE");
		taxJdc[i] 	= addressObj.getFieldValueString(i,"TAXJDC");
	}//End for

	String genNewEzc = "",globalCustNo ="";
	EzCustomerStructure custin = new EzCustomerStructure();
	EzCustomerAddrStructure in = new EzCustomerAddrStructure();
	java.util.Vector custVect = new java.util.Vector(); 
	if(PartNum!=null)
	{
		for(int i = 0;i<PartNum.length;i++)
		{
			if(!"WE".equals(PartFun[i]))
				custin.setCustomerNo(null);
			else
				custin.setCustomerNo(globalCustNo);
			custin.setSysKey(SysKey);
			custin.setPartnerFunc(PartFun[i]);
			custin.setPartnerNo(ERPSoldTo[i]);
			custin.setErpSoldTo(PartNum[i]);
			custin.setBussPartner(BusPartner);
			custin.setDelFlag("N");
			
			for(int j=0;j<AddRows;j++)
			{
				String custNo = customerNo[j];
				if(custNo.equals(ERPSoldTo[i]) && !custVect.contains(ERPSoldTo[i]))
				{
					in.setLanguage("EN");
					in.setRefNo(10);
					in.setCompanyName(CustName[j]);
					in.setName(CustName[j]);
					in.setAddr1(Addr1[j]);
					in.setCity(City[j]);
					in.setState(State[j]);
					in.setPin(Zip[j]);
					in.setIsBussPartner("N");
					in.setPhone(telephone1[j]);
					in.setCountry(Country[j]);
					in.setShipAddr1(telEtexNo[j]);
					in.setShipAddr2(telExNo[j]);
					in.setShipCity(City[j]);
					in.setShipState(State[j]);
					in.setShipCountry(Country[j]);
					in.setShipPin(Zip[j]);
					in.setDelFlag(" ");
					in.setCustomerNo(customerNo[j]);
					in.setTitle(title[j]);
					in.setAddr2(address2[j]);
					in.setCountryCode(countryCode[j]);
					in.setPobox(pobox[j]);
					in.setPoboxCity(poboxCity[j]);
					in.setDistrict(district[j]);
					in.setTel1(telephone1[j]);
					in.setTel2(telephone2[j]);
					in.setTeleboxNo(telBoxNo[j]);
					in.setFax1(faxNo[j]);
					in.setTeletex(telEtexNo[j]);
					in.setTelex(telExNo[j]);
					in.setEmail(email[j]);
					in.setWebAddr(webAddr[j]);
					in.setUnloadIndicator(indicator[j]);
					in.setTransportZone(transportZone[j]);
					in.setJurisdictionCode(taxJdc[j]);
					custVect.add(ERPSoldTo[i]);
				}
			}
			ReturnObjFromRetrieve retSBPSave = null;
			EzcCustomerParams cparams = new EzcCustomerParams();
			EzCustomerParams  cnkparams = new EzCustomerParams();
			cnkparams.setLanguage("EN");
			cnkparams.setEzCustomerStructure(custin);
			cnkparams.setEzCustomerAddrStructure(in);
			cparams.setObject(cnkparams);
			Session.prepareParams(cparams);
			try{
				retSBPSave = (ReturnObjFromRetrieve)CustomerManager.createCustomer(cparams);
			}catch(Exception e){
				System.out.print("Exception Occured while getting addressObj:"+e);
			}
			genNewEzc = retSBPSave.getFieldValueString(0,"EZC_NUMBER");
			if("AG".equals(PartFun[i]))
				globalCustNo = genNewEzc;
		}
	}
	
	//For insert into defaults
		ReturnObjFromRetrieve partnersRet = null;
		//String sysKey = request.getParameter("sysKey");
		//String soldTo = request.getParameter("soldTo");
		
		String sysKey = SysKey;
		String soldTo = pSoldTo;
		String mySoldTo = "";
		
		
		
		if(sysKey!=null && soldTo!=null)
		{
			soldTo = soldTo.trim();
			
			
			try{
			 int vend = Integer.parseInt(soldTo);
			mySoldTo = "0000000000"+soldTo;
			mySoldTo = mySoldTo.substring((mySoldTo.length()-10),mySoldTo.length());
			
			}
			catch(Exception e)
			{
			mySoldTo = soldTo;
			}
		
			EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
			adminUtilsParams.setSyskeys(sysKey);
			adminUtilsParams.setPartnerValueBy(mySoldTo);
	
			EzcParams mainParams = new EzcParams(false);
			mainParams.setObject(adminUtilsParams);
			Session.prepareParams(mainParams);
	
			partnersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams);
			
			System.out.println("partnersRetpartnersRetpartnersRet");
			//partnersRet.toEzcString();
			System.out.println("partnersRetpartnersRetpartnersRet");
			
		}
	
		String user_id = partnersRet.getFieldValueString(0,"EU_ID");
		//System.out.println("user_iduser_iduser_id:::"+user_id);
		
	
		ReturnObjFromRetrieve retUserCust = null;
		EziAdminUtilsParams adminUtilsParams1 = new EziAdminUtilsParams();
		adminUtilsParams1.setAreaType("AC");
		EzcParams mainParams2 = new EzcParams(false);
		mainParams2.setObject(adminUtilsParams1);
		Session.prepareParams(mainParams2);
		ReturnObjFromRetrieve myRet = (ReturnObjFromRetrieve)AdminUtilsManager.getUsersAreasWithDefaults(mainParams2);
		int rowCount = myRet.getRowCount();
		
		System.out.println("printlnprintlnprintln");
		//myRet.toEzcString();
		System.out.println("printlnprintlnprintln");
	
		String [] myRetCols = {"SYSKEY"};
		ReturnObjFromRetrieve retSalArea = new ReturnObjFromRetrieve(myRetCols);	
		java.util.Vector sysVector =new java.util.Vector();	
		int rowId = 0;
		String syskey="",value = "";
		
		for (int i=0;i<rowCount;i++)
		{
			syskey = myRet.getFieldValueString(i,"ESKD_SYS_KEY");
			value  = myRet.getFieldValueString(i,"ECAD_VALUE");
			
			try{
				if(sysVector.contains(syskey))
				{
					rowId= retSalArea.getRowId("SYSKEY",syskey);				
				}
				else
				{
					sysVector.addElement(syskey);
					retSalArea.setFieldValue("SYSKEY",syskey);
					retSalArea.addRow();	
				}
			}catch(Exception e){}
		}	
		System.out.println("retSalArearetSalArearetSalArea");
		retSalArea.toEzcString();
		System.out.println("retSalArearetSalArearetSalArea");
		
		int retRowCount = retSalArea.getRowCount();
		String mySyskeys = "";	
		for (int i=0;i<retRowCount;i++)
		{
			if(i==0)
				mySyskeys = retSalArea.getFieldValueString(0,"SYSKEY");
			else if(i>0)
				mySyskeys += ","+retSalArea.getFieldValueString(i,"SYSKEY");
		}	
		System.out.println("mySyskeysmySyskeys:::::::::"+mySyskeys);
	
		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setSyskeys(mySyskeys);
		adminUtilsParams.setPartnerValueBy(mySoldTo);
		EzcParams mainParams1 = new EzcParams(false);
		mainParams1.setObject(adminUtilsParams);
		Session.prepareParams(mainParams1);
		partnersRet = (ReturnObjFromRetrieve)AdminUtilsManager.getUsersByPartnerValueAndArea(mainParams1);
	
		System.out.println("PARTNERSRETPARTNERSRET::IMPORTANT");
		//partnersRet.toEzcString();
		System.out.println("PARTNERSRETPARTNERSRET::IMPORTANT");
	
		
		String ConnGroup = (String)session.getValue("ConnGroup");
		java.util.ResourceBundle mySite = java.util.ResourceBundle.getBundle("Site");
		Connection con = null;
		Statement st = null;
		
		String qry = "insert into ezc_user_defaults values ('"+partnersRet.getFieldValueString(0,"EU_ID")+"','"+sysKey+"','NULL','SOLDTOPARTY','"+mySoldTo+"','N',''"+")";	
		
		
		try
		{
			Class.forName(mySite.getString("Driver_"+ConnGroup));
			con = DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));	
			st  = con.createStatement();
			st.executeUpdate(qry);	
			st.close();
			
		}
		catch(Exception e)
		{
			System.out.println("Exception occured while taking DB connection"+e);
	}
	// Ends here
	
%>
<Script>
function goHome()
{
	document.location.href="../Misc/ezMenuFrameset.jsp"
}
</Script>
<%
	if(!(genNewEzc==null || "null".equals(genNewEzc) || "".equals(genNewEzc)))
	{
%>		<br><br><br><br>
		<Table width="60%" border="1" align="center" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
		<Tr>
			<Th align=center>User Extended Successfully.</Th>
		</Tr>
		</Table>	
		<br>
		<Center>
			<a href="JavaScript:goHome()"><img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none></a>
		</Center>
<%	}	
	else
	{
%>		<br><br><br>
		<Table width="60%" border="1" align="center" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
		<Tr>
			<Th align=center>Problem occured in User Extension.</Th>
		</Tr>
		</Table>	
		<br>
		<Center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</Center>
<%	}
%>
	
<%--
 --------------- Row 0 --------------------- 
 0 ::  Field Name : ERPCUSTNUMBER ----> Field Value : 0000021677 
 0 ::  Field Name : CUSTOMERNUMBER ----> Field Value : 0000021677 
 0 ::  Field Name : PARTFUNCTIONID ----> Field Value : AG 
 0 ::  Field Name : PARTNERNUMBER ----> Field Value : 0000021677
 --------------- End Of Row 0 --------------
 --------------- Row 1 --------------------- 
 1 ::  Field Name : ERPCUSTNUMBER ----> Field Value : 0000021677 
 1 ::  Field Name : CUSTOMERNUMBER ----> Field Value : 0000021677 
 1 ::  Field Name : PARTFUNCTIONID ----> Field Value : RE 
 1 ::  Field Name : PARTNERNUMBER ----> Field Value : 5100002146
 --------------- End Of Row 1 --------------
 --------------- Row 2 --------------------- 
 2 ::  Field Name : ERPCUSTNUMBER ----> Field Value : 0000021677 
 2 ::  Field Name : CUSTOMERNUMBER ----> Field Value : 0000021677 
 2 ::  Field Name : PARTFUNCTIONID ----> Field Value : WE 
 2 ::  Field Name : PARTNERNUMBER ----> Field Value : 0000021677
 --------------- End Of Row 2 --------------
 --------------- Row 3 --------------------- 
 3 ::  Field Name : ERPCUSTNUMBER ----> Field Value : 0000021677 
 3 ::  Field Name : CUSTOMERNUMBER ----> Field Value : 0000021677 
 3 ::  Field Name : PARTFUNCTIONID ----> Field Value : AF 
 3 ::  Field Name : PARTNERNUMBER ----> Field Value : 4105
 --------------- End Of Row 3 -------------- 
 
 --------------- Row 0 --------------------- 
 0 ::  Field Name : LANGUAGEKEY ----> Field Value : E 
 0 ::  Field Name : LANGUAGECODE ----> Field Value :  
 0 ::  Field Name : CUSTOMERNUMBER ----> Field Value : 0000021677 
 0 ::  Field Name : EXTREFNUMBER ----> Field Value :  
 0 ::  Field Name : TITLE ----> Field Value : M/s. 
 0 ::  Field Name : NAME1 ----> Field Value : NAV ENTERPRISES 
 0 ::  Field Name : NAME2 ----> Field Value : B-18, 1st FLOOR, COMMERCIAL COMPLEX 
 0 ::  Field Name : NAME3 ----> Field Value :  
 0 ::  Field Name : NAME4 ----> Field Value :  
 0 ::  Field Name : ADDRESS1 ----> Field Value : DR. MUKHERJEE NAGAR, 
 0 ::  Field Name : ADDRESS2 ----> Field Value : null 
 0 ::  Field Name : COUNTRYKEY ----> Field Value : IN 
 0 ::  Field Name : COUNTRYCODE ----> Field Value :  
 0 ::  Field Name : POSTALCODE ----> Field Value : 110009 
 0 ::  Field Name : POBOXCODE ----> Field Value :  
 0 ::  Field Name : POBOXCITY ----> Field Value :  
 0 ::  Field Name : CITY ----> Field Value : DELHI. 
 0 ::  Field Name : DISTRICT ----> Field Value :  
 0 ::  Field Name : REGION ----> Field Value : DEL 
 0 ::  Field Name : POBOX ----> Field Value :  
 0 ::  Field Name : TELEPHONE1 ----> Field Value : 27651079-9810... 
 0 ::  Field Name : TELEPHONE2 ----> Field Value :  
 0 ::  Field Name : TELBOXNUMBER ----> Field Value :  
 0 ::  Field Name : FAXNUMBER ----> Field Value : LC/72/175645/1194 
 0 ::  Field Name : TELETEXNUMBER ----> Field Value :  
 0 ::  Field Name : TELEXNUMBER ----> Field Value : 5(969)20B-21B 
 0 ::  Field Name : COMPANYWEBSITE ----> Field Value :  
 0 ::  Field Name : EMAIL ----> Field Value :  
 0 ::  Field Name : INDICATOR ----> Field Value :  
 0 ::  Field Name : TRANSPORTZONE ----> Field Value :  
 0 ::  Field Name : TAXJDC ----> Field Value : ZZ00
 --------------- End Of Row 0 --------------
 --------------- Row 1 --------------------- 
 1 ::  Field Name : LANGUAGEKEY ----> Field Value : E 
 1 ::  Field Name : LANGUAGECODE ----> Field Value :  
 1 ::  Field Name : CUSTOMERNUMBER ----> Field Value : 5100002146 
 1 ::  Field Name : EXTREFNUMBER ----> Field Value :  
 1 ::  Field Name : TITLE ----> Field Value : M/s. 
 1 ::  Field Name : NAME1 ----> Field Value : NAV ENTERPRISES 
 1 ::  Field Name : NAME2 ----> Field Value : B-18, 1st FLOOR, COMMERCIAL COMPLEX 
 1 ::  Field Name : NAME3 ----> Field Value :  
 1 ::  Field Name : NAME4 ----> Field Value :  
 1 ::  Field Name : ADDRESS1 ----> Field Value : DR. MUKHERJEE NAGAR, 
 1 ::  Field Name : ADDRESS2 ----> Field Value : null 
 1 ::  Field Name : COUNTRYKEY ----> Field Value : IN 
 1 ::  Field Name : COUNTRYCODE ----> Field Value :  
 1 ::  Field Name : POSTALCODE ----> Field Value : 110009 
 1 ::  Field Name : POBOXCODE ----> Field Value :  
 1 ::  Field Name : POBOXCITY ----> Field Value :  
 1 ::  Field Name : CITY ----> Field Value : DELHI. 
 1 ::  Field Name : DISTRICT ----> Field Value :  
 1 ::  Field Name : REGION ----> Field Value : DEL 
 1 ::  Field Name : POBOX ----> Field Value :  
 1 ::  Field Name : TELEPHONE1 ----> Field Value : 27651079-9810... 
 1 ::  Field Name : TELEPHONE2 ----> Field Value :  
 1 ::  Field Name : TELBOXNUMBER ----> Field Value :  
 1 ::  Field Name : FAXNUMBER ----> Field Value : LC/72/175645/1194 
 1 ::  Field Name : TELETEXNUMBER ----> Field Value :  
 1 ::  Field Name : TELEXNUMBER ----> Field Value : 5(969)20B-21B 
 1 ::  Field Name : COMPANYWEBSITE ----> Field Value :  
 1 ::  Field Name : EMAIL ----> Field Value :  
 1 ::  Field Name : INDICATOR ----> Field Value :  
 1 ::  Field Name : TRANSPORTZONE ----> Field Value :  
 1 ::  Field Name : TAXJDC ----> Field Value : 
 --------------- End Of Row 1 --------------
 --------------- Row 2 --------------------- 
 2 ::  Field Name : LANGUAGEKEY ----> Field Value : E 
 2 ::  Field Name : LANGUAGECODE ----> Field Value :  
 2 ::  Field Name : CUSTOMERNUMBER ----> Field Value : 4105 
 2 ::  Field Name : EXTREFNUMBER ----> Field Value :  
 2 ::  Field Name : TITLE ----> Field Value : M/s. 
 2 ::  Field Name : NAME1 ----> Field Value : NAV ENTERPRISES 
 2 ::  Field Name : NAME2 ----> Field Value : B-18, 1st FLOOR, COMMERCIAL COMPLEX 
 2 ::  Field Name : NAME3 ----> Field Value :  
 2 ::  Field Name : NAME4 ----> Field Value :  
 2 ::  Field Name : ADDRESS1 ----> Field Value : DR. MUKHERJEE NAGAR, 
 2 ::  Field Name : ADDRESS2 ----> Field Value : null 
 2 ::  Field Name : COUNTRYKEY ----> Field Value : IN 
 2 ::  Field Name : COUNTRYCODE ----> Field Value :  
 2 ::  Field Name : POSTALCODE ----> Field Value : 110009 
 2 ::  Field Name : POBOXCODE ----> Field Value :  
 2 ::  Field Name : POBOXCITY ----> Field Value :  
 2 ::  Field Name : CITY ----> Field Value : DELHI. 
 2 ::  Field Name : DISTRICT ----> Field Value :  
 2 ::  Field Name : REGION ----> Field Value : DEL 
 2 ::  Field Name : POBOX ----> Field Value :  
 2 ::  Field Name : TELEPHONE1 ----> Field Value : 27651079-9810... 
 2 ::  Field Name : TELEPHONE2 ----> Field Value :  
 2 ::  Field Name : TELBOXNUMBER ----> Field Value :  
 2 ::  Field Name : FAXNUMBER ----> Field Value : LC/72/175645/1194 
 2 ::  Field Name : TELETEXNUMBER ----> Field Value :  
 2 ::  Field Name : TELEXNUMBER ----> Field Value : 5(969)20B-21B 
 2 ::  Field Name : COMPANYWEBSITE ----> Field Value :  
 2 ::  Field Name : EMAIL ----> Field Value :  
 2 ::  Field Name : INDICATOR ----> Field Value :  
 2 ::  Field Name : TRANSPORTZONE ----> Field Value :  
 2 ::  Field Name : TAXJDC ----> Field Value : ZZ00
 --------------- End Of Row 2 -------------- 
 
select * from ezc_customer where ec_erp_cust_no='0000005249'
select * from ezc_customer_addr where eca_no in ('100009','100010','100011')
--%>