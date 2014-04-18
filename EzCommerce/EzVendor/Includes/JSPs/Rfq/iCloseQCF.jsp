<%
/*****For Put  Rank Status and PO Nos RFQ wise *****/
		
		ezc.ezparam.EzcParams rfqezcparams				     	= new ezc.ezparam.EzcParams(false);
		ezc.ezpreprocurement.params.EziRFQHeaderTable ezirfqheadertable 	= new ezc.ezpreprocurement.params.EziRFQHeaderTable();
		String reasons="";
		int retCount = rfqNos.size();
		for(int i=0;i<retCount;i++)
		{
			ezc.ezpreprocurement.params.EziRFQHeaderTableRow ezirfqheadertablerow   = new ezc.ezpreprocurement.params.EziRFQHeaderTableRow();

			ezirfqheadertablerow.setRFQNo((String)rfqNos.get(i)); 		
			ezirfqheadertablerow.setRankStatus("L1"); 
			ezirfqheadertablerow.setPOorCon(POorCon);
			ezirfqheadertablerow.setPONo((String)rfqpos.get(rfqNos.get(i))); 
			ezirfqheadertablerow.setModifiedBy(Session.getUserId()); 
			ezirfqheadertable.appendRow(ezirfqheadertablerow);
		}	

		rfqezcparams.setObject(ezirfqheadertable);
		rfqezcparams.setLocalStore("Y");
		Session.prepareParams(rfqezcparams);
		Manager.ezUpdateRFQ(rfqezcparams);
/**********/		
/****For Close All RFQs ******/		

		int tobeclosedvectcnt = tobeclosedrfqs.size();
		String tobeclosedrfqStr ="";
		for(int i=0;i<tobeclosedvectcnt;i++)
		{
			tobeclosedrfqStr+=",'"+tobeclosedrfqs.elementAt(i)+"'";
		}
		if(tobeclosedrfqStr.length() >0)
			tobeclosedrfqStr=tobeclosedrfqStr.substring(2,tobeclosedrfqStr.length()-1);


		ezc.ezparam.EzcParams closeezcparams				     	= new ezc.ezparam.EzcParams(false);
		ezc.ezpreprocurement.params.EziRFQHeaderTable closeezirfqheadertable	= new ezc.ezpreprocurement.params.EziRFQHeaderTable();
		ezc.ezpreprocurement.params.EziRFQHeaderTableRow closeezirfqheadertablerow   = new ezc.ezpreprocurement.params.EziRFQHeaderTableRow();

		if(closeAllRFQs)
			closeezirfqheadertablerow.setCollectiveRFQNo(collNo); 	
		else
			closeezirfqheadertablerow.setRFQNo(tobeclosedrfqStr); 
		closeezirfqheadertablerow.setStatus("C"); 
		closeezirfqheadertablerow.setModifiedBy(Session.getUserId()); 
		closeezirfqheadertable.appendRow(closeezirfqheadertablerow);

		closeezcparams.setObject(closeezirfqheadertable);
		closeezcparams.setLocalStore("Y");
		Session.prepareParams(closeezcparams);
		Manager.ezUpdateRFQ(closeezcparams);
/**********/				

			int tobeclosedrfqcnt = tobeclosedrfqs.size();
			for(int i=0;i<tobeclosedrfqcnt;i++)
			{
				String contract=(String)consVect.elementAt(i);
				ezc.ezparam.EzcParams historyMainParams = new ezc.ezparam.EzcParams(false);
				historyMainParams.setLocalStore("Y");
				ezc.ezpreprocurement.params.EziWFAuditTrailParams eziWFHistoryParams= new ezc.ezpreprocurement.params.EziWFAuditTrailParams();
				eziWFHistoryParams.setEwhDocId(collNo);
				historyMainParams.setObject(eziWFHistoryParams);
				Session.prepareParams(historyMainParams);
				ezc.ezparam.ReturnObjFromRetrieve wfMyRet = (ezc.ezparam.ReturnObjFromRetrieve)Manager.ezGetWFAuditTrailNo(historyMainParams);
				String historyNo = "";
				if(wfMyRet != null)
				{
					historyNo = wfMyRet.getFieldValueString(0,"AUDIT_NO");
					if(historyNo == "null")
						historyNo = "1";
				}
				else
					historyNo = "1";
				eziWFHistoryParams.setEwhAuditTrailNo(historyNo);
				eziWFHistoryParams.setEwhDocId(collNo);
				eziWFHistoryParams.setEwhType("");
				eziWFHistoryParams.setEwhSourceParticipant((String)Session.getUserId());
				eziWFHistoryParams.setEwhSourceParticipantType("");
				eziWFHistoryParams.setEwhDestParticipant("");
				eziWFHistoryParams.setEwhDestParticipantType("");
				ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();	
				String strDate = fd.getStringFromDate(new Date(),".",ezc.ezutil.FormatDate.DDMMYYYY);
				String ConComments = "Contract :"+contract+ " Created on "+strDate+" wrt RFQ :"+(String)poshash.get(contract); 
				eziWFHistoryParams.setEwhComments(ConComments);
				historyMainParams.setObject(eziWFHistoryParams);
				Session.prepareParams(historyMainParams);
				Manager.ezAddWFAuditTrail(historyMainParams);
	
			}

/*************/
		ezc.ezparam.EzcParams historyMainParams = new ezc.ezparam.EzcParams(false);
		historyMainParams.setLocalStore("Y");
		ezc.ezpreprocurement.params.EziWFAuditTrailParams eziWFHistoryParams= new ezc.ezpreprocurement.params.EziWFAuditTrailParams();
		eziWFHistoryParams.setEwhDocId(collNo);
		historyMainParams.setObject(eziWFHistoryParams);
		Session.prepareParams(historyMainParams);
		ezc.ezparam.ReturnObjFromRetrieve wfMyRet = (ezc.ezparam.ReturnObjFromRetrieve)Manager.ezGetWFAuditTrailNo(historyMainParams);
		String historyNo = "";
		if(wfMyRet != null)
		{
			historyNo = wfMyRet.getFieldValueString(0,"AUDIT_NO");
			if(historyNo == "null")
				historyNo = "1";
		}
		else
			historyNo = "1";
		eziWFHistoryParams.setEwhAuditTrailNo(historyNo);
		eziWFHistoryParams.setEwhDocId(collNo);
		eziWFHistoryParams.setEwhType("QCF_CLOSED");
		eziWFHistoryParams.setEwhSourceParticipant((String)Session.getUserId());
		eziWFHistoryParams.setEwhSourceParticipantType("");
		eziWFHistoryParams.setEwhDestParticipant("");
		eziWFHistoryParams.setEwhDestParticipantType("");
		eziWFHistoryParams.setEwhComments(reasons);
		historyMainParams.setObject(eziWFHistoryParams);
		Session.prepareParams(historyMainParams);
		Manager.ezAddWFAuditTrail(historyMainParams);
%>