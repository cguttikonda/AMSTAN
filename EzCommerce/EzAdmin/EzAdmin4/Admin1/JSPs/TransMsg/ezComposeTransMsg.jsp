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
	var url = "../Inbox/ezSelectUsers.jsp";
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
	document.forms[0].action = "../TransMsg/ezAttachFrameSet.jsp";
         document.forms[0].target="subframe"
	document.returnValue = true;
}

function sendMessage() {
	document.forms[0].action = "../TransMsg/ezSaveTransMsg.jsp";
        document.forms[0].target="_parent"
         document.returnValue = true;
}
</script>


<%
// Key Variables
ReturnObjFromRetrieve retUser = null,transobj=null;

String language = "EN";
String client = "200";

	EzcUserParams uparams= new EzcUserParams();
	Session.prepareParams(uparams);

	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");


	uparams.createContainer();
	boolean result_flag = uparams.setObject(ezcUserNKParams);


// Get List of Business Users
//retUser = IBObject.getListOfUsers(AdminObject, servlet, client, language);
retUser = (ReturnObjFromRetrieve)UserManager.getAllBussUsers(uparams);
retUser.check();

transobj= AdminObject.getInputXMLTransactions();
%>

<Title>Inbox: Compose Message</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>

<body bgcolor="#FFFFF7">
<Table  width="60%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader">Compose New Transaction Message</Td>
  </Tr>
</Table>
<form name=myForm method=post action="../Inbox/ezSendPersMsg.jsp">

  <Table  width="100%" align="center" border="1">
    <Tr align="center" valign="middle" bordercolor="#FFFFF7"> 
      <Td width="8%" class="labelcell"> 
        <div align="right"><a href="Javascript:getAddressWindow()">To: </a></div>
      </Td>
      <Td width="92%" align="left" bgcolor="#FFFFF7"> 
        <input type=text class = "InputBox" name="toUser" size="50" maxlength="50">
   </Td>
    </Tr>
    <Tr align="center" valign="middle" bordercolor="#FFFFF7"> 
      <Td width="8%" class="labelcell"> 
        <div align="right">Subject: </div>
      </Td>
      <Td width="92%" bgcolor="#FFFFF7"> 
        <div align="left"> 
          <input type=text class = "InputBox" name="msgSubject" size="25" maxlength="50">
          Trans Code: 
          <select name="MsgTransCode">
<% int Nooftranscodes = transobj.getRowCount();
 //Begin of the For Loop
 for(int j=0;j<Nooftranscodes;j++) {
 %>
             <option value= <% out.println(transobj.getFieldValue(j,"TRANSACTION")); %> > <% out.println(transobj.getFieldValue(j,"DESCRIPTION")); %> </option>
<% } //End of the for loop %>
             </select>
        </div>
      </Td>
    </Tr>
    <Tr align="center" valign="middle" bordercolor="#FFFFF7"> 
      <Td width="8%" bgcolor="#FFFFF7" bordercolor="#FFFFF7" class="blankcell">&nbsp;</Td>
      <Td width="92%" bgcolor="#FFFFF7" bordercolor="#FFFFF7"> 
        <div align="left"> 
          <textarea name="msgText" cols="50" rows="4"></textarea>
        </div>
      </Td>
    </Tr>
  </Table>
  <div align="center">
    <input type="submit" name="sendMsg" value="Send Message" onClick = sendMessage();return document.returnValue >
    <input type="reset" name="clearMsg" value="Clear">
    <input type="submit" value="Attachments" name="Attachments" onClick =     showattachments();return document.returnValue >
  </div>
</form>
</body>
</html>