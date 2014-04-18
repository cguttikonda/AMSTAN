<%@ page import ="ezc.ezparam.*,ezc.ezsap.*" %>
<%@ page import="com.sap.mw.jco.*,java.util.*" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>

<%
	JCO.Client client1=null;
	JCO.Function function = null;
	try
	{
		client1 = EzSAPHandler.getSAPConnection("200~999");
		function = EzSAPHandler.getFunction("Z_EZ_GET_SALES_ORDER_DELIVERY","200~999");

		JCO.ParameterList 	sapProc = function.getImportParameterList();
		sapProc.setValue(sDoc_JCO,"SALESDOCUMENT");
		sapProc.setValue(sSoldTo_JCO,"CUSTOMER");
		sapProc.setValue(sSorg_JCO,"SALESORG");
		sapProc.setValue(sSel_JCO,"SELECTION");

   		try
		{
			client1.execute(function);
			
			String [] myRetCols = {"DELIV_HEADER","DELIV_DETAILS"};
			String [] myHeaderCols = {"Actualgidate","Custgrp","DelivBlock","DelivDate","DelivIndicator","DelivNumb","DelivType","DocCategory","Docdate","Ext1","Ext2","Incoterms1","Incoterms2","Pickdate","Refdoc","Salesdistrict","Salesorg","ShipCondition","Shippoint","ShipToParty","SoldToParty","Unloadpoint","BillOfLading"};
			String [] myDetailsCols = {"BaseUnit","Batch","Carrier","CarrierNumber","DelivItem","DelivItemCat","DelivNumb","DlvqtySalesUnt","Ext1","Ext2","MatEntered","Material","MatGroup","PartialDlv","Plant","SalesUnit","ShortText","StorageLocation","VendorBatch"};

			finalRetObject = new ReturnObjFromRetrieve(myRetCols);
			ReturnObjFromRetrieve retHeader = new ReturnObjFromRetrieve(myHeaderCols);
			ReturnObjFromRetrieve retDetails = new ReturnObjFromRetrieve(myDetailsCols);

			try {
				JCO.Table headerTable = function.getTableParameterList().getTable("DELIV_HEADER");
				JCO.Table detailsTable = function.getTableParameterList().getTable("DELIV_DETAILS");

				if ( headerTable != null )
				{
					if (headerTable.getNumRows() > 0)
					{
						do
						{
							 retHeader.setFieldValue("Actualgidate",headerTable.getValue("ACTUALGIDATE"));
							 retHeader.setFieldValue("Custgrp",headerTable.getValue("CUSTGRP"));	
							 retHeader.setFieldValue("DelivBlock",headerTable.getValue("DELIV_BLOCK"));	
							 retHeader.setFieldValue("DelivDate",headerTable.getValue("DELIV_DATE"));	
							 retHeader.setFieldValue("DelivIndicator" ,headerTable.getValue("DELIV_INDICATOR"));	
							 retHeader.setFieldValue("DelivNumb",headerTable.getValue("DELIV_NUMB"));	
							 retHeader.setFieldValue("DelivType",headerTable.getValue("DELIV_TYPE"));	
							 retHeader.setFieldValue("DocCategory",headerTable.getValue("DOC_CATEGORY"));	
							 retHeader.setFieldValue("Docdate",headerTable.getValue("DOCDATE"));	
							 retHeader.setFieldValue("Ext1",headerTable.getValue("EXT1"));
							 retHeader.setFieldValue("Ext2",headerTable.getValue("EXT2"));
							 retHeader.setFieldValue("Incoterms1",headerTable.getValue("INCOTERMS1"));	
							 retHeader.setFieldValue("Incoterms2",headerTable.getValue("INCOTERMS2"));	
							 retHeader.setFieldValue("Pickdate",headerTable.getValue("PICKDATE"));	
							 retHeader.setFieldValue("Refdoc",headerTable.getValue("REFDOC"));	
							 retHeader.setFieldValue("Salesdistrict" ,headerTable.getValue("SALESDISTRICT"));	
							 retHeader.setFieldValue("Salesorg",headerTable.getValue("SALESORG"));	
							 retHeader.setFieldValue("ShipCondition" ,headerTable.getValue("SHIP_CONDITION"));	
							 retHeader.setFieldValue("Shippoint",headerTable.getValue("SHIPPOINT"));	
							 retHeader.setFieldValue("ShipToParty",headerTable.getValue("SHIP_TO_PARTY"));	
							 retHeader.setFieldValue("SoldToParty",headerTable.getValue("SOLD_TO_PARTY"));	
							 retHeader.setFieldValue("Unloadpoint",headerTable.getValue("UNLOADPOINT"));
							 retHeader.addRow();
						}while(headerTable.nextRow());
					}	
				}

			if ( detailsTable != null )
			{
				if (detailsTable.getNumRows() > 0)
				{
					do
					{
						retDetails.setFieldValue("BaseUnit",detailsTable.getValue("BASE_UNIT"));
						try{
						retDetails.setFieldValue("Batch",detailsTable.getValue("BATCH"));
						}catch(Exception e){}
						retDetails.setFieldValue("Carrier",detailsTable.getValue("CARRIER"));
						retDetails.setFieldValue("CarrierNumber",detailsTable.getValue("CARRIER_NUMBER"));
						retDetails.setFieldValue("DelivItem",detailsTable.getValue("DELIV_ITEM"));
						retDetails.setFieldValue("DelivItemCat",detailsTable.getValue("DELIV_ITEM_CAT"));
						retDetails.setFieldValue("DelivNumb",detailsTable.getValue("DELIV_NUMB"));
						retDetails.setFieldValue("DlvqtySalesUnt",detailsTable.getValue("DLVQTY_SALES_UNT"));
						retDetails.setFieldValue("Ext1",detailsTable.getValue("EXT1"));
						retDetails.setFieldValue("Ext2",detailsTable.getValue("EXT2"));
						retDetails.setFieldValue("MatEntered",detailsTable.getValue("MAT_ENTERED"));
						retDetails.setFieldValue("Material",detailsTable.getValue("MATERIAL"));
						retDetails.setFieldValue("MatGroup",detailsTable.getValue("MAT_GROUP"));
						retDetails.setFieldValue("PartialDlv",detailsTable.getValue("PARTIAL_DLV"));
						retDetails.setFieldValue("Plant",detailsTable.getValue("PLANT"));
						retDetails.setFieldValue("SalesUnit",detailsTable.getValue("SALES_UNIT"));
						retDetails.setFieldValue("ShortText",detailsTable.getValue("SHORT_TEXT"));
						retDetails.setFieldValue("StorageLocation",detailsTable.getValue("STORAGE_LOCATION"));
						retDetails.setFieldValue("VendorBatch",detailsTable.getValue("VENDOR_BATCH"));
						retDetails.addRow();
					}while(detailsTable.nextRow());
				}	
			}
				finalRetObject.setFieldValue("DELIV_HEADER",retHeader);
				finalRetObject.setFieldValue("DELIV_DETAILS",retDetails);
				finalRetObject.addRow();
			}
			catch(Exception e){
			out.println("e::"+e);
			}
		}
		catch(Exception ec){}
	}
	catch(Exception e){}
	finally
	{
		if (client1!=null)
		{
			JCO.releaseClient(client1);
			client1 = null;
			function=null;
		}
	}
%>