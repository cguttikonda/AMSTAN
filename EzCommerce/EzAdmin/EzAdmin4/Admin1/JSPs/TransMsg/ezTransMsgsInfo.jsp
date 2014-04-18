<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>

<html>
<head>

<script LANGUAGE="JavaScript">
function showMessages(){
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "msgFlag=" + document.myForm.newFlag.value;
	mUrl3 = "&FolderID=" + document.myForm.FolderID.value;
	mUrl =  mUrl1 + mUrl2 + mUrl3;
	location.href= mUrl;
}
   function CheckSelect() {
	var pCount=0;
	var selCount=0;
	pCount = document.myForm.TotalCount.value;
	var i = 0;
	for ( i = 0 ; i < pCount; i++ ) {
		if(document.myForm.elements['CheckBox_' + i].checked){
			selCount = selCount + 1;
		}
	}
	if(selCount<1){
		alert("Select Message(s) Before Deleting From Pesonal Messages");
		document.returnValue = false;
	}else{
		document.myForm.DelFlag.value = 'Y';
		document.returnValue = true;
	}
}


/*function setDeleteFlag() {
	document.myForm.DelFlag.value = 'Y';
	document.returnValue = true;
}*/
</script>

<%
// Key Variables
ReturnObjFromRetrieve retProcessedMsgList = null;
String language = "EN";
String client = "200";
String mid = request.getParameter("MessageID");
//----------------------
	//SET PARAMETERS TO CONTAINER
	EzcTransParams  ezcTransParams = new EzcTransParams();
	EzTransParams ezTransParams = new EzTransParams();
	ezTransParams.setMessageId(mid);
	
	
	ezcTransParams.setObject(ezTransParams);
	Session.prepareParams(ezcTransParams);

//----------------------


//Get List of Folders
//retProcessedMsgList = (ReturnObjFromRetrieve)IBObject.getInfoOfProcessedMsgs(AdminObject, servlet,mid);
retProcessedMsgList = (ReturnObjFromRetrieve)TransManager.getInfoOfProcessedMsgs(ezcTransParams);
retProcessedMsgList.check();

%>

<Title>Inbox: Personal Messages</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body >
<Table  width="60%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader">Processed Messages</Td>
  </Tr>
</Table>
<form name=myForm method=post action="../Inbox/ezDelPersMsgs.jsp">

  <br>
  <Table  width="80%" align="center">
    <Tr align="center" valign="middle" bordercolor="#FFFFF7"> 
      <Th width="23%">From </Th>
      <Th width="45%">Message ID</Th>
      <Th width="45%">Attachments</Th>
      <Th width="18%">Created Date</Th>
      <Th width="18%">Created Time</Th>
    </Tr>
    <% 
int msgRows = retProcessedMsgList.getRowCount();
if(msgRows > 0){
	for (int i = 0 ; i < msgRows; i++) {
		// From User
		String fromUser = (String)retProcessedMsgList.getFieldValue(i, "ETM_CREATED_BY");

		// Message Subject
		String msgSubject = (String)retProcessedMsgList.getFieldValue(i,"ETM_MSG_HEADER");

		// Message Created Date
		String msgDate = (String)retProcessedMsgList.getFieldValue(i,"ETM_CREATION_DATE");

		// Message Created Time
		String msgTime = (String)retProcessedMsgList.getFieldValue(i,"ETM_CREATION_TIME");

		// Message Id
                String msgID = (String)retProcessedMsgList.getFieldValue(i,"ETM_MSG_ID");

               // Attachments
               String attachments = (String)retProcessedMsgList.getFieldValue(i,"EML_EXT_LNK");
%> 
    <Tr align="center"> 
      <Td width="23%"><% 
	out.println(fromUser);
%> </Td>
      <Td width="45%"><% out.println(msgID); %></Td>
      <Td width="45%"><% 
	out.println(attachments);
    %> </Td>
      <Td width="18%"><% out.println(msgDate); %></Td>
      <Td width="18%"><% 
	out.println(msgTime);
%> </Td>
    </Tr>
    <% 
}//End for
}//End if for msgRows>0
     	
%> 
    <input type="hidden" name="TotalCount" value=<%=msgRows%>>
    <input type="hidden" name="DelFlag" value="N">
  </Table>
  <div align="center"> </div>
</form>
<p align="center">&nbsp; </p>
</body>
</html>