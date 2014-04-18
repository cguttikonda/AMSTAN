<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%
	String msgFlag = request.getParameter("msgFlag");
	String replyToUser = request.getParameter("fromUser");
	String replyToSubject = request.getParameter("msgSubject");
	String replyToMsgID = request.getParameter("MessageID");
       	session.putValue("fname","");
%>
<html>
<head>
	<Title>Inbox: Reply Personal Message</Title>
	<script language="javascript"></script>
	<script src="../../Library/JavaScript/CheckFormFields.js"></script>
	<script src="../../Library/JavaScript/Inbox/ezComposePersMsgs.js"></script>
</head>
<body onLoad="document.myForm.ccUser.focus()">
<form name=myForm method=post onSubmit="return chkSubmit()" action="ezSendReplyPersMsg.jsp">
<input type="hidden" name='files'>
<Table  align=center border=0 cellPadding=0 cellSpacing=0  width=90%>
<Tr>
	<Td>
	<Table  cellSpacing=0 cellPadding=0 width=100% border=0>
	<Tr>
		<Td vAlign=bottom height=45 width=100%  class=blankcell>
		<Table  cellSpacing=0 cellPadding=0 border=0 >
		<Tr>
			<Td class=blankcell width=10 ><IMG height=27  src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_start.gif" width=15 border=0></Td>
			<Td class=blankcell background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif><a  href="ezListPersMsgs.jsp?msgFlag=<%=msgFlag%>"  title="List of messages" style="text-decoration:none" class="tabclass">Inbox</a></Td>
			<Td class=blankcell width=10><IMG height=27   src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif" width=15 border=0></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_left.gif" width=15  border=0></Td>
			<Td class=blankcell background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_front.gif><a  href="JavaScript:void(0)"  title="Composing of Messages" style="text-decoration:none" class="tabclass">Compose</a></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages//tab_front_right.gif" width=15  border=0></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back1_left.gif" width=15 border=0></Td>
			<Td class=blankcell background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif><a href="ezListFolders.jsp" title="Folders List"  style="text-decoration:none" class="tabclass">Folders</a></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif" width=15 border=0></Td>
			<Td class=blankcell width=12><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_end.gif" width=12 border=0></Td>
		</Tr>
		</Table >
		</Td>
		<Td class=blankcell vAlign=center align=right height=45>&nbsp; </Td>
	</Tr>
	</Table >
	</Td>
</Tr>
</Table >	
<Table   width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666  cellPadding=2 cellSpacing=0 >
<Tr align="center"> 
	<Th >Reply To Message</Th>
</Tr>
</Table >
<Table  width=90% border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 >
<Tr>
	<Td>
	<Table   border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0  width="100%">
	<Tr ><Th><A href="Javascript:getAddressWindow()" ><b>To:</b></a></Th>
      	<Td width=55%><input type=text class=InputBox  style="width:100%"  name="toUser"  size=55  value="<%=replyToUser%>"></Td>
	<Td width=30% rowspan=4>
			<Table   border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0  width="100%" height = "100%">
				 <Tr><Th ><a href="javascript:getAttachWindow()">Click Here For Attachments</a></Th></Tr>
				 <Tr><Td><textarea class=txarea name=attachs rows=4 readonly style="overflow:auto;border:0;width:100%" wrap="off"></textarea></Td></Tr>
				</Td></Tr>
			</Table >
	</Td>
	</Tr>
	<Tr><Th><b>Cc:</b></Th>
        <Td ><input type=text  class=InputBox  style="width:100%"  name="ccUser"  tabindex=2></Td>
    	</Tr>
    	<Tr> 
        <Th><b>Bcc:</b></Th>
        <Td><input type=text  class=InputBox  style="width:100%"  name="bccUser"  tabindex=3></Td>
	</Tr>
	<Tr> 
	<Th ><b>Subject:</b></Th>
      	<Td ><input type=text  class=InputBox  name="msgSubject" style="width:100%" maxlength="256" tabindex=4 value ="Re: <%=replyToSubject%>"></Td>
    	</Tr>
	<Tr>
	<Td align=middle colspan=3>
      		<Table  cellSpacing=0 cellPadding=0 width="100%">
		<Tr><Td>
      			<textarea name="msgText" style="overflow:auto;border:0;width:100%" rows="4" tabindex=5></textarea>
    			<input type="hidden" name="toMessage" value=<%=replyToMsgID%>></Td></Tr></Table >
    	    	</Td>
    		</Tr>
    		<Tr><Th colSpan=3 align="center">Attachments are applicable only for External Mails</Th></Tr>
    		</Table>      
     	</Table>
     	<br>
	<div id="buttons" align = "center">
		<input type=image src="../../Images/Buttons/<%=ButtonDir%>/send.gif" tabindex=6 border=none>
    		<a href="javascript:funReset()"><img src = "../../Images/Buttons/<%=ButtonDir%>/clear.gif" tabindex=7 name="clearMsg" value="Clear" border=none></a>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none tabindex=8></a>
		
    	</div>
    	<div id="ButtonsDiv2" align="center" style="overflow:auto;position:absolute;visibility:hidden;width:100%;top:90%">
     		<font class="msgcolor1"><b>Your request is being processed...  Please Wait</b></font>
 	</div>
<input type = "hidden" name="msgFlag" value ="<%=msgFlag%>" > 	
</form>
</body>
</html>
