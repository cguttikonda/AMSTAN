<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ page import="java.util.*" %>
<%
	ReturnObjFromRetrieve resDetails=null;
	ReturnObjFromRetrieve retMsgInfo = null;
	ReturnObjFromRetrieve retFoldList = null;

	String language = "EN";
	String client = "200";
        EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();
	String msgFlag = request.getParameter("msgFlag");
     	String folderID = request.getParameter("FolderID");
     	if(folderID == null)
     		folderID = "1000";
     	String msgID = request.getParameter("MessageID");

	ezcMessageParams.setMsgId(msgID);
	ezMessageParams.setClient(client);
	ezMessageParams.setLanguage(language);
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams);
	retMsgInfo = (ReturnObjFromRetrieve)Manager.getPersonalMsgDetails(ezcMessageParams);
	retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParams);
	String msgSubject = (String)retMsgInfo.getFieldValue(0, MSG_SUBJECT);
	String msgFrom = (String)retMsgInfo.getFieldValue(0, MSG_FROM_USER);
	String fName = (String)retMsgInfo.getFieldValue(0, "FIRSTNAME");
	String mName = (String)retMsgInfo.getFieldValue(0, "MIDDLENAME");
	String lName = (String)retMsgInfo.getFieldValue(0, "LASTNAME");
	
	if(fName == null || "null".equals(fName))
		fName="";
	if(mName == null || "null".equals(mName))
		mName="";
	if(lName == null || "null".equals(lName))
		lName="";
		
	String fromUserName = fName +" "+mName+" "+lName;	
	String msgContent1 = (String)retMsgInfo.getFieldValue(0, MSG_CONTENT1);
	String msgContent2 = (String)retMsgInfo.getFieldValue(0, MSG_CONTENT2);
	
	global.setDateFormat("MM/dd/yyyy HH:mm:ss");
	java.util.Vector types = new java.util.Vector();
	types.addElement("date");
	global.setColTypes(types);
	
	java.util.Vector names = new java.util.Vector();
	names.addElement(MSG_CREATED_DATE);
	global.setColNames(names);
		
	ReturnObjFromRetrieve GlobObj = (ReturnObjFromRetrieve)global.getGlobal(retMsgInfo);	
	String msgDate = GlobObj.getFieldValueString(0,MSG_CREATED_DATE);


	String msgContent = null;
	if(msgContent1 != null)
	{
	    	msgContent = msgContent1;
	    	if(msgContent2 != null)
	    	{
			msgContent = msgContent + msgContent2;
	    	}
	}
	else
	{
	     	msgContent = " ";
	}
	String FolderName= request.getParameter("FolderName");
	String contype=retMsgInfo.getFieldValueString(0,"EPM_LNK_EXT_INFO");
%>
<html>
<head>
<Title>Inbox: Personal Message Details</Title>
<script src = "../../Library/JavaScript/Inbox/ezPersMsgDetails.js"></script>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
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
			<Td class=blankcell background="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif"><a  href="ezComposePersMsg.jsp"  title="Composing of Messages" style="text-decoration:none">Compose</a></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back_right.gif" width=15  border=0></Td>
			<Td class=blankcell width=10><IMG height=27 src="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_back2_left.gif" width=15 border=0></Td>
			<Td class=blankcell background="../../Images/Buttons/<%=ButtonDir%>/TabsImages/tab_fill_back.gif"><a href="ezListFolders.jsp" title="Folders List"  style="text-decoration:none">Folders</a></Td>
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
        		<input type="hidden" name="fromUser" value="<%=msgFrom%>"><%=fromUserName%>
	      	</Td>
	</Tr>
	<Tr align="center" valign="middle">
    	  	<Td width="20%" class="labelcell" align = right> Subject: </Td>
		<Td width="80%" align="left">
			<input type="hidden" name="msgSubject"  value="<%=msgSubject%>">
<%
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
      	        <Td width="80%" align="left"><%=msgDate%></Td>
	</tr>
</table>
</div>
<DIV id="InnerBox1Div">
<Table  id="InnerBox1Tab" width="89%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=0 cellSpacing=0 >
<%
        if(contype.equalsIgnoreCase("text/html"))
        {
%>
		<Tr  valign="middle" >
			<Td class=blankcell height=100%>
	       	            <%=msgContent%>
	            	</td>
		<tr>
<%
       }
       else
       {
%>
		<Tr  valign="middle" >
		<Td class=blankcell height=100%>
	       	            <textarea name="mess" rows="7" readonly Style = "width:100%;overflow:auto" class = txarea><%=msgContent%></textarea>
            	</td>
            	<tr>
<%
       }
%>
</table>
</Div>
	    	<input type="hidden" name="MessageID" value=<%=msgID%>>
	    	<input type="hidden" name="CheckBox" value=<%=msgID%>>
	    	<input type="hidden" name="PageID" value="Details">
	    	<input type="hidden" name="DelFlag" value="N">
     		<div  id="ButtonDiv" align="center" style="position:absolute;top:80%;width:100%;"><br>
			<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/reply.gif" name="Submit" value="Reply" onClick="setActionNew();return document.returnValue">
			<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/delete.gif" name="Delete" value="Delete" onClick="setDeleteFlag();return document.returnValue">
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
			<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/moveto.gif" name="Move" value="Move To" onClick="return move()">
   			<select name="ToFolder" >
				<option value="select">--Select Folder--</option>
<%
				for ( int i = 0 ; i < foldRows ; i++ )
				{
					foldName = (String)retFoldList.getFieldValue(i,FOLD_NAME);
					if(!(foldName.equals(FolderName)))
					{
%>
					    	<option value="<%=retFoldList.getFieldValue(i,FOLD_ID)%>">
<%
						if (foldName != null)
						{
%>
							<%= foldName%>
<%
						}
%>
		 	           	</option>
<%			 
					}
				}
%>
		        </select>
<%
		}
%>
        <a href="ezListPersMsgs.jsp?msgFlag=<%=msgFlag%>"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a></div>
<!--	<img src = "../../Images/Buttons/<%= ButtonDir%>/expirydate.gif" name="Button" style = "cursor:hand"  value="Expiry Date" onClick="setExpDateWindow(<%=msgID%>)">-->
<input type = "hidden" name=msgFlag value="<%=msgFlag%>" >

</form>
</body>
</html>
