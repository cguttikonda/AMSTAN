<%
	int extCount=extMailIds.size();

	log4j.log("Session.getUserId():------->"+Session.getUserId(),"I");
	log4j.log("extMailIds:---------------->"+extMailIds,"I");
	log4j.log("extCount:------------------>"+extCount,"I");

	String userEmail_CC = (String)session.getValue("USEREMAIL");
	
	if(userEmail_CC==null || "null".equals(userEmail_CC)) userEmail_CC = "";
	
	log4j.log("userEmail_CC------------------>"+userEmail_CC,"I");

	
	String to="";
	if(extCount!=0)
	{
		to = (String) (extMailIds.elementAt(0));

		for(int j=1;j<extMailIds.size();j++)
		{
			to =  to  + "," + (String)(extMailIds.elementAt(j));
		}
		
		log4j.log("Message is supposed to send:"+to+":--->"+msgText,"I");
		log4j.log("Message is sent to:"+to+":--->"+msgText,"I");
		
		ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();	
	   	mailParams.setGroupId("Ezc");
	   	mailParams.setTo(to);
	   	mailParams.setCC(userEmail_CC);
	   	//mailParams.setCC("chanumanthu@answerthink.com,skada@answerthink.com");
	   	///mailParams.setMsgText("Note: Please do not change the subject of the mail<Br><Br>" + msgText);
	   	mailParams.setMsgText(" " + msgText);
	   	mailParams.setSubject(msgSubject+"[" + Session.getUserId() +"]");
	   	mailParams.setSendAttachments(false);
	   	mailParams.setContentType("text/html");
	   	ezc.ezmail.EzMail myMail=new ezc.ezmail.EzMail();
	   	boolean value=myMail.ezSend(mailParams,Session);
	   	log4j.log("End of the ezSend mail."+value,"I");
	}	
%>
