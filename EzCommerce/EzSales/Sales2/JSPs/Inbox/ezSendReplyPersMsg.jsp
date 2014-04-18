<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import ="java.util.*" %>

<%
	String file=request.getParameter("attachflag");
	String attstring=request.getParameter("attachString");
	
        String names="";
        String language = "EN";
	String client = "200";
	
	java.util.ArrayList arrlist=new java.util.ArrayList();
        

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

	//Fill in the message details structure
	String sendToUser = request.getParameter("toUser");
	java.util.StringTokenizer strFullUser = new java.util.StringTokenizer(sendToUser,",");
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

		EzcMessageParams  ezcMessageParams = new EzcMessageParams();
		EzMessageParams ezMessageParams = new EzMessageParams();
		ezMessageParams.setEzPersonalMsgStructure(msgDetails);
		ezMessageParams.setEzMsgStructure(msgStruc);
		ezcMessageParams.setObject(ezMessageParams);   
		Session.prepareParams(ezcMessageParams); 

		Manager.createPersonalMsg(ezcMessageParams);
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
		}
		catch(Exception e)
		{
			System.out.println("the exception is :"+e.getMessage());
		}
	}
	
	response.sendRedirect("../Inbox/ezListPersMsgs.jsp?type=allmess");
%>
