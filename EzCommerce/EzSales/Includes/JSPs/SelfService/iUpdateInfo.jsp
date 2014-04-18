<%@ page import ="ezc.ezparam.*"%>
<%@ page import = "ezc.ezparam.EzCustomerAddrStructure"%>
<%@ page import="java.util.ResourceBundle,java.util.Enumeration"%>
<%@ page import="ezc.forums.params.*,ezc.messaging.params.*,ezc.trans.messaging.params.*" %>
<%@ page import="ezc.client.*,ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="ezc.ezvendor.csb.*" %>
<%@ page import ="ezc.client.EzcUtilManager"%>
<jsp:useBean id="Manager" class="ezc.client.EzMessagingManager" scope="session"/>
<jsp:useBean id="CustomerManager" class="ezc.ezcustomer.client.EzCustomerManager" scope = "page"/>

<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddress.jsp"%>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>
<%
	String language = "EN";
	String companyName="", billAddr1="", billAddr2="", billCity="", billState="", billZip="", billCountry="",shipAddr1="",shipAddr2="",webAddr="",phone="";
	
	
	shipAddr1 	= request.getParameter("shipAddr1");
	shipAddr2 	= request.getParameter("shipAddr2");
	webAddr 	= request.getParameter("webAddr");	
	phone		= request.getParameter("Phone");
	companyName 	= request.getParameter( "billCompany" );
	billAddr1 	= request.getParameter("BillAddress1");
	billAddr2 	= request.getParameter("BillAddress2");
	billCity 	= request.getParameter("BillCity");
	billState 	= request.getParameter("billToState");
	billZip 	= request.getParameter( "BillZip" );
	billCountry 	= request.getParameter( "BillCountry" );
	String defSold 	= request.getParameter("defSold");
	if (billState==null || billState.equalsIgnoreCase("NSS")) billState="";
		
	EzCustomerAddrStructure in = new EzCustomerAddrStructure();
	in.setLanguage(language);
	in.setRefNo(10);
	in.setIsBussPartner("N");
	in.setDelFlag("N");
	in.setCompanyName(companyName);
	in.setName(companyName);
	in.setAddr1(billAddr1);
	in.setAddr2(billAddr2);
	in.setShipCity(billCity);
	in.setState(billState);
	in.setPin(billZip);
	in.setPhone(phone);
	in.setCountry(billCountry);
	in.setShipAddr1(shipAddr1);
	in.setShipAddr2(shipAddr2);
	in.setWebAddr(webAddr);
	in.setErpUpdateFlag("X");

	EzcCustomerParams customerParams = new EzcCustomerParams();
	EzCustomerParams ezCustomerParams = new EzCustomerParams();
	EzCustomerStructure ezCustomerStructure = new EzCustomerStructure();
	ezCustomerStructure.setLanguage("EN");
	ezCustomerParams.setEzCustomerStructure(ezCustomerStructure);
	customerParams.setObject(ezCustomerParams);
	ezCustomerParams.setEzCustomerAddrStructure(in);
	Session.prepareParams(customerParams);
	ezCustomerStructure.setCustomerNo(defSold);
	ReturnObjFromRetrieve updateReturn = (ReturnObjFromRetrieve) CustomerManager.updateCustomerAddress(customerParams);


	EzcCustomerParams customerParams2 = new EzcCustomerParams();
	EzCustomerStructure ezCustomerStructure2 = new EzCustomerStructure();
	ezCustomerStructure2.setLanguage("EN");
	customerParams2.setObject(ezCustomerStructure2);
	Session.prepareParams(customerParams2);
	ReturnObjFromRetrieve ret=new ReturnObjFromRetrieve();

	ret = (ReturnObjFromRetrieve)CustomerManager.getCustomerAddress(customerParams2);
		
	try
	{
	
	
	
	String from =(String) session.getValue("Agent");
	from=from+"("+(String)session.getValue("AgentCode")+")";
	
	
	if(ret.getRowCount() >0)
	{
		companyName = ret.getFieldValueString(0,"ECA_COMPANY_NAME").trim();
		if (companyName.equalsIgnoreCase("null")) companyName="";



		billAddr1 = ret.getFieldValueString(0,"ECA_ADDR_1").trim();
		if (billAddr1.equalsIgnoreCase("null")) billAddr1="";


		billAddr2 = ret.getFieldValueString(0,"ECA_ADDR_2").trim();
		if (billAddr2.equalsIgnoreCase("null")) billAddr2 = "";

		billCity = ret.getFieldValueString(0,"ECA_SHIP_CITY").trim();
		if (billCity.equalsIgnoreCase("null")) billCity = "";

		billState = ret.getFieldValueString(0,"ECA_STATE").trim();
		if (billState.equalsIgnoreCase("null")) billState = "";


		billZip = ret.getFieldValueString(0,"ECA_PIN").trim();
		if (billZip.equalsIgnoreCase("null")) billZip = "";

		billCountry = ret.getFieldValueString(0,"ECA_COUNTRY").trim();
		if (billCountry.equalsIgnoreCase("null")) billCountry = "";

		phone = ret.getFieldValueString(0,"ECA_PHONE").trim();
		if (phone.equalsIgnoreCase("null")) phone="";

		shipAddr1 = ret.getFieldValueString(0,"ECA_SHIP_ADDR_1").trim();
		if (shipAddr1.equalsIgnoreCase("null")) shipAddr1="";

		shipAddr2 = ret.getFieldValueString(0,"ECA_SHIP_ADDR_2").trim();
		if (shipAddr2.equalsIgnoreCase("null")) shipAddr2="";

		webAddr = ret.getFieldValueString(0,"ECA_WEB_ADDR").trim();
		if (webAddr.equalsIgnoreCase("null")) webAddr="";
	}
	
	
	

	
	
}catch(Exception e){}

