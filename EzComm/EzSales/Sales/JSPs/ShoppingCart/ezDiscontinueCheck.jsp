<%@ page import = "ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO,ezc.ezparam.*" %>
<%

	com.sap.mw.jco.JCO.Function functionDis = null;
	com.sap.mw.jco.JCO.Client clientDis = null;

	String site_S = (String)session.getValue("Site");
	String skey_S = "999";
	
	String matDelIndicator = "NA";
	String DistChanDis = (String)session.getValue("dc");
	String salesOrgDis = (String)session.getValue("salesOrg");
	
	try
	{
		functionDis = EzSAPHandler.getFunction("RFC_READ_TABLE",site_S+"~"+skey_S);
		clientDis = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);

		JCO.ParameterList paramIn    = functionDis.getImportParameterList();
		JCO.ParameterList paramTable = functionDis.getTableParameterList();

		JCO.Table fields  = paramTable.getTable("FIELDS");

		paramIn.setValue("MVKE","QUERY_TABLE");
		paramIn.setValue("#","DELIMITER");

		/*fields.appendRow();
		fields.setValue("MATNR","FIELDNAME");
		fields.appendRow();
		fields.setValue("WERKS","FIELDNAME");
		*/
		
		fields.appendRow();
		fields.setValue("VMSTA","FIELDNAME");
		
		
		JCO.Table options  = paramTable.getTable("OPTIONS");

		options.appendRow();
		options.setValue("MATNR = '"+prodCode+"' AND  VKORG = '"+salesOrgDis+"' AND VTWEG = '"+DistChanDis+"'","TEXT");

		try
		{
			clientDis.execute(functionDis);
		}catch(Exception e){
			ezc.ezcommon.EzLog4j.log("Exception while executing RFC call RFC_READ_TABLE"+e,"I");
		}	

		JCO.ParameterList  paramOut = functionDis.getExportParameterList();
		JCO.Table 	  fieldsOut = functionDis.getTableParameterList().getTable("DATA");


		int fieldsOutCount = fieldsOut.getNumRows();

		if(fieldsOutCount>0)
		{
			do
			{
				matDelIndicator = (String)fieldsOut.getValue("WA");
			}
			while(fieldsOut.nextRow());
		}
	}
	catch(Exception e)
	{
		ezc.ezcommon.EzLog4j.log("Exception while getting plant codes from SAP ::::"+e,"I");
	}
	finally
	{
		if (clientDis!=null)
		{
			ezc.ezcommon.EzLog4j.log("R E L E A S I N G   C L I E N T .... ","I");
			JCO.releaseClient(clientDis);
			clientDis = null;
			functionDis=null;
		}
	}
	
	//out.println(":::matDelIndicator:::::"+matDelIndicator);
%>