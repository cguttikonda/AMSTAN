<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import ="java.util.*" %>

<%
	String file=request.getParameter("attachflag");
	String attstring=request.getParameter("attachString");
	String msgType = request.getParameter("msgType");
	ezc.ezcommon.EzLog4j.log("msgType:::::::::::msgType:::::::"+msgType,"D");
	String msgFlag="";
	if("allmess".equals(msgType))msgFlag="0";
	if("newmess".equals(msgType))msgFlag="1";
	
        String names="";
        String language = "EN";
	String client = "202";
	
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
	ezc.ezcommon.EzLog4j.log("msgSubject:::::::::::::::::::::"+msgSubject,"D");
	ezc.ezcommon.EzLog4j.log("msgText:::::::::::::::::::"+msgText,"D");
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
	ezc.ezcommon.EzLog4j.log("sendToUser:::::::::::::::::::::"+sendToUser,"D");
	java.util.StringTokenizer strFullUser = new java.util.StringTokenizer(sendToUser,",");
	int numUsers = strFullUser.countTokens();

	String externalMails="cguttikonda@answerthink.com";

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

		Manager1.createPersonalMsg(ezcMessageParams);
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
			mailParams.setGroupId("Amstan");
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
			ezc.ezcommon.EzLog4j.log("getTo:::::::::::getTo:::::::"+mailParams.getTo(),"D");
			ezc.ezcommon.EzLog4j.log("ezSend:::::::::::MAIL:::::::"+value,"D");
			ezc.ezcommon.EzLog4j.log("msgText:::::::::::msgText:::::::"+msgText,"D");
			ezc.ezcommon.EzLog4j.log("msgSubject:::::::::::msgSubject:::::::"+msgSubject,"D");
		}
		catch(Exception e)
		{
			System.out.println("the exception is :"+e.getMessage());
		}
	}
	
	response.sendRedirect("../Inbox/ezListPersMsgsMain.jsp?type="+msgType+"&msgFlag="+msgFlag);
%>
