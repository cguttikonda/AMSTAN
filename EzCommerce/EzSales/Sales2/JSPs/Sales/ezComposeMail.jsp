<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInbox.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iLang_Lables.jsp" %>
<HTML>
<HEAD>
<script src="../../Library/JavaScript/Inbox/ezComposePersMsgs.js"></script>
<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>
<Title>Inbox: Compose Message</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
	function chkSubmit()
	{
		if(document.myForm.toUser.value=="")
		{
			alert("Please enter To email ID");
			document.myForm.toUser.focus();
			return;
		}
		else
		{
			document.body.style.cursor='wait'
			document.myForm.action="ezComposeSendMail.jsp";
			document.myForm.submit();
		
		}
	}
</script>
</HEAD>
<BODY scroll=no>
<FORM name=myForm method=post>
<% String display_header="Compose New Message"; %>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<%
	String webOrdNo = request.getParameter("soNum");
	if(webOrdNo==null) webOrdNo = "";
	String dispSub = "Approval for review order "+webOrdNo;
%>
<br>
<Table width="95%" align=center border="1" borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
	<Tr>
		<Th  width="15%" height="23" align="left">&nbsp;&nbsp;<b><font color="#ffffff"><%=getLabel("TO")%></font></b></Th>
		<Td  width="53%" height="23"><input type='text'  class=InputBox style="width:100%" tabindex=1  name=toUser></Td>
	</Tr>
	<Tr>
		<Th  width="15%" height="18" align="left">&nbsp;&nbsp;<b><font color="#ffffff"><%=getLabel("CC")%></font></b></Th>
		<Td  width="53%" height="18"><input type='text' class=InputBox  style="width:100%" style="width:100%" tabindex=2  name=ccUser></Td>
	</Tr>
	<!--Tr>
		<Th  width="15%" height="14" align="left">&nbsp;&nbsp;<b><font color="#ffffff"><%=getLabel("BCC")%></font></b></Th>
		<Td  width="53%" height="14"><input type='text' class=InputBox style="width:100%" tabindex=3 name=bccUser></Td>
	</Tr>-->
	<Tr>
		<Th  width="15%" height="21" ALIGN="left">&nbsp;&nbsp;<B><%=getLabel("SUBJ")%></B></Th>
		<Td  width="53%"  height="21">&nbsp;&nbsp;<b><font color="#000000"><%=dispSub%></font></b>
		<input type="hidden" value="<%=dispSub%>" name=msgSubject></Td>
	</Tr>
	<Tr>
		<Td  colspan="3" height="65">
		<Textarea title="Type Message Text" style="overflow:auto;width:100%" tabIndex=3 name="msgText" rows=10></Textarea>
		</Td>
	</Tr>
</Table>
<Table width="100%" align=center>
	<Tr>
	<Td class=blankcell align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Send");
	buttonMethod.add("chkSubmit()");
	buttonName.add("Close");
	buttonMethod.add("window.close()");
	out.println(getButtonStr(buttonName,buttonMethod));	
%>
	</Td>
	</Tr>	
</Table>
<br>
<input type=hidden name="attachflag" value="">
<input type="hidden" name="attachString" value="">
</FORM>
<Div id="MenuSol"></Div>
</BODY>
</HTML>
