<%@ page import = "ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO,ezc.ezparam.*" %>
<%
	ReturnObjFromRetrieve retObjPlants = new ReturnObjFromRetrieve(new String[]{"PLANTCODE","PLANTNAME","SALESORG"});

	com.sap.mw.jco.JCO.Function functionPlant = null;
	com.sap.mw.jco.JCO.Client clientPlant = null;

	String site_S = (String)session.getValue("Site");
	String skey_S = "999";
	
		
	try
	{
		functionPlant = EzSAPHandler.getFunction("RFC_READ_TABLE",site_S+"~"+skey_S);
		clientPlant = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);

		JCO.ParameterList paramIn    = functionPlant.getImportParameterList();
		JCO.ParameterList paramTable = functionPlant.getTableParameterList();

		JCO.Table fields  = paramTable.getTable("FIELDS");

		paramIn.setValue("T001W","QUERY_TABLE");
		paramIn.setValue("#","DELIMITER");

		fields.appendRow();
		fields.setValue("WERKS","FIELDNAME");
		fields.appendRow();
		fields.setValue("NAME1","FIELDNAME");
		fields.appendRow();
		fields.setValue("VKORG","FIELDNAME");

		JCO.Table options  = paramTable.getTable("OPTIONS");

		options.appendRow();
		options.setValue("","TEXT");

		try
		{
			clientPlant.execute(functionPlant);
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception while executing RFC call RFC_READ_TABLE"+e,"I");
		}

		JCO.ParameterList  paramOut = functionPlant.getExportParameterList();
		JCO.Table 	  fieldsOut = functionPlant.getTableParameterList().getTable("DATA");

		int fieldsOutCount = fieldsOut.getNumRows();

		if(fieldsOutCount>0)
		{
			do
			{
				String plantStr = (String)fieldsOut.getValue("WA");

				String plantCode = "";
				String plantName = "";
				String salesOrg  = "";

				try
				{
					plantCode = plantStr.split("#")[0];
				}
				catch(Exception e){}
				try
				{
					plantName = plantStr.split("#")[1];
				}
				catch(Exception e){}
				try
				{
					salesOrg  = plantStr.split("#")[2];
				}
				catch(Exception e){}

				retObjPlants.setFieldValue("PLANTCODE",plantCode);
				retObjPlants.setFieldValue("PLANTNAME",plantName);
				retObjPlants.setFieldValue("SALESORG",salesOrg);
				
				retObjPlants.addRow();
				
				
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
		if (clientPlant!=null)
		{
			ezc.ezcommon.EzLog4j.log("R E L E A S I N G   C L I E N T .... ","I");
			JCO.releaseClient(clientPlant);
			clientPlant = null;
			functionPlant=null;
		}
	}
	//out.println("retObjPlants::"+retObjPlants.toEzcString());
%>