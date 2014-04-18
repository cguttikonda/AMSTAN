<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@page import="com.sap.mw.jco.JCO"%>
<%
	JCO.Function function = null;
	JCO.Client client = null;
	client = EzSAPHandler.getSAPConnection();
	function= EzSAPHandler.getFunction("Z_EZ_PO_POST_PATCH");
	JCO.ParameterList sapImpParam = function.getImportParameterList();

	sapImpParam.setValue("4500000360","PONUM");

	sapImpParam.setValue("ABNDB","HOUSEBANKID");
	sapImpParam.setValue("X","ISIMPORTPO");
	sapImpParam.setValue("I1","RELEASECODE");


System.out.println("funciton="+function);
System.out.println("client="+client);

	client.execute(function);
	EzSAPHandler.commit(client);

	JCO.Table retOut = function.getTableParameterList().getTable("MESSTAB");
	out.println("---------------------------------"+retOut.toString());
	
	
		if (client!=null){
					System.out.println("R E L E A S I N G   C L I E N T .... ");
					JCO.releaseClient(client);
					client = null;
					function=null;
			}
%>