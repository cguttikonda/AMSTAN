<%@ page import ="ezc.ezparam.*"%>
<%@ page import = "ezc.ezparam.EzCustomerAddrStructure"%>
<%@ include file="../../../Includes/Lib/Address.jsp"%>


<jsp:useBean id="VendManager" class="ezc.ezvendor.client.EzVendorManager" scope = "page">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%
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
	
	if  (payToCustNum!=null && payToCustNum.trim().length()>0) {
		companyName = request.getParameter( "payCompany" );
		payAddr1 = request.getParameter("PayAddress1");
		payAddr2 = request.getParameter("PayAddress2");
		payCity = request.getParameter("PayCity");
		payState = request.getParameter("PayState");
		if (payState==null || payState.equalsIgnoreCase("NSS")) payState="";
		payZip = request.getParameter( "PayZip" );
		payCountry = request.getParameter( "PayCountry" );
		in.setCompanyName(companyName);
		in.setName(companyName);
		in.setAddr1(payAddr1);
		in.setAddr2(payAddr2);
		in.setCity(payCity);
		in.setState(payState);
		in.setPin(payZip);
		in.setCountry(payCountry);
		in.setCustomerNo(payToCustNum);
		ezVendorParams.setVendor(payToCustNum);
		updateReturn = (ReturnObjFromRetrieve) VendManager.updateVendorAddress(vendorParams);
	}
	if (!isShpToPayTo && shpTocustNum!=null && shpTocustNum.trim().length()>0){
		System.out.println("\n\n\n+++>>> updateing order to OrdTocustNum="+shpTocustNum+"\n\n\n");
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
		in.setAddr2(orderAddr2);
		in.setCity(orderCity);
		in.setState(orderState);
		in.setCountry(orderCountry);
		in.setPin(orderZip);
		in.setCustomerNo(shpTocustNum);
		updateReturn = (ReturnObjFromRetrieve) VendManager.updateVendorAddress(vendorParams2);
	}
%>
