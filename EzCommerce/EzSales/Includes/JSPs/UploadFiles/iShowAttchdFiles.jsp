<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	uploadFilePathDir = "j2ee/"+uploadFilePathDir;
	
	String docNum = request.getParameter("docNum");
	String docType = request.getParameter("docType");
	ezc.ezparam.ReturnObjFromRetrieve retUploadDocs = null;
	ezc.ezupload.client.EzUploadManager uploadManager = new ezc.ezupload.client.EzUploadManager();
	ezc.ezparam.EzcParams myParams	= new ezc.ezparam.EzcParams(true);
	ezc.ezupload.params.EziUploadDocsParams uDocsParams = new ezc.ezupload.params.EziUploadDocsParams();
	uDocsParams.setObjectNo("'"+(String) session.getValue("SalesAreaCode")+docType+docNum+"'");
	myParams.setObject(uDocsParams);
	Session.prepareParams(myParams);
	try
	{
		retUploadDocs = (ezc.ezparam.ReturnObjFromRetrieve)uploadManager.getUploadedDocs(myParams);
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured while getting Upload docs:"+e);	
	}
	int noOfDocs = 0;
	if(retUploadDocs!= null)
	{
		noOfDocs = retUploadDocs.getRowCount();
		
	
	}
	ezc.ezparam.ReturnObjFromRetrieve fileListRet = null;
	String fstring = "";
	String sfstr = "";
	String usrName = "";
	String uploadedBy = "";
	String uploadedNo = "";
	String uploadNOs = "";

	if(noOfDocs>0)
	{
		for(int i=0;i<noOfDocs;i++)
		{
			fileListRet=(ezc.ezparam.ReturnObjFromRetrieve)retUploadDocs.getFieldValue(i,"FILES");
			
			uploadedBy = retUploadDocs.getFieldValueString(i,"CREATEDBY");
			uploadedNo = retUploadDocs.getFieldValueString(i,"UPLOADNO");
			
		
			for(int j=0;j<fileListRet.getRowCount();j++)
			{
				fstring = fstring+fileListRet.getFieldValueString(j,"CLIENTFILENAME")+"§";
				sfstr = sfstr+fileListRet.getFieldValueString(j,"SERVERFILENAME")+"µ";
				usrName = usrName+uploadedBy.trim()+"$$";
				uploadNOs = uploadNOs+uploadedNo.trim()+"##";
			}
		}	
	}	
	
	java.util.Vector clientFiles	= new java.util.Vector();
	java.util.Vector serverFiles	= new java.util.Vector();
	java.util.Vector userNames	= new java.util.Vector();
	java.util.Vector upldNumbers	= new java.util.Vector();

	
  
	java.util.StringTokenizer clientStk	= null;
	java.util.StringTokenizer serverStk	= null;
	java.util.StringTokenizer usersStk	= null;
	java.util.StringTokenizer upldNumbersStk	= null;


	if(fstring!= null)
		clientStk	= new java.util.StringTokenizer(fstring,"§");
	if(sfstr!= null)	
		serverStk	= new java.util.StringTokenizer(sfstr,"µ");
	if(usrName!= null)	
		usersStk	= new java.util.StringTokenizer(usrName,"$$");
	if(uploadNOs!= null)	
		upldNumbersStk	= new java.util.StringTokenizer(uploadNOs,"##");	
	
		

	while(clientStk.hasMoreElements())
	{
		clientFiles.addElement(clientStk.nextToken());
		serverFiles.addElement(serverStk.nextToken());
		userNames.addElement((usersStk.nextToken()).trim());
		upldNumbers.addElement(upldNumbersStk.nextToken());
	}
	int fileCount = clientFiles.size();
%>