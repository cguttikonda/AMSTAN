<%
	ezc.ezcommon.EzLog4j.log("ATP FM START","F");
	
	String salesOrg  = atpInputsRet.getFieldValueString(0,"SALESORG");
	String distChannel  = atpInputsRet.getFieldValueString(0,"DIST_CHANNEL");
	String division  = atpInputsRet.getFieldValueString(0,"DIVISON");
	String soldTo  = atpInputsRet.getFieldValueString(0,"SOLDTO");
	String shipTo  = atpInputsRet.getFieldValueString(0,"SHIPTO");
	String region  = atpInputsRet.getFieldValueString(0,"REGION");
	
	String prodCdes = "";
	String ordQtys  = "";

	JCO.Client client=null;
	JCO.Function functionEx = null;	
	try
	{
		DateFormat formatter1;
		Date DateFrom = new Date();
		formatter1 = new SimpleDateFormat("MM/dd/yyyy");

		DateFrom = (Date)formatter1.parse(atpion); 

		String site_S = (String)session.getValue("Site");
		String skey_S = "998";

		functionEx 		  = EzSAPHandler.getFunction("Z_EZ_GET_MATERIAL_AVAILABILITY",site_S+"~"+skey_S);
		JCO.ParameterList atpProc = functionEx.getImportParameterList();
		JCO.Table zMat 		  = functionEx.getTableParameterList().getTable("ZMATERIAL");

		atpProc.setValue(salesOrg,"SALES_ORGANIZATION");
		atpProc.setValue(distChannel,"DISTRI_CHANNEL");
		atpProc.setValue(division,"DIVISON");

		atpProc.setValue(soldTo,"KUNNR");
		atpProc.setValue(shipTo,"KUNWE");
		atpProc.setValue(region,"REGIO");

		if(atpQtyPrdRet!=null && atpQtyPrdRet.getRowCount()>0)
		{
			for(int i=0;i<atpQtyPrdRet.getRowCount();i++)
			{
				prodCdes  = atpQtyPrdRet.getFieldValueString(i,"PROCODES");
				ordQtys  = atpQtyPrdRet.getFieldValueString(i,"ORD_QTY");
			
				zMat.appendRow();
				zMat.setValue(prodCdes,"MATERIAL");
				zMat.setValue(DateFrom,"REQ_DATE");
				zMat.setValue(ordQtys,"REQ_QTY");
			}
		}			

		try
		{
			client = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);				
			client.execute(functionEx);

		}
		catch(Exception ec)
		{
			out.println(":::::::::::::::::::ec::::::::::::::::::::"+ec);
		}
		JCO.Table atpResultTable = functionEx.getTableParameterList().getTable("RESULT");
		ezc.ezcommon.EzLog4j.log("ATP::JCO:::ALL:::TEST::END","F");

		if(atpResultTable!=null)
		{				
			if (atpResultTable.getNumRows() > 0)
			{	

				do
				{						
					atpResultRet.setFieldValue("MATERIAL",atpResultTable.getValue("MATERIAL"));

					String matrCode = (String)atpResultTable.getValue("MATERIAL");

					if("".equals(prodCodeStr))
						prodCodeStr = matrCode;
					else
						prodCodeStr = prodCodeStr+"','"+matrCode;

					atpResultRet.setFieldValue("MATERIALDESC",atpResultTable.getValue("MFRPN"));
					atpResultRet.setFieldValue("AVAILQTY",atpResultTable.getValue("AVAIL_QTY"));
					atpResultRet.setFieldValue("PLANT",atpResultTable.getValue("PLANT"));	
					atpResultRet.setFieldValue("PLANTDESC",atpResultTable.getValue("PLANTDESC"));	
					atpResultRet.setFieldValue("STATUS",atpResultTable.getValue("STATUS"));											
					atpResultRet.setFieldValue("UPC",atpResultTable.getValue("EAN11"));	
					atpResultRet.setFieldValue("ENDLEADTIME",atpResultTable.getValue("ENDLEADTME"));	
					atpResultRet.addRow();  
				}
				while(atpResultTable.nextRow());
			}
		}
		JCO.Table atpZMatTable 	 = functionEx.getTableParameterList().getTable("ZMATERIAL");		
		if(atpZMatTable!=null)
		{				
			if (atpZMatTable.getNumRows() > 0)
			{					
				do
				{	
					int varHM = 1;
					String material = (String)atpZMatTable.getValue("MATERIAL");

					atpZMaterialRet.setFieldValue("MATERIAL",atpZMatTable.getValue("MATERIAL"));
					atpZMaterialRet.setFieldValue("REQQTY",atpZMatTable.getValue("REQ_QTY"));											
					atpZMaterialRet.addRow();

					zMatHM.put(atpZMatTable.getValue("MATERIAL"),atpZMatTable.getValue("REQ_QTY"));
				}
				while(atpZMatTable.nextRow());
			}
		}

	}
	catch(Exception e)
	{
		out.println("EXCEPTION>>>>>>"+e);
	}
	finally
	{
		if (client!=null)
		{
			JCO.releaseClient(client);
			client = null;
			functionEx=null;
		}
	}
%>