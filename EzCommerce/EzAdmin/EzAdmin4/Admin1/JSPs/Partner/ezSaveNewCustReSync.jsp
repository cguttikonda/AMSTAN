<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%@ page import= "java.sql.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%
// Get the input parameters
String FUNCTION = request.getParameter("FUNCTION");

if (FUNCTION == null)FUNCTION="AG";
FUNCTION = FUNCTION.trim();

String BusPartner = null;
String SysNum = null;
String SysKey = null;


String genNewEzc="";
BusPartner = request.getParameter("BusPartner");
SysNum = request.getParameter("SysNum");
SysKey = request.getParameter("SysKey");

String ERPSoldTo[]=request.getParameterValues("ERPSoldTo");
String PartNum[]=request.getParameterValues("PartNum");
String PartFun[]=request.getParameterValues("PartFun");
String CheckBox[]=request.getParameterValues("CheckBox");
String SoldTo[]=request.getParameterValues("SoldTo");
String CustName[]=request.getParameterValues("CustName");
String Addr1[]=request.getParameterValues("Addr1");
String City[]=request.getParameterValues("City");
String State[]=request.getParameterValues("State");
String Zip[]=request.getParameterValues("Zip");
String Country[] =request.getParameterValues("Country");

String[] Telephone1 = request.getParameterValues("telephone1");
String[] Telephone2= request.getParameterValues("telephone2");
String[] TeleTexNo = request.getParameterValues("telEtexNo");
String[] TelExNo = request.getParameterValues("telExNo");
String[] CustomerNo=request.getParameterValues("customerNo");
String[] Title=request.getParameterValues("title");
String[] Address2=request.getParameterValues("address2");
String[] CountryCode=request.getParameterValues("countryCode");
String[] POBox=request.getParameterValues("pobox");
String[] POBoxCity=request.getParameterValues("poboxCity");
String[] District=request.getParameterValues("district");
String[] TelBoxNo=request.getParameterValues("telBoxNo");
String[] FaxNo=request.getParameterValues("faxNo");
String[] Email=request.getParameterValues("email");
String[] WebAddr=request.getParameterValues("webAddr");
String[] Indicator=request.getParameterValues("indicator");
String[] TransportZone=request.getParameterValues("transportZone");
String[] TaxJDC=request.getParameterValues("taxJdc");

String[] itermArr = request.getParameterValues("iterm");
String[] ptermArr = request.getParameterValues("pterm");
String[] bcodeArr = request.getParameterValues("bcode");
String[] accgrArr = request.getParameterValues("accgr");
String[] prgrpArr = request.getParameterValues("prgrp");
String[] prdAttrsArr = request.getParameterValues("prdAttrs");





String pCustName=null;
EzCustomerStructure custin = new EzCustomerStructure();
EzCustomerAddrStructure in = new EzCustomerAddrStructure();

