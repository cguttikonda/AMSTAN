<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<%
	String comments		=	request.getParameter("qcfComments");
	String qcfNum 		=	request.getParameter("QcfNumber");
	String destUser		=	request.getParameter("destUser");
	String qcfType		=	request.getParameter("Type");
	String qcfInitiator	=	request.getParameter("Initiator");
	String DOCTYPE		=	request.getParameter("DOCTYPE");
	String VENDOR		= 	request.getParameter("VENDOR");
	String QRYCOUNT		= 	request.getParameter("QRYCOUNT");
	
	String queryAbout = "";
	if("PO".equals(DOCTYPE))
		queryAbout = "Purchase Order";
	else if("CON".equals(DOCTYPE))
		queryAbout = "Contract";
	else
		queryAbout = "Quotation";
	
	String destusr = "";
	
	String user = Session.getUserId();
	if(comments.indexOf("'")!=-1)
		comments = replaceString(comments,"'","`");	
		
	String commentNo = "";
	commentNo = QRYCOUNT;
	
	java.util.StringTokenizer st = new java.util.StringTokenizer(qcfInitiator,"¥");
	ezc.ezpreprocurement.params.EziQcfCommentTable eziQcfCommentTable = new ezc.ezpreprocurement.params.EziQcfCommentTable();
	ezc.ezpreprocurement.params.EziQcfCommentTableRow eziQcfCommentTablerow 	= null;		
	String sendToUser = "";
	while(st.hasMoreTokens())
	{
		destusr =  (String)st.nextToken();

		eziQcfCommentTablerow = new ezc.ezpreprocurement.params.EziQcfCommentTableRow();
		eziQcfCommentTablerow.setQcfExt1("$$");
		eziQcfCommentTablerow.setQcfExt2(DOCTYPE);
		eziQcfCommentTablerow.setQcfCode(qcfNum);
		eziQcfCommentTablerow.setCommentNo(commentNo);
		eziQcfCommentTablerow.setQcfUser(user);
		eziQcfCommentTablerow.setQcfComments(comments);
		eziQcfCommentTablerow.setQcfDestUser(destusr);
		eziQcfCommentTablerow.setQcfType(qcfType);
		eziQcfCommentTablerow.setQcfQueryMap("0");
		eziQcfCommentTable.appendRow(eziQcfCommentTablerow);

		sendToUser += ","+destusr;
	}	
	
	ezc.ezpreprocurement.client.EzPreProcurementManager qcfManager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	mainParams.setLocalStore("Y");
	mainParams.setObject(eziQcfCommentTable);
	Session.prepareParams(mainParams);
	ReturnObjFromRetrieve addRet = (ReturnObjFromRetrieve)qcfManager.addQcfComment(mainParams);


	
	String dispMessage = "";
	if(addRet == null)
	{
		dispMessage = "Problem in sending query..Please try again";	
			
	}	
	else
	{
		if(sendToUser.startsWith(","))
			sendToUser = sendToUser.substring(1);

		dispMessage = "Query sent successfully to "+sendToUser;;	
		String msgSubject ="Query about "+queryAbout+""+qcfNum+" from "+user;
		String msgText = "Dear Sir/Madam,<Br>Query : <BR>"+comments+"<Br>";
		msgText += "<BR>Please click on the below link to send the reply to the query posted<BR>";
		//String link = "http://"+request.getServerName()+"/j2ee/ezPrePostQuery.jsp";
		String link= "http://"+request.getServerName()+"/j2ee/EzCommerce/EzVendor/EzRanbaxyVendor/Offline/JSPs/ezOfflineLogin.jsp?DEFAULT_PAGE=QUERY";
		msgText += "<a href=\""+link+"\" target=\"_blank\">Click here to give the reply for query.</a>";
		msgText += "<BR>Rgds, <Br>"+user;
		String objNo = qcfNum;
		String attachString = "";
		String inboxPath = "";

%>
		<%@ include file="../Purorder/ezSendMail.jsp" %>
<%		

		try
		{
			ezc.ezworkflow.client.EzWorkFlowManager EzWorkFlow = new ezc.ezworkflow.client.EzWorkFlowManager();
			ReturnObjFromRetrieve finalRet = new ReturnObjFromRetrieve(new String[]{"PARTICIPANT","PARTICIPANT_TYPE","ROLE","STATUS","SYSKEY","DOCID","TEMPLATE","AUTHKEY","MODIFIEDBY","ACTIONCODE","DELPARTICIPANT","DELPARTICIPANTTYPE","ADDORUPDATE","PREVPARTICIPANT","PREVPARTICIPANT_TYPE","INITIATOR","WFTYPE","MAIL_EXTS","COMMENTS"});
			finalRet.setFieldValue("PARTICIPANT"		,	(String)session.getValue("USERGROUP"));
			finalRet.setFieldValue("PARTICIPANT_TYPE"	,	"G");
			finalRet.setFieldValue("ROLE"			,	(String)session.getValue("ROLE"));
			finalRet.setFieldValue("STATUS"			,	"QCF_DELETEJOB");
			finalRet.setFieldValue("SYSKEY"			,	"-");
			finalRet.setFieldValue("DOCID"			,	qcfNum);
			finalRet.setFieldValue("TEMPLATE"		,	(String)session.getValue("TEMPLATE"));
			finalRet.setFieldValue("AUTHKEY"		,	"QCF_DELETEJOB");
			finalRet.setFieldValue("MODIFIEDBY"		,	"-");
			finalRet.setFieldValue("ACTIONCODE"		,	"-");
			finalRet.setFieldValue("DELPARTICIPANT"		,	"-");
			finalRet.setFieldValue("DELPARTICIPANTTYPE"	,	"-");
			finalRet.setFieldValue("ADDORUPDATE"		,	"UPDATE");
			finalRet.setFieldValue("PREVPARTICIPANT"	,	(String)session.getValue("USERGROUP"));
			finalRet.setFieldValue("PREVPARTICIPANT_TYPE"	,	"-");
			finalRet.setFieldValue("INITIATOR"		,	"-");
			finalRet.setFieldValue("WFTYPE"			,	"-");
			finalRet.setFieldValue("MAIL_EXTS"		,	"-");
			finalRet.setFieldValue("COMMENTS"		,	"-");
			finalRet.addRow();
			EzWorkFlow.doEscalate(finalRet,mainParams);
		}catch(Exception ex)
		{
			System.out.println("While Deleting the Scheduled Job");
			ex.printStackTrace();
		}	
	}	
