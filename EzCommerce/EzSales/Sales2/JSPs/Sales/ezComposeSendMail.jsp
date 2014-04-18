<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%
	String to_ID = request.getParameter("toUser");
	String cc_ID = request.getParameter("ccUser");
	String msgSub = request.getParameter("msgSubject");
	String msgText = request.getParameter("msgText");

	log4j.log("::ezComposeSendMail::to_ID:------->"+to_ID,"I");
	log4j.log("::ezComposeSendMail::cc_ID:------->"+cc_ID,"I");
	log4j.log("::ezComposeSendMail::msgSub:------->"+msgSub,"I");
	log4j.log("::ezComposeSendMail::msgText:------->"+msgText,"I");

	ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();	
	mailParams.setGroupId("Ezc");
	mailParams.setTo(to_ID);
	mailParams.setCC(cc_ID);
	mailParams.setMsgText(msgText);
	mailParams.setSubject(msgSub);
	mailParams.setSendAttachments(false);
	mailParams.setContentType("text/html");
	ezc.ezmail.EzMail myMail=new ezc.ezmail.EzMail();
	boolean value=myMail.ezSend(mailParams,Session);
	log4j.log("::ezComposeSendMail::End of the ezSend mail."+value,"I");

	String noDataStatement = "Mail has been sent successfully";

	if(!value) noDataStatement = "Problem occured while sending mail<br><br>Please try again";
%>
<html>
<title>Mail sent confirmation</title>
<body oncontextmenu="return false">
<form>
<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<Div id="buttonDiv"  style="position:absolute;top:80%;width:100%">
<Table width="100%" align=center>
	<Tr>
	<Td class=blankcell align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Close");
	buttonMethod.add("window.close()");
	out.println(getButtonStr(buttonName,buttonMethod));	
%>
	</Td>
	</Tr>	
</Table>
</Div>
</form>
</body>
</html>