<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp"%>
<%@ page import="java.io.*"%>

<%@ page import ="java.util.*" %>
<html>
<head>
<Title>Inbox: Send Message</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<%
	java.util.ArrayList arrlist=new java.util.ArrayList();
        String names="";
        String file=request.getParameter("attachflag");
	String attstring=request.getParameter("attachString");
	String needBack=request.getParameter("needBack");
        boolean isSendAttachments=false;
	StringTokenizer st=null;
	Vector finalfiles=new Vector();
        if(file!=null && !"null".equals(file) && !"".equals(file))
        {
        	   isSendAttachments=true;
		   st=new StringTokenizer(attstring,",");
		   while(st.hasMoreElements())
		   {
		   	finalfiles.addElement(st.nextToken());
		   }
	}
        EzMsgStructure msgStruc = null;
	EzPersonalMsgStructure[] msgDetails = null;
	String language = "EN";
	String client = "200"; // TBD : We need to verify this

	// Get Parameters from the Compose Page

	String msgSubject = request.getParameter("msgSubject");
	String msgText = request.getParameter("msgText");

	//Fill in the message structure

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
	String sendToUser = request.getParameter("apptoUser");

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
                System.out.println("inside jsp page7");
	}

	if(!"".equals(externalMails))
		externalMails=externalMails.substring(0,externalMails.length()-1);

	String ccUser=request.getParameter("ccUser");
	String bccUser=request.getParameter("bccUser");
	if("".equals(externalMails))
	{
		externalMails=ccUser;
		ccUser=null;
		if("".equals(externalMails))
		{
			externalMails=bccUser;
			bccUser=null;
		}
	}
	

	if(!"".equals(externalMails))
	{	
        	System.out.println("the external mail ids are :"+externalMails);
	        try
                {
	   	   ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();
	   	   mailParams.setGroupId("Ezc");
	   	   mailParams.setTo(externalMails);
		   if(ccUser!=null)
	   	   mailParams.setCC(ccUser);
		   if(bccUser!=null)
	   	   mailParams.setBCC(bccUser);
	   	   mailParams.setMsgText(request.getParameter("msgText"));
	   	   mailParams.setSubject(request.getParameter("msgSubject"));
	   	   mailParams.setSendAttachments(isSendAttachments);
		   if(isSendAttachments)
		   {
			for(int i=0;i<finalfiles.size();i++)
			{
				arrlist.add(inboxPath+session.getId()+"\\"+finalfiles.elementAt(i));
			}

		   mailParams.setAttachments(arrlist);
		   }
		   mailParams.setIsDelete(true);
		   mailParams.setAttachDirectory(inboxPath+session.getId());
	   	   ezc.ezmail.EzMail myMail=new ezc.ezmail.EzMail();
	   	   boolean value=myMail.ezSend(mailParams,Session);
	      	   System.out.println("at the end of externalmails");

           	}
           	catch(Exception e)
           	{
      	   	   System.out.println("the exception is :"+e.getMessage());
           	}
     }
     if(needBack==null)
     	response.sendRedirect("ezListPersMsgs.jsp?type=allmess");
     else
     {
    	 session.putValue("EzMsg","Mail has been sent to these user(s) :<font red>"+sendToUser+"</font>");

%>
		<script>
				document.location.href="../Misc/ezMenuFrameset.jsp"
		</script>
<%
	}
%>

<Div id="MenuSol"></Div>
</body>
</html>
