<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>
<%@ include file="../../../Includes/JSPs/Inbox/iListPersMsgs.jsp"%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<script src="../../Library/JavaScript/Inbox/ezListPersMsgs.js"></script>
	<Title>Powered by EzCommerceInc</Title>
	<script language="JavaScript">
	function selectAll()
	{
		var len=document.myForm.CheckBox.length;

		if(document.myForm.CheckBox.disabled!=true)
		{
			if(document.myForm.select.checked)
			{
				document.myForm.CheckBox.checked=true
			}
			else
			{
				document.myForm.CheckBox.checked=false
			}
		}

		for(i=0;i<len;i++)
		{
			if(document.myForm.select.checked)
			{
				if(document.myForm.CheckBox[i].disabled!=true)
				{
					document.myForm.CheckBox[i].checked=true
				}
			}
			else
			{
				document.myForm.CheckBox[i].checked=false
			}
		}
	}



	</script>

</head>

<body bgcolor="#FFFFF7"  scroll=no onLoad = "scrollInit()" onResize = "scrollInit()">
<form name=myForm method=post action="ezDelPersMsgs.jsp">
	<input type="hidden" name="FolderID" value=<%=folderID%> >
	<input type="hidden" name="FolderName" value=<%=folderName%>>
	<input type="hidden" name="DelFlag" value="N">
	<div id="theads" >
	<Table  id="tabHead" align=center border=0 cellPadding=0 cellSpacing=0  width=89%>
	<TBODY>
	<Tr>
		<Td>
		<Table  cellSpacing=0 cellPadding=0 width=100% border=0>
		<TBODY>
		<Tr>
			<Td vAlign=bottom height=45 width=100%  class=blankcell>
			<Table  cellSpacing=0 cellPadding=0 border=0 >
			<TBODY>
			<Tr>
				<Td class=blankcell width=10 ><IMG height=27  src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_left.gif" width=15 border=0></Td>
				<Td class=blankcell background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_front.gif><a  href="ezListPersMsgs.jsp?msgFlag=<%=msgFlag%>"  title="List of messages" style="text-decoration:none" class="tabclass">Inbox</a></Td>
				<Td class=blankcell width=10><IMG height=27   src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_front_right.gif" width=15 border=0></Td>
				<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back1_left.gif" width=15  border=0></Td>
				<Td class=blankcell background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif><a  href="ezComposePersMsg.jsp?msgFlag=<%=msgFlag%>"  title="Composing of Messages" style="text-decoration:none" class="tabclass">Compose</a></Td>
				<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif" width=15  border=0></Td>
				<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back2_left.gif" width=15 border=0></Td>
				<Td class=blankcell background=../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif><a href="ezListFolders.jsp?msgFlag=<%=msgFlag%>" title="Folders List"  style="text-decoration:none" class="tabclass">Folders</a></Td>
				<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif" width=15 border=0></Td>
				<Td class=blankcell width=12><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_end.gif" width=12 border=0></Td>
			</Tr>
			</TBODY>
			</Table >
			</Td>
				<Td class=blankcell vAlign=center align=right height=45>&nbsp; </Td>
		</Tr>
		</TBODY>
		</Table >
		</Td>
	</Tr>
	</Table >
	</div>
		
		<Table  width=89%  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666  cellPadding=2 cellSpacing=0 >
		<Tr>
			<th >Messages in <%=folderName%></th>
		</Tr>
		<Tr>
			<Td>
			<Table   width=100%  align=center>
			<Tr>
<%
				int mailCount = retMsgList.getRowCount();
				if(mailCount!=0)
				{
%>
					<Td><a href="javascript:CheckSelectNew();"><img src = "../../Images/Buttons/<%=ButtonDir%>/delete.gif" style="cursor:hand" name="Delete" border=none ></a></Td>		
<%
				}
