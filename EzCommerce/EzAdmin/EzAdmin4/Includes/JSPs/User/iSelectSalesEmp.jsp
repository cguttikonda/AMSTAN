<%@ page import = "ezc.ezparam.*,ezc.ezdrlsales.params.*" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="DrlManager" class="ezc.ezdrlsales.client.EzDrlSalesManager" scope="session" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
	

	EzcUserParams uparams= new EzcUserParams();
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	ezcUserNKParams.setPartnerFunctions(new String[]{"AG"});
	uparams.setObject(ezcUserNKParams);
	Session.prepareParams(uparams);
	ReturnObjFromRetrieve retuser = (ReturnObjFromRetrieve) UserManager.getAllUsers(uparams);
	String[] sortKey = {"EU_ID"};
	retuser.sort( sortKey, true);

	String user_id =request.getParameter ("UserID");
	if (user_id==null)
		user_id=retuser.getFieldValueString(0,"EU_ID");

	
	
	String alert =request.getParameter ("Alert");

	uparams.setUserId(user_id);
	ReturnObjFromRetrieve myRet=(ReturnObjFromRetrieve)UserManager.getUserCustomers(uparams);
	String cust=myRet.getFieldValueString(0,"EC_ERP_CUST_NO");
	String bp=myRet.getFieldValueString(0,"EC_BUSINESS_PARTNER");
	String cname=myRet.getFieldValueString(0,"ECA_COMPANY_NAME");


	EzcParams params=new EzcParams(false);
	
	EzDrlSalesParams sparams=new EzDrlSalesParams();
	sparams.setSoldTo(cust);
	sparams.setPartnerFunction(bp);	//Using to set partner
	sparams.setRequestFlag("select");	//Using in inputconversion to diff queries.
	params.setObject(sparams);
	Session.prepareParams(params);
	ReturnObjFromRetrieve retEmp=(ReturnObjFromRetrieve)DrlManager.ezChangeSalesEmployee(params);

%>