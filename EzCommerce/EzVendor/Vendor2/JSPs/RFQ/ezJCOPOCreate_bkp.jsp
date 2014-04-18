<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="Manager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" />
<%@ page import="ezc.ezpreprocurement.params.*,java.util.*,ezc.ezbasicutil.*,ezc.ezparam.*;" %>
<%

	//Delivery Schedules
	
	String poNum = request.getParameter("PurchaseOrder");
	String OrderDate = request.getParameter("OrderDate");
	String EndDate = request.getParameter("EndDate");

	EzcParams ezcparams= new EzcParams(false);

	EzPSIInputParameters iparams = new EzPSIInputParameters();
	iparams.setOrderNumber(poNum);
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	ezc.ezpurchase.params.EziPurOrderDetailsParams testparams = new ezc.ezpurchase.params.EziPurOrderDetailsParams();
	newParams.createContainer();
	newParams.setObject(iparams);
	newParams.setObject(testparams);
	Session.prepareParams(newParams);
	ReturnObjFromRetrieve retObj =  (ReturnObjFromRetrieve)PoManager.ezPurchaseOrderDeliverySchedule(newParams);

        	int Count = retObj.getRowCount();
        
	//Create PO
	
	com.sap.mw.jco.JCO.Function function = EzSAPHandler.getFunction("BAPI_PO_CREATE1");
        com.sap.mw.jco.JCO.ParameterList sapImpParam = function.getImportParameterList();
        com.sap.mw.jco.JCO.ParameterList sapTabParam = function.getTableParameterList();
        com.sap.mw.jco.JCO.Structure PoHeader = sapImpParam.getStructure("POHEADER");
        com.sap.mw.jco.JCO.Structure PoHeaderx = sapImpParam.getStructure("POHEADERX");
        com.sap.mw.jco.JCO.Table PoItem = sapTabParam.getTable("POITEM");
        com.sap.mw.jco.JCO.Table PoItemx = sapTabParam.getTable("POITEMX");
        com.sap.mw.jco.JCO.Table PoSchedule = sapTabParam.getTable("POSCHEDULE");
        com.sap.mw.jco.JCO.Table PoSchedulex = sapTabParam.getTable("POSCHEDULEX");
        com.sap.mw.jco.JCO.Table PoCond = sapTabParam.getTable("POCOND");
        com.sap.mw.jco.JCO.Table PoCondx = sapTabParam.getTable("POCONDX");
        com.sap.mw.jco.JCO.Table PoTextHeader = sapTabParam.getTable("POTEXTHEADER");
        com.sap.mw.jco.JCO.Table PoTextItem = sapTabParam.getTable("POTEXTITEM");
        
        
           
        PoHeader.setValue(compCode, "COMP_CODE");
        PoHeaderx.setValue("X", "COMP_CODE");
       
        PoHeader.setValue(purchOrg, "PURCH_ORG");
        PoHeaderx.setValue("X", "PURCH_ORG");
        
        PoHeader.setValue(purchGroup, "PUR_GROUP");
        PoHeaderx.setValue("X", "PUR_GROUP");
       
        PoHeader.setValue(docType, "DOC_TYPE");
        PoHeaderx.setValue("X", "DOC_TYPE");
        
      /*  if(createdOn != null)
        {
            PoHeader.setValue(createdOn, "CREAT_DATE");
            PoHeaderx.setValue("X", "CREAT_DATE");
        }
       
       if(createdBy != null)
        {
            PoHeader.setValue(createdBy, "CREATED_BY");
            PoHeaderx.setValue("X", "CREATED_BY");
        }*/
        
        if(vendor != null)
        {
            PoHeader.setValue(vendor, "VENDOR");
            PoHeaderx.setValue("X", "VENDOR");
        }
        if(agreement != null)
        {
            PoHeader.setValue(agreement, "AGREEMENT");
            PoHeaderx.setValue("X", "AGREEMENT");
        }
        if(quotation != null)
        {
            PoHeader.setValue(quotation, "QUOTATION");
            PoHeaderx.setValue("X", "QUOTATION");
        }
        if(quoteDate != null)
        {
            PoHeader.setValue(quoteDate, "QUOT_DATE");
            PoHeaderx.setValue("X", "QUOT_DATE");
        }
        if(pmntTerms != null)
        {
            PoHeader.setValue(pmntTerms, "PMNTTRMS");
            PoHeaderx.setValue("X", "PMNTTRMS");
        }
        int itemTableCount = itemTable.getRowCount();
        System.out.println("itemTableCountitemTableCount===" + itemTableCount);
        
        if(itemTableCount > 0)
        {
            for(int i = 0; i < itemTableCount; i++)
            {
                itmRow = (EziPOItemTableRow)itemTable.getRow(i);
                PoItem.appendRow();
                PoItemx.appendRow();
                itmMaterial = itmRow.getMaterial();
                itmPlant = itmRow.getPlant();
                itmQty = itmRow.getQuantity();
                itmUOM = itmRow.getUOM();
                SLoc = itmRow.getSLoc();
                FOC = itmRow.getFOC();
                itmPrice = itmRow.getPrice();
                taxCode = itmRow.getTaxCode();
                confCtrl = itmRow.getConfCtrl();
                valType = itmRow.getValType();
                shipInstr = itmRow.getShipInstr();
                rfqNo = itmRow.getRFQNo();
                rfqItem = itmRow.getRFQItem();
                reqNo = itmRow.getPRNo();
                reqItem = itmRow.getPRItem();
                itmagreement = itmRow.getAgreement();
                agmtItem = itmRow.getAgmtItem();
                boolean refDoc = false;
                          
                
                
                PoItem.setValue((i + 1) * 10, "PO_ITEM");
                PoItemx.setValue((i + 1) * 10, "PO_ITEM");
                
                PoItemx.setValue("X", "PO_ITEMX");
                if(taxCode != null)
                {
                    PoItem.setValue(taxCode, "TAX_CODE");
                    PoItemx.setValue("X", "TAX_CODE");
                }
                if(itmPlant != null)
                {
                    PoItem.setValue(itmPlant, "PLANT");
                    PoItemx.setValue("X", "PLANT");
                }
               /* if(SLoc != null)
                {
                    PoItem.setValue(SLoc, "STGE_LOC");
                    PoItemx.setValue("X", "STGE_LOC");
                }
                if(FOC != null)
                {
                    PoItem.setValue(FOC, "FREE_ITEM");
                    PoItemx.setValue("X", "FREE_ITEM");
                }
                if(itmQty != null)
                {
                    PoItem.setValue(itmQty, "QUANTITY");
                    PoItemx.setValue("X", "QUANTITY");
                }
                if(itmagreement != null)
                {
                    PoItem.setValue(itmagreement, "AGREEMENT");
                    PoItemx.setValue("X", "AGREEMENT");
                    refDoc = true;
                }
                if(agmtItem != null)
                {
                    PoItem.setValue(agmtItem, "AGMT_ITEM");
                    PoItemx.setValue("X", "AGMT_ITEM");
                }*/
                if(rfqNo != null)
                {
                    PoItem.setValue(rfqNo, "RFQ_NO");
                    PoItem.setValue(10, "RFQ_ITEM");
                    PoItemx.setValue("X", "RFQ_NO");
                    PoItemx.setValue("X", "RFQ_ITEM");
                    refDoc = true;
                }
                
                /*if(reqNo != null)
                {
                    PoItem.setValue(reqNo, "PREQ_NO");
                    PoItem.setValue((i + 1) * 10, "PREQ_ITEM");
                    PoItemx.setValue("X", "PREQ_NO");
                    PoItemx.setValue("X", "PREQ_ITEM");
                    refDoc = true;
                }
                if(confCtrl != null)
                {
                    PoItem.setValue(confCtrl, "CONF_CTRL");
                    PoItemx.setValue("X", "CONF_CTRL");
                }
                if(valType != null)
                {
                    PoItem.setValue(valType, "VAL_TYPE");
                    PoItemx.setValue("X", "VAL_TYPE");
                }
                if(!refDoc)
                {
                    PoItem.setValue(itmMaterial, "MATERIAL");
                    PoItemx.setValue("X", "MATERIAL");
                    PoItem.setValue(itmUOM, "PO_UNIT");
                    PoItemx.setValue("X", "PO_UNIT");
                    PoItem.setValue("X", "FREE_ITEM");
                    PoItemx.setValue("X", "FREE_ITEM");
                    PoItem.setValue(itmPrice, "NET_PRICE");
                    PoItemx.setValue("X", "NET_PRICE");
                }*/
            }

        }
       
        int schTableCount = schTable.getRowCount();
        log("schTableCount-------------> " + schTableCount);
        if(schTableCount > 0)
        {
            int k = 1;
            EziPOSchedTableRow schRow = null;
            for(int j = 0; j < schTableCount; j++)
            {
                schRow = (EziPOSchedTableRow)schTable.getRow(j);
                PoSchedule.appendRow();
                PoSchedulex.appendRow();
                schQty = schRow.getQuantity();
                schDlvDate = schRow.getDelivDate();
                log("schQty-------------> " + schQty);
                log("schDlvDate-------------> " + schDlvDate);
                PoSchedule.setValue((j + 1) * 10, "PO_ITEM");
                PoSchedule.setValue(k, "SCHED_LINE");
                PoSchedule.setValue(schQty, "QUANTITY");
                PoSchedule.setValue(schDlvDate, "DELIVERY_DATE");
                PoSchedulex.setValue((j + 1) * 10, "PO_ITEM");
                PoSchedulex.setValue(k, "SCHED_LINE");
                PoSchedulex.setValue("X", "PO_ITEMX");
                PoSchedulex.setValue("X", "SCHED_LINEX");
                PoSchedulex.setValue("X", "QUANTITY");
                PoSchedulex.setValue("X", "DELIVERY_DATE");
                //k++;
            }

        }
%>