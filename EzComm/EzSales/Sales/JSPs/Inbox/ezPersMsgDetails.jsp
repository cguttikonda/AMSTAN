<%@ include file="../../../Includes/JSPs/Inbox/iGetAttachmentsList.jsp" %>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp" %>


<%@ page import="java.util.*,java.text.*" %>
<%@ page import="ezc.ezutil.FormatDate"%>
<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main">
<div class="col-main1 roundedCorners">
<div class="my-account" style="overflow:hidden">
<div class="dashboard">
<Script src="../../Library/Script/popup.js"></Script> 
<script>
function funDelete()
{
	Popup.showModal('modal1');
	setDeleteFlag();
	if(document.returnValue==true)
	{
		document.myForm.submit();
	}
}
function setActionReply() {
	
	Popup.showModal('modal1');
	document.myForm.action= "ezReplyMailMain.jsp";
	document.myForm.submit();
}
function goBack()
{
	Popup.showModal('modal1');
	document.myForm.action= "ezListPersMsgsMain.jsp";
	document.myForm.submit();	
}
</script>
<%

	// Key Variables
	/*String message=request.getParameter("message");
	String folder=request.getParameter("folder");*/
	ReturnObjFromRetrieve resDetails=null;
	ReturnObjFromRetrieve retMsgInfo = null;
	//ReturnObjFromRetrieve retFoldList = null;
	language_I = "EN";
	client_I = "200";
        ezcMessageParams_I = new EzcMessageParams();
	ezMessageParams_I = new EzMessageParams();



	     	folderID = request.getParameter("FolderID");
	     	if(folderID == null)
	     	{
	     		folderID = "1000";
	     	}

	     	String msgID = request.getParameter("MessageID");

	     	// Set the Input Parameters
	     	ezcMessageParams_I.setMsgId(msgID);
	     	ezMessageParams_I.setClient(client_I);
	     	ezMessageParams_I.setLanguage(language_I);
	     	// Set Input Parameter Object in the Container
	     	ezcMessageParams_I.setObject(ezMessageParams_I);
	     	Session.prepareParams(ezcMessageParams_I); // Preapare Parameters for Call
	     	// Get Message Details
	     	retMsgInfo = (ReturnObjFromRetrieve)Manager1.getPersonalMsgDetails(ezcMessageParams_I);
	     	retMsgInfo.check();
	     	//Get List of Folders
	     	retFoldList = (ReturnObjFromRetrieve)Manager1.getFolderList(ezcMessageParams_I);
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
               // out.println("contype::::"+contype);
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
<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<input type="hidden" name="MessageID" value=<%=msgID%>>
<input type="hidden" name="CheckBox" value=<%=msgID%>>
<input type="hidden" name="PageID" value="Details">
<input type="hidden" name="DelFlag" value="N">
<input type="hidden" name="msgType" value="<%=request.getParameter("msgType")%>">
<div class="block" style="padding-left: 0px; width:100%;">
 	<div class="block-title">
 	<strong>
 		<span>Message Details</span>
	 </strong>
	 </div>
 </div>
<div class="col1-set">
<div class="info-box"><br>
<table class="data-table" id="quickatp">
<tr>
	<th  width="21%" height="23" align="left">&nbsp;&nbsp;<B><font >From </font></B></th>
	<td  width="44%" height="23"><input type="hidden" name="fromUser" value="<%=msgFrom%>"><%=finalname%></td>
</tr>
<tr>
	<th  width="21%" height="21" ALIGN="left">&nbsp;&nbsp;<B>Subject</B></th>
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
	<th  width="21%" height="14" align="left">&nbsp;&nbsp;<B>Date</B></th>
	<td  width="44%" height="14"><%=msgDate%></td>
</tr>
</table>
</div>
</div>

<%
      	if(contype.equalsIgnoreCase("text/html"))
        {
%>

		<div class="col1-set">
		<div class="info-box"><br>
		<table class="data-table" id="quickatp">
				<Tr  valign="middle" >
		                <Td style="WORD-BREAK:BREAK-ALL"><Textarea style="overflow:auto;width:100%" tabIndex=5 name="msgText" rows=10> <%=msgContent%></Textarea>
		                 <input type=hidden name=msgText value='<%=msgContent%>'>
                </td><tr></table></div></div>
               


<%
       }
       else
       {
%>
		<div class="col1-set">
		<div class="info-box"><br>
		<table class="data-table" id="quickatp">		
				<Tr  valign="middle" >
		<Td  style="WORD-BREAK:BREAK-ALL"><%=msgContent%>
			
		</td><tr></table></div></div>
	

<%
       }
%>
	<!--<p>
			<a href="javascript:void(0)"><span>Back </span></a>
			&nbsp;&nbsp;&nbsp;<a href="javascript:setActionReply()"><span>Reply</span></a>
			&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)"><span>Delete</span></a>
			
	</p>-->
	<br>
	<div id="divAction" style="display:block">
		<button type="button" title="Back" class="button" onclick="javascript:goBack()">
		<span>Back</span></button>		

		<button type="button" title="Copy to Cart" class="button" onclick="javascript:setActionReply()">
		<span >Reply</span></button>

		<button type="button" title="Delete Template" class="button" onclick="javascript:funDelete()">
		<span>Delete</span></button>			
	</div>	
</body>
</form>
</div>
</div>
</div>
</div>
</div>


