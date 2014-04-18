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
<script>
function funDelete()
{
	setDeleteFlag();
	if(document.returnValue==true)
	{
		document.myForm.submit();
	}
}
</script>
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
	     	retMsgInfo.check();
	     	//Get List of Folders
	     	retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParams);
	     	retFoldList.check();
	     	String msgSubject = (String)retMsgInfo.getFieldValue(0, MSG_SUBJECT);

	     	if(msgSubject!=null){
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
	     	String msgDate 		= FormatDate.getStringFromDate((Date)retMsgInfo.getFieldValue(0, MSG_CREATED_DATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));	     	
	     	String msgContent 	= null;
	     	String msgCnt[]  	= new String[2];
	     	if(msgContent1 != null)
	     	{
	     	    	msgContent = msgContent1;
	     	    	try
	     	    	{
	     	    		StringTokenizer st = new StringTokenizer(msgContent,"¥");
	     	    	
	     	    		msgCnt[0]=(String)st.nextElement();
	     	    		msgCnt[1]=(String)st.nextElement();	     	    		
	     	    	}
	     	    	catch(Exception e)
	     	    	{}
	     	}
	     	else
	     	{
	     	     msgContent = "";
	     	}
                String FolderName= request.getParameter("FolderName");
                String contype=retMsgInfo.getFieldValueString(0,"EPM_LNK_EXT_INFO");
%>
<html>
<head>
        <Title>Inbox: Personal Message Details</Title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<script src = "../../Library/JavaScript/Inbox/ezPersMsgDetails.js"></script>
	<script>
	function ezHref(event)
	{
		document.location.href = event;
	}
	</script>
</head>
<body bgcolor="#FFFFF7"  scroll=no>
<form name=myForm method=post action="ezDelPersMsgs.jsp?FolderName=Inbox">
<input type="hidden" name="MessageID" value=<%=msgID%>>
<input type="hidden" name="CheckBox" value=<%=msgID%>>
<input type="hidden" name="PageID" value="Details">
<input type="hidden" name="DelFlag" value="N">
<% String display_header="Message Details"; %>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>

<table  width="95%" align=center border="1" borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0  >
<tr>
	<th  width="21%" height="23" align="left">&nbsp;&nbsp;<B><font color="#ffffff"><%= getLabel("FROM") %> </font></B></th>
	<td  width="44%" height="23"><input type="hidden" name="fromUser" value="<%=msgFrom%>"><%=finalname%></td>
</tr>
<tr>
	<th  width="21%" height="21" ALIGN="left">&nbsp;&nbsp;<B><%= getLabel("SUBJ") %></B></th>
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
	<th  width="21%" height="14" align="left">&nbsp;&nbsp;<B><%= getLabel("DAT") %></B></th>
	<td  width="44%" height="14"><%=msgDate%></td>
</tr>
</table>

<%
        if(contype.equalsIgnoreCase("text/html"))
        {
%>

		<Table  width="95%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
				<Tr  valign="middle" >
		                <Td height="40" style="WORD-BREAK:BREAK-ALL"><Textarea style="overflow:auto;width:100%" tabIndex=5 name="msgText" rows=15> <%=msgContent%></Textarea>
		                 <input type=hidden name=msgText value='<%=msgContent%>'>
                </td><tr></table>
               


<%
       }
       else
       {
%>
		<Table  width="95%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
				<Tr  valign="middle" >
		<Td  height="40" style="WORD-BREAK:BREAK-ALL"><Textarea style="overflow:auto;width:100%" tabIndex=5 name="msgText" rows=15 readonly> <%=msgContent%></Textarea>
			
		</td><tr></table>
	

<%
       }
%>


<Div id="ButtonDiv" align=left style="position:absolute;top:90%;visibility:visible;width:100%;left:40%">
<Table align="left">
<tr align="center">
<td class=blankcell align="left">
<%		
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Reply");
			buttonMethod.add("setActionNew()");
			buttonName.add("Delete");
			buttonMethod.add("funDelete()");
			out.println(getButtonStr(buttonName,buttonMethod));	
	
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
</td>
<td class=blankcell align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Move To");
	buttonMethod.add("move()");
	out.println(getButtonStr(buttonName,buttonMethod));	
%>
</td>
<td class=blankcell align="center">

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
</td>
<td class=blankcell align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Back");
	buttonMethod.add("history.go(-1)");
	out.println(getButtonStr(buttonName,buttonMethod));	
%>
       
</Td>
</Tr>
</Table>
</div>
</body>
<Div id="MenuSol"></Div>
</form>
</html>