<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="EzCustomerManager" class="ezc.ezcustomer.client.EzCustomerManager"/>

<%
        String addr1     = request.getParameter("addr1");
	String city      = request.getParameter("city");
	String state     = request.getParameter("selState");
	String zip       = request.getParameter("pin");
	String country   = request.getParameter("country");
	String cname     = request.getParameter("companyname");
	String addr2     = request.getParameter("addr2");
	String phone     = request.getParameter("phone");
	String email     = request.getParameter("email");
	String fax       = request.getParameter("fax");
	
	addr1=(addr1==null ||"null".equals(addr1))?"":addr1;
	city=(city==null ||"null".equals(city))?"":city;
	state=(state==null ||"null".equals(state))?"":state;
	zip=(zip==null ||"null".equals(zip))?"":zip;
	country=(country==null ||"null".equals(country))?"":country;
	cname=(cname==null ||"null".equals(cname))?"":cname;
	addr2=(addr2==null ||"null".equals(addr2))?"":addr2;
	phone=(phone==null ||"null".equals(phone))?"":phone;
	email=(email==null ||"null".equals(email))?"":email;
	fax=(fax==null ||"null".equals(fax))?"":fax;
	
	
        String partnerNo ="",soldTo="",busspartner="";

	EzcCustomerParams custparams = new EzcCustomerParams();
	EzCustomerParams  cnkparams  = new EzCustomerParams();

	EzCustomerStructure custin = new EzCustomerStructure();
	EzCustomerAddrStructure custAddr = new EzCustomerAddrStructure();
	String SysKey     = (String)session.getValue("SalesAreaCode");
        String agentCode  = (String)session.getValue("AgentCode");
        
        ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);	
        ReturnObjFromRetrieve listShipTos = null;
        
        listShipTos = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(agentCode);
        
        if(listShipTos!=null && listShipTos.getRowCount()>0){
        	partnerNo   = listShipTos.getFieldValueString(0,"EC_PARTNER_NO");
        	soldTo      = listShipTos.getFieldValueString(0,"EC_ERP_CUST_NO");
       		busspartner = listShipTos.getFieldValueString(0,"EC_BUSINESS_PARTNER");
        }
        
              
	custin.setCustomerNo(null);
	custin.setSysKey(SysKey);
	custin.setPartnerFunc("WE");
	custin.setPartnerNo(partnerNo);
	custin.setErpSoldTo(soldTo);
	custin.setBussPartner(busspartner);
	custin.setDelFlag("N");

	custAddr.setLanguage("EN");
	custAddr.setRefNo(10);
	custAddr.setCompanyName(cname);
	custAddr.setName("");
	custAddr.setAddr1(addr1);
	custAddr.setCity(city);
	custAddr.setState(state);
	custAddr.setPin(zip);
	custAddr.setIsBussPartner("N");
	custAddr.setPhone(phone);
	custAddr.setWebAddr("");	
	custAddr.setEmail(email);
	custAddr.setAddr2(addr2);
	custAddr.setCountry(country);
	custAddr.setShipAddr1("");
	custAddr.setShipAddr2("");
	custAddr.setShipCity("");
	custAddr.setShipState("");
	custAddr.setShipCountry("");
	custAddr.setDelFlag("");
	custAddr.setTitle("");
	custAddr.setPobox("");
	custAddr.setPoboxCity("");
	custAddr.setDistrict("");
	custAddr.setTel1("");
	custAddr.setTel2("");
	custAddr.setTeleboxNo("");
	custAddr.setFax1("");
	custAddr.setTeletex("");
	custAddr.setTelex("");
	custAddr.setUnloadIndicator("");
	custAddr.setTransportZone("");
	custAddr.setJurisdictionCode("");

	cnkparams.setLanguage("EN");
	cnkparams.setEzCustomerStructure(custin);
	cnkparams.setEzCustomerAddrStructure(custAddr);
	custparams.setObject(cnkparams);
	Session.prepareParams(custparams);	

	try{
		EzCustomerManager.createCustomer(custparams);
	}catch(Exception e)
	{
	}

	response.sendRedirect("ezMyAccount.jsp");
        
        	
%>