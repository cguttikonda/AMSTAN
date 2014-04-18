<%

      ReturnObjFromRetrieve inputParams = (ReturnObjFromRetrieve)session.getValue("RETOBJ");
      EzShipmentHeaderStructure outParams = (EzShipmentHeaderStructure)shipParams2.getObject("ezc.ezshipment.params.EzShipmentHeaderStructure");

	String[] commonMapper = new String[25];
	String[] inputValues = new String[25];
	String[] outputValues = new String[25];
	
	commonMapper[0] = "ShipId";
	commonMapper[1] = "ExpectedArivalTime";
	commonMapper[2] = "DeliveryChallanNumber";
	commonMapper[3] = "DeliveryChallanDate";
	commonMapper[4] = "PurchaseOrderNumber";
	commonMapper[5] = "PurchaseOrderRev";
	commonMapper[6] = "PurchaseOrderDate";
	commonMapper[7] = "InvoiceNumber";
	commonMapper[8] = "InvoiceDate";
	commonMapper[9] = "CreatedBy";
	commonMapper[10] = "CreatedOn";
	commonMapper[11] = "LastModifiedOn";
	commonMapper[12] = "Lr_rr_air_nr";
	commonMapper[13] = "ShipmentDate";	
	commonMapper[14] = "Carrier";
	commonMapper[15] = "Status";
	commonMapper[16] = "Text";
	commonMapper[17] = "Type";
	commonMapper[18] = "Syskey";
	commonMapper[19] = "SoldTo";
	commonMapper[20] = "DocsAttached";
	commonMapper[21] = "Ext1";
	commonMapper[22] = "Ext2";
	commonMapper[23] = "Ext3";
	commonMapper[24] = "UploadId";
	
    outputValues[0] = outParams.getShipId();   inputValues[0] = inputParams.getFieldValueString(0,"SH_ID");
    outputValues[1] = outParams.getExpectedArivalTime();   inputValues[1] = inputParams.getFieldValueString(0,"EXP_ARIVAL_TIME");
    outputValues[2] = outParams.getDeliveryChallanNumber();   inputValues[2] = inputParams.getFieldValueString(0,"DC_NR");
    outputValues[3] = outParams.getDeliveryChallanDate();   inputValues[3] = inputParams.getFieldValueString(0,"DC_DATE");
    outputValues[4] = outParams.getPurchaseOrderNumber();   inputValues[4] = inputParams.getFieldValueString(0,"PO_NUM");
    outputValues[5] = outParams.getPurchaseOrderRev();   inputValues[5] = inputParams.getFieldValueString(0,"PO_REV");
    outputValues[6] = outParams.getPurchaseOrderDate();   inputValues[6] = inputParams.getFieldValueString(0,"PO_DATE");
    outputValues[7] = outParams.getInvoiceNumber();   inputValues[7] = inputParams.getFieldValueString(0,"INV_NUM");
    outputValues[8] = outParams.getInvoiceDate();   inputValues[8] = inputParams.getFieldValueString(0,"INV_DATE");
    outputValues[9] = outParams.getCreatedBy();   inputValues[9] = inputParams.getFieldValueString(0,"CREATED_BY");
    outputValues[10] = outParams.getCreatedOn();   inputValues[10] = inputParams.getFieldValueString(0,"CREATED_ON");
    outputValues[11] = outParams.getLastModifiedOn();   inputValues[11] = inputParams.getFieldValueString(0,"LAST_MOD_ON");
    outputValues[12] = outParams.getLr_rr_air_nr();   inputValues[12] = inputParams.getFieldValueString(0,"LR_RR_AIR_NR");
    outputValues[13] = outParams.getShipmentDate();   inputValues[13] = inputParams.getFieldValueString(0,"SHIPMENT_DATE");
    outputValues[14] = outParams.getCarrier();   inputValues[14] = inputParams.getFieldValueString(0,"CARRIER");
    outputValues[15] = outParams.getStatus();   inputValues[15] = inputParams.getFieldValueString(0,"STATUS");
    outputValues[16] = outParams.getText();   inputValues[16] = inputParams.getFieldValueString(0,"TEXT");
    outputValues[17] = outParams.getType();   inputValues[17] = inputParams.getFieldValueString(0,"DOC_TYPE");
    outputValues[18] = outParams.getSysKey();   inputValues[18] = inputParams.getFieldValueString(0,"SYS_KEY");
    outputValues[19] = outParams.getSoldTo();   inputValues[19] = inputParams.getFieldValueString(0,"SOLD_TO");
    outputValues[20] = outParams.getDocsAttached();   inputValues[20] = inputParams.getFieldValueString(0,"FILES_ATTACHED");
    outputValues[21] = outParams.getExt1();   inputValues[21] = inputParams.getFieldValueString(0,"EXT1");  
    outputValues[22] = outParams.getExt2();   inputValues[22] = inputParams.getFieldValueString(0,"EXT2");  
    outputValues[23] = outParams.getExt3();   inputValues[23] = inputParams.getFieldValueString(0,"EXT3"); 
    outputValues[24] = outParams.getUploadId();   inputValues[24] = inputParams.getFieldValueString(0,"EZSH_UPLOAD_ID");
	
	
	for(int i=0;i<commonMapper.length;i++)
	{

		out.println(commonMapper[i]+"   ==   "+inputValues[i]+"       "+outputValues[i]);
		
		if(inputValues[i].equals(outputValues[i]))
			out.println("       false<br>");
		else
			out.println("       true<br>");		
	
	}
		
	out.println(outParams.getUserType()+"----------------Not Available");
	out.println(outParams.getSelection()+"----------------Not Available");
	out.println(outParams.getBussPartner()+"----------------Not Available");

%>
<Div id="MenuSol"></Div>