%>
				<Td ><a href="ezListPersMsgs.jsp?msgFlag=0&FolderID=<%=folderID%>&FolderName=<%=folderName%>"  style="text-decoration:none" style="cursor:hand" title="All Messages" ><b>All Messages&nbsp;</b></a></Td>
				<Td><a href="ezListPersMsgs.jsp?msgFlag=1&FolderID=<%=folderID%>&FolderName=<%=folderName%>"  title="New Messages" style="text-decoration:none"><b>New Messages</b></a></Td>
<%
				if(mailCount!=0)
				{
%>
					<Td align=right>
<%
					if ( retFoldList.find(FOLD_NAME,"Inbox") )
					{
						int rowID = retFoldList.getRowId(FOLD_NAME,"Inbox");
						retFoldList.deleteRow(rowID);
					}

					int foldRows = retFoldList.getRowCount();
					String foldName = null;
					if ( foldRows > 0 )
					{
%>	
						<img src = "../../Images/Buttons/<%= ButtonDir%>/moveto.gif" alt="Move To"  onClick="funMoveTo()" style="cursor:hand">
   						<select name="ToFolder" >
						<option value="select">Select</option>
<%
						for ( int i = 0 ; i < foldRows ; i++ )
						{
							foldName = retFoldList.getFieldValueString(i,FOLD_NAME);
							if(!(folderName.equals(foldName)))
							{
%>
							    	<option value="<%=retFoldList.getFieldValue(i,FOLD_ID)%>">
								<%= foldName%>
			 			           	</option>
<%			 
							}
						}
%>
			        		</select>
<%
					}
%>	
					</Td>
<%
				}	
%>
			</Tr>
			</Table >
			</Td>
		</Tr>
	</Table >
	
<%
	if(mailCount==0 && msgFlag.equals("0") && extMailCount ==0)
	{
%>	
		<Table   width="89%" valign=center height=50% align=center border=1 borderColorDark=#ffffff borderColorLight=#006666  cellPadding=2 cellSpacing=0 >
		<Tr>
			<Td  align = "center">No Messages in <%=folderName%>.</Td>
		</Tr>
		</Table >
		<br>
		<Center>
			<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" Style = "Cursor:hand" onClick = "JavaScript:history.go(-1)">
		</Center>
<%
		return;
	}
%>
<%
	if(mailCount==0 && msgFlag.equals("1") && extMailCount ==0)
	{
%>	
		<Table   width="89%" valign=center height=50% align=center border=1 borderColorDark=#ffffff borderColorLight=#006666  cellPadding=2 cellSpacing=0 >

		<Tr>
			<Td  align = "center">No New Messages in <%=folderName%>.</Td>
		</Tr>
		</Table >
		<br>
		<Center>
			<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" Style = "Cursor:hand" onClick = "JavaScript:history.go(-1)">
		</Center>
<%
		return;
	}
%>
	<Table   width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666  cellPadding=2 cellSpacing=0 >
	<Tr align="center">
<%
	if(mailCount!=0)
	{
%>	
		<Th width="5%" align='center'><input type="checkbox" name="select" onClick="selectAll()" title="Select/Deselect All"></Th>
<%
	}
	else
	{
%>
		<Th width="5%">&nbsp;</Th>
<%
	}
		if("0".equals(msgFlag))
		{
%>
		<Th width="5%">New</Th>
<%
		}
%>
		<Th width="5%"><img src = "../../Images/Buttons/<%=ButtonDir%>/attachment.gif">
		<Th width="30%">From </Th>
		<Th width="30%"> Subject </Th>
		<Th width="20%">Date</Th>
	</Tr>
	</Table >
	</div>
	<DIV id="InnerBox1Div">
	<Table   id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666  cellPadding=2 cellSpacing=0 width="100%">
