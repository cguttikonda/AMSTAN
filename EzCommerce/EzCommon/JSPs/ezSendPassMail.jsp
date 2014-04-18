<%@ page import="java.util.*,javax.mail.*,javax.mail.internet.*" %>
<%@ page import="ezc.ezbasicutil.EzAuthenticator" %>
<%@ page import="javax.activation.*"%>
<%@ page import="java.security.Security"%>  

<%

	/*String host      	= "170.205.46.28";
        String from      	= "myASbp@AmericanStandard.com";
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
	
	MimeMessage msg = new MimeMessage(sessionnew);
	msg.setFrom(new InternetAddress(from));
	new InternetAddress();
	
	InternetAddress mailTO[] = InternetAddress.parse(userMail, true);
	
	msg.setRecipients(Message.RecipientType.TO, mailTO);
	//msg.setRecipients(Message.RecipientType.CC, mailCC);
	msg.setSubject(messageSub);
	msg.setSentDate(new Date());                 
	msg.setContent(messageText,"text/html");
	try
	{
		Transport.send(msg);
		mailSucesFlag = true;
		ezc.ezcommon.EzLog4j.log("EzSend Mail:::::"+mailSucesFlag,"I");
	}catch(Exception e){
		ezc.ezcommon.EzLog4j.log("::::Error Occured While Sending External Mail:::::"+e,"I");
		mailSucesFlag = false;
		ezc.ezcommon.EzLog4j.log("EzSend Mail:::::"+mailSucesFlag,"I");
	}*/	
	if("Y".equals(regMail))
		messageText = messageText + "<Br><Br>Regards,<Br>"+firstName+" "+lastName+".</Body></Html>";	
	
	ezc.ezcommon.EzLog4j.log("Message is supposed to send:"+userMail+":--->"+messageText,"I");
	ezc.ezcommon.EzLog4j.log("Message is sent to:"+userMail+":--->"+messageText,"I");

	ezc.ezmail.EzcMailParams mailParams_E=new ezc.ezmail.EzcMailParams();
	mailParams_E.setGroupId("Amstan");
	mailParams_E.setTo(userMail);
	//mailParams_E.setCC(userEmail_CC);
	mailParams_E.setMsgText(messageText);
	mailParams_E.setSubject(messageSub);
	mailParams_E.setSendAttachments(false);
	mailParams_E.setContentType("text/html");
	ezc.ezmail.EzMail myMail=new ezc.ezmail.EzMail();
	boolean value=myMail.ezSend(mailParams_E,Session);
	
	ezc.ezcommon.EzLog4j.log("End of the ezSend mail."+value,"I");	
	ezc.ezcommon.EzLog4j.log("::::Mail is Sent to:::::"+userMail+":::messageText::"+messageText,"I");

%>
