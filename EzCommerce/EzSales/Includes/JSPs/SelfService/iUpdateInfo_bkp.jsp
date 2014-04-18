<%@ page import ="ezc.ezparam.*"%>
<%@ page import = "ezc.ezparam.EzCustomerAddrStructure"%>
<%@ page import="java.util.ResourceBundle,java.util.Enumeration"%>
<%@ page import="ezc.forums.params.*,ezc.messaging.params.*,ezc.trans.messaging.params.*" %>
<%@ page import="ezc.client.*,ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="ezc.ezvendor.csb.*" %>
<%@ page import ="ezc.client.EzcUtilManager"%>
<jsp:useBean id="Manager" class="ezc.client.EzMessagingManager" scope="session"/>
<jsp:useBean id="CustomerManager" class="ezc.ezcustomer.client.EzCustomerManager" scope = "page"/>
<jsp:useBean id="MsgManager" class="ezc.client.EzMessagingManager" scope="session">
</jsp:useBean>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddress.jsp"%>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>
<%
	String language = "EN";
	String companyName="", billAddr1="", billAddr2="", billCity="", billState="", billZip="", billCountry="",shipAddr1="",shipAddr2="",webAddr="",phone="";
	String sendToUser = "";
	String to 	  = "";
	
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
	ezc.ezparam.ReturnObjFromRetrieve retsoldto = null;
	
	String template=(String)session.getValue("Templet");
	String group=(String)session.getValue("UserGroup");
	String userRole = (String)session.getValue("UserRole");
	String catalog_area=(String)session.getValue("SalesAreaCode");
	Hashtable allUsers=new Hashtable();	
	String user = Session.getUserId();
	
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
	
	
	
//**********This for reteriving internal user List  *************//
	
	
		


		String participant="";
		ArrayList desiredStep=new ArrayList();
		desiredStep.add("-1");
		//desiredStep.add("-2");
		//desiredStep.add("-3");
		//desiredStep.add("1");
		//desiredStep.add("2");
		//desiredStep.add("3");


		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
		params.setTemplate(template);
		params.setSyskey(catalog_area);
		params.setParticipant((String)session.getValue("Participant"));


		//params.setDesiredStep((String)desiredStep.get(i));
		params.setDesiredSteps(desiredStep);

		mainParams.setObject(params);

		Session.prepareParams(mainParams);


		retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams);
		
//********** End of reteriving internal user List*************/
	
	
	
	if(retsoldto!=null)
	{
		for(int j=0;j<retsoldto.getRowCount();j++)
		{
			sendToUser=sendToUser+retsoldto.getFieldValueString(j,"EU_ID")+",";
			to = to+retsoldto.getFieldValueString(j,"EU_EMAIL")+",";
		}
	}
	sendToUser=sendToUser.substring(0,sendToUser.length()-1);
	to=to.substring(0,to.length()-1);
	
	
}catch(Exception e){}

String msg ="Change of Address Information for : "+agent+"<br><br> Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+tbillAddr+"<br> City &nbsp;\t\t&nbsp;&nbsp;&nbsp;&nbsp; "+billCity+"<br> Zip\t\t&nbsp;&nbsp;&nbsp;&nbsp; "+billZip+"<br> State \t\t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+billState+"<br> Country \t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+billCountry+"<br> Phone\t\t &nbsp;&nbsp;&nbsp;&nbsp;"+phone+"<br> Ship To Address1 &nbsp;&nbsp;&nbsp;"+shipAddr1+"<br> Ship To Address2 &nbsp;&nbsp;&nbsp;"+shipAddr2+"<br> Web Address &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "+webAddr+"<br><br> Regards,<br> &nbsp;"+Session.getUserId();

	
%>
