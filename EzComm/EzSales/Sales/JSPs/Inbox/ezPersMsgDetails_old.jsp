<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInbox.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iLang_Lables.jsp" %>
<%@ include file="../../../Includes/JSPs/Inbox/iGetAttachmentsList.jsp" %>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp" %>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import="ezc.ezutil.FormatDate"%>
<%
	// Key Variables
	/*String message=request.getParameter("message");
	String folder=request.getParameter("folder");*/
	ReturnObjFromRetrieve resDetails=null;
	ReturnObjFromRetrieve retMsgInfo = null;
	ReturnObjFromRetrieve retFoldList = null;
	String language = "EN";
	String client = "200";
        EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();



	     	String folderID = request.getParameter("FolderID");
	     	if(folderID == null)
	     	{
	     		folderID = "1000";
	     	}

	     	String msgID = request.getParameter("MessageID");

	     	// Set the Input Parameters
	     	ezcMessageParams.setMsgId(msgID);
	     	ezMessageParams.setClient(client);
	     	ezMessageParams.setLanguage(language);
	     	// Set Input Parameter Object in the Container
	     	ezcMessageParams.setObject(ezMessageParams);
	     	Session.prepareParams(ezcMessageParams); // Preapare Parameters for Call
	     	// Get Message Details
	     	retMsgInfo = (ReturnObjFromRetrieve)Manager.getPersonalMsgDetails(ezcMessageParams);
		//out.println(retMsgInfo.toEzcString());
	     	retMsgInfo.check();
	     	//Get List of Folders
	     	retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParams);
	     	retFoldList.check();
	     	String msgSubject = (String)retMsgInfo.getFieldValue(0, MSG_SUBJECT);

	     	if(msgSubject!=null)
	     	{

	     	}
	     	else
	     	{
	     	      msgSubject="";
	     	}
	     	String msgFrom = retMsgInfo.getFieldValueString(0, MSG_FROM_USER);
		String firstname=retMsgInfo.getFieldValueString(0,"FIRSTNAME");
		if(firstname==null || "".equals(firstname) || "null".equals(firstname))
		firstname="";

		String middlename=retMsgInfo.getFieldValueString(0,"MIDDLENAME");
		if(middlename==null || "".equals(middlename) || "null".equals(middlename))
		middlename="";

		String lastname=retMsgInfo.getFieldValueString(0,"LASTNAME");
		if(lastname==null || "".equals(lastname) || "null".equals(lastname))
		lastname="";

		String finalname=firstname+" "+middlename+" "+lastname;

	     	String msgContent1 = retMsgInfo.getFieldValueString(0, MSG_CONTENT1);
	     	String msgContent2 = retMsgInfo.getFieldValueString(0, MSG_CONTENT2);
	     	SimpleDateFormat sdf=new SimpleDateFormat("dd.MM.yyyy");
	     	String msgDate = FormatDate.getStringFromDate((Date)retMsgInfo.getFieldValue(0, MSG_CREATED_DATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT"))) ;
	     	if(msgDate == null)
	     	{msgDate="";}
	     	String msgContent = null;
	     	if(msgContent1 != null)
	     	{
	     	    msgContent = msgContent1;
	     	    if(msgContent2 != null)
	     	    {
	     		msgContent = msgContent + msgContent2;
	     	    }//End if
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
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<script>
		var plzFolMov_L = '<%=plzFolMov_L%>'
	</script>
	<script src = "../../Library/JavaScript/Inbox/ezPersMsgDetails.js"></script>
        <script>
        	function funReply()
        	{
        		setActionNew();
        		if(document.returnValue==true)
        		{
        			setMessageVisible();
        			document.forms[0].submit();
        		}
        	}
        	function funDelete()
        	{
        		setDeleteFlag();
        		if(document.returnValue==true)
			{
				setMessageVisible();
				document.forms[0].submit();
        		}
        	}
        	function funMoveto()
        	{
        		move();
        		if(document.returnValue==true)
        		{
        			setMessageVisible();
        			document.forms[0].submit();
        		}
        	}
        	function ezHref(param)
		{
			setMessageVisible();
			document.myForm.action = param;
			document.myForm.submit();
			
		}
        </script>
        
        
<body bgcolor="#FFFFF7"  scroll=no>
<form name=myForm method=post action="ezDelPersMsgs.jsp?FolderName=Inbox">
<input type="hidden" name="MessageID" value=<%=msgID%>>
<input type="hidden" name="CheckBox" value=<%=msgID%>>
<input type="hidden" name="PageID" value="Details">
<input type="hidden" name="DelFlag" value="N">
<% String display_header =messageDet_L; %>
<!-- <Table  width=40%  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th align="center" >
			Message Details
		</Th>
	</Tr>
	</Table> -->
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<br>

<table  width="95%" align=center border="1" borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0  >
<tr>
	<th  width="21%" height="23" align="left">&nbsp;&nbsp;<B><font color="#ffffff"><%=from_L%></font></B></th>
	<td  width="44%" height="23"><input type="hidden" name="fromUser" value="<%=msgFrom%>"><%=finalname%></td>
</tr>
<tr>
	<th  width="21%" height="21" ALIGN="left">&nbsp;&nbsp;<B><%=subject_L%></B></th>
	<td  width="44%" height="21">
	<input type="hidden" name="msgSubject"  value="<%=msgSubject%>">
	<%
		if(!(msgSubject==null || "".equals(msgSubject) || "null".equals(msgSubject)))
		{
	%>
			<%=msgSubject%>&nbsp;
	<%
		}
		else
		{
	%>
			[No Subject]
	<%
		}
	%>
	</td>
</tr>
<tr>
	<th  width="21%" height="14" align="left">&nbsp;&nbsp;<B><%=date_L%></B></th>
	<td  width="44%" height="14"><%=msgDate%></td>
</tr>
</table>
<%
        if(contype.equalsIgnoreCase("text/html"))
        {
%>

		<Table  width="95%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr  valign="middle" >
                <Td height="40" ><!--<Textarea title="Type Message Text" style="overflow:auto;width:100%" tabIndex=5 name="msgText" rows=5> <%=msgContent%></Textarea>-->
                <%=msgContent%>
                </td><tr></table>


<%
       }
       else
       {
%>
		<Table  width="95%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr  valign="middle" >
<Td  height="40"><!--<Textarea title="Type Message Text" style="overflow:auto;width:100%" tabIndex=5 name="msgText" rows=5 readonly> <%=msgContent%></Textarea>-->
	<%=msgContent%>
</td><tr></table>

<%
       }
%>


<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">

	<!--<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/reply.gif" name="Submit"  title="Click here to send a Reply" value="Reply" onClick="setActionNew();return document.returnValue" border=none>
	<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/delete.gif" name="Delete"  title="Click here to delete this mail" value="Delete" onClick="setDeleteFlag();return document.returnValue" border=none> -->
	<%
			
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			
			buttonName.add("Reply");
			buttonMethod.add("funReply()");
			
			buttonName.add("Delete");
			buttonMethod.add("funDelete()");
			//out.println(getButtonStr(buttonName,buttonMethod));
	%>
<%
if ( retFoldList.find(FOLD_NAME,"Inbox") )
{
	int rowID = retFoldList.getRowId(FOLD_NAME,"Inbox");
	retFoldList.deleteRow(rowID);
} //end if
int foldRows = retFoldList.getRowCount();
String foldName = null;
if ( foldRows > 0 )
{
%>
	<!-- <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/moveto.gif" name="Move" value="Click here to move this mail to selected folder"  title="moveto" onClick="move();return document.returnValue" border=none> -->
	<%
			
			
			buttonName.add("Move To");
			buttonMethod.add("funMoveto()");
			
			//out.println(getButtonStr(buttonName,buttonMethod));
	%>
	<select name="ToFolder" >
		<option value="select">Select</option>
<%
	for ( int i = 0 ; i < foldRows ; i++ )
	{
		foldName = (String)retFoldList.getFieldValue(i,FOLD_NAME);
		if(!(foldName.equals(FolderName)))
		{
%>
		<option  value="<%=retFoldList.getFieldValue(i,FOLD_ID)%>">
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
	}//End for
%>
        </select>
<%
}
%>
       <!--<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  title="Click here to go to Previous Page"  <%=statusbar%> border=none ></a>
       <a style="text-decoration:none"  class=subclass href='ezListPersMsgs.jsp'> <img src = "../../Images/Buttons/<%= ButtonDir%>/inbox.gif"  title="Click here to go to Inbox"  <%=statusbar%>   border=none></a> -->
       <%
       		
       		
       		buttonName.add("Inbox");
       		buttonMethod.add("ezHref(\"ezListPersMsgs.jsp\")");
       		
       		//buttonName.add("Back");
       		//buttonMethod.add("history.go(-1)");
       		
       		
       		out.println(getButtonStr(buttonName,buttonMethod));
	%>
</div>
<%@ include file="../Misc/ezAddMessage.jsp" %>
</body>
</form>
<Div id="MenuSol"></Div>
</html>