String agent		=(String)session.getValue("Agent");
String sendToExt="N";
String subject="Change of Address Info for:"+agent;
String tbillAddr = billAddr1+","+billAddr2;


String msgExt ="<b>Change of Address Information for : "+agent+"</b><BR><BR> <b>Address</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "+tbillAddr+"<BR> <b>City</b> ¥&nbsp;¥&nbsp;¥&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "+billCity+"<BR> <b>Zip</b> &nbsp;¥&nbsp;¥&nbsp;¥&nbsp;¥&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "+billZip+"<BR> <b>State</b> ¥&nbsp;¥&nbsp;¥&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+billState+"<BR> <b>Country</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+billCountry+"<BR> <b>Phone</b> ¥&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;"+phone+"<BR> <b>Ship To Address1</b> &nbsp;&nbsp;&nbsp;\tspc;spc;spc;spc;"+shipAddr1+"<BR> <b>Ship To Address2</b> &nbsp;&nbsp;\tspc;spc;spc; "+shipAddr2+"<BR> <b>Web Address</b> \t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;spc;spc; "+webAddr+"<BR><BR> Regards,<BR> &nbsp;"+Session.getUserId();
String msgInt ="Change of Address Information for : "+agent+" \n \n Address  : "+tbillAddr+"\n City  : "+billCity+"\n Zip :"+billZip+"\n State "+billState+" \n Country "+billCountry+"\n Phone  "+phone+"\n Ship To Address1 "+shipAddr1+"\n Ship To Address2 "+shipAddr2+"\n Web Address "+webAddr+"\n\n Regards,\n "+Session.getUserId();

//String msgInt = "";
if(msgExt!=null)
{
	/*msgInt = msgExt.replaceAll("<BR>","\n");
	msgInt = msgInt.replaceAll("<b>","");
	msgInt = msgInt.replaceAll("</b>","");
	msgInt = msgInt.replaceAll("¥&nbsp;","");
	msgInt = msgInt.replaceAll("spc;","&nbsp;");
	*/
	msgExt = msgExt.replaceAll("¥","");
	msgExt = msgExt.replaceAll("\t","");
	msgExt = msgExt.replaceAll("spc;","");
}


	
%>
