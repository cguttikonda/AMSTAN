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
	
	headerParams.setCreatedOn(new Date());	
	headerParams.setCreatedBy(Session.getUserId());
	headerParams.setDocType("NB");
	headerParams.setVendor("1100000887");
	//headerParams.setAgreement(agreement);
	//headerParams.setQuotation(quotation);
	//headerParams.setQuoteDate(new Date());
	
	itemRow = new EziPOItemTableRow();
	itemRow.setMaterial("000000000004000060");
	itemRow.setPlant("1000");
	itemRow.setQuantity("50");
	itemRow.setUOM("KG");
	itemRow.setPrice("10");
	itemRow.setTaxCode("AA");
	//itemRow.setValType("OGL FOR RM");

	itemTable.appendRow(itemRow);
	
	schRow = new EziPOSchedTableRow();
	schRow.setMaterial("4000060");
	schRow.setQuantity("50");
	schRow.setDelivDate("04/12/2005");
	schTable.appendRow(schRow);

	EzcParams mainParams = new EzcParams(true);
	mainParams.setObject(headerParams);
	mainParams.setObject(itemTable);
	mainParams.setObject(schTable);
	mainParams.setObject(condTable);
	Session.prepareParams(mainParams);
	ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)Manager.ezCreatePO(mainParams);
	ret.toEzcString();
%>
