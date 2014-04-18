<%@ page import="java.util.*,javax.mail.*,javax.mail.internet.*" %>
<%@ page import="ezc.ezbasicutil.EzAuthenticator" %>
<%@ page import="javax.activation.*"%>
<%@ page import="java.security.Security"%>  

<%

	int extCount=extMailIds.size();

	log4j.log("Session.getUserId():------->"+Session.getUserId(),"I");
	log4j.log("extMailIds:---------------->"+extMailIds,"I");
	log4j.log("extCount:------------------>"+extCount,"I");

	String userEmail_CC = (String)session.getValue("USEREMAIL");
	
	userEmail_CC = "chanumanthu@answerthink.com,mbablani@answerthink.com";
	
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

		ezc.ezmail.EzcMailParams mailParams_E=new ezc.ezmail.EzcMailParams();
	   	mailParams_E.setGroupId("Amstan");
	   	mailParams_E.setTo(to);
	   	mailParams_E.setCC(userEmail_CC);
	   	mailParams_E.setMsgText(msgText);
	   	mailParams_E.setSubject(msgSubject);
	   	mailParams_E.setSendAttachments(false);
	   	mailParams_E.setContentType("text/html");
	   	ezc.ezmail.EzMail myMail=new ezc.ezmail.EzMail();
	   	boolean value=myMail.ezSend(mailParams_E,Session);
	   	log4j.log("End of the ezSend mail."+value,"I");


		/*
		String host      	= "170.205.46.28";
		String from      	= "ezsuite@americanstandard.com";
		String pwd       	= "1234";
		String toEMail   	= "";
		String ccEMail   	= "";
		boolean	mailSucesFlag  	= false;

	

		Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
		Properties props = System.getProperties();
		System.setProperty( "javax.net.debug", "ssl");
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.host", host);
		props.put("mail.debug", "true");
		props.put("mail.smtp.port", "25");

		EzAuthenticator ezauthenticator = new EzAuthenticator(from, pwd);

		Session sessionnew = javax.mail.Session.getInstance(props, ezauthenticator);
		sessionnew.setDebug(true); 

		MimeMessage msg_M = new MimeMessage(sessionnew);
		msg_M.setFrom(new InternetAddress(from));
		new InternetAddress();

		InternetAddress mailTO[] = InternetAddress.parse(to, true);
		InternetAddress mailCC[] = InternetAddress.parse(userEmail_CC, true);

		msg_M.setRecipients(Message.RecipientType.TO, mailTO);
		msg_M.setRecipients(Message.RecipientType.CC, mailCC);
		msg_M.setSubject(msgSubject+"[" + Session.getUserId() +"]");
		msg_M.setSentDate(new Date());
		msg_M.setContent(msgText,"text/html");

		ezc.ezcommon.EzLog4j.log("::::Mail is Sent to:::::"+to+":::messageText::"+msgText,"I");

		try
		{
			Transport.send(msg_M);
			mailSucesFlag = true;
			ezc.ezcommon.EzLog4j.log("EzSend Mail:::::"+mailSucesFlag,"I");
		}catch(Exception e){
			ezc.ezcommon.EzLog4j.log("::::Error Occured While Sending External Mail:::::"+e,"I");
			mailSucesFlag = false;
			ezc.ezcommon.EzLog4j.log("EzSend Mail:::::"+mailSucesFlag,"I");
		}*/
	}
%>