<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
	String status = request.getParameter("status");
	String collectiveRFQNo = request.getParameter("collectiveRFQNo");
	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager 	 = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams ezcparams				    		 = new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams 	 = new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	
	if(status != null && !"null".equals(status) && "CR".equals(status))
	{
		ezirfqheaderparams.setExt1("CR");
		ezirfqheaderparams.setStatus("Y','N','R");
	}
	else if(!(collectiveRFQNo == null || "null".equals(collectiveRFQNo)))
	{
		ezirfqheaderparams.setExt1("RFQ");
		ezirfqheaderparams.setStatus("Y','N','R");
		ezirfqheaderparams.setCollectiveRFQNo(collectiveRFQNo);
	}

	ezcparams.setObject(ezirfqheaderparams);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);

	ezc.ezparam.ReturnObjFromRetrieve myRet = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQList(ezcparams);
%>
