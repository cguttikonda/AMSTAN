<%@ page import ="ezc.ezparam.*"%>
<%@ page import="java.util.ResourceBundle,java.util.Enumeration"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddress.jsp"%>
<%@ page import ="ezc.client.EzcUtilManager"%>
<jsp:useBean id="CustomerManager" class="ezc.ezcustomer.client.EzCustomerManager" scope = "page"/>

<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>

<%
		String template=(String)session.getValue("Templet");

		//out.println("******template****"+template);
		String group=(String)session.getValue("UserGroup");
		String userRole = (String)session.getValue("UserRole");
		String catalog_area=(String)session.getValue("SalesAreaCode");

		Hashtable allUsers=new Hashtable();


		String participant="";
		ArrayList desiredStep=new ArrayList();
		desiredStep.add("-1");
		desiredStep.add("-2");
		desiredStep.add("-3");
		desiredStep.add("1");
		desiredStep.add("2");
		desiredStep.add("3");


		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
		params.setTemplate(template);
		params.setSyskey(catalog_area);
		params.setParticipant((String)session.getValue("Participant"));

		//for(int i=0;i<desiredStep.size();i++)
		//{
			//params.setDesiredStep((String)desiredStep.get(i));
			params.setDesiredSteps(desiredStep);

			mainParams.setObject(params);

			Session.prepareParams(mainParams);

			ezc.ezparam.ReturnObjFromRetrieve retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams);

			if(retsoldto!=null)
			{
				for(int j=0;j<retsoldto.getRowCount();j++)
				{			
					allUsers.put(retsoldto.getFieldValueString(j,"EU_ID"),retsoldto.getFieldValueString(j,"EU_FIRST_NAME")+"^"+retsoldto.getFieldValueString(j,"EU_LAST_NAME"));
				}
			}
		//}

	
	String defPartnNum ="";

	String shipAddr1="";
	String shipAddr2="";
	String webAddr="";
	String CompName="";
	String addrLine2="";
	String addrLine3="";
	String City="";
	String State="";
	String Zip="";
	String Country="";
	String phone="";
	

	EzcCustomerParams customerParams = new EzcCustomerParams();
	EzCustomerStructure ezCustomerStructure = new EzCustomerStructure();
	ezCustomerStructure.setLanguage("EN");
	customerParams.setObject(ezCustomerStructure);
	Session.prepareParams(customerParams);
	ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)CustomerManager.getCustomerAddress(customerParams);
	int retCount=ret.getRowCount();

	if(retCount >0)
	{

		defPartnNum=ret.getFieldValueString(0,"ECA_NO").trim();
		if (defPartnNum.equalsIgnoreCase("null")) defPartnNum="";

		CompName=ret.getFieldValueString(0,"ECA_COMPANY_NAME").trim();
		if (CompName.equalsIgnoreCase("null")) CompName="";

		Zip=ret.getFieldValueString(0,"ECA_PIN").trim();
		if (Zip.equalsIgnoreCase("null")) Zip="";

		City=ret.getFieldValueString(0,"ECA_SHIP_CITY").trim();
		if (City.equalsIgnoreCase("null")) City="";

		State=ret.getFieldValueString(0,"ECA_STATE").trim();
		if (State.equalsIgnoreCase("null")) State="";

		Country=ret.getFieldValueString(0,"ECA_COUNTRY").trim();
		if (Country.equalsIgnoreCase("null")) Country="";

		addrLine2=ret.getFieldValueString(0,"ECA_ADDR_1").trim();
		if (addrLine2.equalsIgnoreCase("null")) addrLine2="";

		addrLine3=ret.getFieldValueString(0,"ECA_ADDR_2").trim();
		if (addrLine3.equalsIgnoreCase("null")) addrLine3="";

		phone = ret.getFieldValueString(0,"ECA_PHONE").trim();
		if (phone.equalsIgnoreCase("null")) phone="";


		shipAddr1 = ret.getFieldValueString(0,"ECA_SHIP_ADDR_1").trim();
		if (shipAddr1.equalsIgnoreCase("null")) shipAddr1="";

		shipAddr2 = ret.getFieldValueString(0,"ECA_SHIP_ADDR_2").trim();
		if (shipAddr2.equalsIgnoreCase("null")) shipAddr2="";

		webAddr = ret.getFieldValueString(0,"ECA_WEB_ADDR").trim();
		if (webAddr.equalsIgnoreCase("null")) webAddr="";
	}
%>
