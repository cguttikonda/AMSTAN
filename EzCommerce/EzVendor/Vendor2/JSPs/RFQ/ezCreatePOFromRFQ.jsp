<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="Manager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" />
<%@ page import="ezc.ezpreprocurement.params.*,java.util.*,ezc.ezparam.*;" %>
<jsp:useBean id="PcManager" class ="ezc.client.EzPurContractManager" scope="page"></jsp:useBean>

<%

	EziPOHeaderParams headerParams	= new EziPOHeaderParams();
	EziPOItemTable	itemTable	= new EziPOItemTable();	
	EziPOItemTableRow itemRow	= null;
	EziPOSchedTable schTable	= new EziPOSchedTable();
	EziPOSchedTableRow schRow	= null;
	EziPOCondTable condTable	= new EziPOCondTable();
	EziPOCondTableRow condRow	= null;
	

	String vendor		= (String)session.getValue("SOLDTO");
	String quotation	= request.getParameter("PurchaseOrder");
	String quotationDate	= request.getParameter("OrderDate");
	Date quoteDate = new Date(Integer.parseInt(quotationDate.substring(6,10))-1900, Integer.parseInt(quotationDate.substring(3,5))-1, Integer.parseInt(quotationDate.substring(0,2)));

	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager 	= new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams ezcparams				     		= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams 	= new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	ezirfqheaderparams.setRFQNo(quotation);

	ezcparams.setObject(ezirfqheaderparams);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);

	ezc.ezpreprocurement.params.EzoRFQHeaderParams ezorfqheaderparams = (ezc.ezpreprocurement.params.EzoRFQHeaderParams)ezrfqmanager.ezGetRFQDetails(ezcparams);
	ezc.ezparam.ReturnObjFromRetrieve rfqHeader  = (ezc.ezparam.ReturnObjFromRetrieve)ezorfqheaderparams.getRFQHeader();
	ezc.ezparam.ReturnObjFromRetrieve rfqDetails = (ezc.ezparam.ReturnObjFromRetrieve)ezorfqheaderparams.getRFQDetails();

	String conditionNo	= null; 	//request.getParameter("ConditionNo");
	String conditionVal	= null; 	//request.getParameter("ConditionVal");
	
	headerParams.setCreatedOn(new Date());	
	headerParams.setCreatedBy(Session.getUserId());
	headerParams.setVendor(vendor);
	headerParams.setQuotation(quotation);
	headerParams.setQuoteDate(quoteDate);
	
	
	int Count = rfqDetails.getRowCount();
	Date d = null;
	for(int i=0;i<Count;i++)
	{
		itemRow = new EziPOItemTableRow();
		itemRow.setMaterial(rfqDetails.getFieldValueString(i,"MATERIAL"));
		itemRow.setPlant(rfqDetails.getFieldValueString(i,"PLANT"));
		itemRow.setQuantity(rfqDetails.getFieldValueString(i,"QUANTITY"));
		itemRow.setUOM(rfqDetails.getFieldValueString(i,"UOM"));
		itemRow.setPrice(rfqDetails.getFieldValueString(i,"PRICE"));
		itemTable.appendRow(itemRow);
	
		schRow = new EziPOSchedTableRow();
		schRow.setMaterial(rfqDetails.getFieldValueString(i,"MATERIAL"));
		schRow.setQuantity(rfqDetails.getFieldValueString(i,"QUANTITY"));
		d = (Date)rfqDetails.getFieldValue(i,"DELIVERY_DATE");
		schRow.setDelivDate((d.getYear()+1900)+"-"+(d.getMonth()+1)+"-"+d.getDate());
		schTable.appendRow(schRow);
	}
	
	EzcParams mainParams = new EzcParams(true);
	mainParams.setObject(headerParams);
	mainParams.setObject(itemTable);
	mainParams.setObject(schTable);
	mainParams.setObject(condTable);
	Session.prepareParams(mainParams);
	ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)Manager.ezCreatePO(mainParams);
	
	String retMsg = "";
	
	if(ret != null)
	{
		for(int i=0;i<ret.getRowCount();i++)
		{
			if(ret.getFieldValueString(i,"TYPE").equals("E"))	
			{
				retMsg = ret.getFieldValueString(i,"MESSAGE");
				break;
			}
		}
	}
	if(retMsg.equals(""))
	  retMsg = "PO has been created successfully";
	  
	response.sendRedirect("../Shipment/ezMessage.jsp?Msg="+retMsg);
%>
