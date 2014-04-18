<%@ page import="java.util.*,ezc.ezutil.FormatDate"%>
<%
	
	boolean headFlag = false,itemFlag = false;
	
	EzBapisdheadStructure ezcSdheadStructure = new EzBapisdheadStructure();
	EzBapisdh1xStructure ezcSdheadxStructure = new EzBapisdh1xStructure();

	EzBapiiteminTable ezcIteminTable 	= new EzBapiiteminTable();
	EzBapiiteminTableRow ezcIteminRow 	= null;

	EzBapiitemexTable ezcItemexTable 	= new EzBapiitemexTable();
	EzBapiitemexTableRow ezcItemexRow 	= null;

	EzBapiscondTable ezccondtable 		= new EzBapiscondTable();
	EzBapiscondTableRow ezccondRow 		= null;

	EzBapicondxTable ezccondxtable 		= new EzBapicondxTable();
	EzBapicondxTableRow ezccondxRow		= null;

	EzBapischdlTable ezcschdlTable 		= new EzBapischdlTable();
	EzBapischdlTableRow ezcschdlRow		= null;

	EzBapischdlxTable ezcschdlxTable 	= new EzBapischdlxTable();
	EzBapischdlxTableRow ezcschdlxRow 	= null;

	EzBapistextTable ezctextTable 		= new EzBapistextTable();
	EzBapistextTableRow ezctextRow 		= null;

	ezcSdheadStructure.setDocNumber(quoteNo);
	if(!paymentTerm.equals(prevPayTerm))
	{
		ezcSdheadStructure.setPmnttrms(paymentTerm);
		headFlag = true;
		
		//** add WF AuditTrail **//
		
		ezc.ezsalesquote.client.EzSalesQuoteManager EzSalesQuote = new ezc.ezsalesquote.client.EzSalesQuoteManager();

		String myAuditNoTemp = "1";
		ezc.ezparam.EzcParams auditMainParams = new ezc.ezparam.EzcParams(true);
		auditMainParams.setLocalStore("Y");
		EziWFAuditTrailParams eziWFHistoryParams= new EziWFAuditTrailParams();
		eziWFHistoryParams.setEwhDocId(soNum);
		auditMainParams.setObject(eziWFHistoryParams);
		Session.prepareParams(auditMainParams);
		ReturnObjFromRetrieve auditNoRetObj = (ReturnObjFromRetrieve)EzSalesQuote.ezGetWFAuditTrailNo(auditMainParams);

		if(auditNoRetObj!=null && auditNoRetObj.getRowCount()>0){
			myAuditNoTemp = auditNoRetObj.getFieldValueString(0,"AUDIT_NO");
		}

		EziWFAuditTrailTable myAuditTab = new EziWFAuditTrailTable();
		EziWFAuditTrailTableRow myAuditTabRow 	= null;	

		myAuditTabRow=new EziWFAuditTrailTableRow();
		myAuditTabRow.setEwhAuditTrailNo(myAuditNoTemp);
		myAuditTabRow.setEwhDocId(soNum);
		myAuditTabRow.setEwhType("SQUOTE");
		myAuditTabRow.setEwhSourceParticipant((Session).getUserId());
		myAuditTabRow.setEwhSourceParticipantType("");
		myAuditTabRow.setEwhDestParticipant("");
		myAuditTabRow.setEwhDestParticipantType("");
		myAuditTabRow.setEwhComments("Payment Term is changed from "+prevPayTerm+" to "+paymentTerm);
		myAuditTab.appendRow(myAuditTabRow);

		auditMainParams = new ezc.ezparam.EzcParams(true);
		auditMainParams.setLocalStore("Y");
		auditMainParams.setObject(myAuditTab);
		Session.prepareParams(auditMainParams);
		EzSalesQuote.ezAddWFAuditTrail(auditMainParams);

		//** add WF AuditTrail **//
	}
	ezcSdheadxStructure.setUpdateflag("U");

	int lineno = 1;
	java.math.BigInteger line = null;
	String OrderQuantity = null;

	for(int j=0;j<prodCodeLength;j++)
	{
		line = new java.math.BigInteger(String.valueOf(lineno*10));

		OrderQuantity = reqQty_1[j];
		OrderQuantity = (OrderQuantity==null || "".equals(OrderQuantity.trim()) || "null".equals(OrderQuantity))?"0":OrderQuantity.trim();

		if(!"0".equals(OrderQuantity))
		{
			try
			{
				
				java.math.BigDecimal prevPrice = new java.math.BigDecimal(Double.parseDouble(prevSapPrice_1[j]));
				java.math.BigDecimal newPrice = new java.math.BigDecimal(Double.parseDouble(listPrice_1[j]));
				
				prevPrice = prevPrice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
				newPrice = newPrice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
				
				if(!prevPrice.equals(newPrice))
				{
					ezccondRow = new EzBapiscondTableRow();
					ezccondxRow = new EzBapicondxTableRow();

					ezccondRow.setItmNumber(line);
					ezccondRow.setCondType("PR00");
					ezccondRow.setCondValue(new java.math.BigDecimal(Double.parseDouble(listPrice_1[j])/10));
					//ezccondRow.setCurrency();
					//ezccondRow.setCondUnit();

					ezccondtable.appendRow(ezccondRow);

					ezccondxRow.setUpdateflag("U");

					ezccondxtable.appendRow(ezccondxRow);
					itemFlag =true;
					
					//** add WF AuditTrail **//

					ezc.ezsalesquote.client.EzSalesQuoteManager EzSalesQuote = new ezc.ezsalesquote.client.EzSalesQuoteManager();

					String myAuditNoTemp = "1";
					ezc.ezparam.EzcParams auditMainParams = new ezc.ezparam.EzcParams(true);
					auditMainParams.setLocalStore("Y");
					EziWFAuditTrailParams eziWFHistoryParams= new EziWFAuditTrailParams();
					eziWFHistoryParams.setEwhDocId(soNum);
					auditMainParams.setObject(eziWFHistoryParams);
					Session.prepareParams(auditMainParams);
					ReturnObjFromRetrieve auditNoRetObj = (ReturnObjFromRetrieve)EzSalesQuote.ezGetWFAuditTrailNo(auditMainParams);

					if(auditNoRetObj!=null && auditNoRetObj.getRowCount()>0){
						myAuditNoTemp = auditNoRetObj.getFieldValueString(0,"AUDIT_NO");
					}

					EziWFAuditTrailTable myAuditTab = new EziWFAuditTrailTable();
					EziWFAuditTrailTableRow myAuditTabRow 	= null;	

					myAuditTabRow=new EziWFAuditTrailTableRow();
					myAuditTabRow.setEwhAuditTrailNo(myAuditNoTemp);
					myAuditTabRow.setEwhDocId(soNum);
					myAuditTabRow.setEwhType("SQUOTE");
					myAuditTabRow.setEwhSourceParticipant((Session).getUserId());
					myAuditTabRow.setEwhSourceParticipantType("");
					myAuditTabRow.setEwhDestParticipant("");
					myAuditTabRow.setEwhDestParticipantType("");
					myAuditTabRow.setEwhComments("Price for item "+line+" is changed from "+prevPrice+" to "+newPrice);
					myAuditTab.appendRow(myAuditTabRow);

					auditMainParams = new ezc.ezparam.EzcParams(true);
					auditMainParams.setLocalStore("Y");
					auditMainParams.setObject(myAuditTab);
					Session.prepareParams(auditMainParams);
					EzSalesQuote.ezAddWFAuditTrail(auditMainParams);

					//** add WF AuditTrail **//
				}
			}
			catch(Exception err){}
		}
		lineno++;
	}
	
	log4j.log("SAPnumberSAPnumberSAPnumberSAPnumber======>"+SAPnumber, "D");

	if(SAPnumber && (headFlag || itemFlag))
	{
		try
		{
			ezc.ezsalesquote.client.EzSalesQuoteManager EzSalesQuote = new ezc.ezsalesquote.client.EzSalesQuoteManager();

			ezc.ezparam.EzcParams ezcParams = new ezc.ezparam.EzcParams(true);

			ezcParams.setObject(ezcSdheadStructure);
			ezcParams.setObject(ezcSdheadxStructure);
			ezcParams.setObject(ezcIteminTable);
			ezcParams.setObject(ezcItemexTable);
			ezcParams.setObject(ezccondtable);
			ezcParams.setObject(ezccondxtable);
			ezcParams.setObject(ezcschdlTable);
			ezcParams.setObject(ezcschdlxTable);
			ezcParams.setObject(ezctextTable);
			
			Session.prepareParams(ezcParams);
			
			ReturnObjFromRetrieve retUpdateQuote = (ReturnObjFromRetrieve)EzSalesQuote.ezChangeSalesQuote(ezcParams);

			int retUpdateQuoteCount = retUpdateQuote.getRowCount();

			log4j.log("retUpdateQuoteCount======>"+retUpdateQuoteCount,"D");
			log4j.log("retUpdateQuote======>"+retUpdateQuote.toEzcString(),"D");

			for(int pc=0;pc<retUpdateQuoteCount;pc++)
			{
				ErrorType = retUpdateQuote.getFieldValueString(pc,"TYPE");
				if("E".equalsIgnoreCase(ErrorType))
				{
					ErrorMessage = ErrorMessage+"<br>Post:"+orderError.getFieldValueString(pc,"MESSAGE");
					SAPnumber=false; 
				}
			}
		}	
      		catch(Exception e)
      		{
			e.printStackTrace();
			SAPnumber=false;
      		}
	}
%>