<%
	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager 	= new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams ezcparams				     		= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderTable ezirfqheadertable 	= new ezc.ezpreprocurement.params.EziRFQHeaderTable();
	ezc.ezpreprocurement.params.EziRFQHeaderTableRow ezirfqheadertablerow   = new ezc.ezpreprocurement.params.EziRFQHeaderTableRow();	
	ezirfqheadertablerow.setModifiedBy(Session.getUserId());
	ezirfqheadertablerow.setCollectiveRFQNo(collRfq);
	ezirfqheadertable.appendRow(ezirfqheadertablerow);
	ezcparams.setObject(ezirfqheadertable);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);
	ezrfqmanager.ezUpdateRFQ(ezcparams);
%>