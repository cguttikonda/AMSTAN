<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezwebstats.params.*" %>
<jsp:useBean id="WebStatsManager" class="ezc.ezwebstats.client.EzWebStatsManager"/>

<%
try{
	ezc.client.EzcPurchaseUtilManager PurManager=new ezc.client.EzcPurchaseUtilManager(Session);
	String  defCatArea=PurManager.getDefaultPurArea();
	ReturnObjFromRetrieve retcat = null;
	defCatArea = (String)session.getValue("SalesAreaCode");
	EzcParams mainParams = new EzcParams(true);
	EziWebStatsParams  params= new EziWebStatsParams();
	params.setUserId(Session.getUserId());
	params.setSysKey("999001");//defCatArea
	params.setIP(request.getRemoteAddr());
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	System.out.println("Befoe Update Method Call");

	WebStatsManager.updateWebStats(mainParams);
System.out.println("aFTER Update Method Call");
}catch(Exception e){ 
	System.out.println("Exception Occured While Updating Web Stats");

}


%>

