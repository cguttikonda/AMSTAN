<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iCheckTimes.jsp" %>
<%
	boolean errRelRfq = false;
	String errMsg = "Error in releasing RFQ(s) in SAP <Br>";

%>
<%@ include file="../../../Includes/Jsps/Rfq/iReleaseRFQ.jsp" %>
<%
	String Offline  	=(String) session.getValue("OFFLINE");
	String PAGE = request.getParameter("PAGE");
	String display_header = "";
	if(errRelRfq)
	{
%>
		<Html>
		<Head>
		<Script>
			function back()
			{
				document.myForm.action = "../Misc/ezSBUWelcome.jsp";			
				document.myForm.submit(); 
			}
		</Script>
		</Head>
		<Body>
		<Form name="myForm">
<%		
	if(!"Y".equals(Offline))
	{
%>	
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
	}
%>		
		<Br><Br><Br>
			<Table width="50%" align="center" border=0>
			<Tr align="center">
				<Th><%=errMsg%></Th>
			</Tr>
			</Table>
			<Br><Br>
		<Center>
<%
	 butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
	 butActions.add("back()");
    	 out.println(getButtons(butNames,butActions));
%>
</Center>
</Form>
<Div id="MenuSol"></Div>
<%
		return;
	}
%>
<%@ include file="../../../Includes/Jsps/Rfq/iProposeRFQ.jsp" %>
<%
	
	java.text.SimpleDateFormat sdf 	= new java.text.SimpleDateFormat("dd.MM.yyyy hh:mm:ss");
	String sysKey		=	(String)session.getValue("SYSKEY");
	String comments		=	request.getParameter("qcfComments");
	String user		=	Session.getUserId();
	String qcfNum 		=	request.getParameter("QcfNumber");
	String type 		=	request.getParameter("Type");
	String isDelegate 	=	request.getParameter("isdelegate");
	String isByPass 	=	request.getParameter("byPassAllow");
	String byPassCount 	=	request.getParameter("hideBypassCount");
	String attachString 	=	"";
	if(request.getParameter("attachString") != null)
		attachString 	=	request.getParameter("attachString");
	String attachflag 	=	request.getParameter("attachflag");
	String qcsCommentNo	=	request.getParameter("qcsCommentNo");
	String wfType = "-";
	
	String message = "";
	
	if(comments != null && comments.indexOf("'")!=-1)
		comments = replaceString(comments,"'","`");
	
	
	
	if(isByPass != null && "Y".equals(isByPass))
	{
		isByPass = "Y";
		wfType = "BYPASS";
		message = "QCF has been Bypassed by ";
	}
	else
	{
		isByPass = "N";
		byPassCount = "";
		
		if(!"NO".equals(isDelegate))
		{
			wfType = "DELEGATE";
			message = "QCF has been delegated by ";
		}
	}
%>

<%@ include file="../../../Includes/JSPs/Rfq/iUpdateQCFStatus.jsp" %>
<html>
<head>
<title></title>
<script>
function reLoad(action)
{
	if(action == 'Y')
	{
		if('<%=PAGE%>' != 'NEW')
		{
			document.myForm.Type.value='N'
			if('<%=PAGE%>' == 'OFFLINE')
				document.myForm.action="ezOfflineWFListQcfs.jsp";
			if('<%=PAGE%>' == 'ACT')
				document.myForm.action="ezWFListQcfs.jsp";
		}
		else
		{
			document.myForm.action="ezListQCS.jsp";
		}
		document.myForm.submit();
		
		
		
	}	
	else
	{
		setTimeout("reLoad('Y')",1000);
	}
		
}
</script>
<script language="Javascript1.2">
	am = "This function is disabled!";
	bV  = parseInt(navigator.appVersion)
	bNS = navigator.appName=="Netscape"
	bIE = navigator.appName=="Microsoft Internet Explorer"
	function nrc(e) 
	{
	  if (bNS && e.which > 1)
	  {
	     alert(am)
	     return false
	  } 
	  else if (bIE && (event.button >1)) 
	  {
	    alert(am)
	    return false;
	  }
	}
	document.onmousedown = nrc;
	if (document.layers) window.captureEvents(Event.MOUSEDOWN);
	if (bNS && bV<5) window.onmousedown = nrc;
</script>

</head>
<%
	String objNo 		= qcfNum;
	String documentType 	= "QCF";
%>
<%@ include file="../Purorder/ezSendMail.jsp" %>
<%@ include file="../UploadFiles/ezSaveAttachFiles.jsp" %>
<body onLoad="reLoad('N')">
<form name="myForm">
<%
	if(!"Y".equals(Offline))
	{
%>	
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
	}
%>
<input type=hidden name=status value='CR'>
<input type=hidden name=EDIT >
<input type=hidden name=Type>
<Div style="position:absolute;top:30%;width:100%;">
<TABLE width="50%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
  <Tr align="center" valign="middle">
    <Th><BR>&nbsp;<BR><%=dispMessage%><BR>&nbsp;<BR>&nbsp;</Th>
  </Tr>
</Table>
</Div>
<Div style="position:absolute;top:90%;width:100%;align:center;visibility:hidden">
<%
	        butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ok &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
	        butActions.add("reLoad('"+action+"')");
	        out.println(getButtons(butNames,butActions));
%>       
</Div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

</form>
</body>
</html>
