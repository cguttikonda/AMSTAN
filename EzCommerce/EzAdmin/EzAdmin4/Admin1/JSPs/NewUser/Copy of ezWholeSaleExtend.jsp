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

		String SysKey="",BusPartner="",pSoldTo="",genNewEzc = "";
        	String customer[]  =  request.getParameterValues("customer");
        	String syskey[]	   =  request.getParameterValues("syskey");
        	
			/*********Add User Start****/
	
			
			String catnum	=request.getParameter("catnum");
			//String soldTo 	=request.getParameter("soldTo");
			String userId 	=request.getParameter("userId");
			String userName =request.getParameter("userName");	
			String plant 	="QU";	
			String emailH 	=request.getParameter("email");	
			
			String ConnGroup = (String)session.getValue("ConnGroup");	
			
			try
			{
				userId 	= (Long.parseLong(userId))+"";
			}
			catch(Exception e)
			{
				userId 	= userId;
			}
			
			/*out.println("catnumcatnum::"+catnum);
			out.println("soldTosoldTo::"+soldTo);
			out.println("userIduserId::"+userId);
			out.println("userNameuserName::"+userName);
			out.println("plantplant::"+plant);
			out.println("ConnGroupConnGroup::"+ConnGroup);*/
						
			Hashtable bpSysAuth=new Hashtable();	  
			Hashtable bpIndAuth=new Hashtable();
			Hashtable userSysAuth=new Hashtable();
			Hashtable userIndAuth=new Hashtable();
			
			bpSysAuth.put("SALES_SYS_DEP","Sales System Dependent Role");
			bpIndAuth.put("SALES_SYS_IND","Sales System Independent Role");
			//bpIndAuth.put("SALES_CUSTOMER","Sales Customer Role");
		
			userSysAuth.put("SALES_SYS_DEP","Sales System Dependent Role");
			userIndAuth.put("SALES_SYS_IND","Sales System Independent Role");
			//userIndAuth.put("SALES_CUSTOMER","Sales Customer Role");
			
			Connection con=null;
			Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
			java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
			con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));
		
			Hashtable partnerDefaults= new Hashtable();
			partnerDefaults.put("COMPCODE","1000");
			partnerDefaults.put("PLANT",plant);
			
			Hashtable userDefaults = new Hashtable();
			userDefaults.put("USERROLE","CU");
			userDefaults.put("ISSUBUSER","N");
			
			ezc.ezbasicutil.EzMassCustSynch mySynch= new ezc.ezbasicutil.EzMassCustSynch("999",catnum);
			mySynch.setSession(Session);
			mySynch.setConnection(con);
		
			mySynch.ERPSOLDTO=customer[0];
			mySynch.company = userName;
			mySynch.SYSKEY=syskey[0];
			boolean error=false;
		
			String mySyskey = syskey[0];
			for(int i=1;i<syskey.length;i++)
			{
				mySyskey += "#####"+syskey[i];
			}
			mySynch.ezAreas=mySyskey;
			
		   	String bpnumber=mySynch.addBP();
		   	
	   		//out.println("bpnumberbpnumber::"+bpnumber);
	   		
	   		if(bpnumber!=null && !"null".equals(bpnumber))
			{
				//mySynch.addBPSysAuth(bpnumber,bpSysAuth);
				mySynch.addBPSysInAuth(bpnumber,bpIndAuth);
			}
	   		
	   		
	   		mySynch.UserId = userId.toUpperCase();
			mySynch.email = emailH;
			mySynch.setPassword();	    
			mySynch.addUser(bpnumber);
			mySynch.addUserSysAuth(userSysAuth);
			mySynch.addUserSysInAuth(userIndAuth);
			mySynch.addUserDefaults(userDefaults);
								
			/*********Add User END****/
       
	
	SysKey 		= syskey[0];//request.getParameter("salesArea");
	BusPartner 	= bpnumber; //request.getParameter("partnerNo").trim();
		
	for(int w=0;w<customer.length;w++)
	{
			
	pSoldTo		= customer[w];
	
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
		//out.println("busspartnerObj::::"+busspartnerObj.toEzcString());
	}	

	if ( addressObj != null ) 
	{
		AddRows = addressObj.getRowCount();
		//out.println("addressObj::::"+addressObj.toEzcString());
	}

	String PartNum[]	= new  String[bpObjRows]; 
	String PartFun[] 	= new  String[bpObjRows]; 		
	String ERPSoldTo[] 	= new  String[bpObjRows]; 
	
	
	
	for (int i = 0;i<bpObjRows;i++)
	{
		PartNum[i]	= busspartnerObj.getFieldValueString(i,"CUSTOMERNUMBER");
		PartFun[i] 	= busspartnerObj.getFieldValueString(i,"PARTFUNCTIONID");
		ERPSoldTo[i] 	= busspartnerObj.getFieldValueString(i,"PARTNERNUMBER");
		
		//out.println("ERPSoldTo::::"+ERPSoldTo[i] );		
		//out.println("PartFun::::"+PartFun[i] );
		
		
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
				
			//out.println("getCustomerNo:::"+custin.getCustomerNo());	
			//out.println("globalCustNo:::"+globalCustNo);	
			//out.println("PartFun:::"+PartFun[i]);	
				
			custin.setSysKey(SysKey);
			custin.setPartnerFunc(PartFun[i]);
			custin.setPartnerNo(ERPSoldTo[i]);
			custin.setErpSoldTo(PartNum[i]);
			custin.setBussPartner(BusPartner);
			custin.setDelFlag("N");
			
			for(int j=0;j<AddRows;j++)
			{
				String custNo = customerNo[j];
				//out.println("customerNo:::"+customerNo[j]);
				//out.println("ERPSoldTo:::"+ERPSoldTo[i]);
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
					
					in.setIncoTerms(incoTermsAddr[j]);
					in.setPymtTerms(pymtTermsAddr[j]);
					in.setBlckCode(blckCodeAddr[j]);
					in.setAccGroup(accGroupAddr[j]);
					in.setPricGroup(pricGroupAddr[j]);
					
					
					
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
			if("WE".equals(PartFun[i]))
				globalCustNo = "";
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
		String syskeyH="",value = "";
		
		for (int i=0;i<rowCount;i++)
		{
			syskeyH = myRet.getFieldValueString(i,"ESKD_SYS_KEY");
			value  = myRet.getFieldValueString(i,"ECAD_VALUE");
			
			try{
				if(sysVector.contains(syskeyH))
				{
					rowId= retSalArea.getRowId("SYSKEY",syskeyH);				
				}
				else
				{
					sysVector.addElement(syskeyH);
					retSalArea.setFieldValue("SYSKEY",syskeyH);
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
	
		
		//String ConnGroup = (String)session.getValue("ConnGroup");
		java.util.ResourceBundle mySite1 = java.util.ResourceBundle.getBundle("Site");
		Connection con1 = null;
		java.sql.Statement st = null;
		
		String qry = "insert into ezc_user_defaults values ('"+partnersRet.getFieldValueString(0,"EU_ID")+"','"+sysKey+"','NULL','SOLDTOPARTY','"+mySoldTo+"','N',''"+")";	
		
		
		try
		{
			Class.forName(mySite1.getString("Driver_"+ConnGroup));
			con1 = DriverManager.getConnection(mySite1.getString("ConnectString_"+ConnGroup),mySite1.getString("UserId_"+ConnGroup),mySite1.getString("Password_"+ConnGroup));	
			st  = con.createStatement();
			st.executeUpdate(qry);	
			st.close();
			
		}
		catch(Exception e)
		{
			System.out.println("Exception occured while taking DB connection"+e);
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


<%

			/* To Insert User Auths :::START:::From Properties file */
				
			EzcParams mainParams= new EzcParams(false);
			EziMiscParams miscParams= new EziMiscParams();

			String userIdUC = userId.toUpperCase();
			String fileName = "ezWholeSaleExtend.jsp";
			String filePath = request.getRealPath(fileName);

			ezc.ezcommon.EzLog4j.log("fileName::"+fileName,"I");
			filePath = filePath.substring(0,filePath.indexOf(fileName));
			ezc.ezcommon.EzLog4j.log("filePath::"+filePath,"I");
			filePath +="ezCustAuth.properties";
			ezc.ezcommon.EzLog4j.log("filePath::"+filePath,"I");

			Properties prop=new Properties();
			prop.load(new java.io.FileInputStream(filePath));

			String intAuthSplit  = prop.getProperty("CUSTAUTH");
			String bussAuthSplit = prop.getProperty("BUSSPARTNER");
			
			String intAuthSplitArr[] = null;
			String bussAuthSplitArr[] = null;
			
			int intAuthSplitCnt=0;
			int bussAuthSplitCnt=0;
			
			if(bussAuthSplit!=null)
			{
				bussAuthSplitArr = bussAuthSplit.split("§");
				bussAuthSplitCnt = bussAuthSplitArr.length;
			}
			if(intAuthSplit!=null)
			{
				intAuthSplitArr = intAuthSplit.split("§");
				intAuthSplitCnt = intAuthSplitArr.length;
			}
			
			for(int j=0;j<bussAuthSplitCnt;j++)
			{

				String authKey   =  bussAuthSplitArr[j].split("¥")[0];
				String authDesc  =  bussAuthSplitArr[j].split("¥")[1];


				miscParams.setIdenKey("MISC_INSERT");
				String query="INSERT INTO EZC_BUSS_PARTNER_AUTH VALUES ('"+bpnumber+"','999','"+authKey+"','"+authDesc+"','')";
				miscParams.setQuery(query);

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
			}

			for(int i=0;i<intAuthSplitCnt;i++)
			{

				String authKey   =  intAuthSplitArr[i].split("¥")[0];
				String authDesc  =  intAuthSplitArr[i].split("¥")[1];


				miscParams.setIdenKey("MISC_INSERT");
				String query="INSERT INTO EZC_USER_AUTH VALUES ('"+userIdUC+"','999','"+authKey+"','"+authDesc+"','R')";
				miscParams.setQuery(query);

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
			}
					
			/*To Insert User Auths :::END:::From Properties file */


%>

	<br><br>

	<Table width="60%" border="1" align="center" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
	<Tr>
		<Th align=center>User "<%=userId.toUpperCase()%>" created successfully with Password "<%=mySynch.getPassword()%>".</Th>
	</Tr>
	</Table>
	
	<Center>
			<a href="JavaScript:goHome()"><img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none></a>
	</Center>
	