%>
<html>
<head>
<Script>
	
	function closeWindow()
	{
		window.opener = window.dialogArguments
		var buttDiv = opener.document.getElementById("ButtonsDiv");
		buttDiv.style.visibility='hidden'
		if("Y"=="<%=(String)session.getValue("OFFLINE")%>")
		{
			if("PO"== "<%=DOCTYPE%>")
				opener.document.myForm.action="../Purorder/ezBlockedOfflinePoLineitems.jsp?PurchaseOrder=<%=qcfNum%>&type=Amend&POORCONTRACT=<%=DOCTYPE%>&vendorNo=<%=VENDOR%>";
			else if("CON" == "<%=DOCTYPE%>")
				opener.document.myForm.action="../Rfq/ezGetOfflineAgrmtDetails.jsp?agmtNo=<%=qcfNum%>&viewType=UNREL&POORCONTRACT=CON&RQSTFROM=PORTAL";
			else 
				opener.document.myForm.action="ezOfflineQuotationComparisionForm.jsp?collectiveRFQNo=<%=qcfNum%>";
			opener.document.myForm.submit();
		}
		else
		{
			//opener.document.myForm.submit();
			//opener.location.refresh();
			opener.history.go(0)
		}	
		window.close();
	}


</Script>
<Title>Quotation Comparative Statement-- Answerthink</Title>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
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
<body>
<form name="myForm">
<DIV align="center" style="position:absolute;width:100%;top:30%">
<Table align="center" border=0 style="width:50%" borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
	<Tr>
		<Th width="30%"><%=dispMessage%></Th>
	</Tr>
</Table>
</Div>	

<DIV style="position:absolute;width:100%;top:80%">
<%  
    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
    butActions.add("closeWindow()");
    out.println(getButtons(butNames,butActions));	
%>    
</Div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>



