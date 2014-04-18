<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezwebstats.params.*" %>
<jsp:useBean id="WebStatsManager" class="ezc.ezwebstats.client.EzWebStatsManager">
</jsp:useBean>

<%
	try{
		String  defCatArea=(String)session.getValue("SYSKEY");;
		ReturnObjFromRetrieve retcat = null;
		EzcParams mainParams = new EzcParams(true);
		EziWebStatsParams  params= new EziWebStatsParams();
		params.setUserId(Session.getUserId());
		params.setSysKey(defCatArea);
		params.setIP(request.getRemoteAddr());
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		WebStatsManager.updateWebStats(mainParams);
	}catch(Exception e)
	{ 
		System.out.println("Exception Occured While Updating Web Stats");
	}
%>

