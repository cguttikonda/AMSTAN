<%@ page import ="ezc.ezparam.*,java.util.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%

	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager 	     = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	EzcParams ezcparamsnew=new EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQConditionsTable ezirfconditiontable 	     = new ezc.ezpreprocurement.params.EziRFQConditionsTable();
	ezc.ezpreprocurement.params.EziRFQConditionsTableRow ezirfconditiontablerow   = null;//new ezc.ezpreprocurement.params.EziRFQConditionsTableRow();



	ezirfconditiontablerow = new ezc.ezpreprocurement.params.EziRFQConditionsTableRow();

	ezirfconditiontablerow.setRFQNo("2");
	ezirfconditiontablerow.setConditionId("2777");
	ezirfconditiontablerow.setConditionVal("112");
	ezirfconditiontablerow.setPer("121");
	ezirfconditiontablerow.setCurrency("23");
	ezirfconditiontablerow.setUOM("343");
	ezirfconditiontablerow.setExt1("343");
	ezirfconditiontablerow.setExt2("34");
	ezirfconditiontablerow.setExt3("32224");

	ezirfconditiontable.appendRow(ezirfconditiontablerow);
	
	ezirfconditiontablerow = new ezc.ezpreprocurement.params.EziRFQConditionsTableRow();

	ezirfconditiontablerow.setRFQNo("2");
	ezirfconditiontablerow.setConditionId("33888");
	ezirfconditiontablerow.setConditionVal("3");
	ezirfconditiontablerow.setPer("4");
	ezirfconditiontablerow.setCurrency("9");
	ezirfconditiontablerow.setUOM("5");
	ezirfconditiontablerow.setExt1("6");
	ezirfconditiontablerow.setExt2("7");
	ezirfconditiontablerow.setExt3("1118");
	
	ezirfconditiontable.appendRow(ezirfconditiontablerow);
	
	
	ezirfconditiontablerow = new ezc.ezpreprocurement.params.EziRFQConditionsTableRow();

	
	ezirfconditiontablerow.setRFQNo("2");
	ezirfconditiontablerow.setConditionId("4999");
	ezirfconditiontablerow.setConditionVal("3");
	ezirfconditiontablerow.setPer("4");
	ezirfconditiontablerow.setCurrency("9");
	ezirfconditiontablerow.setUOM("5");
	ezirfconditiontablerow.setExt1("6");
	ezirfconditiontablerow.setExt2("7");
	ezirfconditiontablerow.setExt3("0008");
	
	ezirfconditiontable.appendRow(ezirfconditiontablerow);
	
	



	ezcparamsnew.setObject(ezirfconditiontable);
	ezcparamsnew.setLocalStore("Y");
	Session.prepareParams(ezcparamsnew);
	ReturnObjFromRetrieve ret =(ReturnObjFromRetrieve)ezrfqmanager.ezUpdateRFQConditions(ezcparamsnew);
	
%>