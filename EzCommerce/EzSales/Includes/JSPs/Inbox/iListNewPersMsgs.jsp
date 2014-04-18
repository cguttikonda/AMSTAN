<%
	String temp="false";
	    ReturnObjFromRetrieve retExternal = new ReturnObjFromRetrieve();
	    ReturnObjFromRetrieve retExternalNew = new ReturnObjFromRetrieve();
	    ReturnObjFromRetrieve retMsgList = null;
	    ReturnObjFromRetrieve retFoldList = null;
	    String folderID="";
	    String folderName="";
	    String type="";
	    String test="false";
	    
	      try
	      {
       ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();

        //mailParams.setHost("192.168.1.3");
        //mailParams.setProtocol("imap");
        //mailParams.setPort(""+143);
        //mailParams.setUserId("ezcadmin");
        //mailParams.setPassword("ezcadmin");
        
        String server = (String)session.getValue("SERVER");
        String protocol = (String)session.getValue("PROTOCOL");
        String mailUser = (String)session.getValue("USERID");
        String mailPassword = (String)session.getValue("PASSWORD");
        
        if(server != null)
        {
        	mailParams.setHost(server);
        	mailParams.setProtocol(protocol);
        	if("IMAP".equals(protocol))
        		mailParams.setPort(""+143);
        	else
        		mailParams.setPort("110");
        	
        	mailParams.setUserId(mailUser);
        	mailParams.setPassword(mailPassword);
  	}
  	        
        
        folderName = request.getParameter("FolderName");
	if (folderName == null) 
	folderName="Inbox";
        mailParams.setFolderName(folderName);		
       
       	if(server != null)
       	{
       		if("newmess".equals(type))
		{
			ezc.ezmail.EzMail mail1=new ezc.ezmail.EzMail();
			retExternalNew=mail1.getNewMails(mailParams);
		
	      	}
	      	else  //if("allmess".equals(type))
	      	{
	      	
			ezc.ezmail.EzMail mail=new ezc.ezmail.EzMail();
			retExternal=mail.getAllMails(mailParams);
     		
	      	}	
	}
  

                test="true";
		type=request.getParameter("type");
		//out.println(type);
		if(type==null)
		{
	 	   type="allmess";
	 	}
		String language = "EN";
		folderID = request.getParameter("FolderID");
		if(folderID == null)
		{
			folderID = "1000";
		}
		 
	
		String client = "200";
		EzcMessageParams  ezcMessageParams = new EzcMessageParams();
		EzMessageParams ezMessageParams = new EzMessageParams();
		// Set the Input Parameters
		ezMessageParams.setClient(client);
		ezMessageParams.setToFolderId(folderID);
		ezMessageParams.setLanguage(language);
	
		// Set Input Parameter Object in the Container
		ezcMessageParams.setObject(ezMessageParams);
		Session.prepareParams(ezcMessageParams); // Preapare Parameters for Call
	
		String newFlag = request.getParameter("msgFlag");
		if (newFlag == null)
		{
			newFlag = "0";
		}
		if(newFlag.equals("1"))
		{
			// Get List of New Message Headers Only
			retMsgList = (ReturnObjFromRetrieve)Manager.getPersonalNewMsgHeader(ezcMessageParams);
		}
		else
		{
			retMsgList = (ReturnObjFromRetrieve)Manager.getPersonalAllMsgHeader(ezcMessageParams);
		}
		temp="false";
		retMsgList.check();
		retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParams);
                System.out.println("end of the page in try:"+retFoldList.getRowCount()+","+retMsgList.getRowCount());
	     }

	     
             
	       catch(Exception e)
	     {
	     	
	     	System.out.println("inside exception");
	          
	           
	     
		// Key Variables
		type=request.getParameter("type");
		if(type==null)
		{
	 	   type="allmess";
	 	}
		System.out.println("the type of the variable is :"+type);
		String language = "EN";
		folderID = request.getParameter("FolderID");
		if(folderID == null)
		{
			folderID = "1000";
		}
		 folderName = request.getParameter("FolderName");
		if (folderName == null) 
			folderName="Inbox";
		String client = "200";
		//EzMessagingManager mManager = new EzMessagingManager();
		EzcMessageParams  ezcMessageParams = new EzcMessageParams();
		EzMessageParams ezMessageParams = new EzMessageParams();
	
		// Set the Input Parameters
		ezMessageParams.setClient(client);
		ezMessageParams.setToFolderId(folderID);
		ezMessageParams.setLanguage(language);
	
		// Set Input Parameter Object in the Container
		ezcMessageParams.setObject(ezMessageParams);
		Session.prepareParams(ezcMessageParams); // Preapare Parameters for Call
	
		String newFlag = request.getParameter("msgFlag");
		if (newFlag == null)
		{
			newFlag = "0";
		}
		if(newFlag.equals("1"))
		{
			retMsgList = (ReturnObjFromRetrieve)Manager.getPersonalNewMsgHeader(ezcMessageParams);
		}
		else
		{
			retMsgList = (ReturnObjFromRetrieve)Manager.getPersonalAllMsgHeader(ezcMessageParams);
		}
		temp="false";
		retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParams);
               System.out.println("the end of page in catch :"+retMsgList.getRowCount());
	     }
            

      	retMsgList.sort(new String[]{"EPM_CREATION_DATE","EPM_CREATION_TIME"},false);
       
	    
%>