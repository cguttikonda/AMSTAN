<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import ="java.util.*" %>
<html>
<head>
<Title>Inbox: Send Message</Title>
</head>
<body>
<%
	String msgFlag = request.getParameter("msgFlag");
       	ResourceBundle rb=ResourceBundle.getBundle("Site");
	String path=rb.getString("INBOXPATH");
        String names="";
        String file=request.getParameter("attachs");
        boolean isSendAttachments=false;
        if(file!=null && !"null".equals(file) && !"".equals(file))
        {
        	isSendAttachments=true;
	}     
    
        EzMsgStructure msgStruc = null;
	EzPersonalMsgStructure[] msgDetails = null;
	String language = "EN";
	String client = "200";	
	String msgSubject = request.getParameter("msgSubject");
	String msgText = request.getParameter("msgText");
	
	msgStruc = new EzMsgStructure();
	msgStruc.setClient(client);
	msgStruc.setPriorityFlag("U");
	msgStruc.setMsgHeader(msgSubject);
	msgStruc.setMsgContent1(msgText);
	msgStruc.setMsgContent2("");
	msgStruc.setLnkExtInfo("Lnk");
	
	EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();
	ezMessageParams.setEzMsgStructure(msgStruc);
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams); 
	String sendToUser = request.getParameter("toUser");
	String ccUsersList = request.getParameter("ccUser");

	if(!(ccUsersList == null || "".equals(ccUsersList) || "null".equals(ccUsersList)))
		sendToUser = sendToUser +","+ccUsersList;
	java.util.StringTokenizer strFullUser = new java.util.StringTokenizer(sendToUser, ",");
	int numUsers = strFullUser.countTokens();


        String externalMails="";
	for(int i=0; i<numUsers; i++)
	{
		String useri = strFullUser.nextToken();
		if(useri!=null && useri.indexOf("@")!=-1)
		{
			externalMails=externalMails+useri+",";
			continue;
		}

		msgDetails = new EzPersonalMsgStructure[1];
		msgDetails[0] = new EzPersonalMsgStructure();
		msgDetails[0].setClient(client);
		msgDetails[0].setRecUserId(useri);
		msgDetails[0].setExpiryDate("99999999");
		msgDetails[0].setExpiryDays(10);

		msgDetails[0].setReminderDate(""+0);
		msgDetails[0].setFolderId("1000");


		ezMessageParams.setEzPersonalMsgStructure(msgDetails);
		Manager.createPersonalMsg(ezcMessageParams);
	}

	if(!"".equals(externalMails))
	{
		externalMails=externalMails.substring(0,externalMails.length()-1);
	        try
                {

		   String ext1="";
		   if(externalMails.indexOf(",")>0)
		   {
		   	ext1=externalMails.substring(0,externalMails.indexOf(","));
			externalMails=externalMails.substring(externalMails.indexOf(",")+1);
		   }
		   else
		   {
		   	ext1=externalMails;
			externalMails=null;
		   }

	   	   ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();
	   	   mailParams.setGroupId("EzC");
	   	   mailParams.setTo(ext1);
		   if(externalMails != null)
		   	mailParams.setCC(externalMails);
	   	   mailParams.setBCC(request.getParameter("bccUser"));
	   	   mailParams.setMsgText(request.getParameter("msgText"));
	   	   mailParams.setSubject(request.getParameter("msgSubject"));
	   	   mailParams.setSendAttachments(isSendAttachments);
           	   mailParams.setAttachDirectory(path+session.getId());

		   mailParams.setGroupId("Ezc");

	   	   ezc.ezmail.EzMail myMail=new ezc.ezmail.EzMail();
	   	   boolean value=myMail.ezSend(mailParams,Session);
           	}
           	catch(Exception e)
           	{
      	   	   System.out.println("the exception is :"+e.getMessage());
           	}
     }
     response.sendRedirect("ezListPersMsgs.jsp?msgFlag="+msgFlag);
%>
</body>
</html>
