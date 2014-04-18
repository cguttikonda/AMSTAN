
<%@ page import ="ezc.ezparam.*"%>
<%@ page import = "ezc.ezparam.EzCustomerAddrStructure"%>
<%@ include file="../../../Includes/Lib/Address.jsp"%>
<jsp:useBean id="VendManager" class="ezc.ezvendor.client.EzVendorManager" scope = "page">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%

	boolean isSendMail = false; 
	EzCustomerAddrStructure in = new EzCustomerAddrStructure();
	EzCustomerStructure ezCustomerStructure = new EzCustomerStructure();
	ezc.ezparam.EzcVendorParams vendorParams = new ezc.ezparam.EzcVendorParams();
	EzVendorParams ezVendorParams = new EzVendorParams();
	ReturnObjFromRetrieve updateReturn = null;
	boolean isShpToPayTo = false;
	String language = "EN";
	String shpCompanyName="" ,orderAddr1="" , orderAddr2="", orderCity="", orderState="", orderZip="",orderCountry="";
	String companyName="", payAddr1="", payAddr2="", payCity="", payState="", payZip="", payCountry="";
	String payToCustNum = request.getParameter("defPayToCustNum");
	String shpTocustNum = request.getParameter("defOrderToCustNum");
	if (payToCustNum!=null && payToCustNum.equalsIgnoreCase(shpTocustNum)) isShpToPayTo = true;

	in.setLanguage(language);
	in.setRefNo(10);
	in.setIsBussPartner("N");
	in.setDelFlag("Y");	
	ezVendorParams.setLanguage(language);
	vendorParams.setObject(ezVendorParams);
	vendorParams.setObject(in);
	vendorParams.setObject(ezVendorParams);
	Session.prepareParams(vendorParams);
	
	
	String errorMessage = "";
	boolean isError = false;
	if  (payToCustNum!=null && payToCustNum.trim().length()>0) 
	{
		companyName 	= request.getParameter( "payCompany" );
		payAddr1 	= request.getParameter("PayAddress1");
		payAddr2 	= request.getParameter("PayAddress2");
		payCity 	= request.getParameter("PayCity");
		payState 	= request.getParameter("PayState");
		if (payState == null || payState.equalsIgnoreCase("NSS")) 
			payState="";
		payZip 		= request.getParameter("PayZip");
		payCountry 	= request.getParameter("PayCountry");
		in.setCompanyName(companyName);
		in.setName(companyName);
		in.setAddr1(payAddr1);
		in.setDistrict(payAddr2);
		in.setCity(payCity);
		in.setState(payState);
		in.setPostalCode(payZip);
		in.setCountry(payCountry);
		in.setCustomerNo(payToCustNum);
		ezVendorParams.setVendor(payToCustNum);
		updateReturn = (ReturnObjFromRetrieve)VendManager.updateErpVendor(vendorParams);
		if(updateReturn != null)
		{
			if("E".equals(updateReturn.getFieldValueString(0,"MSGTYP")))
			{
				isError = true;
				errorMessage = updateReturn.getFieldValueString(0,"MESSAGE");
			}
		}	
	}
	
	/*if (!isShpToPayTo && shpTocustNum!=null && shpTocustNum.trim().length()>0)
	{
		ezc.ezparam.EzcVendorParams vendorParams2 = new ezc.ezparam.EzcVendorParams();
		EzVendorParams ezVendorParams2 = new EzVendorParams();
		ezVendorParams2.setLanguage(language);
		vendorParams2.setObject(ezVendorParams2);
		vendorParams2.setObject(in);
		ezVendorParams2.setVendor(shpTocustNum);
		vendorParams2.setObject(ezVendorParams2);
		Session.prepareParams(vendorParams2);
		shpCompanyName = request.getParameter( "shpCompany" );
		orderAddr1 = request.getParameter( "OrderAddress1" );
		orderAddr2 = request.getParameter( "OrderAddress2" );
		orderCity = request.getParameter( "OrderCity" );
		orderState = request.getParameter( "OrderState" );
		if (orderState== null || orderState.equalsIgnoreCase("NSS")) orderState="";
		orderZip = request.getParameter( "OrderZip" );
		orderCountry = request.getParameter( "OrderCountry" );
		in.setCompanyName(shpCompanyName);
		in.setName(shpCompanyName);
		in.setAddr1(orderAddr1);
		in.setDistrict(orderAddr2);
		in.setCity(orderCity);
		in.setState(orderState);
		in.setCountry(orderCountry);
		in.setPostalCode(orderZip);
		in.setCustomerNo(shpTocustNum);
		updateReturn = VendManager.updateErpVendor(vendorParams2);
	}*/
