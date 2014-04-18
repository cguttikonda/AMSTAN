<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%
	String msgFlag = request.getParameter("msgFlag");
%>
<html>
<head>
	<Title>Inbox: Compose Message</Title>
	<script src="../../Library/JavaScript/Inbox/ezComposePersMsgs.js"></script>
	<script src="../../Library/JavaScript/CheckFormFields.js"></script>
</head>
<body onLoad="document.myForm.toUser.focus()" scroll = "no">
<form name=myForm method=post onSubmit="return chkSubmit()" action="ezSendPersMsg.jsp">
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
				<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_right.gif" width=15  border=0></Td>
				<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back1_left.gif" width=15 border=0></Td>
				<Td class=blankcell background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif><a href="ezListFolders.jsp?msgFlag=<%=msgFlag%>" title="Folders List"  style="text-decoration:none" class="tabclass">Folders</a></Td>
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
	<Th >Compose Message</Th>
</Tr>
</Table >
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="90%">
<Tr>
	<Td>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000"  cellSpacing=0 width="100%">
	<Tr>
		<Th align=right width=15%>&nbsp;&nbsp;<B><A href="Javascript:getAddressWindow()" >To</A>:*</B></Th>
		<Td  width=55%><input type='text'  class=InputBox   tabindex=1 style="width:100%" name=toUser></Td>
		<Td  width=30% rowspan=4 align=center>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="100%">
				 <Tr><Th ><a href="javascript:getAttachWindow()">Click Here For Attachments</a></Th></Tr>
				 <Tr><Td><textarea class=txarea name=attachs rows=3 readonly style="overflow:auto;border:0;width:100%" wrap="off"></textarea></Td></Tr>
				</Td></Tr>
			</Table >
		</Td>
		</Tr>
		<Tr>
		<Th align=right>&nbsp;&nbsp;<B>Cc :</B></Th>
		<Td><input type='text' class=InputBox  tabindex=2  style="width:100%" name=ccUser></Td>
		</Tr>
		<Tr>
		<Th align=right>&nbsp;&nbsp;<B>Bcc :</B></Th>
		<Td><input type='text'  class=InputBox  tabindex=3   style="width:100%" name=bccUser></Td>
		</Tr>
		<Tr>
		<Th align=right>&nbsp;&nbsp;<B>Subject :</B></Th>
		<Td><input type='subject' class=InputBox  maxLength=256 tabindex=4 style="width:100%" name=msgSubject></Td>
		</Tr>
		</Table >
		</Td>
	</Tr>
	<Tr>
	<Td>  
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="100%">
		<Tr>
			<Th align=right valign = top width = "15%"><B>Message:</B></Th>
			<Td align=middle><textarea title="Type Message Text"  tabIndex=5 name="msgText" rows=4  style="overflow:auto;border:0;width:100%"  ></textarea></Td>
		</Tr>
		</Table >
	</Td>
	</Tr>
	<Tr><Th colSpan=2 align="center">Attachments are applicable only for External Mails</Th></Tr>
	</Table>
	</Table>
	<br>
 	<center>
		<div id="buttons">
			<input type=image src="../../Images/Buttons/<%=ButtonDir%>/send.gif" tabindex=6 border=none>
			<a href="javascript:funReset()"><img src = "../../Images/Buttons/<%=ButtonDir%>/clear.gif" tabindex=7 name="clearMsg" value="Clear" border=none></a>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" tabindex=8 border=none></a>
		</div>
 	</center>
	<div id="ButtonsDiv2" align="center" style="overflow:auto;position:absolute;visibility:hidden;width:100%;top:90%">
	     <font class="msgcolor1"><b>Your request is being processed...  Please Wait</b></font>
	 </div>
	 <input type = "hidden" name="msgFlag" value ="<%=msgFlag%>" >
</form>
</body>
</html>
