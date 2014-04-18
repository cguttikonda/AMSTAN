<%@ page import="java.util.*"%>
<%@ page import = "ezc.ezparam.*,ezc.eznegotiation.params.*,ezc.eznegotiation.client.*" %>
<%@ page import = "ezc.ezmisc.params.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%
 	String status 	  = request.getParameter("status"); 
 	String weborno 	  = request.getParameter("weborno");
 	String poNumber	  = request.getParameter("poNumber");
 	String itemLineNo = request.getParameter("itemLineNo");
 	String [] prdCode = request.getParameterValues("product");
 	String DocsoldToCode = request.getParameter("soldToCode");

 	String toAct 		= request.getParameter("toAct");
 	String purOfOrder 	= request.getParameter("purOfOrder");
 	String reasonCode 	= request.getParameter("reasonCode");
 	String explanation 	= request.getParameter("explanation");
 	String comments 	= request.getParameter("comments");

 	int prodCodeLength = 0;

 	if(prdCode!=null)
 		prodCodeLength = prdCode.length;

 	EzNegotiationManager ezNegotiationManager = new EzNegotiationManager();
 	EziOrderNegotiateParams ezOrderNegotiateParams = new EziOrderNegotiateParams();
 	EziOrderNegotiateTable ezNegotiateTable = new EziOrderNegotiateTable();
 	EziOrderNegotiateTableRow ezNegotiateTableRow = null;
 	EzcParams indexMainParams = new EzcParams(false);
	EzcParams mainParamsNeg= new EzcParams(false);
	EziMiscParams miscParamsNeg = new EziMiscParams();

	String negStat = "";

	try
	{
		String createdOn = "";
		int iRowCount  = 0;

		if("A".equals(status)) negStat = "FOCAPPROVED";
		else if("R".equals(status)) negStat = "FOCREJECTED";

		/*
		Date DateTo = new Date();
		DateFormat formatter1 = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss a");
		createdOn = formatter1.format(DateTo);

		EzcParams orderMainParams = new EzcParams(false);

		ezOrderNegotiateParams.setType("ADD_ORDER_NEGOTIATE");
		for(int i=0;i<prodCodeLength;i++)
		{
			ezNegotiateTableRow = new EziOrderNegotiateTableRow();
			String line 	    = String.valueOf((i+1)*10);
			iRowCount           = iRowCount + 1;

			ezNegotiateTableRow.setOrderNo(weborno);
			ezNegotiateTableRow.setItemNo(line);
			ezNegotiateTableRow.setIndexNo(toAct);			//ToAct
			ezNegotiateTableRow.setCreatedBy(Session.getUserId());
			ezNegotiateTableRow.setCreatedOn(createdOn);
			ezNegotiateTableRow.setModifiedBy(Session.getUserId());
			ezNegotiateTableRow.setText(explanation);		//Explanation
			ezNegotiateTableRow.setStatus(negStat);
			ezNegotiateTableRow.setQuestionType(reasonCode);	//Code
			ezNegotiateTableRow.setQuesAnsrFlag(purOfOrder);	//Purpose
			ezNegotiateTableRow.setExt1(comments);			//Comments

			ezNegotiateTable.insertRow((iRowCount-1),ezNegotiateTableRow);
		}

		orderMainParams.setLocalStore("Y");
		orderMainParams.setObject(ezOrderNegotiateParams);
		orderMainParams.setObject(ezNegotiateTable);
		Session.prepareParams(orderMainParams);
		ezNegotiationManager.ezAddOrderNegotiate(orderMainParams);
		*/

		miscParamsNeg.setIdenKey("MISC_UPDATE");
 		miscParamsNeg.setQuery("UPDATE EZC_ORDER_NEGOTIATE SET EON_MODIFIED_BY='"+Session.getUserId()+"', EON_STATUS='"+negStat+"', EON_MODIFIED_ON=GETDATE() WHERE EON_ORDER_NO='"+weborno+"'");
 
 		mainParamsNeg.setLocalStore("Y");
 		mainParamsNeg.setObject(miscParamsNeg);
 		Session.prepareParams(mainParamsNeg);

 		try
 		{
 			ezMiscManager.ezUpdate(mainParamsNeg);
 		}
 		catch(Exception e){}
	}
	catch(Exception e){}

 	String msg="";
 	String msgSubject="";
 	String msgText="";
 	boolean sendMail=false;

 	String sendToUser = "a@a.com";
 	String soldTo_M = (String)session.getValue("AgentCode");
 	String statMsg = "";
	/*
	HashMap soldToHash = (HashMap)session.getValue("SOLDTONAMES");
	String soldToName_N = "";
	if(soldToHash!=null && soldToHash.size()>0)
		soldToName_N = (String)soldToHash.get(DocsoldToCode);
	*/	

 	if("A".equals(status)) statMsg = "Approved";
 	else if("R".equals(status)) statMsg = "Rejected";

	String offLink = "http://"+request.getServerName()+"/AST/EzComm/EzSales/Sales/JSPs/Sales/ezOfflineLogin.jsp?webOrNo="+weborno+"&soldTo="+DocsoldToCode+"&sysKey="+(String)session.getValue("SalesAreaCode")+"&status=SUBMITTED";//negotiateType="+negStat;

	msgText ="Dear Concerned<br><br>Purchase Order with reference no: <a href='"+offLink+"'>"+poNumber+"</a> has been "+statMsg+".<br>";

	msg ="PO No: <font color=white>"+poNumber+"</font> has been "+statMsg;
	sendMail = true;

	msgSubject = "Purchase Order "+poNumber+" has been "+statMsg;
	msgText += "<br>";
	msgText += "<br>";
	msgText += "<br>Regards,<br>"+Session.getUserId();

	if(sendMail)
	{
%>
		<%//@ include file="../../../Sales/JSPs/Misc/ezSendMail.jsp"%>
<%
	}

    	session.putValue("EzMsg",msg);
	response.sendRedirect("../Sales/ezOutMsg.jsp");
%>