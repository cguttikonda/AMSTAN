<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@page import="com.sap.mw.jco.JCO"%>
<%@ page import ="java.util.*,ezc.ezutil.*" %>
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>

<%
	JCO.Function function= EzSAPHandler.getFunction("Z_EZ_PO_POST_PATCH");
	JCO.ParameterList sapImpParam = function.getImportParameterList();

	sapImpParam.setValue("4500011315","PONUM");
	sapImpParam.setValue("ABNDB","HOUSEBANKID");
	sapImpParam.setValue("X","ISIMPORTPO");
	
	JCO.Client client = EzSAPHandler.getSAPConnection();
	client.execute(function);
	EzSAPHandler.commit(client);
	
	JCO.Table messageTable = function.getTableParameterList().getTable("MESSTAB");
	out.println("messageTable-------------------------"+messageTable.toString());
	
	if (client!=null)
	{
		JCO.releaseClient(client);
		client = null;
		function=null;
	}
%>

