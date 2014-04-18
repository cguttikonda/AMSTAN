<%
	
	int extCount=extMailIds.size();
	String to="";
	if(extCount!=0)
	{
		to= (String) (extMailIds.elementAt(0));



		for(int j=1;j<extMailIds.size();j++)
		{
			 to =  to  + "," +  (String) (extMailIds.elementAt(j));
		}
		
		
//Commented and mail group method added by nagesh		

/*		String from = "scmadmin@drreddys.com";
		// String cc = "asrinfo@onebox.com";
		// String bcc ="asrinfo@onebox.com";
		String host1 = "152.63.1.233";
		
		boolean debug = true;
		System.out.println(to);
		System.out.println(from);
		System.out.println(msgSubject);
		System.out.println(msgText);
	
		Properties props = new Properties();
		props.put("mail.smtp.host", host1);
		System.out.println(props);
		
		if (debug)
			 props.put("mail.debug", "true");
		javax.mail.Session session1 = javax.mail.Session.getDefaultInstance(props, null);
		session1.setDebug(debug);
		try 
		{
		    Message msg = new MimeMessage(session1);
		    msg.setFrom(new InternetAddress(from));
		    InternetAddress[] address = new InternetAddress().parse(to);
		   // InternetAddress[] address1 = new InternetAddress().parse(cc);
		   // InternetAddress[] address2 = new InternetAddress().parse(bcc);
		    msg.setRecipients(Message.RecipientType.TO, address);
	    	    // msg.addRecipients(Message.RecipientType.CC, address1);
 	    	    // msg.addRecipients(Message.RecipientType.BCC, address2);
	    	    msg.setSubject(msgSubject+"[" + Session.getUserId() +"]");
	    	    msg.setSentDate(new Date());
	                 //msg.setContentType("text/html");

	    	    msg.setText("Note: Dont change the subject of the mail\n\n" + msgText );
	          Transport.send(msg);
		    System.out.println("<b>Your mail has been sent sucessfully</b>");
	     }
	     catch (MessagingException mex) 
	    {
	        System.out.println(mex);
	    	  Exception ex = mex;
	       do 
		{
		if (ex instanceof SendFailedException) 
		   {
		    SendFailedException sfex = (SendFailedException)ex;
		    Address[] invalid = sfex.getInvalidAddresses();
		    if (invalid != null) 
			{
			System.out.println("    ** Invalid Addresses");
			if (invalid != null) {
			    for (int i = 0; i < invalid.length; i++) 
				System.out.println("         " + invalid[i]);
			}
		      }
		    Address[] validUnsent = sfex.getValidUnsentAddresses();
		    if (validUnsent != null) 
			{
			System.out.println("    ** ValidUnsent Addresses");
			if (validUnsent != null) 
			   {
			    for (int i = 0; i < validUnsent.length; i++) 
				System.out.println("         "+validUnsent[i]);
			   }
		          }
		    Address[] validSent = sfex.getValidSentAddresses();
		    if (validSent != null) 
			{
			System.out.println("    ** ValidSent Addresses");
			if (validSent != null) 
			    {
			    for (int i = 0; i < validSent.length; i++) 
				System.out.println("         "+validSent[i]);
			    }
		          }
		  }
		
		if (ex instanceof MessagingException)
		    ex = ((MessagingException)ex).getNextException();
		else
		    ex = null;
	    } 	
	     while (ex != null);
	}

		
*/


//Added by nagesh
		   ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();	
	   	   mailParams.setGroupId("Ezc");
	   	   mailParams.setTo(to);
	   	  // mailParams.setCC("");
	   	  // mailParams.setBCC("");
	   	   mailParams.setMsgText("Note: Dont change the subject of the mail\n\n" + msgText);
	   	   mailParams.setSubject(msgSubject+"[" + Session.getUserId() +"]");
	   	   mailParams.setSendAttachments(false);
	   	  // mailParams.setContentType("text/html");
	   	   ezc.ezmail.EzMail myMail=new ezc.ezmail.EzMail();
	   	   boolean value=myMail.ezSend(mailParams,Session);
}	   
%>
<Div id="MenuSol"></Div>		







