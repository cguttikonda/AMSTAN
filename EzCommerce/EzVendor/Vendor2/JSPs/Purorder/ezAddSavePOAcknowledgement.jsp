<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iComposePersMsg_Labels.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session" />
<%
	String msgSubject	= request.getParameter("msgSubject"); 
	String msgText		= request.getParameter("msgText");
	String sendToUser 	= request.getParameter("toUser");
	String po 		= request.getParameter("PurchaseOrder");	
	String podate 		= request.getParameter("OrderDate");	
	String status 		= request.getParameter("status");	
	String date		= (new FormatDate()).getStringFromDate(new java.util.Date(),".",FormatDate.DDMMYYYY);
	
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	mainParams.setLocalStore("Y");	    
	ezc.ezvendorapp.params.EzPOAcknowledgementTable table =  new ezc.ezvendorapp.params.EzPOAcknowledgementTable();
	ezc.ezvendorapp.params.EzPOAcknowledgementTableRow tableRow =  new ezc.ezvendorapp.params.EzPOAcknowledgementTableRow();
	tableRow.setDocNo(po);
	tableRow.setDocStatus(status);
	tableRow.setModifiedOn(date);
	tableRow.setHeaderText(msgText);
	table.appendRow(tableRow);	
	mainParams.setObject(table);	
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve ret = (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezUpdatePOAcknowledgement(mainParams);
%>
<%@include file="../Purorder/ezSendAckMail.jsp" %>
<%
	String noDataStatement = mailSentRfr_L;
%>

<Html>
<Head>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script>
	function checkDone()
	{
		location.href="../Misc/ezSBUWelcome.jsp";
	}
</Script>	
</head>
<body scroll=no>
<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Done");
	buttonMethod.add("checkDone()");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
<Div id="MenuSol"></Div>