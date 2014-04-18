<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="EzCustomerManager" class="ezc.ezcustomer.client.EzCustomerManager"/>

<%
        String shipToNo   = request.getParameter("shipToNo");
        String addr1      = request.getParameter("addr1");
	String city       = request.getParameter("city");
	String state      = request.getParameter("selState");
	String zip        = request.getParameter("pin");
	String country    = request.getParameter("country");

	String cname     = request.getParameter("companyname");
	String addr2     = request.getParameter("addr2");
	String phone     = request.getParameter("phone");
	String email     = request.getParameter("email");
	String fax       = request.getParameter("fax");

	
	String SysKey     = (String)session.getValue("SalesAreaCode");
	String agentCode  = (String)session.getValue("AgentCode");
        
        if(shipToNo!=null || !"null".equals(shipToNo))
        	shipToNo = shipToNo.trim();
	
	EzcCustomerParams customerParams = new EzcCustomerParams();
	EzCustomerParams ezCustomerParams = new EzCustomerParams();
	EzCustomerStructure ezCustomerStructure = new EzCustomerStructure();
	EzCustomerAddrStructure in = new EzCustomerAddrStructure();

	ezCustomerStructure.setLanguage("EN");
	ezCustomerParams.setEzCustomerStructure(ezCustomerStructure);
	customerParams.setObject(ezCustomerParams);
	Session.prepareParams(customerParams);

	in.setLanguage("EN");
	in.setRefNo(10);
	in.setCompanyName(cname);
	in.setName("");
	in.setAddr1(addr1);
	in.setCity(city);
	in.setState(state);
	in.setPin(zip);
	in.setIsBussPartner("N");
	in.setPhone(phone);
	in.setWebAddr("");
	in.setEmail(email);
	in.setAddr2(addr2);
	in.setCountry(country);
	in.setShipAddr1("");
	in.setShipAddr2("");
	in.setShipCity("");
	in.setShipState("");
	in.setShipCountry("");
	in.setDelFlag("");
	in.setErpUpdateFlag("");
	in.setPobox("");
	ezCustomerParams.setEzCustomerAddrStructure(in);
	ezCustomerStructure.setCustomerNo(shipToNo);
	
	try{
		EzCustomerManager.updateCustomerAddress(customerParams);
	}catch(Exception e)
	{
	}
        response.sendRedirect("ezMyAccount.jsp");
%>