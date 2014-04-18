<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>
<%@ page import="ezc.discussion.groups.EZC_TRAX_MESSAGES" %> 
<%@ page import="ezc.discussion.groups.EZC_MSG_LINKS" %> 
<jsp:useBean id="FileNames"  class="ezc.discussion.groups.EzFileNamesStore" scope="session">
</jsp:useBean>

<html>
<head>
<Title>Untitled Document</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>

<body bgcolor="#FFFFFF">
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center"><b><span class="bannerbody"><span class="bannercell"><font size="4">Transaction 
  Mail Sent ..............<tt> </tt></font></span></span></b></p>
<tt><%
EZC_TRAX_MESSAGES TransMsg = new EZC_TRAX_MESSAGES();
EZC_MSG_LINKS MsgLink = new EZC_MSG_LINKS();
String UserId = request.getParameter("toUser");
String MsgHeader = request.getParameter("msgSubject");
String MsgTransId = request.getParameter("MsgTransCode");
String MsgContent = request.getParameter("msgText");
//ReturnObjFromRetrieve retToBeProcessedMsgList = null;
	TransMsg.setETM_CLIENT(200);
	TransMsg.setETM_TRAN_ID(MsgTransId);
	TransMsg.setETM_MSG_ID("");
	TransMsg.setETM_MSG_TYPE("PO");
	TransMsg.setETM_USER_ID("UserId");
	TransMsg.setETM_FOLDER_ID(0);
	TransMsg.setETM_PRIORITY_FLAG("");
	TransMsg.setETM_PROCESS_TIME("");
	TransMsg.setETM_IS_PROCESSED("N");
	TransMsg.setETM_MSG_STATUS("");
	TransMsg.setETM_MSG_HEADER(MsgHeader);
	TransMsg.setETM_MSG_CONTENT1(MsgContent);
	TransMsg.setETM_LNK_EXT_INFO("");
	TransMsg.setETM_CREATION_DATE("");
	TransMsg.setETM_CREATION_TIME("");
	TransMsg.setETM_CREATED_BY("");
	TransMsg.setETM_PROCESSED_DATE("");
	TransMsg.setETM_PROCESSED_TIME("");
	TransMsg.setETM_SYS_NO(0);
        TransMsg.setETM_CAT_AREA("");

        String[] filenames=FileNames.getUploadedFileName();
 
        MsgLink.setEML_CLIENT_ID(200);
	MsgLink.setEML_MSG_ID("");
	MsgLink.setEML_EXT_LNK(filenames);

          IBObject.addProcessedMsg(AdminObject, servlet,TransMsg,MsgLink);
          FileNames.removeallattachments();

%> </tt>
</body>
</html>
