<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iComposePersMsg_Labels.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>
<%
	String toUser = request.getParameter("toUser");
%>

<html>
<head>
<title>Inbox: Compose Message</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>


<script LANGUAGE="JavaScript">
function clearFields()
{
	document.composeform.reset();
	return false;
}


function trim( inputStringTrim) 
{
	fixedTrim = "";
	lastCh = " ";
	for( x=0;x < inputStringTrim.length; x++)
	{
	   	ch = inputStringTrim.charAt(x);
	 	if ((ch != " ") || (lastCh != " ")) 
	 	{ 
	 		fixedTrim += ch; 
	 	}
		lastCh = ch;
	}
	if (fixedTrim.charAt(fixedTrim.length - 1) == " ") 
	{
		fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1);
	}
	return fixedTrim;
}   

function VerifyEmptyFields() 
{
	if (trim(document.forms[0].toUser.value) == "" ){
		alert('<%=plzSelValTo_A%>');
		document.returnValue = false;
		return;
	}
	else
	{	//document.forms[0].toUser.value=document.forms[0].toUser.value.toUpperCase();
		document.returnValue = true;
	}
	
	if (trim(document.forms[0].msgSubject.value) == "" )
	{
		alert('<%=subjEmpty_A%>');
		document.returnValue = false;
		document.forms[0].msgSubject.focus();
	}
	else
	{
		document.returnValue = true;
	}
	if(document.returnValue)
	{
	    <%
		if(request.getParameter("flag")==null)
		{
	    %>		
		     document.forms[0].action="ezAddSavePOAcknowledgement.jsp";
	    <%  
		}else{  
	    %> 	
	             document.forms[0].action="../Materials/ezSendRejectedMatMail.jsp";

	   <%   } %>	
	   	     setMessageVisible();	
		     document.forms[0].submit();		

	}


}

function cancelMsg() 
{
	document.forms[0].action = "../Inbox/ezListPersMsgs.jsp";
	document.returnValue = true;
}

function getAddressWindow()
{
	var url = "ezSelectUsers.jsp";
	var hWnd = 	window.open(url,"UserWindow","width=300,height=300,resizable=yes,scrollbars=yes");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;
}

</script>
</head>
<body scroll=no>
<%	
	String subject		= "";
	String display_header	= "";
	if(request.getParameter("flag")==null)
	{
		display_header = composeRejMessage_L;
	}	
	else
	{	
		display_header = resForRej_L;
		java.util.StringTokenizer stk = new java.util.StringTokenizer(request.getParameter("chk1"),"#");
		subject = "Response to Rejected Material :"+(String)stk.nextToken()+",PO No :"+(String)stk.nextToken();
	}
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>

<center>
	<font face=verdana size=1><%=selUsrToMail_L%></font></center>
	<form method="post"  name="composeform">
	<TABLE width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center" valign="middle" >
		<Th width="15%"> <a href="Javascript:getAddressWindow()"><font color='#ffffff'><%=to_L%>:</font> </a></Td>
		<Td width="85%" align="left">
			<input type="text" class=InputBox   name="toUser" size="60" maxlength="50" value="<%=toUser%>">
		</Td>
	</Tr>
	<Tr align="center" valign="middle">
		<Th width="15%"><%=subject_L%>:</Th>
		<Td width="85%">
			<div align="left">
				<input type="text" class=InputBox  name="msgSubject" size="60" maxlength="100" value="<%=subject%>">
			</div>
		</Td>
	</Tr>
	<Tr align="center" valign="middle">
		<Td width="15%" bgcolor="#FFFFF7">&nbsp;</Td>
		<Td width="85%" bgcolor="#FFFFF7">
			<div align="left">
				<textarea name="msgText" cols="60" rows="6"></textarea>
			</div>
		</Td>
	</Tr>
	</Table>



<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Back");
	buttonMethod.add("history.go(-1)");

	buttonName.add("Send");
	buttonMethod.add("VerifyEmptyFields()");

	buttonName.add("Clear");
	buttonMethod.add("clearFields()");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
<%@ include file="../Misc/AddMessage.jsp" %>
<input type="hidden" name="PurchaseOrder" value="<%=request.getParameter("PurchaseOrder")%>">
<input type="hidden" name="OrderDate" value="<%=request.getParameter("OrderDate")%>">
<input type="hidden" name="status" value="<%=request.getParameter("status")%>">

</form>
<Div id="MenuSol"></Div>
</body>
</html>
