<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>
<%@ include file="../../../Includes/Lib/Currency.jsp"%>

<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>



<jsp:useBean id="ConfigManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>


<%
// Key Variables
ReturnObjFromRetrieve retdef = null;
ReturnObjFromRetrieve reterpdef = null;
ReturnObjFromRetrieve retcur = null;

String userBP = null;
String bus_user= null;
String bus_sysKey = request.getParameter("BPsyskey");
String websyskey=request.getParameter("WebSysKey");
if(bus_sysKey!=null && !"null".equals(bus_sysKey))
	websyskey = bus_sysKey	;
//Get Business User Value
bus_user = request.getParameter("BusUser");
EzcUserParams uparamsU= new EzcUserParams();
Session.prepareParams(uparamsU);
ReturnObjFromRetrieve retuser=null;
int uRows=0;


if(websyskey!=null)
{
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
}


if(websyskey!=null)
{
	if("sel".equals(websyskey))
	{
		bus_user="sel";
	}
}



if(websyskey!=null)
{
	if(!"sel".equals(websyskey))
	{
		if(bus_user!=null)
		{

			if(!"sel".equals(bus_user))
			{

			EzcUserParams uparams = new EzcUserParams();
			EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
			ezcUserNKParams.setLanguage("EN");
			uparams.setUserId(bus_user);
			uparams.createContainer();
			uparams.setObject(ezcUserNKParams);
			Session.prepareParams(uparams);

			// System Configuration Class
			//EzSystemConfig ezsc = new EzSystemConfig();
			//Read Selected Languages
			EzcSysConfigParams sparamsdef = new EzcSysConfigParams();
			EzcSysConfigNKParams snkparamsdef = new EzcSysConfigNKParams();
			snkparamsdef.setLanguage("EN");
			sparamsdef.setObject(snkparamsdef);
			Session.prepareParams(sparamsdef);
			retdef = (ReturnObjFromRetrieve)ConfigManager.getLangKeys(sparams);
			retdef.check();
			//ret = ezc.getLangKeys();

			//Get Valid Currencies
			EzcSysConfigParams sparams1 = new EzcSysConfigParams();
			EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
			snkparams1.setLanguage("EN");

			sparams1.setObject(snkparams1);
			Session.prepareParams(sparams1);
			retcur = (ReturnObjFromRetrieve) ConfigManager.getCurrencyDesc(sparams1);
			retcur.check();

			//Get ERP Customer Defaults
			reterpdef = (ReturnObjFromRetrieve)UserManager.getAddUserDefaults(uparams);
			reterpdef.check();
			//reterpdef = AdminObject.getAddUserDefaults(servlet, bus_user, null);
		}
	}
}
}

%>