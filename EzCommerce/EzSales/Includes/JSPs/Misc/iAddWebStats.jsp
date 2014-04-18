<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezwebstats.params.*" %>
<jsp:useBean id="WebStatsManager" class="ezc.ezwebstats.client.EzWebStatsManager">
</jsp:useBean>

<%
	try
	{
		ReturnObjFromRetrieve retcat = null;
		EzcParams mainParams = new EzcParams(true);
		EziWebStatsParams  params= new EziWebStatsParams();
		params.setUserId(Session.getUserId());
		params.setSysKey((String)session.getValue("SalesAreaCode"));
		params.setIP(request.getRemoteAddr());
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		
		ezc.ezcommon.EzLog4j.log("ADDING USER WEB STATS INFO STARTS","I");
		WebStatsManager.addWebStats(mainParams);
		ezc.ezcommon.EzLog4j.log("ADDING USER WEB STATS INFO ENDS","I");
	}catch(Exception e)
	{}
%>

