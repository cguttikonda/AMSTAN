<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
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

	String type 		= null;
	String vendor		= null;
	String agreement	= null;
	String agmtItem		= null;

	String fromRFQ = request.getParameter("fromRFQ");  
	String collRfq = request.getParameter("collectiveRfq");
	
	if(fromRFQ == null)
	{
		String[] chk1 = request.getParameterValues("chk1");
		StringTokenizer stk = new StringTokenizer(chk1[0],"##");	
		type 		= stk.nextToken();	
		vendor		= stk.nextToken();
		agreement	= stk.nextToken();
		agmtItem	= stk.nextToken();
	}
	else
	{	
		type 		= request.getParameter("typ");	
		vendor		= request.getParameter("vend");
		agreement	= "";
		agmtItem	= "";
	}
	
	
	EzPurchCtrDtlXML dtlxml = null;
	EzPSIInputParameters ioparams = new EzPSIInputParameters();
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	newParams.createContainer();
	newParams.setObject(ioparams);
	Session.prepareParams(newParams);
	ioparams.setOrderNumber(agreement);
	ioparams.setCostCenter(vendor);
	Session.prepareParams(ioparams);
	dtlxml = (EzPurchCtrDtlXML)PcManager.getPurchaseContractStatus(newParams);

	String price		= "10.00"; 	//request.getParameter("Price");
	
	for(int i=0;i<dtlxml.getRowCount();i++)
	{
		String itm ="";
		try
		{
			itm=""+Long.parseLong(dtlxml.getFieldValueString(i,"POSITION"));
		}
		catch(Exception e)
		{
			itm=dtlxml.getFieldValueString(i,"POSITION");
		}
		
		if(agmtItem.equals(itm))
		{
			price = dtlxml.getFieldValueString(i,"GROSSNETPRICEYN");	
			break;
		}
	}

	//String quotation	= "6000000251";//request.getParameter("quotation");
	//String quoteDate	= "07.11.2004";//request.getParameter("quoteDate");
	
	String material		= request.getParameter("material");
	material ="000000000000000000"+material;
	material =material.substring(material.length-18,material.length);
	String plant		= request.getParameter("plant");
	String qty		= request.getParameter("quantity");
	String uom		= request.getParameter("uom");
	String reqDate		= request.getParameter("reqDate");
	String delivDate	= reqDate.substring(3,5)+"/"+reqDate.substring(0,2)+"/"+reqDate.substring(6,10);
	
	String conditionNo	= null; 	//request.getParameter("ConditionNo");
	String conditionVal	= null; 	//request.getParameter("ConditionVal");
	
	headerParams.setCreatedOn(new Date());	
	headerParams.setCreatedBy(Session.getUserId());
	headerParams.setVendor(vendor);
	//headerParams.setAgreement(agreement);
	//headerParams.setQuotation(quotation);
	//headerParams.setQuoteDate(new Date());
	
	itemRow = new EziPOItemTableRow();
	itemRow.setMaterial(material);
	itemRow.setPlant(plant);
	itemRow.setQuantity(qty);
	itemRow.setUOM(uom);
	itemRow.setPrice(price);
	itemRow.setTaxCode("AA");
	
	itemTable.appendRow(itemRow);
	
	schRow = new EziPOSchedTableRow();
	schRow.setMaterial(material);
	schRow.setQuantity(qty);
	schRow.setDelivDate(delivDate);
	schTable.appendRow(schRow);

	EzcParams mainParams = new EzcParams(true);
	mainParams.setObject(headerParams);
	mainParams.setObject(itemTable);
	mainParams.setObject(schTable);
	mainParams.setObject(condTable);
	Session.prepareParams(mainParams);
	ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)Manager.ezCreatePO(mainParams);
	
	String retMsg = "";
	boolean flag = false;
	if(ret != null)
	{
		for(int i=0;i<ret.getRowCount();i++)
		{
			if(ret.getFieldValueString(i,"TYPE").equals("E"))	
			{
				flag = true;
				retMsg = ret.getFieldValueString(i,"MESSAGE");
				break;
			}
		}
	}
	if(retMsg.equals(""))
	  	retMsg = "PO has been created successfully";

	if(!flag && collRfq != null) //Condition for updating status to 'C' in RFQ header
	{
%>
		<%@include file="../../../Includes/Jsps/Rfq/iUpdateLocalQCFStatus.jsp" %>
<%
	}
	response.sendRedirect("../Shipment/ezMessage.jsp?Msg="+retMsg);
%>
