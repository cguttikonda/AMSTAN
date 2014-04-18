<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<jsp:useBean id="VendorManager" class="ezc.ezvendor.client.EzVendorManager" scope="session"></jsp:useBean>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<%@ include file="../../../Includes/Lib/AdminUtilsBean.jsp"%>

<jsp:useBean id="AdminUtilsManager" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<%@ page import="ezc.ezparam.*,java.sql.*" %>

<%
        
        String syskey[] 	= request.getParameterValues("syskey");
	String payTo 		= request.getParameter("payTo");
	String userName 	= request.getParameter("userName");
	String userId 		= request.getParameter("userId");
	String bizPartner	= request.getParameter("bizPartner");
	String genNewEzc 	= "";
	boolean isError 	= false;
		
	String ConnGroup = (String)session.getValue("ConnGroup");
	java.util.ResourceBundle mySite = java.util.ResourceBundle.getBundle("Site");
	ezc.ezcommon.EzLog4j.log("ConnGroupConnGroup>>>"+ConnGroup,"I");
	Connection con = null;
	java.sql.Statement st = null;
	
	ReturnObjFromRetrieve bizpartnerObj 	= null;
	ReturnObjFromRetrieve bizvendObj	= null;
	ReturnObjFromRetrieve addressObj	= null;

	EzcVendorParams vendparams 	= new EzcVendorParams();
	EzVendorParams  vendnkparams 	= new EzVendorParams();
	vendnkparams.setLanguage("EN");
	vendnkparams.setVendor(payTo);
	
	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWorkGroupUsersTable addTable= new ezc.ezworkflow.params.EziWorkGroupUsersTable();
	ezc.ezworkflow.params.EziWorkGroupUsersTableRow addParams = null;
	
	for(int s=0;s<syskey.length;s++){
	
		vendnkparams.setSysKey(syskey[s]);
		vendparams.setSysKey(syskey[s]);
		vendparams.setObject(vendnkparams);
		Session.prepareParams(vendparams);	
	
		try{
			bizvendObj = (ReturnObjFromRetrieve)VendorManager.getVendorsFromErp(vendparams);
			ezc.ezcommon.EzLog4j.log("DE1GetbizvendObjSuccesfully>>>"+bizvendObj,"I");
		}catch(Exception e){
			System.out.print("Exception Occured while getting bizvendObj:"+e);
		}
	
		if(bizvendObj!=null){
			//For Vendors
			try{
				bizpartnerObj = (ReturnObjFromRetrieve)bizvendObj.getObject("VENDORDETAILS");
				//out.println(bizpartnerObj.toEzcString());
				ezc.ezcommon.EzLog4j.log("DE2GetbizpartnerObjSuccesfully>>>"+bizpartnerObj,"I");
			}catch(Exception e){
				System.out.print("Exception Occured while getting bizpartnerObj:"+e);
			}
	
			//For vendor Addresses
			try{
				addressObj = (ReturnObjFromRetrieve)bizvendObj.getObject("VENDORADDRESSDETAILS");
				ezc.ezcommon.EzLog4j.log("DE3GetaddressObjSuccesfully>>>","I");
			}catch(Exception e){
				System.out.print("Exception Occured while getting addressObj:"+e);
			}
			
			//---------------
			int AddRows 	=0;
			int bpObjRows	=0;
			String temp ="";
			
			if(bizpartnerObj != null){
				
				for (int i = 0;i<bizpartnerObj.getRowCount();i++){
				temp = bizpartnerObj.getFieldValueString(i,"PARTFUNCTIONID");
				if(temp==null || "null".equals(temp))
				bizpartnerObj.deleteRow(i);
				}
				bpObjRows = bizpartnerObj.getRowCount();
				ezc.ezcommon.EzLog4j.log("DEKKGWERWRWRWRW>>>"+bizpartnerObj,"I");
				try{
				bizpartnerObj.sort(new String[]{"PARTFUNCTIONID"},true);
				}catch(Exception e){
					ezc.ezcommon.EzLog4j.log("DEKKGetPartFun>>>"+e,"I");
				}
			}
			if ( addressObj != null ) 
				AddRows = addressObj.getRowCount();
				
			String PartNum[]	= new  String[bpObjRows]; 
			String PartFun[] 	= new  String[bpObjRows]; 		
			String ERPSoldTo[] 	= new  String[bpObjRows]; 	
			
			for (int i = 0;i<bpObjRows;i++){
					
				PartNum[i]	= bizpartnerObj.getFieldValueString(i,"CUSTOMERNUMBER");
				PartFun[i] 	= bizpartnerObj.getFieldValueString(i,"PARTFUNCTIONID");
				ERPSoldTo[i] 	= bizpartnerObj.getFieldValueString(i,"PARTNERNUMBER");
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
			
			for ( int i = 0 ; i < AddRows; i++ ){
					
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
			
			genNewEzc = "";
			String globalCustNo ="";
			EzCustomerStructure custin = new EzCustomerStructure();
			EzCustomerAddrStructure in = new EzCustomerAddrStructure();
			java.util.Vector custVect = new java.util.Vector(); 
			
			if(PartNum!=null){
				for(int i = 0;i<PartNum.length;i++){
					if("OA".equals(PartFun[i]))
						custin.setCustomerNo(null);
					else
						custin.setCustomerNo(globalCustNo);

					custin.setSysKey(syskey[s]);
					custin.setPartnerFunc(PartFun[i]);
					custin.setPartnerNo(ERPSoldTo[i]);
					custin.setErpSoldTo(PartNum[i]);
					custin.setBussPartner(bizPartner);
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
					
					EzcVendorParams vparams = new EzcVendorParams();
					EzVendorParams  vnkparams = new EzVendorParams();
					vnkparams.setLanguage("EN");
					vnkparams.setEzCustomerStructure(custin);
					vnkparams.setEzCustomerAddrStructure(in);
					vparams.setObject(vnkparams);
					Session.prepareParams(vparams);
					
					
					try{
						retSBPSave = (ReturnObjFromRetrieve) VendorManager.createVendor(vparams);
					}catch(Exception e){
						System.out.print("Exception Occured while CREATING  cust:"+e);
					}
					genNewEzc = retSBPSave.getFieldValueString(0,"EZC_NUMBER");
					////out.println("genNewEzc>>"+genNewEzc);
					if("OA".equals(PartFun[i]))
							globalCustNo = genNewEzc;
				}
				ezc.ezcommon.EzLog4j.log("DE4SYNCH TO LOCAL DB SUCCESSFULLY>>>","I");
				
				String qry = "insert into ezc_user_defaults values ('"+userId+"','"+syskey[s]+"','NULL','SOLDTOPARTY','"+payTo+"','N',''"+")";	
							
				try{
						Class.forName(mySite.getString("Driver_"+ConnGroup));
						con = DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));	
						st  = con.createStatement();
						st.executeUpdate(qry);	
				ezc.ezcommon.EzLog4j.log("DE5DEFAULTSTO LOCAL DB SUCCESSFULLY>>>","I");		
				}
				catch(Exception e)
				{
						System.out.println("Exception occured while taking DB connection"+e);
				}
				finally{
					
					try{
						st.close();
						con.close();
					}catch(Exception cex){}	
				}
					
			}
			
			addParams= new ezc.ezworkflow.params.EziWorkGroupUsersTableRow();
			addParams.setEffectiveFrom("01/01/2000");	
			addParams.setEffectiveTo("01/01/2999");	
			addParams.setGroupId("VENDOR");
			addParams.setUserId(userId);
			addParams.setSyskey(syskey[s]);
			addParams.setSoldTo(payTo);
			addTable.appendRow(addParams);
			
		}else{
			isError=true;
			break;
		}
		
		
		if((!(genNewEzc==null || "null".equals(genNewEzc) || "".equals(genNewEzc))) && (!isError)){
			addMainParams.setObject(addTable);
			Session.prepareParams(addMainParams);
			////EzWorkFlowManager.addWorkGroupUsers(addMainParams);
		}	
		
	}	

	
	//out.println("isError>>>>>>:"+isError);
			
	
%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script>
function goHome()
{
	document.location.href="ezQuickVendorCheck.jsp?Area=V"
}
</Script>
<%
	if((!(genNewEzc==null || "null".equals(genNewEzc) || "".equals(genNewEzc))) && (!isError))
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
			<Th align=center>Problem occured while getting data from ERP.</Th>
		</Tr>
		</Table>	
		<br>
		<Center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</Center>
<%	}
%>











