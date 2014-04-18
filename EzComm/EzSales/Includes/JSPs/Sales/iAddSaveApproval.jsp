<%@ page import = "java.util.*"%>
<%@ page import = "ezc.ezparam.*,ezc.eznegotiation.params.*,ezc.eznegotiation.client.*" %>
<%
	EzNegotiationManager ezNegotiationManager = new EzNegotiationManager();
	EziOrderNegotiateParams ezOrderNegotiateParams = new EziOrderNegotiateParams();
	EziOrderNegotiateTable ezNegotiateTable = new EziOrderNegotiateTable();
	EziOrderNegotiateTableRow ezNegotiateTableRow = null;

	try
	{
		String toAct_A = approver;
		String createdOn = "";
		int iRowCount = 0;

		String negStat = "FORAPPROVAL";

		if("TRANSFERED".equals(status)) negStat = "FOCACCEPTED";

		Date DateTo = new Date();
		DateFormat formatter1 = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss a");
		createdOn = formatter1.format(DateTo);

		EzcParams orderMainParams = new EzcParams(false);

		ezOrderNegotiateParams.setType("ADD_ORDER_NEGOTIATE");

		for(int i=0;i<prodCodeLength;i++)
		{
			ezNegotiateTableRow = new EziOrderNegotiateTableRow();
			String line 	    = String.valueOf((i+1)*10);
			iRowCount           = iRowCount + 1;

			ezNegotiateTableRow.setOrderNo(weborno);
			ezNegotiateTableRow.setItemNo(line);
			ezNegotiateTableRow.setIndexNo(toAct_A);		//ToAct
			ezNegotiateTableRow.setCreatedBy(Session.getUserId());
			ezNegotiateTableRow.setCreatedOn(createdOn);
			ezNegotiateTableRow.setModifiedBy(Session.getUserId());
			ezNegotiateTableRow.setText(billToAddress);		//Explanation
			ezNegotiateTableRow.setStatus(negStat);
			ezNegotiateTableRow.setQuestionType(reasonCode);	//Code
			ezNegotiateTableRow.setQuesAnsrFlag(purposeOrder);	//Purpose
			ezNegotiateTableRow.setExt1(generalNotes2);		//Shipping Text

			ezNegotiateTable.insertRow((iRowCount-1),ezNegotiateTableRow);
		}
		orderMainParams.setLocalStore("Y");
		orderMainParams.setObject(ezOrderNegotiateParams);
		orderMainParams.setObject(ezNegotiateTable);
		Session.prepareParams(orderMainParams);
		ezc.ezcommon.EzLog4j.log("BEFORE ezAddOrderNegotiate >>>>>>>>>>>>","D");
		ezNegotiationManager.ezAddOrderNegotiate(orderMainParams);
		ezc.ezcommon.EzLog4j.log("AFTER ezAddOrderNegotiate >>>>>>>>>>>>","D");
	}
	catch(Exception e){}
%>