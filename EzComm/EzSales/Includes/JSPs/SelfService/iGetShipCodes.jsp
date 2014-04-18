<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"></jsp:useBean>
<%@ page import="java.util.*,javax.servlet.*,javax.servlet.http.*,ezc.ezbasicutil.*,java.io.*" %>
<%@ page import="java.text.*" %>
<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<%@ page import="ezc.ezparam.*"%>
<%
	String userId	= (String)session.getValue("UserId");
	ezc.ezparam.EzcParams mainParamsShips		= null;
	ezc.ezmisc.params.EziMiscParams miscParamsShips	= new ezc.ezmisc.params.EziMiscParams();
	ezc.ezparam.ReturnObjFromRetrieve retShipCodes	= null;
	
	mainParamsShips	= new ezc.ezparam.EzcParams(true);

	miscParamsShips.setIdenKey("MISC_SELECT");
	String queryShip	= "SELECT EUD_VALUE FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID='"+userId+"' and EUD_KEY='SHIPTOPARTY'";
	miscParamsShips.setQuery(queryShip);

	mainParamsShips.setLocalStore("Y");
	mainParamsShips.setObject(miscParamsShips);
	Session.prepareParams(mainParamsShips);
	try
	{
		retShipCodes	= (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsShips);
	}
	catch(Exception e)
	{
		System.out.println("ERROR::::::::::::::::::::"+e);
	}	
%>
	