if(PartNum!=null)
{
	Connection connection = null;
	java.sql.Statement st = null;
	try{
	    java.util.ResourceBundle siteProps_A = java.util.ResourceBundle.getBundle("Site");
	    String SiteNo_A = "202"; //siteProps_A.getString("DBGRP");
	    Class.forName(siteProps_A.getString("Driver_"+SiteNo_A));
	    connection = DriverManager.getConnection(siteProps_A.getString("ConnectString_"+SiteNo_A),siteProps_A.getString("UserId_"+SiteNo_A),siteProps_A.getString("Password_"+SiteNo_A));
	    int recordsUpdated  = 0;
	    
	    st = connection.createStatement();
	    String qryStr = "DELETE FROM EZC_CUSTOMER_ADDR WHERE ECA_NO IN (SELECT EC_NO FROM EZC_CUSTOMER WHERE EC_ERP_CUST_NO = '"+SoldTo[0]+"' AND EC_SYS_KEY = '"+SysKey+"' AND EC_BUSINESS_PARTNER = '"+BusPartner+"')";
	    recordsUpdated  = st.executeUpdate(qryStr);
	    
	    qryStr = "DELETE FROM EZC_CUSTOMER WHERE EC_ERP_CUST_NO = '"+SoldTo[0]+"' AND EC_SYS_KEY = '"+SysKey+"' AND EC_BUSINESS_PARTNER = '"+BusPartner+"' ";
	    recordsUpdated  = st.executeUpdate(qryStr);
	    //ezc.ezcommon.EzLog4j.log(" <<<<<<<<<<<<<<<<<<<<<<<<<<< No. Of Records Deleted From Customer Table>>>>>>>>>>>>>>>>>>>>> "+recordsUpdated,"I");		
	    
	 }catch(Exception e){}
	 finally{   
	    st.close();	
	    connection.close();
	 }   
	    


	for ( int i = 0  ; i <PartNum.length; i++ )
	{

		custin.setCustomerNo(null);
		custin.setSysKey(SysKey);
		custin.setPartnerFunc(PartFun[i]);
		custin.setPartnerNo(PartNum[i]);
		custin.setErpSoldTo(ERPSoldTo[i]);
		custin.setBussPartner(BusPartner);
		custin.setDelFlag("N");

		pCustName= CustName[i].replace('\'',' ');

		in.setLanguage("EN");
		in.setRefNo(10);
		in.setCompanyName(CustName[i]);
		in.setName(CustName[i]);
		in.setAddr1(Addr1[i]);
		in.setCity(City[i]);
		in.setState(State[i]);
		in.setPin(Zip[i]);
		in.setIsBussPartner("N");
		in.setPhone(Telephone1[i]);
		//in.setWebAddr(" ");
		//in.setEmail(" ");
		//in.setAddr2(" ");

		in.setCountry(Country[i]);
		in.setShipAddr1(TeleTexNo[i]);
		in.setShipAddr2(TelExNo[i]);
		in.setShipCity(City[i]);
		in.setShipState(State[i]);
		in.setShipCountry(Country[i]);
		in.setShipPin(Zip[i]);
		in.setDelFlag(" ");


		in.setCustomerNo(CustomerNo[i]);
		in.setTitle(Title[i]);
		in.setAddr2(Address2[i]);
		in.setCountryCode(CountryCode[i]);
		in.setPobox(POBox[i]);
		in.setPoboxCity(POBoxCity[i]);
		in.setDistrict(District[i]);
		in.setTel1(Telephone1[i]);
		in.setTel2(Telephone2[i]);
		in.setTeleboxNo(TelBoxNo[i]);
		in.setFax1(FaxNo[i]);
		in.setTeletex(TeleTexNo[i]);
		in.setTelex(TelExNo[i]);
		in.setEmail(Email[i]);
		in.setWebAddr(WebAddr[i]);
		in.setUnloadIndicator(Indicator[i]);
		in.setTransportZone(TransportZone[i]);
		in.setJurisdictionCode(TaxJDC[i]);

		in.setIncoTerms(itermArr[i]);
		in.setPymtTerms(ptermArr[i]);
		in.setBlckCode(bcodeArr[i]);
		in.setAccGroup(accgrArr[i]);
		in.setPricGroup(prgrpArr[i]);
		in.setProdAttrs(prdAttrsArr[i]);
		


		if ( FUNCTION.equals("AG") )
		{
			EzcCustomerParams cparams = new EzcCustomerParams();
			EzCustomerParams  cnkparams = new EzCustomerParams();
			cnkparams.setLanguage("EN");
			cnkparams.setEzCustomerStructure(custin);
			cnkparams.setEzCustomerAddrStructure(in);
			cparams.setObject(cnkparams);
			Session.prepareParams(cparams);
			ReturnObjFromRetrieve retSBPSave = (ReturnObjFromRetrieve) CustomerManager.createCustomer(cparams);

			genNewEzc = retSBPSave.getFieldValueString(0,"EZC_NUMBER");

		}
		else
		{

			EzcVendorParams vparams = new EzcVendorParams();
			EzVendorParams  vnkparams = new EzVendorParams();
			vnkparams.setLanguage("EN");
			vnkparams.setEzCustomerStructure(custin);
			vnkparams.setEzCustomerAddrStructure(in);
			vparams.setObject(vnkparams);
			Session.prepareParams(vparams);
			ReturnObjFromRetrieve retSBPSave = (ReturnObjFromRetrieve) VendorManager.createVendor(vparams);

			genNewEzc = retSBPSave.getFieldValueString(0,"EZC_NUMBER");
		}



	}//End For

}

	String Area=request.getParameter("Area");
%>

<html>
<body>
	<input type="hidden" name="BusPartner" value="<%=BusPartner%>">
	<input type="hidden" name="SysKey" value="<%=SysKey%>">
	<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
	<input type="hidden" name="genezc" value="<%=genNewEzc%>">
<%
	response.sendRedirect("ezConfirmPartnerFunctionSync.jsp?BusPartner="+BusPartner+"&SysKey="+SysKey+"&New=Y&FUNCTION="+FUNCTION+"&genezc="+genNewEzc+"&Area="+Area);
%>
</body>
</html>