<%
	String subject = "";
	String date = "";
	String newMsgFlag = "";
	String fName = "";
	String mName = "";
	String lName = "";
	String userName = "";

	String isAttach = "";
	for(int i=0;i<extMailCount;i++)
	{
		newMsgFlag = "&nbsp;";
		isAttach = "&nbsp;";
		if("0".equals(msgFlag) && "Y".equals(retExternal.getFieldValueString(i,"ISNEW")))
			newMsgFlag = "<img src = '../../Images/Buttons/"+ButtonDir+"/new.gif'>";

		subject =retExternal.getFieldValueString(i,"SUBJECT");
		if(subject == null || "null".equals(subject))
			subject="[No Subject]";

%>
		<Tr>
			<Td width="5%" align = "center"><input type="checkbox" name= "CheckBox1" disabled ></Td>
<%
		if("0".equals(msgFlag))
		{
%>
			<Td width="5%"><%=newMsgFlag%></Td>
<%
		}
			if("Y".equals(retExternal.getFieldValueString(i,"ISATTACH")))
			{
%>
				<Td width="5%" align = "center">
				<a href="ezGetAttachment.jsp?msgId=<%=retExternal.getFieldValueString(i,"MESSAGEID")%>">
					<img src = "../../Images/Buttons/<%=ButtonDir%>/attachment.gif" border=none></a>
				</a>
				</Td>
<%
			} else {
%>
				<Td width="5%">&nbsp;</Td>
<%
			}
%>
			<Td width="30%" align = "center">
				<a href="ezExternalMailDetails.jsp?msgId=<%=retExternal.getFieldValueString(i,"MESSAGEID")%>&msgFlag=<%=msgFlag%>"><%=retExternal.getFieldValue(i,"FROM")%></a>
			</Td>
			<Td width="30%"><%=subject%></Td>
			<Td width="20%"><%=extGlob.getFieldValue(i,"DATE")%></Td>
		</Tr>
<%
	}

	for (int i=0;i<mailCount;i++)
	{
		newMsgFlag = "&nbsp;";
		subject = "[No Subject]";
		date = "[No Date]";
		if(!((retMsgList.getFieldValueString(i,MSG_SUBJECT)).trim().equals("") && (retMsgList.getFieldValueString(i,MSG_SUBJECT)).equals("")))
			subject = retMsgList.getFieldValueString(i,MSG_SUBJECT);
		if("N".equals(retMsgList.getFieldValueString(i,NEW_MSG_FLAG)))
			newMsgFlag = "<img src = '../../Images/Buttons/"+ButtonDir+"/new.gif'>";
%>
		<Tr>
		<label for="cb_<%=i%>">

				<Td width="5%" align = "center"><input type="checkbox" name= "CheckBox" id="cb_<%=i%>" value="<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>" ></Td>
<%
		if("0".equals(msgFlag))
		{
%>
			<Td width="5%"><%=newMsgFlag%></Td>
<%
		}
%>
			<Td width="5%">&nbsp;</Td>
			<Td width="30%" align = "center">
				<a style="text:decoration:none" href="ezPersMsgDetails.jsp?MessageID=<%=retMsgList.getFieldValueString(i,MSG_ID).trim()%>&FolderName=<%=folderName%>&msgFlag=<%=msgFlag%>">
<%
 				fName = retMsgList.getFieldValueString(i,"FIRSTNAME");
				if(fName == null || "null".equals(fName))
					fName="";

				mName = retMsgList.getFieldValueString(i,"MIDDLENAME");
				if(mName ==null || "null".equals(mName))
					mName="";

 				lName = retMsgList.getFieldValueString(i,"LASTNAME");
				if(lName==null || "null".equals(lName))
					lName="";

				userName  = fName +" "+ mName +" "+  lName;
%>

				<%=userName%>
				</a>
			</Td>
			<Td width="30%"><%=subject%></Td>
			<Td width="20%"><%=GlobObj.getFieldValue(i,MSG_CREATED_DATE)%></Td>
		</Tr>
<%
	}
%>
<input type = "hidden" name = "msgFlag" value = "<%=msgFlag%>">
</form>
</body>
</html>
