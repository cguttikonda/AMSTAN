<%@ page import = "ezc.sales.params.*,java.util.*,ezc.ezcustomer.params.*,java.math.*,ezc.ezutil.*,ezc.ezerp.*,ezc.ezparam.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>

<%
	JCO.Client client = null;
	client = EzSAPHandler.getSAPConnection();
	JCO.Function function=null;
	function= EzSAPHandler.getFunction("BAPI_SALESORDER_SIMULATE");

	JCO.Structure headerStructure 	= function.getImportParameterList().getStructure("ORDER_HEADER_IN");
	JCO.Table     orderItemsTable 	= function.getTableParameterList().getTable("ORDER_ITEMS_IN");
	JCO.Table     partnerTable 	= function.getTableParameterList().getTable("ORDER_PARTNERS");
	JCO.Table     schTable 		= function.getTableParameterList().getTable("ORDER_SCHEDULE_IN");

	//headerStructure.setValue(cGrp5,"CUST_GRP5");
	//headerStructure.setValue("","SALES_OFF");
	//headerStructure.setValue("","SALES_GRP");
	//headerStructure.setValue("","CURRENCY");
	//headerStructure.setValue(condtype1,"CD_TYPE1");
	//headerStructure.setValue(ezcSdheadStructure.getCdValue1(),"CD_VALUE1");				
	//headerStructure.setValue(condtype2,"CD_TYPE2");
	//headerStructure.setValue(ezcSdheadStructure.getCdValue2(),"CD_VALUE2");				
	//headerStructure.setValue(condtype3,"CD_TYPE3");
	//headerStructure.setValue(ezcSdheadStructure.getCdValue3(),"CD_VALUE3");				
	//headerStructure.setValue(condtype4,"CD_TYPE4");
	//headerStructure.setValue(ezcSdheadStructure.getCdValue4(),"CD_VALUE4");				
	//headerStructure.setValue(name,"NAME");
	//headerStructure.setValue(incoTerms1,"INCOTERMS1");
	//headerStructure.setValue(incoTerms2,"INCOTERMS2");
	//headerStructure.setValue(paymentTerms,"PMNTTRMS");
	//headerStructure.setValue(ref1,"REF_1");
	//headerStructure.setValue(ezcSdheadStructure.getPurchDate(),"PURCH_DATE");
	
	headerStructure.setValue("","DIVISION");
	headerStructure.setValue("","DISTR_CHAN");
	headerStructure.setValue("","SALES_ORG");
	headerStructure.setValue("","DOC_TYPE");				
	headerStructure.setValue("WWW","PO_SUPPLEM");
	headerStructure.setValue("420","PURCH_NO");	
	java.util.GregorianCalendar reqDateH = new java.util.GregorianCalendar(2006,07,10);
	headerStructure.setValue(reqDateH.getTime(),"REQ_DATE_H");
	
	orderItemsTable.appendRow();
	orderItemsTable.setValue("10","ITM_NUMBER");
	orderItemsTable.setValue((java.util.Date)ezcIteminRow.getBillDate(),"BILL_DATE");
	//orderItemsTable.setValue(""+ezcIteminRow.getPoItmNo(),"PO_ITM_NO");
	orderItemsTable.setValue(itemcurrency,"CURRENCY");
	orderItemsTable.setValue(condType,"COND_TYPE");
	orderItemsTable.setValue(condValue,"COND_VALUE");
	orderItemsTable.setValue(plant,"PLANT");
	orderItemsTable.setValue(shortText,"SHORT_TEXT");
	orderItemsTable.setValue(condValue1,"COND_VAL1");
	orderItemsTable.setValue(Incoterms1,"INCOTERMS1");
	orderItemsTable.setValue(Incoterms2,"INCOTERMS2");
	orderItemsTable.setValue(ezcIteminRow.getItemCateg(),"ITEM_CATEG");
	orderItemsTable.setValue(ezcIteminRow.getMaterial(),"MATERIAL");
	orderItemsTable.setValue(ezcIteminRow.getReqDate(),"REQ_DATE");
	orderItemsTable.setValue(ezcIteminRow.getReqQty(),"REQ_QTY");
	orderItemsTable.setValue(ezcIteminRow.getSalesUnit(),"SALES_UNIT");


	partnerTable.appendRow();
	partnerTable.setValue(ezcPartnrRow.getPartnNumb(),"PARTN_NUMB");
	partnerTable.setValue("AG","PARTN_ROLE");


	schTable.appendRow();
	schTable.setValue("10","ITM_NUMBER");
	schTable.setValue(new java.math.BigInteger("10"),"SCHED_LINE");
	schTable.setValue(ezcschdlRow.getReqQty(),"REQ_QTY");
	schTable.setValue(ezcschdlRow.getReqDate(),"REQ_DATE");

	client.execute(function);

	JCO.Table sapCucfgTable 		=function.getTableParameterList().getTable("ORDER_CFGS_REF");
	JCO.Table sapCuinsTable 		=function.getTableParameterList().getTable("ORDER_CFGS_INST");
	JCO.Table sapCuprtTable 		=function.getTableParameterList().getTable("ORDER_CFGS_PART_OF");
	JCO.Table sapCuvalTable 		=function.getTableParameterList().getTable("ORDER_CFGS_VALUE");
	JCO.Table sapIteminTable 		=function.getTableParameterList().getTable("ORDER_ITEMS_IN");
	JCO.Table sapItemexTable 		=function.getTableParameterList().getTable("ORDER_ITEMS_OUT");
	JCO.Table sapPartnrTable 		=function.getTableParameterList().getTable("ORDER_PARTNERS");
	JCO.Table sapDeliverySchedTableOut 	=function.getTableParameterList().getTable("ORDER_SCHEDULE_EX");
	JCO.Structure sapPayerStructure  	=function.getExportParameterList().getStructure("BILLING_PARTY");
	JCO.Structure sapSdheadStructure 	=function.getImportParameterList().getStructure("ORDER_HEADER_IN");
	JCO.Structure sapShiptoStructure 	=function.getExportParameterList().getStructure("SHIP_TO_PARTY");
	JCO.Structure sapSoldtoStructure 	=function.getExportParameterList().getStructure("SOLD_TO_PARTY");
	JCO.Structure sapReturnStructure 	=function.getExportParameterList().getStructure("RETURN");

	EzoSalesOrderCreate finalReturnObject = new EzoSalesOrderCreate();
	ReturnObjFromRetrieve retCfgTable = finalReturnObject.getOrderCfgsRef();
	if(sapCucfgTable.getNumRows() > 0)
	{
		do
		{
			retCfgTable.setFieldValue("ConfigId",sapCucfgTable.getValue("CONFIG_ID"));
			retCfgTable.setFieldValue("Posex",sapCucfgTable.getValue("POSEX"));
			retCfgTable.setFieldValue("RootId",sapCucfgTable.getValue("ROOT_ID"));
			retCfgTable.addRow();
		}
		while(sapCucfgTable.nextRow());
	}

	finalReturnObject.setOrderCfgsRef(retCfgTable);

	ReturnObjFromRetrieve retCuinsTable = finalReturnObject.getOrderCfgsInst();
	if(sapCuinsTable.getNumRows() > 0)
	{
		do
		{
			retCuinsTable.setFieldValue("ClassType",sapCuinsTable.getValue("CLASS_TYPE"));
			retCuinsTable.setFieldValue("ConfigId",sapCuinsTable.getValue("CONFIG_ID"));
			retCuinsTable.setFieldValue("InstId",sapCuinsTable.getValue("INST_ID"));
			retCuinsTable.setFieldValue("ObjKey",sapCuinsTable.getValue("OBJ_KEY"));
			retCuinsTable.setFieldValue("ObjTxt",sapCuinsTable.getValue("OBJ_TXT"));
			retCuinsTable.setFieldValue("ObjType",sapCuinsTable.getValue("OBJ_TYPE"));
			retCuinsTable.setFieldValue("Quantity",sapCuinsTable.getValue("QUANTITY"));
			retCuinsTable.addRow();
		}
		while(sapCuinsTable.nextRow());
	}

	finalReturnObject.setOrderCfgsInst(retCuinsTable);

	ReturnObjFromRetrieve retCuprtTable = finalReturnObject.getOrderCfgsPartOf();
	if (sapCuprtTable.getNumRows() > 0)
	{
		do
		{
			retCuprtTable.setFieldValue("ClassType",sapCuprtTable.getValue("CLASS_TYPE"));
			retCuprtTable.setFieldValue("ConfigId",sapCuprtTable.getValue("CONFIG_ID"));
			retCuprtTable.setFieldValue("InstId",sapCuprtTable.getValue("INST_ID"));
			retCuprtTable.setFieldValue("ObjKey",sapCuprtTable.getValue("OBJ_KEY"));
			retCuprtTable.setFieldValue("ObjType",sapCuprtTable.getValue("OBJ_TYPE"));
			retCuprtTable.setFieldValue("ParentId",sapCuprtTable.getValue("PARENT_ID"));
			retCuprtTable.setFieldValue("PartOfNo",sapCuprtTable.getValue("PART_OF_NO"));
			retCuprtTable.addRow();
		}
		while(sapCuprtTable.nextRow());
	}

	finalReturnObject.setOrderCfgsPartOf(retCuprtTable);

	ReturnObjFromRetrieve retCuvalTable = finalReturnObject.getOrderCfgsValue();
	if(sapCuvalTable.getNumRows() > 0)
	{
		do
		{
			retCuvalTable.setFieldValue("Charc",sapCuvalTable.getValue("CHARC"));
			retCuvalTable.setFieldValue("CharcTxt",sapCuvalTable.getValue("CHARC_TXT"));
			retCuvalTable.setFieldValue("ConfigId",sapCuvalTable.getValue("CONFIG_ID"));
			retCuvalTable.setFieldValue("InstId",sapCuvalTable.getValue("INST_ID"));
			retCuvalTable.setFieldValue("Value",sapCuvalTable.getValue("VALUE"));
			retCuvalTable.setFieldValue("ValueTxt",sapCuvalTable.getValue("VALUE_TXT"));

			retCuvalTable.addRow();
		}
		while(sapCuvalTable.nextRow());
	}

	finalReturnObject.setOrderCfgsValue(retCuvalTable);

	ReturnObjFromRetrieve retIteminTable = finalReturnObject.getOrderItemsIn();
	if(sapIteminTable.getNumRows() > 0)
	{
		do
		{
			retIteminTable.setFieldValue("Batch",sapIteminTable.getValue("BATCH"));
			retIteminTable.setFieldValue("BillBlock",sapIteminTable.getValue("BILL_BLOCK"));
			retIteminTable.setFieldValue("BillDate",sapIteminTable.getValue("BILL_DATE"));
			retIteminTable.setFieldValue("CondDUnt",sapIteminTable.getValue("COND_D_UNT"));
			retIteminTable.setFieldValue("CondPUnt",sapIteminTable.getValue("COND_P_UNT"));
			retIteminTable.setFieldValue("CondType",sapIteminTable.getValue("COND_TYPE"));
			retIteminTable.setFieldValue("CondValue",sapIteminTable.getValue("COND_VALUE"));
			retIteminTable.setFieldValue("CustMat",sapIteminTable.getValue("CUST_MAT"));
			retIteminTable.setFieldValue("DateType",sapIteminTable.getValue("DATE_TYPE"));
			retIteminTable.setFieldValue("DlvGroup",sapIteminTable.getValue("DLV_GROUP"));
			retIteminTable.setFieldValue("HgLvItem",sapIteminTable.getValue("HG_LV_ITEM"));
			retIteminTable.setFieldValue("ItemCateg",sapIteminTable.getValue("ITEM_CATEG"));
			retIteminTable.setFieldValue("ItmNumber",sapIteminTable.getValue("ITM_NUMBER"));
			retIteminTable.setFieldValue("Material",sapIteminTable.getValue("MATERIAL"));
			retIteminTable.setFieldValue("MatlGroup",sapIteminTable.getValue("MATL_GROUP"));
			retIteminTable.setFieldValue("PartDlv",sapIteminTable.getValue("PART_DLV"));
			retIteminTable.setFieldValue("Plant",sapIteminTable.getValue("PLANT"));
			retIteminTable.setFieldValue("PoItmNo",sapIteminTable.getValue("PO_ITM_NO"));
			retIteminTable.setFieldValue("PrcGroup1",sapIteminTable.getValue("PRC_GROUP1"));
			retIteminTable.setFieldValue("PrcGroup2",sapIteminTable.getValue("PRC_GROUP2"));
			retIteminTable.setFieldValue("PrcGroup3",sapIteminTable.getValue("PRC_GROUP3"));
			retIteminTable.setFieldValue("PrcGroup4",sapIteminTable.getValue("PRC_GROUP4"));
			retIteminTable.setFieldValue("PrcGroup5",sapIteminTable.getValue("PRC_GROUP5"));
			retIteminTable.setFieldValue("ProdHiera",sapIteminTable.getValue("PROD_HIERA"));
			retIteminTable.setFieldValue("ReasonRej",sapIteminTable.getValue("REASON_REJ"));
			retIteminTable.setFieldValue("ReqDate",sapIteminTable.getValue("REQ_DATE"));
			retIteminTable.setFieldValue("ReqQty",sapIteminTable.getValue("REQ_QTY"));
			retIteminTable.setFieldValue("ReqTime",sapIteminTable.getValue("REQ_TIME"));
			retIteminTable.setFieldValue("SalesUnit",sapIteminTable.getValue("SALES_UNIT"));
			retIteminTable.setFieldValue("ShortText",sapIteminTable.getValue("SHORT_TEXT"));
			retIteminTable.setFieldValue("StoreLoc",sapIteminTable.getValue("STORE_LOC"));
			retIteminTable.setFieldValue("TarQty",sapIteminTable.getValue("TARGET_QTY"));
			retIteminTable.setFieldValue("TarQu",sapIteminTable.getValue("TARGET_QU"));
			retIteminTable.addRow();
		}
		while(sapIteminTable.nextRow());
	}

	finalReturnObject.setOrderItemsIn(retIteminTable);

	ReturnObjFromRetrieve retItemexTable = finalReturnObject.getOrderItemsOut();
	if(sapItemexTable.getNumRows() > 0)
	{
		java.util.Vector myVector = new java.util.Vector();
		com.sap.mw.jco.JCO.FieldIterator ft = sapItemexTable.fields();
		while(ft.hasMoreElements())
		{
			com.sap.mw.jco.JCO.Field myField=(com.sap.mw.jco.JCO.Field)ft.nextElement();
			myVector.addElement(myField.getName());
		}
		do
		{
			retItemexTable.setFieldValue("Configured",sapItemexTable.getValue("CONFIGURED"));
			retItemexTable.setFieldValue("Currency",sapItemexTable.getValue("CURRENCY"));
			retItemexTable.setFieldValue("DlvDate",sapItemexTable.getValue("DLV_DATE"));
			retItemexTable.setFieldValue("Number",sapItemexTable.getValue("ITM_NUMBER"));
			retItemexTable.setFieldValue("MatEntrd",sapItemexTable.getValue("MAT_ENTRD"));
			retItemexTable.setFieldValue("Material",sapItemexTable.getValue("MATERIAL"));
			retItemexTable.setFieldValue("NetValue",sapItemexTable.getValue("NET_VALUE"));
			retItemexTable.setFieldValue("PoItmNo",sapItemexTable.getValue("PO_ITM_NO"));
			retItemexTable.setFieldValue("QtyReqDt",sapItemexTable.getValue("QTY_REQ_DT"));
			retItemexTable.setFieldValue("ReplTime",sapItemexTable.getValue("REPL_TIME"));
			retItemexTable.setFieldValue("SalesUnit",sapItemexTable.getValue("SALES_UNIT"));
			retItemexTable.setFieldValue("ShortText",sapItemexTable.getValue("SHORT_TEXT"));
			retItemexTable.setFieldValue("Subtotal1",sapItemexTable.getValue("SUBTOTAL_1"));
			retItemexTable.setFieldValue("Subtotal2",sapItemexTable.getValue("SUBTOTAL_2"));
			retItemexTable.setFieldValue("Subtotal3",sapItemexTable.getValue("SUBTOTAL_3"));
			retItemexTable.setFieldValue("Subtotal4",sapItemexTable.getValue("SUBTOTAL_4"));
			retItemexTable.setFieldValue("Subtotal5",sapItemexTable.getValue("SUBTOTAL_5"));
			retItemexTable.setFieldValue("Subtotal6",sapItemexTable.getValue("SUBTOTAL_6"));
			retItemexTable.setFieldValue("NetValue1",sapItemexTable.getValue("NET_VALUE1"));
			retItemexTable.setFieldValue("ItemCat",sapItemexTable.getValue("ITEM_CATEG"));
			retItemexTable.setFieldValue("Plant",sapItemexTable.getValue("PLANT"));
			retItemexTable.setFieldValue("ReqQty",sapItemexTable.getValue("REQ_QTY"));
			if(myVector.contains("HG_LV_ITEM"))
				retItemexTable.setFieldValue("HgLvItem",sapItemexTable.getValue("HG_LV_ITEM"));
			retItemexTable.setFieldValue("TxDoc",sapItemexTable.getValue("TX_DOC_CUR"));
			retItemexTable.addRow();
		}
		while(sapItemexTable.nextRow());
	}

	finalReturnObject.setOrderItemsOut(retItemexTable);				

	ReturnObjFromRetrieve retPartnrTable =finalReturnObject.getOrderPartners();
	if(sapPartnrTable.getNumRows() > 0)
	{
		do
		{
			retPartnrTable.setFieldValue("PartnNumb",sapPartnrTable.getValue("PARTN_NUMB"));
			retPartnrTable.setFieldValue("PartnRole",sapPartnrTable.getValue("PARTN_ROLE"));/////
			retPartnrTable.addRow();
		}
		while(sapPartnrTable.nextRow());
	}

	finalReturnObject.setOrderPartners(retPartnrTable);

	ReturnObjFromRetrieve retPayerStructure = finalReturnObject.getBillingParty();
	retPayerStructure.setFieldValue("AccntAsgn",sapPayerStructure.getValue("ACCNT_ASGN"));
	retPayerStructure.setFieldValue("AddValDy",sapPayerStructure.getValue("ADD_VAL_DY"));
	retPayerStructure.setFieldValue("BillBlock",sapPayerStructure.getValue("BILL_BLOCK"));
	retPayerStructure.setFieldValue("BillSched",sapPayerStructure.getValue("BILL_SCHED"));
	retPayerStructure.setFieldValue("CCtrArea",sapPayerStructure.getValue("C_CTR_AREA"));
	retPayerStructure.setFieldValue("City",sapPayerStructure.getValue("CITY"));
	retPayerStructure.setFieldValue("Country",sapPayerStructure.getValue("COUNTRY"));
	retPayerStructure.setFieldValue("CredAccnt",sapPayerStructure.getValue("CRED_ACCNT"));
	retPayerStructure.setFieldValue("CredGroup",sapPayerStructure.getValue("CRED_GROUP"));
	retPayerStructure.setFieldValue("CredLiab",sapPayerStructure.getValue("CRED_LIAB"));
	retPayerStructure.setFieldValue("CredLimit",sapPayerStructure.getValue("CRED_LIMIT"));
	retPayerStructure.setFieldValue("Currency",sapPayerStructure.getValue("CURRENCY"));
	retPayerStructure.setFieldValue("FixValDy",sapPayerStructure.getValue("FIX_VAL_DY"));
	retPayerStructure.setFieldValue("Langu",sapPayerStructure.getValue("LANGU"));
	retPayerStructure.setFieldValue("ListSched",sapPayerStructure.getValue("LIST_SCHED"));
	retPayerStructure.setFieldValue("MnInvoice",sapPayerStructure.getValue("MN_INVOICE"));
	retPayerStructure.setFieldValue("Name",sapPayerStructure.getValue("NAME"));
	retPayerStructure.setFieldValue("OrderBlck",sapPayerStructure.getValue("ORDER_BLCK"));
	retPayerStructure.setFieldValue("OrderVals",sapPayerStructure.getValue("ORDER_VALS"));
	retPayerStructure.setFieldValue("Payer",sapPayerStructure.getValue("PAYER"));
	retPayerStructure.setFieldValue("Pmnttrms",sapPayerStructure.getValue("PMNTTRMS"));
	retPayerStructure.setFieldValue("PoBox",sapPayerStructure.getValue("PO_BOX"));
	retPayerStructure.setFieldValue("PobxPcd",sapPayerStructure.getValue("POBX_PCD"));
	retPayerStructure.setFieldValue("PostlCode",sapPayerStructure.getValue("POSTL_CODE"));
	retPayerStructure.setFieldValue("ProdProp",sapPayerStructure.getValue("PROD_PROP"));
	retPayerStructure.setFieldValue("RcvblVals",sapPayerStructure.getValue("RCVBL_VALS"));
	retPayerStructure.setFieldValue("RebateFrm",sapPayerStructure.getValue("REBATE_FRM"));
	retPayerStructure.setFieldValue("RebateRel",sapPayerStructure.getValue("REBATE_REL"));
	retPayerStructure.setFieldValue("ReprGroup",sapPayerStructure.getValue("REPR_GROUP"));
	retPayerStructure.setFieldValue("RiskCateg",sapPayerStructure.getValue("RISK_CATEG"));
	retPayerStructure.setFieldValue("Street",sapPayerStructure.getValue("STREET"));
	retPayerStructure.setFieldValue("TaxClass1",sapPayerStructure.getValue("TAX_CLASS1"));
	retPayerStructure.setFieldValue("TaxClass2",sapPayerStructure.getValue("TAX_CLASS2"));
	retPayerStructure.setFieldValue("TaxClass3",sapPayerStructure.getValue("TAX_CLASS3"));
	retPayerStructure.setFieldValue("TaxClass4",sapPayerStructure.getValue("TAX_CLASS4"));
	retPayerStructure.setFieldValue("TaxClass5",sapPayerStructure.getValue("TAX_CLASS5"));
	retPayerStructure.setFieldValue("TaxClass6",sapPayerStructure.getValue("TAX_CLASS6"));
	retPayerStructure.setFieldValue("TaxClass7",sapPayerStructure.getValue("TAX_CLASS7"));
	retPayerStructure.setFieldValue("TaxClass8",sapPayerStructure.getValue("TAX_CLASS8"));
	retPayerStructure.setFieldValue("TaxClass9",sapPayerStructure.getValue("TAX_CLASS9"));
	retPayerStructure.setFieldValue("Telephone",sapPayerStructure.getValue("TELEPHONE"));
	retPayerStructure.setFieldValue("TradeId",sapPayerStructure.getValue("TRADE_ID"));
	retPayerStructure.setFieldValue("ValLimit",sapPayerStructure.getValue("VAL_LIMIT"));
	retPayerStructure.setFieldValue("VatCntry",sapPayerStructure.getValue("VAT_CNTRY"));
	retPayerStructure.setFieldValue("VatRegNo",sapPayerStructure.getValue("VAT_REG_NO"));
	finalReturnObject.setBillingParty(retPayerStructure);

	ReturnObjFromRetrieve retSdheadStructure = finalReturnObject.getOrderHeaderIn();
	retSdheadStructure.setFieldValue("BillBlock",sapSdheadStructure.getValue("BILL_BLOCK"));
	retSdheadStructure.setFieldValue("CollectNo",sapSdheadStructure.getValue("COLLECT_NO"));
	retSdheadStructure.setFieldValue("ComplDlv",sapSdheadStructure.getValue("COMPL_DLV"));
	retSdheadStructure.setFieldValue("CtValidF",sapSdheadStructure.getValue("CT_VALID_F"));
	retSdheadStructure.setFieldValue("CtValidT",sapSdheadStructure.getValue("CT_VALID_T"));
	retSdheadStructure.setFieldValue("CustGroup",sapSdheadStructure.getValue("CUST_GROUP"));
	retSdheadStructure.setFieldValue("CustGrp1",sapSdheadStructure.getValue("CUST_GRP1"));
	retSdheadStructure.setFieldValue("CustGrp2",sapSdheadStructure.getValue("CUST_GRP2"));
	retSdheadStructure.setFieldValue("CustGrp3",sapSdheadStructure.getValue("CUST_GRP3"));
	retSdheadStructure.setFieldValue("CustGrp4",sapSdheadStructure.getValue("CUST_GRP4"));
	retSdheadStructure.setFieldValue("CustGrp5",sapSdheadStructure.getValue("CUST_GRP5"));
	retSdheadStructure.setFieldValue("DateType",sapSdheadStructure.getValue("DATE_TYPE"));
	retSdheadStructure.setFieldValue("DistrChan",sapSdheadStructure.getValue("DISTR_CHAN"));
	retSdheadStructure.setFieldValue("Division",sapSdheadStructure.getValue("DIVISION"));
	retSdheadStructure.setFieldValue("DlvBlock",sapSdheadStructure.getValue("DLV_BLOCK"));
	retSdheadStructure.setFieldValue("DocNumber",sapSdheadStructure.getValue("DOC_NUMBER"));
	retSdheadStructure.setFieldValue("DocType",sapSdheadStructure.getValue("DOC_TYPE"));
	retSdheadStructure.setFieldValue("Incoterms1",sapSdheadStructure.getValue("INCOTERMS1"));
	retSdheadStructure.setFieldValue("Incoterms2",sapSdheadStructure.getValue("INCOTERMS2"));
	retSdheadStructure.setFieldValue("Name",sapSdheadStructure.getValue("NAME"));
	retSdheadStructure.setFieldValue("OrdReason",sapSdheadStructure.getValue("ORD_REASON"));
	retSdheadStructure.setFieldValue("Pmnttrms",sapSdheadStructure.getValue("PMNTTRMS"));
	retSdheadStructure.setFieldValue("PoMethod",sapSdheadStructure.getValue("PO_METHOD"));
	retSdheadStructure.setFieldValue("PoSupplem",sapSdheadStructure.getValue("PO_SUPPLEM"));
	retSdheadStructure.setFieldValue("PriceDate",sapSdheadStructure.getValue("PRICE_DATE"));
	retSdheadStructure.setFieldValue("PriceGrp",sapSdheadStructure.getValue("PRICE_GRP"));
	retSdheadStructure.setFieldValue("PriceList",sapSdheadStructure.getValue("PRICE_LIST"));
	retSdheadStructure.setFieldValue("PurchDate",sapSdheadStructure.getValue("PURCH_DATE"));
	retSdheadStructure.setFieldValue("PurchNo",sapSdheadStructure.getValue("PURCH_NO"));
	retSdheadStructure.setFieldValue("QtValidF",sapSdheadStructure.getValue("QT_VALID_F"));
	retSdheadStructure.setFieldValue("QtValidT",sapSdheadStructure.getValue("QT_VALID_T"));
	retSdheadStructure.setFieldValue("Ref1",sapSdheadStructure.getValue("REF_1"));
	retSdheadStructure.setFieldValue("ReqDateH",sapSdheadStructure.getValue("REQ_DATE_H"));
	retSdheadStructure.setFieldValue("SalesDist",sapSdheadStructure.getValue("SALES_DIST"));
	retSdheadStructure.setFieldValue("SalesGrp",sapSdheadStructure.getValue("SALES_GRP"));
	retSdheadStructure.setFieldValue("SalesOff",sapSdheadStructure.getValue("SALES_OFF"));
	retSdheadStructure.setFieldValue("SalesOrg",sapSdheadStructure.getValue("SALES_ORG"));
	retSdheadStructure.setFieldValue("Telephone",sapSdheadStructure.getValue("TELEPHONE"));
	finalReturnObject.setOrderHeaderIn(retSdheadStructure);


	ReturnObjFromRetrieve retShiptoStructure = finalReturnObject.getShipToParty();
	retShiptoStructure.setFieldValue("Acc1Time",sapShiptoStructure.getValue("ACC_1_TIME"));
	retShiptoStructure.setFieldValue("AccntGrp",sapShiptoStructure.getValue("ACCNT_GRP"));
	retShiptoStructure.setFieldValue("City",sapShiptoStructure.getValue("CITY"));
	retShiptoStructure.setFieldValue("CityCode",sapShiptoStructure.getValue("CITY_CODE"));
	retShiptoStructure.setFieldValue("CountyCde",sapShiptoStructure.getValue("COUNTY_CDE"));
	retShiptoStructure.setFieldValue("CtrdataOk",sapShiptoStructure.getValue("CTRDATA_OK"));
	retShiptoStructure.setFieldValue("DescPartn",sapShiptoStructure.getValue("DESC_PARTN"));
	retShiptoStructure.setFieldValue("DestCntry",sapShiptoStructure.getValue("DEST_CNTRY"));
	retShiptoStructure.setFieldValue("DlvBlock",sapShiptoStructure.getValue("DLV_BLOCK"));
	retShiptoStructure.setFieldValue("DlvPlant",sapShiptoStructure.getValue("DLV_PLANT"));
	retShiptoStructure.setFieldValue("ExprStat",sapShiptoStructure.getValue("EXPR_STAT"));
	retShiptoStructure.setFieldValue("FacCalend",sapShiptoStructure.getValue("FAC_CALEND"));
	retShiptoStructure.setFieldValue("FrAmFrom",sapShiptoStructure.getValue("FR_AM_FROM"));
	retShiptoStructure.setFieldValue("FrAmUntl",sapShiptoStructure.getValue("FR_AM_UNTL"));
	retShiptoStructure.setFieldValue("FrPmFrom",sapShiptoStructure.getValue("FR_PM_FROM"));
	retShiptoStructure.setFieldValue("FrPmUntl",sapShiptoStructure.getValue("FR_PM_UNTL"));
	retShiptoStructure.setFieldValue("FyVariant",sapShiptoStructure.getValue("FY_VARIANT"));
	retShiptoStructure.setFieldValue("Langu",sapShiptoStructure.getValue("LANGU"));
	retShiptoStructure.setFieldValue("MoAmFrom",sapShiptoStructure.getValue("MO_AM_FROM"));
	retShiptoStructure.setFieldValue("MoAmUntl",sapShiptoStructure.getValue("MO_AM_UNTL"));
	retShiptoStructure.setFieldValue("MoPmFrom",sapShiptoStructure.getValue("MO_PM_FROM"));
	retShiptoStructure.setFieldValue("MoPmUntl",sapShiptoStructure.getValue("MO_PM_UNTL"));
	retShiptoStructure.setFieldValue("Name",sapShiptoStructure.getValue("NAME"));
	retShiptoStructure.setFieldValue("OrderBlck",sapShiptoStructure.getValue("ORDER_BLCK"));
	retShiptoStructure.setFieldValue("PoBox",sapShiptoStructure.getValue("PO_BOX"));
	retShiptoStructure.setFieldValue("PobxPcd",sapShiptoStructure.getValue("POBX_PCD"));
	retShiptoStructure.setFieldValue("PostlCode",sapShiptoStructure.getValue("POSTL_CODE"));
	retShiptoStructure.setFieldValue("ProdAttr1",sapShiptoStructure.getValue("PROD_ATTR1"));
	retShiptoStructure.setFieldValue("ProdAttr2",sapShiptoStructure.getValue("PROD_ATTR2"));
	retShiptoStructure.setFieldValue("ProdAttr3",sapShiptoStructure.getValue("PROD_ATTR3"));
	retShiptoStructure.setFieldValue("ProdAttr4",sapShiptoStructure.getValue("PROD_ATTR4"));
	retShiptoStructure.setFieldValue("ProdAttr5",sapShiptoStructure.getValue("PROD_ATTR5"));
	retShiptoStructure.setFieldValue("ProdAttr6",sapShiptoStructure.getValue("PROD_ATTR6"));
	retShiptoStructure.setFieldValue("ProdAttr7",sapShiptoStructure.getValue("PROD_ATTR7"));
	retShiptoStructure.setFieldValue("ProdAttr8",sapShiptoStructure.getValue("PROD_ATTR8"));
	retShiptoStructure.setFieldValue("ProdAttr9",sapShiptoStructure.getValue("PROD_ATTR9"));
	retShiptoStructure.setFieldValue("ProdAttra",sapShiptoStructure.getValue("PROD_ATTRA"));
	retShiptoStructure.setFieldValue("ProdProp",sapShiptoStructure.getValue("PROD_PROP"));
	retShiptoStructure.setFieldValue("RecvHours",sapShiptoStructure.getValue("RECV_HOURS"));
	retShiptoStructure.setFieldValue("Region",sapShiptoStructure.getValue("REGION"));
	retShiptoStructure.setFieldValue("SaAmFrom",sapShiptoStructure.getValue("SA_AM_FROM"));
	retShiptoStructure.setFieldValue("SaAmUntl",sapShiptoStructure.getValue("SA_AM_UNTL"));
	retShiptoStructure.setFieldValue("SaPmFrom",sapShiptoStructure.getValue("SA_PM_FROM"));
	retShiptoStructure.setFieldValue("SaPmUntl",sapShiptoStructure.getValue("SA_PM_UNTL"));
	retShiptoStructure.setFieldValue("ShipCond",sapShiptoStructure.getValue("SHIP_COND"));
	retShiptoStructure.setFieldValue("ShipTo",sapShiptoStructure.getValue("SHIP_TO"));
	retShiptoStructure.setFieldValue("Street",sapShiptoStructure.getValue("STREET"));
	retShiptoStructure.setFieldValue("SuAmFrom",sapShiptoStructure.getValue("SU_AM_FROM"));
	retShiptoStructure.setFieldValue("SuAmUntl",sapShiptoStructure.getValue("SU_AM_UNTL"));
	retShiptoStructure.setFieldValue("SuPmFrom",sapShiptoStructure.getValue("SU_PM_FROM"));
	retShiptoStructure.setFieldValue("SuPmUntl",sapShiptoStructure.getValue("SU_PM_UNTL"));
	retShiptoStructure.setFieldValue("TaxClass1",sapShiptoStructure.getValue("TAX_CLASS1"));
	retShiptoStructure.setFieldValue("TaxClass2",sapShiptoStructure.getValue("TAX_CLASS2"));
	retShiptoStructure.setFieldValue("TaxClass3",sapShiptoStructure.getValue("TAX_CLASS3"));
	retShiptoStructure.setFieldValue("TaxClass4",sapShiptoStructure.getValue("TAX_CLASS4"));
	retShiptoStructure.setFieldValue("TaxClass5",sapShiptoStructure.getValue("TAX_CLASS5"));
	retShiptoStructure.setFieldValue("TaxClass6",sapShiptoStructure.getValue("TAX_CLASS6"));
	retShiptoStructure.setFieldValue("TaxClass7",sapShiptoStructure.getValue("TAX_CLASS7"));
	retShiptoStructure.setFieldValue("TaxClass8",sapShiptoStructure.getValue("TAX_CLASS8"));
	retShiptoStructure.setFieldValue("TaxClass9",sapShiptoStructure.getValue("TAX_CLASS9"));
	retShiptoStructure.setFieldValue("Taxjurcode",sapShiptoStructure.getValue("TAXJURCODE"));
	retShiptoStructure.setFieldValue("Telephone",sapShiptoStructure.getValue("TELEPHONE"));
	retShiptoStructure.setFieldValue("ThAmFrom",sapShiptoStructure.getValue("TH_AM_FROM"));
	retShiptoStructure.setFieldValue("ThAmUntl",sapShiptoStructure.getValue("TH_AM_UNTL"));
	retShiptoStructure.setFieldValue("ThPmFrom",sapShiptoStructure.getValue("TH_PM_FROM"));
	retShiptoStructure.setFieldValue("ThPmUntl",sapShiptoStructure.getValue("TH_PM_UNTL"));
	retShiptoStructure.setFieldValue("TrainStat",sapShiptoStructure.getValue("TRAIN_STAT"));
	retShiptoStructure.setFieldValue("TrnspZone",sapShiptoStructure.getValue("TRNSP_ZONE"));
	retShiptoStructure.setFieldValue("TuAmFrom",sapShiptoStructure.getValue("TU_AM_FROM"));
	retShiptoStructure.setFieldValue("TuAmUntl",sapShiptoStructure.getValue("TU_AM_UNTL"));
	retShiptoStructure.setFieldValue("TuPmFrom",sapShiptoStructure.getValue("TU_PM_FROM"));
	retShiptoStructure.setFieldValue("TuPmUntl",sapShiptoStructure.getValue("TU_PM_UNTL"));
	retShiptoStructure.setFieldValue("UnloadPt",sapShiptoStructure.getValue("UNLOAD_PT"));
	retShiptoStructure.setFieldValue("VatRegNo",sapShiptoStructure.getValue("VAT_REG_NO"));
	retShiptoStructure.setFieldValue("WeAmFrom",sapShiptoStructure.getValue("WE_AM_FROM"));
	retShiptoStructure.setFieldValue("WePmFrom",sapShiptoStructure.getValue("WE_PM_FROM"));
	retShiptoStructure.setFieldValue("WePmUntl",sapShiptoStructure.getValue("WE_PM_UNTL"));
	retShiptoStructure.setFieldValue("WrAmUntl",sapShiptoStructure.getValue("WR_AM_UNTL"));
	finalReturnObject.setShipToParty(retShiptoStructure);

	ReturnObjFromRetrieve retSoldtoStructure = finalReturnObject.getSoldToParty();
	retSoldtoStructure.setFieldValue("Acc1Time",sapSoldtoStructure.getValue("ACC_1_TIME"));
	retSoldtoStructure.setFieldValue("BtchSplit",sapSoldtoStructure.getValue("BTCH_SPLIT"));
	retSoldtoStructure.setFieldValue("City",sapSoldtoStructure.getValue("CITY"));
	retSoldtoStructure.setFieldValue("CompanyId",sapSoldtoStructure.getValue("COMPANY_ID"));
	retSoldtoStructure.setFieldValue("ComplDlv",sapSoldtoStructure.getValue("COMPL_DLV"));
	retSoldtoStructure.setFieldValue("Country",sapSoldtoStructure.getValue("COUNTRY"));
	retSoldtoStructure.setFieldValue("Currency",sapSoldtoStructure.getValue("CURRENCY"));
	retSoldtoStructure.setFieldValue("CustGroup",sapSoldtoStructure.getValue("CUST_GROUP"));
	retSoldtoStructure.setFieldValue("DlvBlock",sapSoldtoStructure.getValue("DLV_BLOCK"));
	retSoldtoStructure.setFieldValue("DlvPrio",sapSoldtoStructure.getValue("DLV_PRIO"));
	retSoldtoStructure.setFieldValue("ExchgRate",sapSoldtoStructure.getValue("EXCHG_RATE"));
	retSoldtoStructure.setFieldValue("Incoterms1",sapSoldtoStructure.getValue("INCOTERMS1"));
	retSoldtoStructure.setFieldValue("Incoterms2",sapSoldtoStructure.getValue("INCOTERMS2"));
	retSoldtoStructure.setFieldValue("Langu",sapSoldtoStructure.getValue("LANGU"));
	retSoldtoStructure.setFieldValue("MaxPlDlv",sapSoldtoStructure.getValue("MAX_PL_DLV"));
	retSoldtoStructure.setFieldValue("Name",sapSoldtoStructure.getValue("NAME"));
	retSoldtoStructure.setFieldValue("OrderBlck",sapSoldtoStructure.getValue("ORDER_BLCK"));
	retSoldtoStructure.setFieldValue("OrderComb",sapSoldtoStructure.getValue("ORDER_COMB"));
	retSoldtoStructure.setFieldValue("OrderProb",sapSoldtoStructure.getValue("ORDER_PROB"));
	retSoldtoStructure.setFieldValue("PartDlv",sapSoldtoStructure.getValue("PART_DLV"));
	retSoldtoStructure.setFieldValue("PoBox",sapSoldtoStructure.getValue("PO_BOX"));
	retSoldtoStructure.setFieldValue("PobxPcd",sapSoldtoStructure.getValue("POBX_PCD"));
	retSoldtoStructure.setFieldValue("PostlCode",sapSoldtoStructure.getValue("POSTL_CODE"));
	retSoldtoStructure.setFieldValue("PrcProced",sapSoldtoStructure.getValue("PRC_PROCED"));
	retSoldtoStructure.setFieldValue("PriceGrp",sapSoldtoStructure.getValue("PRICE_GRP"));
	retSoldtoStructure.setFieldValue("PriceList",sapSoldtoStructure.getValue("PRICE_LIST"));
	retSoldtoStructure.setFieldValue("ProdProp",sapSoldtoStructure.getValue("PROD_PROP"));
	retSoldtoStructure.setFieldValue("SalesDist",sapSoldtoStructure.getValue("SALES_DIST"));
	retSoldtoStructure.setFieldValue("SalesGrp",sapSoldtoStructure.getValue("SALES_GRP"));
	retSoldtoStructure.setFieldValue("SalesOff",sapSoldtoStructure.getValue("SALES_OFF"));
	retSoldtoStructure.setFieldValue("ShipCond",sapSoldtoStructure.getValue("SHIP_COND"));
	retSoldtoStructure.setFieldValue("SoldTo",sapSoldtoStructure.getValue("SOLD_TO"));
	retSoldtoStructure.setFieldValue("StatGroup",sapSoldtoStructure.getValue("STAT_GROUP"));
	retSoldtoStructure.setFieldValue("Street",sapSoldtoStructure.getValue("STREET"));
	retSoldtoStructure.setFieldValue("TaxClass1",sapSoldtoStructure.getValue("TAX_CLASS1"));
	retSoldtoStructure.setFieldValue("TaxClass2",sapSoldtoStructure.getValue("TAX_CLASS2"));
	retSoldtoStructure.setFieldValue("TaxClass3",sapSoldtoStructure.getValue("TAX_CLASS3"));
	retSoldtoStructure.setFieldValue("TaxClass4",sapSoldtoStructure.getValue("TAX_CLASS4"));
	retSoldtoStructure.setFieldValue("TaxClass5",sapSoldtoStructure.getValue("TAX_CLASS5"));
	retSoldtoStructure.setFieldValue("TaxClass6",sapSoldtoStructure.getValue("TAX_CLASS6"));
	retSoldtoStructure.setFieldValue("TaxClass7",sapSoldtoStructure.getValue("TAX_CLASS7"));
	retSoldtoStructure.setFieldValue("TaxClass8",sapSoldtoStructure.getValue("TAX_CLASS8"));
	retSoldtoStructure.setFieldValue("TaxClass9",sapSoldtoStructure.getValue("TAX_CLASS9"));
	retSoldtoStructure.setFieldValue("Telephone",sapSoldtoStructure.getValue("TELEPHONE"));
	retSoldtoStructure.setFieldValue("VatRegNo",sapSoldtoStructure.getValue("VAT_REG_NO"));
	finalReturnObject.setSoldToParty(retSoldtoStructure);

	ReturnObjFromRetrieve retScheduleStructure = finalReturnObject.getScheduleTable();
	if(sapDeliverySchedTableOut.getNumRows() > 0)
	{
		do
		{
			retScheduleStructure.setFieldValue("Operation",sapDeliverySchedTableOut.getValue("OPERATION"));
			retScheduleStructure.setFieldValue("DocNumber",sapDeliverySchedTableOut.getValue("DOC_NUMBER"));
			retScheduleStructure.setFieldValue("ItmNumber",sapDeliverySchedTableOut.getValue("ITM_NUMBER"));
			retScheduleStructure.setFieldValue("SchedLine",sapDeliverySchedTableOut.getValue("SCHED_LINE"));
			retScheduleStructure.setFieldValue("SchedType",sapDeliverySchedTableOut.getValue("SCHED_TYPE"));
			retScheduleStructure.setFieldValue("Relfordel",sapDeliverySchedTableOut.getValue("RELFORDEL"));
			retScheduleStructure.setFieldValue("ReqDate",sapDeliverySchedTableOut.getValue("REQ_DATE"));
			retScheduleStructure.setFieldValue("ReqType",sapDeliverySchedTableOut.getValue("REQ_TYPE"));
			retScheduleStructure.setFieldValue("ReqQty",sapDeliverySchedTableOut.getValue("REQ_QTY"));
			retScheduleStructure.setFieldValue("SalesUnit",sapDeliverySchedTableOut.getValue("SALES_UNIT"));
			retScheduleStructure.setFieldValue("Isocodunit",sapDeliverySchedTableOut.getValue("ISOCODUNIT"));
			retScheduleStructure.setFieldValue("ReqQty1",sapDeliverySchedTableOut.getValue("REQ_QTY1"));
			retScheduleStructure.setFieldValue("BaseUom",sapDeliverySchedTableOut.getValue("BASE_UOM"));
			retScheduleStructure.setFieldValue("Isobasunit",sapDeliverySchedTableOut.getValue("ISOBASUNIT"));
			retScheduleStructure.setFieldValue("ConfirQty",sapDeliverySchedTableOut.getValue("CONFIR_QTY"));
			retScheduleStructure.setFieldValue("ReqDate1",sapDeliverySchedTableOut.getValue("REQ_DATE1"));
			retScheduleStructure.setFieldValue("ReqType1",sapDeliverySchedTableOut.getValue("REQ_TYPE"));
			retScheduleStructure.setFieldValue("Pltype",sapDeliverySchedTableOut.getValue("PLTYPE"));
			retScheduleStructure.setFieldValue("Busidocnr",sapDeliverySchedTableOut.getValue("BUSIDOCNR"));
			retScheduleStructure.setFieldValue("Busiitnr",sapDeliverySchedTableOut.getValue("BUSIITNR"));
			retScheduleStructure.setFieldValue("SchedLin1",sapDeliverySchedTableOut.getValue("SCHED_LIN1"));
			retScheduleStructure.setFieldValue("EarlDate",sapDeliverySchedTableOut.getValue("EARL_DATE"));
			retScheduleStructure.setFieldValue("MaintReq",sapDeliverySchedTableOut.getValue("MAINT_REQ"));
			retScheduleStructure.setFieldValue("PreqNo",sapDeliverySchedTableOut.getValue("PREQ_NO"));
			retScheduleStructure.setFieldValue("PoType",sapDeliverySchedTableOut.getValue("PO_TYPE"));
			retScheduleStructure.setFieldValue("DocCat",sapDeliverySchedTableOut.getValue("DOC_CAT"));
			retScheduleStructure.setFieldValue("ConfStat",sapDeliverySchedTableOut.getValue("CONF_STAT"));
			retScheduleStructure.setFieldValue("IrInd",sapDeliverySchedTableOut.getValue("IR_IND"));
			retScheduleStructure.setFieldValue("Returndate",sapDeliverySchedTableOut.getValue("RETURNDATE"));
			retScheduleStructure.setFieldValue("DateType",sapDeliverySchedTableOut.getValue("DATE_TYPE"));
			retScheduleStructure.setFieldValue("TpDate",sapDeliverySchedTableOut.getValue("TP_DATE"));
			retScheduleStructure.setFieldValue("MsDate",sapDeliverySchedTableOut.getValue("MS_DATE"));
			retScheduleStructure.setFieldValue("LoadDate",sapDeliverySchedTableOut.getValue("LOAD_DATE"));
			retScheduleStructure.setFieldValue("GiDate",sapDeliverySchedTableOut.getValue("GI_DATE"));
			retScheduleStructure.setFieldValue("CorrQty",sapDeliverySchedTableOut.getValue("CORR_QTY"));
			retScheduleStructure.setFieldValue("ReqDlvBl",sapDeliverySchedTableOut.getValue("REQ_DLV_BL"));
			retScheduleStructure.setFieldValue("GrpDefin",sapDeliverySchedTableOut.getValue("GRP_DEFIN"));
			retScheduleStructure.setFieldValue("Releastyp",sapDeliverySchedTableOut.getValue("RELEASTYP"));
			retScheduleStructure.setFieldValue("ForcastNr",sapDeliverySchedTableOut.getValue("FORCAST_NR"));
			retScheduleStructure.setFieldValue("CommitQty",sapDeliverySchedTableOut.getValue("COMMIT_QTY"));
			retScheduleStructure.setFieldValue("Size2",sapDeliverySchedTableOut.getValue("SIZE2"));
			retScheduleStructure.setFieldValue("Size3",sapDeliverySchedTableOut.getValue("SIZE3"));
			retScheduleStructure.setFieldValue("UnitMeas",sapDeliverySchedTableOut.getValue("UNIT_MEAS"));
			retScheduleStructure.setFieldValue("IsoRomei",sapDeliverySchedTableOut.getValue("ISO_ROMEI"));
			retScheduleStructure.setFieldValue("Formulakey",sapDeliverySchedTableOut.getValue("FORMULAKEY"));
			retScheduleStructure.setFieldValue("Salesqtynr",sapDeliverySchedTableOut.getValue("SALESQTYNR"));
			retScheduleStructure.setFieldValue("Salesqtyde",sapDeliverySchedTableOut.getValue("SALESQTYDE"));
			retScheduleStructure.setFieldValue("AvailCon",sapDeliverySchedTableOut.getValue("AVAIL_CON"));
			retScheduleStructure.setFieldValue("MoveType",sapDeliverySchedTableOut.getValue("MOVE_TYPE"));
			retScheduleStructure.setFieldValue("PreqItem",sapDeliverySchedTableOut.getValue("PREQ_ITEM"));
			retScheduleStructure.setFieldValue("LintypEdi",sapDeliverySchedTableOut.getValue("LINTYP_EDI"));
			retScheduleStructure.setFieldValue("Orderid",sapDeliverySchedTableOut.getValue("ORDERID"));
			retScheduleStructure.setFieldValue("Planordnr",sapDeliverySchedTableOut.getValue("PLANORDNR"));
			retScheduleStructure.setFieldValue("BomexplNo",sapDeliverySchedTableOut.getValue("BOMEXPL_NO"));
			retScheduleStructure.setFieldValue("Custchstat",sapDeliverySchedTableOut.getValue("CUSTCHSTAT"));

			Double guaranteed=null;
			String guarString=sapDeliverySchedTableOut.getValue("GURANTEED").toString();
			guarString="1";
			if((Integer.parseInt(guarString))>0)
			{
				guaranteed=new Double(guarString);
			}

			retScheduleStructure.setFieldValue("Guranteed",guaranteed);
			retScheduleStructure.setFieldValue("MsTime",sapDeliverySchedTableOut.getValue("MS_TIME"));
			retScheduleStructure.setFieldValue("TpTime",sapDeliverySchedTableOut.getValue("TP_TIME"));
			retScheduleStructure.setFieldValue("LoadTime",sapDeliverySchedTableOut.getValue("LOAD_TIME"));
			retScheduleStructure.setFieldValue("GiTime",sapDeliverySchedTableOut.getValue("GI_TIME"));
			retScheduleStructure.setFieldValue("Routesched",sapDeliverySchedTableOut.getValue("ROUTESCHED"));
			retScheduleStructure.addRow();

		}
		while(sapDeliverySchedTableOut.nextRow());
	}

	finalReturnObject.setScheduleTable(retScheduleStructure);

	ReturnObjFromRetrieve retReturnStructure = finalReturnObject.getReturn();
	retReturnStructure.setFieldValue("Code",sapReturnStructure.getValue("CODE"));
	retReturnStructure.setFieldValue("LogMsgNo",sapReturnStructure.getValue("LOG_MSG_NO"));
	retReturnStructure.setFieldValue("LogNo",sapReturnStructure.getValue("LOG_NO"));
	retReturnStructure.setFieldValue("Message",sapReturnStructure.getValue("MESSAGE"));
	retReturnStructure.setFieldValue("Type",sapReturnStructure.getValue("TYPE"));
	retReturnStructure.addRow();

	finalReturnObject.setReturn(retReturnStructure);

//////////////finalReturnObject;C10150X
%>
			
			