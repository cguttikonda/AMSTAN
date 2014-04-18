<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iListFolders.jsp"%>
<%
	String msgFlag = request.getParameter("msgFlag");
%>
<html>
<head>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script src="../../Library/JavaScript/Inbox/ezListFolders.js"></script>
<Title>List Folders</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script language="JavaScript">
function selectAll()
{
   	var len=document.myForm.CheckBox.length;
	if(document.myForm.select.checked)
	{
   		document.myForm.CheckBox.checked=true
	}
	else
	{
        	document.myForm.CheckBox.checked=false
	}
   	for(i=0;i<len;i++)
   	{
   		if(document.myForm.select.checked)
      		{
          		document.myForm.CheckBox[i].checked=true
      		}
      		else
      		{
         		document.myForm.CheckBox[i].checked=false
      		}
   	}
}
</script>
</head>
<body onLoad='scrollInit()' onResize='scrollInit()' scroll=no >
<form name=myForm method=post action="ezDelFolders.jsp" onSubmit="return CheckSelect()">
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
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back2_left.gif" width=15  border=0></Td>
			<Td class=blankcell background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif><a  href="ezComposePersMsg.jsp?msgFlag=<%=msgFlag%>"  title="Composing of Messages" style="text-decoration:none" class="tabclass">Compose</a></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif" width=15  border=0></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_left.gif" width=15 border=0></Td>
			<Td class=blankcell background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_front.gif><a href="JavaScript:void(0)" title="Folders List"  style="text-decoration:none" class="tabclass">Folders</a></Td>
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
	</Table >
<%
	int foldRows = retFoldList.getRowCount();
	if ( foldRows < 1 )
	{
%>
		<Table   width="90%" height=50% align=center border=1 borderColorDark=#ffffff borderColorLight=#006666  cellPadding=2 cellSpacing=0 >
		<Tr align="center">
			<Td align=center valign=center >There are no folders to list</Td>
		</Tr>
		</Table >
		<br>
		<center>
			<img src = "../../Images/Buttons/<%=ButtonDir%>/addfolder.gif" name="Add" value="Add Folder" onClick="funAdd('<%=msgFlag%>')" style = "cursor:hand">
		    	<img src = "../../Images/Buttons/<%=ButtonDir%>/back.gif" name="Back" value="Back" onClick="JavaScript:history.go(-1)" style = "cursor:hand">
		</center>
<%
	}
	else
	{
%>
	<div id="theads">
	<Table   id="tabHead" width=90% align=center border=1 borderColorDark=#ffffff borderColorLight=#006666  cellPadding=2 cellSpacing=0 >
	<Tr>
		<Td colspan=2>
		<Table   width=100% align=center>
		<Tr>
			<Td align=left><input type="image" src = "../../Images/Buttons/<%=ButtonDir%>/deletefolder.gif" border=none  ></Td>
			<Td align=right><a href="javascript:funAdd('<%=msgFlag%>')"><img src = "../../Images/Buttons/<%=ButtonDir%>/addfolder.gif" name="Add" value="Add Folder" border=none></a></Td>
		</Tr>
		</Table >
		</Td>
	</Tr>
	<Tr align="center" valign="middle">
    		<Th width="15%" align='center'><input type="checkbox" name="select" onClick="selectAll()" title="Select All/Deselect All"></Th>
      		<Th width="85%">Folder </Th>
    		</Tr>
	</Table >
	</div>
     	<DIV id="InnerBox1Div">
     	<Table  id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666  cellPadding=2 cellSpacing=0 width=100%>
<%
	String foldID = null;
	String foldName = null;
	String foldDisable = null;
	retFoldList.sort(new String[]{FOLDER_NAME},true);
	for (int i = 0 ; i < foldRows; i++)
	{
		foldDisable = "";
		if((retFoldList.getFieldValue(i,FOLDER_ID)) != null)
		{
			foldID = retFoldList.getFieldValue(i,FOLDER_ID).toString();
		}
		foldName = retFoldList.getFieldValueString(i,FOLDER_NAME);
		foldName = foldName.trim();
		if ( foldName.equalsIgnoreCase("INBOX") )
		{
			foldDisable = "disabled";
		}
%>
		<Tr align="center">
<%		int k=0;
%>
		<label for=cb_<%=k%>">
      		<Td width="15%">
                <input type="checkbox" id=cb_<%=k%>" name= "CheckBox" value="<%=foldID %>" <%=foldDisable%> >
 		</Td>
      		<Td width="85%">
			<a href='ezListPersMsgs.jsp?FolderID=<%=foldID%>&FolderName=<%=foldName%>&msgFlag=<%=msgFlag%>'>
				<%=foldName%>
			</a>
     		</Td>
		</label>
		</Tr>
<%
	}
%>
	</Table >
	</div>
<%
	}
%>
<input type = "hidden" name = "msgFlag" value = "<%=msgFlag%>">
</form>
</body>
</html>
