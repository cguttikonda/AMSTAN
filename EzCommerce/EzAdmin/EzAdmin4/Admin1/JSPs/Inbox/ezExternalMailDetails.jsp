<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/MailGroupBean.jsp" %>

<%
	String groupId="Ezc";
	String msgId = request.getParameter("msgId");
	String msgFlag = request.getParameter("msgFlag");

	ezc.ezmail.EzcMailParams params=new ezc.ezmail.EzcMailParams();
	params.setGroupId("Ezc");
	params.setFolderName("Inbox");
	params.setMessageId(msgId);

	ezc.ezmail.EzMail ezmail=new ezc.ezmail.EzMail();
	ReturnObjFromRetrieve mailDetails = ezmail.getMailDetails(params,Session);

	global.setDateFormat("MM/dd/yyyy HH:mm:ss");
	java.util.Vector types = new java.util.Vector();
	types.addElement("date");
	global.setColTypes(types);
	java.util.Vector names = new java.util.Vector();
	names.addElement("DATE");
	global.setColNames(names);
	ReturnObjFromRetrieve globDet = (ReturnObjFromRetrieve)global.getGlobal(mailDetails);
%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<Title>Inbox: Personal Message Details</Title>
	<script src = "../../Library/JavaScript/Inbox/ezPersMsgDetails.js"></script>
	<script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<body  scroll=no>
<form name=myForm method=post action="ezDelPersMsgs.jsp?FolderName=Inbox">
<div id="theads">
<TABLE id="tabHead" align=center border=0 cellPadding=0 cellSpacing=0  width=90%>
<TR>
	<Td>
	<TABLE cellSpacing=0 cellPadding=0 width=100% border=0>
      	<TR>
		<Td vAlign=bottom height=45 width=100%  class=blankcell>
	     	<TABLE cellSpacing=0 cellPadding=0 border=0 >
	     	<TR>
			<Td class=blankcell width=10 ><IMG height=27  src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_left.gif" width=15 border=0></Td>
		      	<Td class=blankcell background="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_front.gif"><a  href="ezListPersMsgs.jsp?msgFlag=<%=msgFlag%>"  title="List of messages" style="text-decoration:none">Inbox</a></Td>
			<Td class=blankcell width=10><IMG height=27   src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_right.gif" width=15 border=0></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back1_left.gif" width=15  border=0></Td>
			<Td class=blankcell background="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif"><a  href="ezComposePersMsg.jsp?msgFlag=<%=msgFlag%>"  title="Composing of Messages" style="text-decoration:none">Compose</a></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif" width=15  border=0></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back2_left.gif" width=15 border=0></Td>
			<Td class=blankcell background="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif"><a href="ezListFolders.jsp?msgFlag=<%=msgFlag%>" title="Folders List"  style="text-decoration:none">Folders</a></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif" width=15 border=0></Td>
			<Td class=blankcell width=12><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_end.gif" width=12 border=0></Td>
		</TR>
		</TABLE>
	</Td>
	<Td class=blankcell vAlign=center align=right height=45>&nbsp; </Td>
 	</TR>
	</TABLE>
	</Td>
</Tr>
</Table>
<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<tr>
		<Td width="20%" class="labelcell" align = right> From: </Td>
		<Td width="80%" align="left">
			<!--<input type="hidden" name="fromUser" value="<% //=msgFrom%>">-->
			<%=mailDetails.getFieldValueString(0,"FROM")%>
	      	</Td>
	</Tr>
	<Tr align="center" valign="middle">
		<Td width="20%" class="labelcell" align = right> Subject: </Td>
		<Td width="80%" align="left">
			<!--<input type="hidden" name="msgSubject"  value="<%//=msgSubject%>">-->
<%
			String msgSubject=mailDetails.getFieldValueString(0,"SUBJECT");
			if(msgSubject==null || "null".equals(msgSubject) || "".equals(msgSubject))
			{
				msgSubject="[No Subject]";
			}
%>
	               	<input type="text" size=90 readonly value="<%=msgSubject%>" class=DisplayBox>
		</Td>
	</Tr>
	<Tr align="center" valign="middle" >
		<Td width="20%" class="labelcell" align = right>Date:</Td>

		<Td width="80%" align="left"><%=globDet.getFieldValueString(0,"DATE")%></Td>
	</tr>
</table>
</div>
<DIV id="InnerBox1Div">
<Table  id="InnerBox1Tab" width="89%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=0 cellSpacing=0 >
	<Tr  valign="middle" >
		<Td class=blankcell height=100%>
			<textarea name="mess" rows="7" readonly Style = "width:100%;overflow:auto" class = txarea><%=mailDetails.getFieldValueString(0,"CONTENT")%></textarea>
		</td>
	<tr>
</table>
</Div><br><center>
        <a href="ezListPersMsgs.jsp?msgFlag=<%=msgFlag%>"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a></div>
	<input type = "hidden" name=msgFlag value="<%=msgFlag%>" >

</form>
</body>
</html>

