
	if(!("TRANSFERED").equals(status))
	{
		EzcParams mainParamsAudit = new EzcParams(false);
		EziMiscParams miscParamsAudit = new EziMiscParams();

		ReturnObjFromRetrieve retAuditNo = null;
		miscParamsAudit.setIdenKey("MISC_SELECT");
		miscParamsAudit.setQuery("SELECT MAX(CAST (EWAT_AUDIT_NO AS INT))+1 AUDIT_NO,EWAT_DOC_ID DOC_NO FROM EZC_WF_AUDIT_TRAIL WHERE EWAT_DOC_ID in('"+weborno+"') group by EWAT_DOC_ID");

		mainParamsAudit.setLocalStore("Y");
		mainParamsAudit.setObject(miscParamsAudit);
		Session.prepareParams(mainParamsAudit);

		try
		{
			retAuditNo = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsAudit);
		}
		catch(Exception e){}

		String historyNo = "";
		String statusType = "";
		String reasons = "";

		if(retAuditNo != null)
		{
			historyNo = retAuditNo.getFieldValueString(0,"AUDIT_NO");

			if(historyNo == "null") historyNo = "1";
		}
		else
			historyNo = "1";

		statusType = "QUERY";

		String userFName_A = (String)session.getValue("FIRSTNAME");
		String userLName_A = (String)session.getValue("LASTNAME");

		reasons = "Query has been raised by "+userFName_A+" "+userLName_A+"("+(String)Session.getUserId()+")";

		miscParamsAudit.setIdenKey("MISC_INSERT");
		miscParamsAudit.setQuery("INSERT INTO EZC_WF_AUDIT_TRAIL(EWAT_AUDIT_NO,EWAT_DOC_ID,EWAT_TYPE,EWAT_SOURCE_PARTICIPANT,EWAT_SOURCE_PARTICIPANT_TYPE,EWAT_DEST_PARTICIPANT,EWAT_DEST_PARTICIPANT_TYPE,EWAT_COMMENTS,EWAT_DATE) VALUES('"+historyNo+"','"+weborno+"','"+statusType+"','"+(String)Session.getUserId()+"','','','','"+reasons+"',GETDATE())");

		mainParamsAudit.setLocalStore("Y");
		mainParamsAudit.setObject(miscParamsAudit);
		Session.prepareParams(mainParamsAudit);

		try
		{
			ezMiscManager.ezAdd(mainParamsAudit);
		}
		catch(Exception e){}
	}