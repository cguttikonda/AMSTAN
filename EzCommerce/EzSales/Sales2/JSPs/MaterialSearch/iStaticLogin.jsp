<%@ page import="java.util.*" %>
<%@ page import="ezc.ezparam.*" %>
<jsp:useBean id="esManager" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>
<%
	ezc.session.EzLogonStructure logs = new ezc.session.EzLogonStructure();
	logs.setUserId("ONETIMECU");
	logs.setPassWd("onetimecu");
	
	/*logs.setUserId("onetime");
	logs.setPassWd("onetime");*/
	
	logs.setConnGroup("111");
	ezc.ezparam.EzLogonStatus LogonStatus =  (ezc.ezparam.EzLogonStatus)Session.logon(logs);
	ezc.ezparam.EzDefReturn ezDefSales = Session.isValidSalesUser();
%>	