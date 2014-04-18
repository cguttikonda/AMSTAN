<%


	String qcfNum = request.getParameter("qcfNumber");
	
	//String qcfNum = "1100005";
	ezc.ezparam.ReturnObjFromRetrieve retUploadDocs = null;
	ezc.ezupload.client.EzUploadManager uploadManager = new ezc.ezupload.client.EzUploadManager();
	ezc.ezparam.EzcParams myParams	= new ezc.ezparam.EzcParams(true);
	ezc.ezupload.params.EziUploadDocsParams uDocsParams = new ezc.ezupload.params.EziUploadDocsParams();
	uDocsParams.setObjectNo("'"+(String) session.getValue("SYSKEY")+"QCF"+qcfNum+"'");
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
	
	if(noOfDocs>0)
	{
		for(int i=0;i<noOfDocs;i++)
		{
			fileListRet=(ezc.ezparam.ReturnObjFromRetrieve)retUploadDocs.getFieldValue(i,"FILES");
			for(int j=0;j<fileListRet.getRowCount();j++)
			{
				fstring = fstring+fileListRet.getFieldValueString(j,"CLIENTFILENAME")+"§";
				sfstr = sfstr+fileListRet.getFieldValueString(j,"SERVERFILENAME")+"µ";
			}
		}	
	}	
	
	java.util.Vector clientFiles	= new java.util.Vector();
	java.util.Vector serverFiles	= new java.util.Vector();

	java.util.StringTokenizer clientStk	= null;
	java.util.StringTokenizer serverStk	= null;
	
	if(fstring!= null)
		clientStk	= new java.util.StringTokenizer(fstring,"§");
	if(sfstr!= null)	
		serverStk	= new java.util.StringTokenizer(sfstr,"µ");

	while(clientStk.hasMoreElements())
	{
		clientFiles.addElement(clientStk.nextToken());
		serverFiles.addElement(serverStk.nextToken());
	}	
	
%>