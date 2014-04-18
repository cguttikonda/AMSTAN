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
String websyskey=request.getParameter("WebSysKey");

String bus_sysKey = request.getParameter("BPsyskey");
if(bus_sysKey!=null && !"null".equals(bus_sysKey))
	websyskey = bus_sysKey	;


	if(websyskey!=null)
	{
	if(!"sel".equals(websyskey) && !"All".equals(websyskey))
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
	else
	{
		if(websyskey.equals("All"))
		{
			websyskey="";
			int retCount = ret.getRowCount(); 
			for(int i=0;i<retCount;i++)
			{
				if(i==retCount-1)
				{
					websyskey=websyskey+"'"+ret.getFieldValueString(i,SYSTEM_KEY)+"'";
				}
				else
				{
					websyskey=websyskey+"'"+ret.getFieldValueString(i,SYSTEM_KEY)+"',";
				}
			}
			EzcUserNKParams ezcUserNKParamsU1 = new EzcUserNKParams();
			ezcUserNKParamsU1.setLanguage("EN");
			ezcUserNKParamsU1.setSys_Key(websyskey);
			uparamsU.createContainer();
			boolean result_flagU = uparamsU.setObject(ezcUserNKParamsU1);
			retuser =	(ReturnObjFromRetrieve)UserManager.getUsersForSalesArea(uparamsU);
			uRows=retuser.getRowCount();
		}

	}
	}

	String bus_user = request.getParameter("BusinessUser");
	if(bus_user==null || "null".equals(bus_user))
		bus_user = request.getParameter("BusUser");




%>