<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezwebstats.params.*" %>
<jsp:useBean id="WebStatsManager" class="ezc.ezwebstats.client.EzWebStatsManager">
</jsp:useBean>

<%


ReturnObjFromRetrieve retWebStats = null;
EzcParams mainParams = new EzcParams(false);
EziWebStatsParams  webStatparams= new EziWebStatsParams();
webStatparams.setSysKey(WebSysKey);
mainParams.setObject(webStatparams);
Session.prepareParams(mainParams);
System.out.println("Befor Web stats list Mehtod call");
retWebStats=(ReturnObjFromRetrieve)WebStatsManager.getToBeActivatedList(mainParams);
System.out.println("after Web stats list Mehtod call");

//out.println(retWebStats.toEzcString());





%>

