
<%
// This call is to store attachments information in UPLOAD DOC TABLES

	java.util.StringTokenizer fileToken	= null;
	ezc.ezupload.params.EziUploadDocFilesTableRow rowParams = null;
	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(true);
	ezc.ezupload.client.EzUploadManager uploadManager= new ezc.ezupload.client.EzUploadManager();
	ezc.ezupload.params.EziUploadDocsParams uDocsParams = new ezc.ezupload.params.EziUploadDocsParams();
	ezc.ezupload.params.EziUploadDocFilesTable tabParams = null;

	uDocsParams.setUploadDirectory(inboxPath+session.getId());	// we get this path from iGetUploadTempDir.jsp
	uDocsParams.setObjectType("QCF");		// To Store QCF Related files
	uDocsParams.setObjectNo(objNo);
	uDocsParams.setSysKey((String)session.getValue("SYSKEY"));
	uDocsParams.setCreatedBy(Session.getUserId());
	myParams.setObject(uDocsParams);
	myParams.setLocalStore("Y");
	fileToken = new StringTokenizer(attachString,",");
	tabParams = new ezc.ezupload.params.EziUploadDocFilesTable();
	while(fileToken.hasMoreElements())
	{
		String finalfile = (String)fileToken.nextToken();
		rowParams	 = new ezc.ezupload.params.EziUploadDocFilesTableRow();
		rowParams.setType("QCFDOC");
		rowParams.setClientFileName(finalfile);
		tabParams.appendRow(rowParams);
	}
	myParams.setObject(tabParams);
	Session.prepareParams(myParams);
	try
	{		
		uploadManager.uploadDoc(myParams);
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured while Uploading docs:"+e);
	}

// Ends Here
%>