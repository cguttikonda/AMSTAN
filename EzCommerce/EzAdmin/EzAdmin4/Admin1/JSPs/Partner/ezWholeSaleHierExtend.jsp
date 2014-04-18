<%//@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="CustomerManager" class="ezc.ezcustomer.client.EzCustomerManager" scope="session"></jsp:useBean>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<%@ include file="../../../Includes/Lib/AdminUtilsBean.jsp"%>
<jsp:useBean id="AdminUtilsManager" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="BussPartnerManager" class="ezc.client.CEzBussPartnerManager" scope="session" />
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="java.util.*,ezc.ezparam.*,ezc.ezmisc.params.*,java.sql.*" %>

<%
	EzcParams mainParams= new EzcParams(false);
	EziMiscParams miscParams= new EziMiscParams();

	String hierCode    =  request.getParameter("hierCode");
	String SysKey      =  request.getParameter("sysKey");
	String BusPartner  =  request.getParameter("bPartner");

	String customer[]  =  request.getParameterValues("customer");
	
	ReturnObjFromRetrieve retObjMisc = null;
			
	//delete from customers & addr

	miscParams.setIdenKey("MISC_DELETE");

	miscParams.setQuery("DELETE FROM EZC_CUSTOMER_ADDR WHERE ECA_NO IN ( SELECT EC_NO FROM EZC_CUSTOMER WHERE EC_BUSINESS_PARTNER = '"+BusPartner+"' AND EC_SYS_KEY='"+SysKey+"' )");

	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);	
	try
	{		
		ezMiscManager.ezDelete(mainParams);
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}


	miscParams.setQuery("DELETE FROM EZC_CUSTOMER WHERE EC_BUSINESS_PARTNER='"+BusPartner+"' AND EC_SYS_KEY='"+SysKey+"' ");

	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);	
	try
	{		
		ezMiscManager.ezDelete(mainParams);
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}

	//delete from customers & addr

	miscParams.setIdenKey("MISC_SELECT");
	miscParams.setQuery("select EU_ID from EZC_USERS where EU_BUSINESS_PARTNER='"+BusPartner+"'");

	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);	
	try
	{		
		retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams);
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}

	miscParams.setIdenKey("MISC_DELETE");

	miscParams.setQuery("DELETE FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID='"+retObjMisc.getFieldValueString(0,"EU_ID")+"' and EUD_SYS_KEY='"+SysKey+"' and EUD_KEY='SOLDTOPARTY'  ");

	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);	
	try
	{		
		ezMiscManager.ezDelete(mainParams);
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}

	for(int al=0;al<customer.length;al++)
	{
		String pSoldTo  =  customer[al];

		miscParams.setIdenKey("MISC_INSERT");
		miscParams.setQuery("INSERT INTO EZC_USER_DEFAULTS VALUES('"+retObjMisc.getFieldValueString(0,"EU_ID")+"','"+SysKey+"',NULL,'SOLDTOPARTY','"+pSoldTo+"','N',NULL)");

		mainParams.setLocalStore("Y");
		mainParams.setObject(miscParams);
		Session.prepareParams(mainParams);	
		try
		{		
			ezMiscManager.ezAdd(mainParams);
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}

		ReturnObjFromRetrieve busspartnerObj 	= null;
		ReturnObjFromRetrieve buss_cust_retObj	= null;
		ReturnObjFromRetrieve addressObj	= null;



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
		{
			AddRows = addressObj.getRowCount();
		}

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

		String incoTermsAddr[] 	= new  String[AddRows]; 
		String pymtTermsAddr[] 	= new  String[AddRows];
		String blckCodeAddr[] 	= new  String[AddRows]; 
		String accGroupAddr[] 	= new  String[AddRows]; 
		String pricGroupAddr[] 	= new  String[AddRows]; 
		String prodAttrsAddr[] 	= new  String[AddRows];

		for ( int i = 0 ; i < AddRows; i++ )
		{
			CustName[i] 		= addressObj.getFieldValueString(i,"NAME1");
			Addr1[i] 		= addressObj.getFieldValueString(i,"ADDRESS1");
			City[i] 		= addressObj.getFieldValueString(i,"CITY");
			State[i] 		= addressObj.getFieldValueString(i,"REGION");
			Zip[i] 			= addressObj.getFieldValueString(i,"POSTALCODE");
			Country[i] 		= addressObj.getFieldValueString(i,"COUNTRYKEY");
			telephone1[i] 		= addressObj.getFieldValueString(i,"TELEPHONE1");
			telephone2[i] 		= addressObj.getFieldValueString(i,"TELEPHONE2");
			telEtexNo[i] 		= addressObj.getFieldValueString(i,"TELETEXNUMBER");
			telExNo[i] 		= addressObj.getFieldValueString(i,"TELEXNUMBER");
			customerNo[i] 		= addressObj.getFieldValueString(i,"CUSTOMERNUMBER");
			title[i]		= addressObj.getFieldValueString(i,"TITLE");
			address2[i] 		= addressObj.getFieldValueString(i,"ADDRESS2");
			countryCode[i] 		= addressObj.getFieldValueString(i,"COUNTRYCODE");
			pobox[i] 		= addressObj.getFieldValueString(i,"POBOX");
			poboxCity[i] 		= addressObj.getFieldValueString(i,"POBOXCITY");
			district[i] 		= addressObj.getFieldValueString(i,"DISTRICT");
			telBoxNo[i] 		= addressObj.getFieldValueString(i,"TELBOXNUMBER");
			faxNo[i] 		= addressObj.getFieldValueString(i,"FAXNUMBER");
			email[i] 		= addressObj.getFieldValueString(i,"EMAIL");
			webAddr[i] 		= addressObj.getFieldValueString(i,"COMPANYWEBSITE");
			indicator[i] 		= addressObj.getFieldValueString(i,"INDICATOR");
			transportZone[i]	= addressObj.getFieldValueString(i,"TRANSPORTZONE");
			taxJdc[i] 		= addressObj.getFieldValueString(i,"TAXJDC");

			for(int j=0;j<busspartnerObj.getRowCount();j++)
			{	
				if(busspartnerObj.getFieldValueString(j,"PARTNERNUMBER").equals(addressObj.getFieldValueString(i,"CUSTOMERNUMBER")))
				{
					incoTermsAddr[i] 	= busspartnerObj.getFieldValueString(j,"INCOTERMS");
					pymtTermsAddr[i] 	= busspartnerObj.getFieldValueString(j,"PAYMENTTERMS");
					blckCodeAddr[i] 	= busspartnerObj.getFieldValueString(j,"BLOCKCODE");
					accGroupAddr[i] 	= busspartnerObj.getFieldValueString(j,"ACCOUNTGROUP");
					pricGroupAddr[i] 	= busspartnerObj.getFieldValueString(j,"PRICEGROUP");
					prodAttrsAddr[i]	= busspartnerObj.getFieldValueString(j,"PRODATTRIBUTES");
				}
			}

		}//End for

		String globalCustNo ="";
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
						in.setTeleboxNo(hierCode);
						in.setFax1(faxNo[j]);
						in.setTeletex(telEtexNo[j]);
						in.setTelex(telExNo[j]);
						in.setEmail(email[j]);
						in.setWebAddr(webAddr[j]);
						in.setUnloadIndicator(indicator[j]);
						in.setTransportZone(transportZone[j]);
						in.setJurisdictionCode(taxJdc[j]);

						in.setIncoTerms(incoTermsAddr[j]);
						in.setPymtTerms(pymtTermsAddr[j]);
						in.setBlckCode(blckCodeAddr[j]);
						in.setAccGroup(accGroupAddr[j]);
						in.setPricGroup(pricGroupAddr[j]);
						in.setProdAttrs(prodAttrsAddr[j]);



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
				String genNewEzc = retSBPSave.getFieldValueString(0,"EZC_NUMBER");
				if("AG".equals(PartFun[i]))
					globalCustNo = genNewEzc;
				if("WE".equals(PartFun[i]))
					globalCustNo = "";
			}
		}						
	}
	// Ends here	
%>
<Script>
function goHome()
{
	document.location.href="../Misc/ezMenuFrameSet.jsp"
}
</Script>

<br><br>

<Table width="60%" border="1" align="center" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
<Tr>
	<Th align=center>"Users Synchronized Successfully".</Th>
</Tr>
</Table>

<br><br><br><br>

<Center>
		<a href="JavaScript:goHome()"><img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none></a>
</Center>
	
