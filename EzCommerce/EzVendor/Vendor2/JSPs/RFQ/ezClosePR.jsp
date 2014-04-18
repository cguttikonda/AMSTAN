<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	ezc.ezparam.ReturnObjFromRetrieve myRet = null;
	ezc.ezpreprocurement.client.EzPreProcurementManager ezpreprocurementmanager=new ezc.ezpreprocurement.client.EzPreProcurementManager();
		
	ezc.ezpreprocurement.params.EziPRTable  	prTable		= new ezc.ezpreprocurement.params.EziPRTable();
	ezc.ezpreprocurement.params.EziPRTableRow 	prTableRow	= null;
	
	String str[] 	= request.getParameterValues("purchReq");
	String reasons  = request.getParameter("reasons");

	int count 	= 0;
	count 	     = str.length;
	
	String[] reqNo 	= new String[count];
	String[] item 	= new String[count];

	for(int i=0;i<count;i++)
	{
		ezc.ezbasicutil.EzStringTokenizer EzToken = new ezc.ezbasicutil.EzStringTokenizer(str[i],"$$");
		java.util.Vector Tokens = EzToken.getTokens();		
		int size = Tokens.size();	
		String[] retStr = new String[size];
		
		for(int j=0;j<size;j++)
		{
			retStr[j] = (String)Tokens.elementAt(j);
			if(j==6)
				reqNo[i]=retStr[j];
			if(j==7)
				item[i]=retStr[j];	
		}
	}
	
	for(int i=0;i<count;i++)
	{
		prTableRow     =  new ezc.ezpreprocurement.params.EziPRTableRow();
		prTableRow.setReqNo(reqNo[i]);
		prTableRow.setItemNo(item[i]);
		prTableRow.setStatus("X");
		prTable.appendRow(prTableRow);
	}

	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(true);
	mainParams.setObject(prTable);
	Session.prepareParams(mainParams);

	try
	{
		myRet=(ezc.ezparam.ReturnObjFromRetrieve)ezpreprocurementmanager.ezClosePR(mainParams);
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured in ezClosePR.jsp"+e.getMessage());
	}
	int myRetCount = 0;
	String retMessage ="";
	if(myRet!=null)
	{
		myRetCount = myRet.getRowCount();
	}
	
	if(myRetCount>0 && "I".equals(myRet.getFieldValueString(0,"TYPE")))
	{
		for(int i=0;i<count;i++)
		{
			reasons	= item[i]+"$"+reasons;	//itemNo+$+reason 	
		
			ezc.ezparam.EzcParams historyMainParams = new ezc.ezparam.EzcParams(false);
			historyMainParams.setLocalStore("Y");
			ezc.ezpreprocurement.params.EziWFAuditTrailParams eziWFHistoryParams= new ezc.ezpreprocurement.params.EziWFAuditTrailParams();
			eziWFHistoryParams.setEwhAuditTrailNo(reqNo[i]);
			eziWFHistoryParams.setEwhDocId(reqNo[i]);
			eziWFHistoryParams.setEwhType("PR_CLOSED");
			eziWFHistoryParams.setEwhSourceParticipant((String)Session.getUserId());
			eziWFHistoryParams.setEwhSourceParticipantType("");
			eziWFHistoryParams.setEwhDestParticipant("");
			eziWFHistoryParams.setEwhDestParticipantType("");
			eziWFHistoryParams.setEwhComments(reasons);
			historyMainParams.setObject(eziWFHistoryParams);
			Session.prepareParams(historyMainParams);
			ezpreprocurementmanager.ezAddWFAuditTrail(historyMainParams);
		}
		retMessage = "PR(s) Closed Successfully";
	}
	else
	{
		retMessage = "Error in Closing PR";		
	}
	response.sendRedirect("ezListPR.jsp?Status=R");	
%>

