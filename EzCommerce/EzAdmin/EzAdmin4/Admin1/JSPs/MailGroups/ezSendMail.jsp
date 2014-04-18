<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import="java.io.File" %>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body>
<center>
<%
	boolean mailSendFlag=true;
	String errMsg="";
	String sub=request.getParameter("subject");
	//String from=request.getParameter("from");
	String to=request.getParameter("to");
	String msgTxt=request.getParameter("msgtxt");
	String bcc=request.getParameter("bcc");
	String cc=request.getParameter("cc");
	String contentType=request.getParameter("contentType");
	String groupId=request.getParameter("groupId");
	try
	{
		ezc.ezparam.EzcParams eParams=new ezc.ezparam.EzcParams(false);
		ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();
		mailParams.setSubject(sub);
		//mailParams.setFrom(from);
		mailParams.setTo(to);
		mailParams.setMsgText(msgTxt);
		mailParams.setBCC(bcc);
		mailParams.setCC(cc);
		mailParams.setGroupId(groupId);
		mailParams.setIsFailOver(true);
		mailParams.setContentType(contentType);
		
		String username = Session.getUserId();
		String fileName="C:\\MailApp\\"+username;
		File f = new File(fileName);
		if(f.exists())
    		{
    			mailParams.setAttachDirectory(fileName);
    			mailParams.setSendAttachments(true);
    			//mailParams.setAttachExclusion("");pass file names to be excluded
		}
		else
		{
			mailParams.setSendAttachments(false);
		}
		ezc.ezmail.EzMail mail=new ezc.ezmail.EzMail();
		mailSendFlag=mail.ezSend(mailParams,Session);
		
	}
	catch(Exception e)
	{
		mailSendFlag=false;
		errMsg = e.getMessage();
	}
	if(mailSendFlag)
	{
%>
		<br><br><br><br>
		<TABLE align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Th align = "center">
   				Your mail has been sent successfully.
   			</Th>
   		</Tr>
   		</Table>
   		<br>
   		<center>
   			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
  		</center>
<%
	}
	else
	{
%>
		<br><br><br><br>
		<TABLE align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Th align = "center">
   				Due to Following Exception your mail was not sent.<br><%= errMsg %>
   			</Th>
   		</Tr>
   		</Table>
   		<br>
   		<center>
   			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
  		</center>
<%
 	}
%>