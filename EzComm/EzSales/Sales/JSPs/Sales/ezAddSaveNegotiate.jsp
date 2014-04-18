<%@ page import = "java.text.*,java.util.*,ezc.ezmisc.params.*" %>
<%@ page import = "ezc.ezparam.*,ezc.eznegotiation.params.*,ezc.eznegotiation.client.*" %>
<%@ include file= "../../../Includes/Lib/ezSessionBean.jsp" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session" />
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../Misc/ezDBMethods.jsp"%>
<%@ include file="../Misc/ezEncryption.jsp"%>
<%
	String negReasons = "";

 	String status 	  	= request.getParameter("status");
 	String weborno 	  	= request.getParameter("weborno");
 	String poNumber	  	= request.getParameter("poNumber"); 		 	
 	String itemLineNo 	= request.getParameter("itemLineNo");
 	String [] prdCode 	= request.getParameterValues("product");
 	String quesHash	  	= request.getParameter("quesHash");
 	String ansHash	  	= request.getParameter("ansHash");
 	String repFlag	  	= request.getParameter("repFlag");
 	String DocsoldToCode 	= request.getParameter("soldToCode");
 	String rejComments 	= request.getParameter("rejComments");
 	String toEncryp		= "";
 	String encrypText	= "";
 	String dvToAct		= request.getParameter("dvToAct");
 	String user_L 		= Session.getUserId();
 	String shipToName	= request.getParameter("shipToName");
 	String shipToState	= request.getParameter("shipToState");
 	String soldToStreet	= request.getParameter("soldToStreet");
 	String sysKey	 	= (String)session.getValue("SalesAreaCode");
 	String soldToCity	= request.getParameter("soldToCity");
	String soldToState	= request.getParameter("soldToState");
 	String soldToZipCode	= request.getParameter("soldToZipCode");
 	
 	
	String mySoldTo_A = "";

	try
	{
		DocsoldToCode = Long.parseLong(DocsoldToCode)+"";
		mySoldTo_A = "0000000000"+DocsoldToCode;
		mySoldTo_A = mySoldTo_A.substring((mySoldTo_A.length()-10),mySoldTo_A.length());
	}
	catch(Exception ex)
	{
		mySoldTo_A = DocsoldToCode;
	}	
 	
 	
 	boolean addIndex  = false;
 	String negStat="";
 	if(!"null".equals(repFlag) && !"".equals(repFlag) && "N".equals(repFlag))
 		addIndex=true;
 	int prodCodeLength = 0;
 	if(prdCode!=null)
 		prodCodeLength = prdCode.length;
 	ezc.ezcommon.EzLog4j.log("repFlag::::::::"+repFlag+"::::addIndex:::"+addIndex ,"I");
 	EzNegotiationManager ezNegotiationManager = new EzNegotiationManager();
 	EziOrderNegotiateParams ezOrderNegotiateParams = new EziOrderNegotiateParams();
 	EziOrderNegotiateTable ezNegotiateTable = new EziOrderNegotiateTable();
 	EziOrderNegotiateTableRow ezNegotiateTableRow = null;
 	EzcParams indexMainParams = new EzcParams(false);
	EzcParams mainParamsNeg= new EzcParams(false);
	EziMiscParams miscParamsNeg = new EziMiscParams();
	ezc.ezcommon.EzLog4j.log("::::::::status::::::::"+status ,"I");
 	if("F".equals(status) || "A".equals(status) || "R".equals(status))
 	{
		try
		{
			/*EziOrderNegotiateParams indexNoParams = new EziOrderNegotiateParams();
			indexNoParams.setType("GET_MAXINDEX_ORDER_NEGOTIATE");
			indexNoParams.setOrderNo(weborno);
			indexMainParams.setLocalStore("Y");
			indexMainParams.setObject(indexNoParams);
			Session.prepareParams(indexMainParams);
			ReturnObjFromRetrieve retIndexNo = (ReturnObjFromRetrieve)ezNegotiationManager.ezGetOrderNegotiate(indexMainParams);
			*/

			ReturnObjFromRetrieve retIndexNo = null;		
			miscParamsNeg.setIdenKey("MISC_SELECT");
			miscParamsNeg.setQuery("SELECT MAX(EON_INDEX_NO) INDEX_NO,EON_CREATED_BY FROM EZC_ORDER_NEGOTIATE WHERE EON_ORDER_NO = '"+weborno+"' AND EON_ITEM_NO='"+itemLineNo+"' GROUP BY EON_INDEX_NO,EON_CREATED_BY");

			mainParamsNeg.setLocalStore("Y");
			mainParamsNeg.setObject(miscParamsNeg);
			Session.prepareParams(mainParamsNeg);	

			try
			{		
				ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParamsNeg.getQuery() ,"I");
				retIndexNo = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsNeg);
			}
			catch(Exception e)
			{
				out.println("Exception in Getting Data"+e);
			}		
			String indexNO = "";
			String prevIndex = "";
			String createdOn;
			String createdBy = "";
			String ansrFlag	="A";
			int iRowCount  = 0;
			if("F".equals(status))
				negStat ="INPROCESS";
			else if("A".equals(status))	
				negStat ="ACCEPTED";
			else if("R".equals(status))
				negStat ="REJECTED";
			if("F".equals(status))ansrFlag ="Q";


			if(retIndexNo != null)
			{
				indexNO = retIndexNo.getFieldValueString(0,"INDEX_NO");
				createdBy = retIndexNo.getFieldValueString(0,"EON_CREATED_BY");
			}

			if(createdBy == null || "null".equalsIgnoreCase(createdBy) || "".equals(createdBy))
				createdBy = (String)Session.getUserId();

			if(indexNO == null || "null".equalsIgnoreCase(indexNO) || "".equals(indexNO))
				indexNO = "0";
			else if((quesHash.equals(ansHash)) && !addIndex)
				indexNO = String.valueOf(Integer.parseInt(indexNO) + 1);

			prevIndex =  String.valueOf(Integer.parseInt(indexNO) - 1);		
				ezc.ezcommon.EzLog4j.log("indexNO >>>>>>>>>>>>"+indexNO,"D");
			/*java.util.GregorianCalendar gDate = new java.util.GregorianCalendar();
			ezc.ezutil.FormatDate formatDate_N = new ezc.ezutil.FormatDate();
			createdOn = formatDate_N.getStringFromDate(gDate);*/

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

				String  qType		= request.getParameter("qType"+line);
				String  qComments	= request.getParameter("QComments"+line);
				if(qComments!=null && !"null".equals(qComments) && !"".equals(qComments))
					qComments	= qComments.replaceAll("\'","`");

				log4j.log("qType in ezAddSaveNegotiateBody.jsp>>>>>>>>>>>>"+qType,"D");
				log4j.log("qComments in ezAddSaveNegotiateBody.jsp>>>>>>>>>>>>"+qComments,"D");

				qType		    = ((qType == null) || (("").equals(qType)))?"N/A":qType;
				qComments	    = ((qComments == null) || (("").equals(qComments)))?"N/A":qComments; 			

				if("".equals(negReasons))
					negReasons = "for item"+line+":"+qComments;
				else
					negReasons = negReasons+"<br>for item"+line+":"+qComments;

				ezNegotiateTableRow.setOrderNo(weborno);
				ezNegotiateTableRow.setItemNo(line);
				ezNegotiateTableRow.setIndexNo(indexNO);
				ezNegotiateTableRow.setCreatedBy(createdBy);
				ezNegotiateTableRow.setCreatedOn(createdOn);
				ezNegotiateTableRow.setModifiedBy(Session.getUserId());
				ezNegotiateTableRow.setText(qComments);
				ezNegotiateTableRow.setStatus(negStat);
				ezNegotiateTableRow.setQuestionType(qType);
				ezNegotiateTableRow.setQuesAnsrFlag(ansrFlag);

				ezNegotiateTable.insertRow((iRowCount-1),ezNegotiateTableRow);

			}
			orderMainParams.setLocalStore("Y");
			orderMainParams.setObject(ezOrderNegotiateParams);
			orderMainParams.setObject(ezNegotiateTable);
			Session.prepareParams(orderMainParams);
			ezc.ezcommon.EzLog4j.log("BEFORE ezAddOrderNegotiate >>>>>>>>>>>>","D");
			ezNegotiationManager.ezAddOrderNegotiate(orderMainParams);
			ezc.ezcommon.EzLog4j.log("AFTER ezAddOrderNegotiate >>>>>>>>>>>>","D");
		}
 		catch(Exception e){
 			ezc.ezcommon.EzLog4j.log("Exception ezAddOrderNegotiate >>>>>>>>>>>>"+e,"D");
 		}
		
		miscParamsNeg.setIdenKey("MISC_UPDATE");
 		//miscParamsNeg.setQuery("UPDATE EZC_ORDER_NEGOTIATE SET EON_MODIFIED_BY='"+Session.getUserId()+"', EON_STATUS='ACCEPTED' WHERE EON_ORDER_NO='"+weborno+"'");
 		miscParamsNeg.setQuery("UPDATE EZC_SALES_DOC_HEADER set ESDH_MODIFIED_BY='"+Session.getUserId()+"',ESDH_MODIFIED_ON=GETDATE(),ESDH_STATUS='"+negStat+"' where ESDH_DOC_NUMBER='"+weborno+"'");
 
 		mainParamsNeg.setLocalStore("Y");
 		mainParamsNeg.setObject(miscParamsNeg);
 		Session.prepareParams(mainParamsNeg);	
 
 		try
 		{		
 			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+status ,"I");
 			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParamsNeg.getQuery() ,"I");
 			ezMiscManager.ezUpdate(mainParamsNeg);
 		}
 		catch(Exception e)
 		{
 			out.println("Exception in Getting Data"+e);
 		} 		
 		
 		
	}
	if("R".equals(status))
	{
		miscParamsNeg.setIdenKey("MISC_UPDATE");
 		miscParamsNeg.setQuery("UPDATE EZC_ORDER_NEGOTIATE SET EON_MODIFIED_BY='"+Session.getUserId()+"', EON_STATUS='REJECTED' WHERE EON_ORDER_NO='"+weborno+"'");
 
 		mainParamsNeg.setLocalStore("Y");
 		mainParamsNeg.setObject(miscParamsNeg);
 		Session.prepareParams(mainParamsNeg);	
 
 		try
 		{		
 			ezc.ezcommon.EzLog4j.log("mainParamsNeg.getQuery()::::::::"+status ,"I");
 			ezc.ezcommon.EzLog4j.log("mainParamsNeg.getQuery()::::::::"+miscParamsNeg.getQuery() ,"I");
 			ezMiscManager.ezUpdate(mainParamsNeg);
 		}
 		catch(Exception e)
 		{
 			out.println("Exception in Getting Data"+e);
 		} 

		if(rejComments!=null && !"null".equalsIgnoreCase(rejComments) && !"".equals(rejComments))
		{
			miscParamsNeg.setIdenKey("MISC_UPDATE");
			miscParamsNeg.setQuery("UPDATE EZC_SALES_DOC_HEADER SET ESDH_TEXT1='"+rejComments+"' WHERE ESDH_DOC_NUMBER='"+weborno+"'");

			mainParamsNeg.setLocalStore("Y");
			mainParamsNeg.setObject(miscParamsNeg);
			Session.prepareParams(mainParamsNeg);	

			try
			{		
				ezc.ezcommon.EzLog4j.log("mainParamsNeg.getQuery()::::::::reject comments"+miscParamsNeg.getQuery() ,"I");
				ezMiscManager.ezUpdate(mainParamsNeg);
			}
			catch(Exception e)
			{
				out.println("Exception in Getting Data"+e);
			}
		}
 	}


	EzcParams mainParamsAudit = new EzcParams(false);
	EziMiscParams miscParamsAudit = new EziMiscParams();

	ReturnObjFromRetrieve retAuditNo = null;
	miscParamsAudit.setIdenKey("MISC_SELECT");
	miscParamsAudit.setQuery("SELECT MAX(CAST (EWAT_AUDIT_NO AS INT))+1 AUDIT_NO,EWAT_DOC_ID DOC_NO FROM EZC_WF_AUDIT_TRAIL WHERE EWAT_DOC_ID in('"+weborno+"') group by EWAT_DOC_ID");

	mainParamsAudit.setLocalStore("Y");
	mainParamsAudit.setObject(miscParamsAudit);
	Session.prepareParams(mainParamsAudit);

	try
	{
		retAuditNo = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsAudit);
	}
	catch(Exception e){}

	String historyNo = "";
	String statusType = "";
	String reasons = "";

	if(retAuditNo != null)
	{
		historyNo = retAuditNo.getFieldValueString(0,"AUDIT_NO");

		if(historyNo == "null") historyNo = "1";
	}
	else
		historyNo = "1";

	statusType = "REPLY";

	if("F".equals(status)) statusType = "QUERY";

	String statType_N = "";

	if("A".equals(status)) statType_N = "order has been accepted";
	else if("R".equals(status)) statType_N = "order has been rejected";
	else if("F".equals(status)) statType_N = "Query has been raised";

	String userFName_A = (String)session.getValue("FIRSTNAME");
	String userLName_A = (String)session.getValue("LASTNAME");

	reasons = statType_N+" by "+userFName_A+" "+userLName_A+"("+(String)Session.getUserId()+")";
	reasons = reasons+"<br>"+negReasons;

	miscParamsAudit.setIdenKey("MISC_INSERT");
	miscParamsAudit.setQuery("INSERT INTO EZC_WF_AUDIT_TRAIL(EWAT_AUDIT_NO,EWAT_DOC_ID,EWAT_TYPE,EWAT_SOURCE_PARTICIPANT,EWAT_SOURCE_PARTICIPANT_TYPE,EWAT_DEST_PARTICIPANT,EWAT_DEST_PARTICIPANT_TYPE,EWAT_COMMENTS,EWAT_DATE) VALUES('"+historyNo+"','"+weborno+"','"+statusType+"','"+(String)Session.getUserId()+"','','','','"+reasons+"',GETDATE())");

	mainParamsAudit.setLocalStore("Y");
	mainParamsAudit.setObject(miscParamsAudit);
	Session.prepareParams(mainParamsAudit);

	try
	{
		ezMiscManager.ezAdd(mainParamsAudit);
	}
	catch(Exception e){}
 		
 	String custName_M="";
 	String msg="";
 	String msgSubject="";
 	String msgText="";
 	boolean sendMail=false;

 	String createdBy_M = request.getParameter("createdBy");

 	String sendToUser = createdBy_M;	//"a@a.com";
 	String soldTo_M = (String)session.getValue("AgentCode");
 	String statMsg = "";
	/*
	HashMap soldToHash = (HashMap)session.getValue("SOLDTONAMES");
	String soldToName_N = "";
	if(soldToHash!=null && soldToHash.size()>0)
		soldToName_N = (String)soldToHash.get(DocsoldToCode); 
	*/	

	Properties prop=new Properties();

	try
	{
		String fileName = "ezAddSaveNegotiate.jsp";
		String filePath = request.getRealPath(fileName);
		filePath = filePath.substring(0,filePath.indexOf(fileName));
		filePath +="ezEmailText.properties";

		prop.load(new java.io.FileInputStream(filePath));
	}
	catch(Exception e){}

	String mainURL = prop.getProperty("MAINURL");

	String offLink = "";	
 	if("A".equals(status) || "F".equals(status))
 	{
		String subBy = "sent to Customer";
		toEncryp = "EzComm/EzSales/Sales/JSPs/Sales/ezNegotiateOrderDetails.jsp?webOrNo="+weborno+"&soldTo="+DocsoldToCode+"&sysKey="+(String)session.getValue("SalesAreaCode")+"&negotiateType=INPROCESS";
		encrypText = MD5(toEncryp);
		offLink = "http://"+mainURL+"/AST/ezLinkController.jsp?link="+encrypText;

		if("CU".equals((String)session.getValue("UserRole"))) 
			subBy = "submitted to Sales Rep";
		
		if("A".equals(status)){
			//msgText ="Dear Concerned<br><br>Purchase Order submitted for review with reference no: <a href='"+offLink+"'>"+poNumber+"</a> has been accepted.<br>";
			//statMsg = "Accepted";
			msgSubject = prop.getProperty("EMAILSUB_ACCEPT");
			msgSubject = msgSubject.replaceAll("%PONumber%",poNumber);
			msgText = prop.getProperty("EMAILBODY_ACCEPT");
			msgText = msgText.replaceAll("%ConcernedUser%",createdBy_M);
			msgText = msgText.replaceAll("%MainURL%",mainURL);
			msgText = msgText.replaceAll("%OffLineURL%",offLink);

			String toEmail = getUserEmail(Session,createdBy_M);
			String ccEmail = "";
			
			sendEmail(Session,toEmail,ccEmail,msgText,msgSubject);
		}	
		else if("F".equals(status)){
			//msgText = "Dear Concerned<br><br>Purchase Order created by" +soldToName_N+ "("+soldTo_M+") has been submitted for action with reference no: <a href='"+offLink+"'>"+poNumber+"</a>.<br>";
			//statMsg = "submitted for action";
			msgSubject = prop.getProperty("EMAILSUB_Q");
			msgSubject = msgSubject.replaceAll("%PONumber%",poNumber);
			msgText = prop.getProperty("EMAILBODY_Q");
			msgText = msgText.replaceAll("%ConcernedUser%",createdBy_M);
			msgText = msgText.replaceAll("%MainURL%",mainURL);
			msgText = msgText.replaceAll("%OffLineURL%",offLink);

			String toEmail = getUserEmail(Session,createdBy_M);
			String ccEmail = "";
			
			sendEmail(Session,toEmail,ccEmail,msgText,msgSubject);
		}	

		msg ="PO No: <font color=white>"+poNumber+"</font> has been "+subBy;//.<br>To Submit it to sap please go to Saved Orders in the Orders Menu";
		sendMail = true;

		/*msgSubject = "Purchase Order "+poNumber+" has been "+statMsg;
		msgText += "<br>";
		msgText += "<br>";
		msgText += "<br>Regards,<br>"+soldToName_N+"("+Session.getUserId() +") "+custName_M;*/			 	
 	}
 	if("R".equals(status))
 	{
		String subBy = "rejected and sent to Customer";
		
		msg ="PO No: <font color=white>"+poNumber+"</font> has been "+subBy;//.<br>To Submit it to sap please go to Saved Orders in the Orders Menu";
		sendMail = true;
		toEncryp = "EzComm/EzSales/Sales/JSPs/Sales/ezNegotiateOrderDetails.jsp?webOrNo="+weborno+"&soldTo="+mySoldTo_A+"&sysKey="+sysKey+"&status="+status;
		encrypText = MD5(toEncryp);
		offLink = "http://"+mainURL+"/AST/ezLinkController.jsp?link="+encrypText;

		msgSubject = prop.getProperty("EMAILSUB_REJECT");
		msgSubject = msgSubject.replaceAll("%PONumber%",poNumber);
		msgText = prop.getProperty("EMAILBODY_REJECT");
		msgText = msgText.replaceAll("%ConcernedUser%",createdBy_M);
		msgText = msgText.replaceAll("%MainURL%",mainURL);
		msgText = msgText.replaceAll("%OffLineURL%",offLink);

		String toEmail = getUserEmail(Session,createdBy_M);
		String ccEmail = "";

		sendEmail(Session,toEmail,ccEmail,msgText,msgSubject);
 	}
	if(sendMail)
	{	
		/******************************/
		EzcParams mainParamsURL = new EzcParams(false);
		EziMiscParams miscParamsURL = new EziMiscParams();

		miscParamsURL.setIdenKey("MISC_INSERT");
		miscParamsURL.setQuery("INSERT INTO EZC_URL_MAPPING(EUM_SHORT_URL,EUM_ACTUAL_URL) VALUES('"+encrypText+"','"+toEncryp+"')");

		mainParamsURL.setLocalStore("Y");
		mainParamsURL.setObject(miscParamsURL);
		Session.prepareParams(mainParamsURL);	

		try
		{
			ezMiscManager.ezAdd(mainParamsURL);
		}
		catch(Exception e){}

		/******************************/
	}

      	session.putValue("EzMsg",msg);

	response.sendRedirect("../Sales/ezOutMsg.jsp");
%>