%>


<%
	EzCustomerAddrStructure cStr = new EzCustomerAddrStructure();
	EzCustomerStructure ezCustomerStructure1 = new EzCustomerStructure();
	ezc.ezparam.EzcVendorParams vendParamsdb = new ezc.ezparam.EzcVendorParams();
	EzVendorParams ezVendorParamsdb = new EzVendorParams();
	ReturnObjFromRetrieve updateReturndb = null;
	
	if (payToCustNum!=null && payToCustNum.equalsIgnoreCase(shpTocustNum)) 
		isShpToPayTo = true;

	cStr.setLanguage(language);
	cStr.setRefNo(10);
	cStr.setIsBussPartner("N");
	cStr.setDelFlag("Y");	
	ezVendorParamsdb.setLanguage(language);
	vendParamsdb.setObject(ezVendorParamsdb);
	vendParamsdb.setObject(cStr);
	vendParamsdb.setObject(ezVendorParamsdb);
	Session.prepareParams(vendParamsdb);
	
	if  (payToCustNum!=null && payToCustNum.trim().length()>0 && !isError) 
	{
		companyName = request.getParameter( "payCompany" );
		payAddr1 = request.getParameter("PayAddress1");
		payAddr2 = request.getParameter("PayAddress2");
		payCity = request.getParameter("PayCity");
		payState = request.getParameter("PayState");
		if (payState==null || payState.equalsIgnoreCase("NSS")) payState="";
		payZip = request.getParameter( "PayZip" );
		payCountry = request.getParameter( "PayCountry" );
		cStr.setCompanyName(companyName);
		cStr.setName(companyName);
		cStr.setAddr1(payAddr1);
		cStr.setAddr2(payAddr2);
		cStr.setCity(payCity);
		cStr.setState(payState);
		cStr.setPin(payZip);
		cStr.setCountry(payCountry);
		cStr.setCustomerNo(payToCustNum);
		cStr.setErpUpdateFlag("X");

		ezVendorParamsdb.setVendor(payToCustNum);
		updateReturndb = (ReturnObjFromRetrieve) VendManager.updateVendorAddress(vendParamsdb);
	}
	
	/*if (!isShpToPayTo && shpTocustNum!=null && shpTocustNum.trim().length()>0)
	{
		ezc.ezparam.EzcVendorParams vendorParamsdb2 = new ezc.ezparam.EzcVendorParams();
		EzVendorParams ezVendorParamsdb2 = new EzVendorParams();
		ezVendorParamsdb2.setLanguage(language);
		vendorParamsdb2.setObject(ezVendorParamsdb2);
		vendorParamsdb2.setObject(cStr);
		ezVendorParamsdb2.setVendor(shpTocustNum);
		vendorParamsdb2.setObject(ezVendorParamsdb2);
		Session.prepareParams(vendorParamsdb2);
		shpCompanyName = request.getParameter( "shpCompany" );
		orderAddr1 = request.getParameter( "OrderAddress1" );
		orderAddr2 = request.getParameter( "OrderAddress2" );
		orderCity = request.getParameter( "OrderCity" );
		orderState = request.getParameter( "OrderState" );
		if (orderState== null || orderState.equalsIgnoreCase("NSS")) orderState="";
		orderZip = request.getParameter( "OrderZip" );
		orderCountry = request.getParameter( "OrderCountry" );
		cStr.setCompanyName(shpCompanyName);
		cStr.setName(shpCompanyName);
		cStr.setAddr1(orderAddr1);
		cStr.setAddr2(orderAddr2);
		cStr.setCity(orderCity);
		cStr.setState(orderState);
		cStr.setCountry(orderCountry);
		cStr.setPin(orderZip);
		cStr.setCustomerNo(shpTocustNum);
		cStr.setErpUpdateFlag("X");
		//Session.prepareParams(vendorParamsdb2);
		updateReturndb = (ReturnObjFromRetrieve) VendManager.updateVendorAddress(vendorParamsdb2);
	}*/
	
	if(!isError && "3".equals((String)session.getValue("UserType")) )
		isSendMail = true;
	 
	if(isSendMail)
	{
	
		Hashtable mailData = new Hashtable();
		String msgType = "CHGADD";
		boolean sendToExt = true ;  
		boolean isVendor  = true;	
		
		  mailData.put((String)session.getValue("SOLDTO"),(String)session.getValue("Vendor"));
		 
%>
		<%@include file="../../../Vendor2/JSPs/Purorder/ezSendMailCounter.jsp"%>

<%
	}
%>
