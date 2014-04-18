<%@ include file="../../Lib/MailGroupBean.jsp" %>


<%
	String groupId=request.getParameter("chk1");

        groupId=groupId.trim();
	EzcParams eParams = new EzcParams(false);
	
	EziMailGroupStructure struct = new EziMailGroupStructure();
	struct.setMailGroupId(groupId);
	
	eParams.setObject(struct);
	Session.prepareParams(eParams);
	ReturnObjFromRetrieve mailGroupObj = (ReturnObjFromRetrieve)Mail.ezGetMailGroupDetails(eParams);
	
	String inPort = mailGroupObj.getFieldValueString(0,"INPORT");
	 if(inPort==null || "null".equals(inPort))
	 inPort="";
	 String outPort = mailGroupObj.getFieldValueString(0,"OUTPORT");
	 if(outPort==null || "null".equals(outPort))
	  outPort="";
	  String destName = mailGroupObj.getFieldValueString(0,"TOPICNAME");
	   if(destName==null || "null".equals(destName))
	    destName="";
	    String destFact = mailGroupObj.getFieldValueString(0,"DESTFACT");
	   
	    if(destFact==null || "null".equals(destFact))
	    destFact="";
	    
	    String providerURL = mailGroupObj.getFieldValueString(0,"PROVIDERURL");
	    
	    if(providerURL==null || "null".equals(providerURL))
	    providerURL="";
	    
	    String ctxFact = mailGroupObj.getFieldValueString(0,"CTXFACT");
	    
            if(ctxFact==null || "null".equals(ctxFact))
	    ctxFact="";
		
		String passWord=mailGroupObj.getFieldValueString(0,"PASSWORD");
		if(passWord==null || "null".equals(passWord))
		passWord="";
	
		String userName=mailGroupObj.getFieldValueString(0,"USERID");
		if(userName==null || "null".equals(userName))
		userName="";
	
	        	
%>	
