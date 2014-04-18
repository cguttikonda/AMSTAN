

<%@ page import="ezc.ezparam.*" %>


<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session">
</jsp:useBean>
<jsp:useBean id="CatalogManager" class="ezc.client.EzCatalogManager" scope="session">
</jsp:useBean>
<jsp:useBean id="ezc" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="UtilityManager" class="ezc.client.EzUtilityManager" scope="session">
</jsp:useBean>
<jsp:useBean id="VendorManager" class="ezc.client.EzVendorManager" scope="session">
</jsp:useBean>


<%
//ezc.client.EzcUtilManager UtilityManager = new ezc.client.EzcUtilManager(Session);


%>