<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%
	String msgFlag = request.getParameter("msgFlag");

	ReturnObjFromRetrieve retFoldList = null;
	EzcMessageParams  ezcMessageParamsF = new EzcMessageParams();
	EzMessageParams ezMessageParamsF = new EzMessageParams();
	ezMessageParamsF.setClient("200");
	ezMessageParamsF.setLanguage("EN");
	ezcMessageParamsF.setObject(ezMessageParamsF);
	Session.prepareParams(ezcMessageParamsF);
	retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParamsF);
%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/Inbox/ezAddFolder.js"></script>
	<Title>Add Folder</Title>
	<script>
	var folderNames=new Array()
<%
	int rowCount=retFoldList.getRowCount();
	for(int i=0;i<rowCount;i++)
	{
%>
		folderNames[<%=i%>]="<%=retFoldList.getFieldValueString(i,"EFI_FOLDER_NAME")%>"
<%
	}
%>
	</script>
</head>
<body onLoad="document.myForm.FolderName.focus()">
<form name=myForm method=post onSubmit="return chkFolder()" >
<Table  align=center border=0 cellPadding=0 cellSpacing=0  width=90%>
<Tr>
	<Td>
	<Table cellSpacing=0 cellPadding=0 width=100% border=0>
      	<Tr>
		<Td vAlign=bottom height=45 width=100%  class=blankcell>
	     	<Table  cellSpacing=0 cellPadding=0 border=0 >
	     	<Tr>
			<Td class=blankcell width=10 ><IMG height=27  src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_start.gif" width=15 border=0></Td>
			<Td class=blankcell background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif><a  href="ezListPersMsgs.jsp?msgFlag=<%=msgFlag%>"  title="List of messages" style="text-decoration:none" class="tabclass">Inbox</a></Td>
			<Td class=blankcell width=10><IMG height=27   src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif" width=15 border=0></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back2_left.gif" width=15  border=0></Td>
			<Td class=blankcell background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif><a  href="ezComposePersMsg.jsp?msgFlag=<%=msgFlag%>"  title="Composing of Messages" style="text-decoration:none" class="tabclass">Compose</a></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif" width=15  border=0></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_left.gif" width=15 border=0></Td>
			<Td class=blankcell background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_front.gif><a href="ezListFolders.jsp?msgFlag=<%=msgFlag%>" title="Folders List"  style="text-decoration:none" class="tabclass">Folders</a></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_right.gif" width=15 border=0></Td>
			<Td class=blankcell width=12><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_end.gif" width=12 border=0></Td>
		</Tr>
		</Table >
		</Td>
		<Td class=blankcell vAlign=center align=right height=45>&nbsp; </Td>
		</Tr>
	</Table >
	</Td>
</Tr>
</Table>
<Table   width="90%" height=50% align=center border=1 borderColorDark=#ffffff borderColorLight=#006666  cellPadding=2 cellSpacing=0 >
<Tr>
 	<Td>
	<Table  valign=center align=center border=1 borderColorDark=#ffffff borderColorLight=#006666  cellPadding=2 cellSpacing=0 >
	<Tr>
	      	<Th  height="27" class="labelcell">Folder Description:</Th>
	      	<Td  height="27">
	          	<input type=text class = "InputBox" name="FolderName" size="20" maxlength="128">
	      	</Td>
	</Tr>
	</Table >
       	</Td>
</Tr>
</Table >
<br>
<div id="buttons" align="center">
	<input type="image" src = "../../Images/Buttons/<%=ButtonDir%>/addfolder.gif" alt="Add Folder">
	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%=ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset();document.myForm.FolderName.focus()" ></a>
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
</div>
<script Language="JavaScript">
<%
	String fName = request.getParameter("Folder");
	if ( fName != null )
	{
%>
		alert('Folder already exists. Try a different one');
		document.forms[0].FolderName.value='<%=fName%>';
<%
	 } 
%>
		document.forms[0].FolderName.focus();
</script>
<div id="ButtonsDiv2" align="center" style="overflow:auto;position:absolute;visibility:hidden;width:100%;top:96%">
     <font class="msgcolor1"><b>Your request is being processed...  Please Wait</b></font>
</div>
<input type = "hidden" name = "msgFlag" value = "<%=msgFlag%>">
</form>
</body>
</html>
