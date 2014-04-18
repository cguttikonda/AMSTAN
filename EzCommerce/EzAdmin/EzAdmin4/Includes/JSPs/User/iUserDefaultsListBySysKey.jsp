<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>


<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>



<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session">
</jsp:useBean>

<jsp:useBean id="SysConManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>


<%
// Key Variables
ReturnObjFromRetrieve retbp = null;
ReturnObjFromRetrieve retsyskey = null;
ReturnObjFromRetrieve retcust = null;
ReturnObjFromRetrieve retdef = null;
ReturnObjFromRetrieve reterpdef = null;
ReturnObjFromRetrieve retuser = null;

String userBP = null;
String bus_user= null;

//Get Business User Value
bus_user = request.getParameter("BusUser");
String websyskey=request.getParameter("WebSysKey");
String bus_sysKey = request.getParameter("BPsyskey");
if(bus_sysKey!=null && !"null".equals(bus_sysKey))
	websyskey = bus_sysKey	;


if(websyskey==null)
{
	bus_user="sel";
}
else
{
	if("sel".equals(websyskey))
		bus_user="sel";
}

int uRows=0;
if(!"sel".equals(websyskey))
{
	EzcUserParams uparamsU= new EzcUserParams();
	Session.prepareParams(uparamsU);
	EzcUserNKParams ezcUserNKParamsU = new EzcUserNKParams();
	ezcUserNKParamsU.setLanguage("EN");
	ezcUserNKParamsU.setSys_Key(websyskey);
	uparamsU.createContainer();
	boolean result_flagU = uparamsU.setObject(ezcUserNKParamsU);
	//Get All Users
	//retuser = (ReturnObjFromRetrieve)UserManager.getAllBussUsers(uparamsU);
	retuser =	(ReturnObjFromRetrieve)UserManager.getUsersForSalesArea(uparamsU);
	uRows=retuser.getRowCount();
}


//retuser.check();

if(bus_user!=null)
	{

		if(!"sel".equals(bus_user))
		{

			if(uRows>0)
			{
				bus_user = bus_user.trim();
				// System Configuration Class
				//EzSystemConfig ezc = new EzSystemConfig();
				EzcUserParams uparams= new EzcUserParams();
				EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
				EzcBussPartnerParams bparams = new EzcBussPartnerParams();
				EzcBussPartnerNKParams bNKParams = new EzcBussPartnerNKParams();
				ezcUserNKParams.setLanguage("EN");
				ezcUserNKParams.setSys_Key(websyskey);
				uparams.createContainer();
				uparams.setUserId(bus_user.trim());
				boolean result_flag1 = uparams.setObject(ezcUserNKParams);
				Session.prepareParams(uparams);

				//Get ERP Customer Defaults
				reterpdef = (ReturnObjFromRetrieve)UserManager.getAddCatAreaUserDefaults(uparams);
				reterpdef.check();


			}
		}
	}

%>