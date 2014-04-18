
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp" %>
<%
	// This call is to store attachments information in UPLOAD DOC TABLES
	java.util.StringTokenizer fileToken	= null;
	
	ezc.ezupload.params.EziUploadDocFilesTableRow rowParams = null;
	ezc.ezupload.params.EziUploadDocFilesTable tabParams = null;
	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(true);
	ezc.ezupload.client.EzUploadManager uploadManager= new ezc.ezupload.client.EzUploadManager();
	ezc.ezupload.params.EziUploadDocsParams uDocsParams = new ezc.ezupload.params.EziUploadDocsParams();
	

	uDocsParams.setUploadDirectory(inboxPath+session.getId());	
	uDocsParams.setSysKey((String)session.getValue("SalesAreaCode"));
	uDocsParams.setCreatedBy(Session.getUserId());
	uDocsParams.setObjectType(documentType);
	uDocsParams.setObjectNo(objNo);
	
	myParams.setObject(uDocsParams);
	myParams.setLocalStore("Y");
	
	fileToken = new StringTokenizer(attachString,"$$");
	tabParams = new ezc.ezupload.params.EziUploadDocFilesTable();
	
	while(fileToken.hasMoreElements())
	{
		String finalfile = (String)fileToken.nextToken();
		rowParams	 = new ezc.ezupload.params.EziUploadDocFilesTableRow();
		rowParams.setType(documentType+"DOC");
		rowParams.setClientFileName(finalfile);
		tabParams.appendRow(rowParams);
	}
	myParams.setObject(tabParams);
	Session.prepareParams(myParams);
	try
	{
		System.out.println("before uploadDoc:");					
		uploadManager.uploadDoc(myParams);
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured while Uploading docs:"+e);
	}

// Ends Here
%>