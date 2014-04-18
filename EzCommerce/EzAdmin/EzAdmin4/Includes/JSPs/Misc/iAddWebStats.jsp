<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezwebstats.params.*" %>
<jsp:useBean id="WebStatsManager" class="ezc.ezwebstats.client.EzWebStatsManager">
</jsp:useBean>

<%
try{
ReturnObjFromRetrieve retcat = null;
EzcParams mainParams = new EzcParams(true);
EziWebStatsParams  params= new EziWebStatsParams();
params.setUserId(Session.getUserId());
params.setSysKey("111222");
params.setIP(request.getRemoteAddr());
mainParams.setObject(params);
Session.prepareParams(mainParams);
WebStatsManager.addWebStats(mainParams);
}catch(Exception e){}


%>

