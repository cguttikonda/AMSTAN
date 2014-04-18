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

/*
function setDeleteAction() {
	document.forms[0].action = "ezListToBeTransMsgs2.jsp";
	document.returnValue = true;
}
*/
function setDeleteAction() {
	var pCount=0;
	var selCount=0;
	pCount = document.myForm.TotalCount.value;
	var i = 0;
	for ( i = 0 ; i < pCount; i++ ) {
		if(document.myForm.elements['CheckBox_' + i].checked){
			selCount = selCount + 1;
			break;
		}
	}
	if(selCount<1){
		alert("Select Message(s) Before Deleting From Pesonal Messages");
		document.returnValue = false;
	}else{
		ocument.forms[0].action = "ezListToBeTransMsgs2.jsp";
		document.returnValue = true;
	}
}

function setProcessAction() {
	var pCount=0;
	var selCount=0;
	pCount = document.myForm.TotalCount.value;
	var i = 0;
	for ( i = 0 ; i < pCount; i++ ) {
		if(document.myForm.elements['CheckBox_' + i].checked){
			selCount = selCount + 1;
			break;
		}
	}
	if(selCount<1){
		alert("Select Message(s) Before Processing From Pesonal Messages");
		document.returnValue = false;
	}else{
		document.forms[0].action = "../Misc/ezProcessMessage.jsp";
		document.returnValue = true;
	}
}
/*
function setProcessAction() {
	document.forms[0].action = "../Misc/ezProcessMessage.jsp";
	document.returnValue = true;
}*/

/*function setDeleteFlag() {
	document.myForm.DelFlag.value = 'Y';
	document.returnValue = true;
}*/
</script>

<%
// Key Variables
ReturnObjFromRetrieve retToBeProcessedMsgList = null;
String language = "EN";
String client = "200";
	//SET PARAMETERS TO CONTAINER
	EzcTransParams  ezcTransParams = new EzcTransParams();
	EzTransParams ezTransParams = new EzTransParams();

	ezTransParams.setClientId("200");

	ezcTransParams.setObject(ezTransParams);
	Session.prepareParams(ezcTransParams);

//retToBeProcessedMsgList = (ReturnObjFromRetrieve)IBObject.getAllToBeProcessedMsgList(AdminObject, servlet);
retToBeProcessedMsgList = (ReturnObjFromRetrieve)TransManager.getAllToBeProcessedMsgList(ezcTransParams);
retToBeProcessedMsgList.check();

%>

<Title>Inbox: Personal Messages</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body >
<form name=myForm method=post action="../TransMsg/ezListToBeTransMsgs2.jsp">

   <%
int msgRows = retToBeProcessedMsgList.getRowCount();
if(msgRows > 0){
%>
<Table  width="60%" border="0" align="center">
  <Tr align="center">
    <Td class="displayheader">To Be Processed Messages</Td>
  </Tr>
</Table>

  <br>
  <Table  width="80%" align="center">

    <Tr align="center" valign="middle" bordercolor="#FFFFF7">
      <Th width="8%">Select</Th>
      <Th width="23%">From </Th>
      <Th width="45%"> Subject </Th>
      <Th width="18%">Date</Th>
    </Tr>
<%
	for (int i = 0 ; i < msgRows; i++) {
		// From User
	String fromUser = (String)retToBeProcessedMsgList.getFieldValue(i, "ETM_CREATED_BY");

		// Message Subject
        String msgSubject = (String)retToBeProcessedMsgList.getFieldValue(i, "ETM_MSG_HEADER");

		// Message ID
	String msgID = (String)retToBeProcessedMsgList.getFieldValue(i,"ETM_MSG_ID");
                //Transaction ID
       String TransID = (String)retToBeProcessedMsgList.getFieldValue(i,"ETM_TRAN_ID");


		// Message Created Date
	String msgDate = (String)retToBeProcessedMsgList.getFieldValue(i,"ETM_CREATION_DATE");

		// Message Created Time
	String msgTime = (String)retToBeProcessedMsgList.getFieldValue(i,"ETM_CREATION_TIME");

   // Client for the Message Id
		String clientID = String.valueOf(retToBeProcessedMsgList.getFieldValue(i,"ETM_CLIENT"));

%>
    <Tr align="center">
      <Td width="8%"> <%
	out.println("<input type=\"checkbox\" name= \"ToBeProcessMsg_"+i+"\" value=\"Selected\" >");
%> </Td>
      <Td width="23%"><%
	out.println(fromUser);
%> </Td>
      <Td width="45%"><%
	out.println("<a href=\"ezComposeTransToBeMsgInfo.jsp?MessageID="+ msgID +"\">");
	out.println(msgSubject);
     	out.println("<input type=\"hidden\" name=\"MessageID_"+i+"\" value=\""+ msgID +"\">");
        out.println("<input type=\"hidden\" name=\"TransID_"+i+"\" value=\""+ TransID +"\">");

     	out.println("<input type=\"hidden\" name=\"UserID_"+i+"\" value=\""+ fromUser +"\">");
	out.println("<input type=\"hidden\" name=\"ClientID_"+i+"\" value=\""+ clientID +"\">");
     	//out.println("<input type=\"hidden\" name=\"AttachCount_"+i+"\" value=\""+ procMsgRows +"\">");



%> </Td>
      <Td width="18%"><%
	out.println(msgDate);
%> </Td>
    </Tr>
    <%
}//End for
   //  	out.println("<input type=\"hidden\" name=\"FolderID\" value=\""+folderID+"\">");
%>
    <input type="hidden" name="TotalCount" value=<%=msgRows%>>
    <input type="hidden" name="DelFlag" value="N">
  </Table>
  <div align="center"> <br>
    <input type="submit" name="Delete" value="Delete"  onClick="setDeleteAction();return document.returnValue">
    <input type="submit" name="Process" value="Process" onClick="setProcessAction();return document.returnValue">
  </div>
<%
}
else
{
%>
	<br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
			<Td class = "labelcell">
				<div align="center"><b>There Are No Messages To Be Processed</b></div>
			</Td>
		</Tr>
	</Table>
<br>
<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>


<%
}//End if for msgRows>0
%>
</form>
<p align="center">&nbsp; </p>
</body>
</html>