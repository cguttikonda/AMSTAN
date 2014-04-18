<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@page import="com.sap.mw.jco.JCO"%>
<%@ page import ="java.util.*,ezc.ezutil.*" %>
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%

	JCO.Function function= EzSAPHandler.getFunction("Z_EZ_GET_PURCHASE_ORDERS");
	JCO.ParameterList importParameter = function.getImportParameterList();

	importParameter.setValue("1000","PURCH_ORG");
	importParameter.setValue("351","PUR_GROUP");
	importParameter.setValue("####","MATERIAL");
	importParameter.setValue("1100000044","VENDOR");
	importParameter.setValue(new Date(),"DOC_DATE");
	importParameter.setValue("A","ITEMS_OPEN_FOR_RECEIPT");
	importParameter.setValue("K","DOC_CATEGORY");

	JCO.Client client = EzSAPHandler.getSAPConnection();
	client.execute(function);
	EzSAPHandler.commit(client);
	
	JCO.Table messageTable = function.getTableParameterList().getTable("PURORDLIST");
	int messCount = messageTable.getNumRows();
	if(messCount==0)
		out.println("messCount-------------------------"+messCount);
	else
		System.out.println("messageTable-------------------------"+messageTable);//+messageTable.toString());

	if (client!=null)
	{
		JCO.releaseClient(client);
		client = null;
		function=null;
	}
%>

