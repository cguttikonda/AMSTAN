<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%
	String docNumber_U 	= tempDocNo_U;
	String docType_U 	= tempDocType_U;
	String relType_U 	= "URL";
	String docTitle_U 	= "MyASBP.com";
	String urlLink_U 	= tempUrlLink_U;

	JCO.Client client_U = null;
	JCO.Function function_U = null;

	String site_S = (String)session.getValue("Site");
	String skey_S = "999";

	try
	{
		client_U = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
		function_U = EzSAPHandler.getFunction("Z_EZ_DOCATT_UPLOAD",site_S+"~"+skey_S);
		JCO.ParameterList docDetail = function_U.getImportParameterList();

		docDetail.setValue(docNumber_U,"DOC_NUMBER");
		docDetail.setValue(docType_U,"DOC_TYPE");
		docDetail.setValue(relType_U,"RELATIONTYPE");
		docDetail.setValue(docTitle_U,"DOCUMENT_TITLE");
		docDetail.setValue(urlLink_U,"URL");

		client_U.execute(function_U);
	}
	catch(Exception e){}
	finally
	{
		if(client_U!=null)
		{
			JCO.releaseClient(client_U);
			client_U = null;
			function_U=null;
		}
	}
%>