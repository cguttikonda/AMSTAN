<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/Users.jsp"%>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>



<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session">
</jsp:useBean>

<%@ include file="../../Lib/ArmsConfig.jsp" %>


<%
	EzcParams einParams = new EzcParams(false);
	Session.prepareParams( einParams );
	ReturnObjFromRetrieve retRoles = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( einParams );
%>


<%
// Key Variables
ReturnObjFromRetrieve retuserinfo = null;
ReturnObjFromRetrieve retbpsys = null;
ReturnObjFromRetrieve retauth = null;
ReturnObjFromRetrieve retuserauth = null;
ReturnObjFromRetrieve retuser = null;
ReturnObjFromRetrieve retFinal = null;
int uRows=0;
EzcUserParams uparamsU= new EzcUserParams();
Session.prepareParams(uparamsU);

String bus_sysKey = request.getParameter("BPsyskey");
String websyskey=request.getParameter("WebSysKey");

if(bus_sysKey!=null && !"null".equals(bus_sysKey))
	websyskey = bus_sysKey	;


	if(!"sel".equals(websyskey))
	{
		EzcUserNKParams ezcUserNKParamsU = new EzcUserNKParams();
		ezcUserNKParamsU.setLanguage("EN");
		ezcUserNKParamsU.setSys_Key(websyskey);
		uparamsU.createContainer();
		boolean result_flagU = uparamsU.setObject(ezcUserNKParamsU);

		//Get All Users
		//retuser = (ReturnObjFromRetrieve)UserManager.getAllBussUsers(uparamsU);
		retuser =	(ReturnObjFromRetrieve)UserManager.getUsersForSalesArea(uparamsU);
		retuser.check();
		uRows=retuser.getRowCount();

	}

	String bus_user = request.getParameter("BusUser");
		if("sel".equals(websyskey))
		{
			bus_user="sel";
		}



if(!"sel".equals(websyskey)){

//Get Selected User Value



	if(bus_user!=null)
	{

		if(!"sel".equals(bus_user))
		{
			EzcUserParams uparams= new EzcUserParams();
			EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
				EzcBussPartnerParams bparams = new EzcBussPartnerParams();
			EzcBussPartnerNKParams bNKParams = new EzcBussPartnerNKParams();

				ezcUserNKParams.setLanguage("EN");
			uparams.createContainer();
			uparams.setUserId(bus_user);
			boolean result_flag = uparams.setObject(ezcUserNKParams);
			Session.prepareParams(uparams);

			// Get Basic User Information
			retuserinfo = (ReturnObjFromRetrieve)UserManager.getUserData(uparams);
			retuserinfo.check();

			String Bus_Partner = (String)(retuserinfo.getFieldValue(0,USER_BUSINESS_PARTNER));



			String pf[] = {"AG","VN"};
			EzcUserParams uparamsUA = new EzcUserParams();
			EzcUserNKParams ezcUserNKParamsUA = new EzcUserNKParams();
			ezcUserNKParamsUA.setLanguage("EN");
			ezcUserNKParamsUA.setPartnerFunctions(pf);
			uparamsUA.setUserId(bus_user.trim());
			uparamsUA.setBussPartner(Bus_Partner.trim());
			uparamsUA.setObject(ezcUserNKParamsUA);
			Session.prepareParams(uparamsUA);
			retFinal = (ReturnObjFromRetrieve) UserManager.getUserAllowedAuthorizations(uparamsUA);
		}
	}
}

%>