<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>

<html>
<head>

<script LANGUAGE="JavaScript">
function cancelMsg() {
	document.forms[0].action = "../Inbox/ezListPersMsgs.jsp";
	document.returnValue = true;
}

function getAddressWindow()
{	
	//changed by Ranjith
	var url = "../Inbox/ezSelectUsers.jsp";
	//var url = "ezSelectUsers.jsp";


	var hWnd = 	window.open(url,"UserWindow","width=300,height=300,resizable=yes,scrollbars=auto");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;
}



function getAttachmentsWindow()
{
	var url = "../Misc/ezAttachFrameSet.jsp";
	var hWnd = 	window.open(url,"UserWindow","width=500,height=300,resizable=yes,scrollbars=auto");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;
}

function showattachments() {
	document.forms[0].action = "../Misc/ezAttachFrameSet.jsp";
         document.forms[0].target="subframe"
	document.returnValue = true;
}

function sendMessage() {
	document.forms[0].action = "../Inbox/ezSaveTransMsg.jsp";
        document.forms[0].target="_parent"
         document.returnValue = true;
}
</script>


<%
// Key Variables
ReturnObjFromRetrieve retProcessedMsgList = null;
String language = "EN";
String client = "200";
String mid = request.getParameter("MessageID");

	//SET PARAMETERS TO CONTAINER
	EzcTransParams  ezcTransParams = new EzcTransParams();
	EzTransParams ezTransParams = new EzTransParams();
	ezTransParams.setClientId(client);
	ezTransParams.setMessageId(mid);
	
	ezcTransParams.setObject(ezTransParams);
	Session.prepareParams(ezcTransParams);

//Get List of Folders
//retProcessedMsgList = (ReturnObjFromRetrieve)IBObject.getInfoOfToBeProcessedMsgs(AdminObject, servlet,mid);
retProcessedMsgList = (ReturnObjFromRetrieve)TransManager.getInfoOfToBeProcessedMsgs(ezcTransParams);
retProcessedMsgList.check();

int msgRows = retProcessedMsgList.getRowCount();
		// From User
		String fromUser = (String)retProcessedMsgList.getFieldValue(0, "ETM_CREATED_BY");

		// Transaction Id
	String TranId = (String)retProcessedMsgList.getFieldValue(0, "ETM_TRAN_ID");
		// Message Subject
		String msgSubject = (String)retProcessedMsgList.getFieldValue(0,"ETM_MSG_HEADER");

		//Message Content
    String msgcontent = (String)retProcessedMsgList.getFieldValue(0,"ETM_MSG_CONTENT1");
  if(msgcontent==null) msgcontent="No Content";

		// Message Created Date
		String msgDate = (String)retProcessedMsgList.getFieldValue(0,"ETM_CREATION_DATE");
		// Message Created Time
		String msgTime = (String)retProcessedMsgList.getFieldValue(0,"ETM_CREATION_TIME");
		// Message Id
                String msgID = (String)retProcessedMsgList.getFieldValue(0,"ETM_MSG_ID");
               // Attachments
//               String attachments = //(String)retProcessedMsgList.getFieldValue(0,"EML_EXT_LNK");
 


%>

<Title>Inbox: Compose Message</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>

<body bgcolor="#FFFFF7">
<Table  width="60%" border="0" align="center">
  <Tr align="center"> 
      <Td class="displayheader">View Transaction Message</Td>
  </Tr>
</Table>
<form name=myForm method=post action="../Inbox/ezSendPersMsg.jsp">

  <Table  width="45%" align="center" border="1">
    <Tr align="center" valign="middle" bordercolor="#FFFFF7"> 
      <Td width="15%" class="labelcell"> 
            <div align="right">From:</div>
      </Td>
      <Td width="85%" align="left" bgcolor="#FFFFF7"> 
          
        <input type=text class = "InputBox" name="toUser" size="50" maxlength="50" value= <%=fromUser%> readonly>
 
 </Td>
    </Tr>
    <Tr align="center" valign="middle" bordercolor="#FFFFF7"> 
      <Td width="15%" class="labelcell"> 
        <div align="right">Subject: </div>
      </Td>

      <Td width="85%" bgcolor="#FFFFF7"> 
        <div align="left"> 
          <input type=text class = "InputBox" name="msgSubject" size="25" maxlength="50"  readonly value=" <%= msgSubject %> "  >
          Trans Code: 
			 <input type=text class = "InputBox" name="MsgTransCode" value="<%=TranId%>" readonly>
        </div>
      </Td>
    </Tr>
    <Tr align="center" valign="middle" bordercolor="#FFFFF7"> 
      <Td width="15%" bgcolor="#FFFFF7" bordercolor="#FFFFF7" class="blankcell">&nbsp;</Td>
      <Td width="85%" bgcolor="#FFFFF7" bordercolor="#FFFFF7"> 
        <div align="left"> 
          <textarea name="msgText" cols="50" rows="4" readonly > <%  out.println(msgcontent); %>
</textarea>
        </div>
      </Td>
    </Tr>
  </Table>
  <div align="center"> 
    <p>&nbsp;</p>
    <p><b><font size="4" face="Verdana, Arial, Helvetica, sans-serif">Attached 
      File List</font></b></p>
    <Table  width="25%" border="0">
      <% if(msgRows>0)  for(int i=0;i<msgRows;i++) {  
               String attachments = (String)retProcessedMsgList.getFieldValue(i,"EML_EXT_LNK");

 %> 
      <Tr> 
        <Td><% 

String UP_File = attachments;
   int space = UP_File.lastIndexOf("\\"); 
   UP_File = UP_File.substring(space+1,UP_File.length());

out.println(UP_File); %></Td>
      </Tr>
      <% } %> 
    </Table>
  </div>
</form>
</body>
</html>