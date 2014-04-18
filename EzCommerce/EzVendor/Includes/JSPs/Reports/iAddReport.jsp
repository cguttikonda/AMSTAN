<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.client.*" %>

<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<%@ include file="../../../Includes/Lib/Systems.jsp"%>
<%
	// Key Variables
	ReturnObjFromRetrieve retsys = null;
	ezc.client.EzSystemConfigManager ezsc = new ezc.client.EzSystemConfigManager();//Get
	try
	{
		//Get List Of Systems
		EzcSysConfigParams sparams = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
		snkparams.setLanguage("EN");
		sparams.setObject(snkparams);
		Session.prepareParams(sparams);
		retsys = (ReturnObjFromRetrieve)ezsc.getSystemDesc(sparams);
		retsys.check();
	}
	catch (Exception e) 
	{
		e.printStackTrace();
	}
%>