<%@ page import="java.util.*"%>
<%@ page import = "ezc.ezparam.*,ezc.eznegotiation.params.*,ezc.eznegotiation.client.*" %>
<%
	String negReasons = "";

	EzNegotiationManager ezNegotiationManager = new EzNegotiationManager();
	EziOrderNegotiateParams ezOrderNegotiateParams = new EziOrderNegotiateParams();
	EziOrderNegotiateTable ezNegotiateTable = new EziOrderNegotiateTable();
	EziOrderNegotiateTableRow ezNegotiateTableRow = null;
	EzcParams indexMainParams = new EzcParams(false);
	try
	{
		EzcParams mainParamsNeg= new EzcParams(false);
		EziMiscParams miscParamsNeg = new EziMiscParams();

		ReturnObjFromRetrieve retIndexNo = null;		
		miscParamsNeg.setIdenKey("MISC_SELECT");
		miscParamsNeg.setQuery("SELECT MAX(EON_INDEX_NO) INDEX_NO FROM EZC_ORDER_NEGOTIATE WHERE EON_ORDER_NO = '"+weborno+"'");

		mainParamsNeg.setLocalStore("Y");
		mainParamsNeg.setObject(miscParamsNeg);
		Session.prepareParams(mainParamsNeg);	

		try
		{
			ezc.ezcommon.EzLog4j.log("miscParamsNeg.getQuery()::::::::"+miscParamsNeg.getQuery() ,"I");
			retIndexNo = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsNeg);
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}

		String indexNO = "";
		String createdOn;
		int iRowCount  = 0;
		String negStat ="";

		if("3".equals(UserType))
			negStat = "INPROCESS";
		else
			negStat = "ACCEPTED";

		if(retIndexNo != null)
			indexNO = retIndexNo.getFieldValueString(0,"INDEX_NO");

		if(indexNO == null || "null".equalsIgnoreCase(indexNO) || "".equals(indexNO))
			indexNO = "0";
		else
			indexNO = retIndexNo.getFieldValueString(0,"INDEX_NO");//String.valueOf(Integer.parseInt(indexNO) + 1)

		ezc.ezcommon.EzLog4j.log("indexNO >>>>>>>>>>>>"+indexNO,"D");
		/*java.util.GregorianCalendar gDate = new java.util.GregorianCalendar();
		ezc.ezutil.FormatDate formatDate_N = new ezc.ezutil.FormatDate();
		createdOn = formatDate_N.getStringFromDate(gDate);*/
	
		Date DateTo = new Date();
		DateFormat formatter1 = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss a");

		createdOn = formatter1.format(DateTo);

		if(createdBy == null || "null".equalsIgnoreCase(createdBy) || "".equals(createdBy))
			createdBy = (String)Session.getUserId();
		
		EzcParams orderMainParams = new EzcParams(false);

		ezOrderNegotiateParams.setType("ADD_ORDER_NEGOTIATE");
		for(int i=0;i<prodCodeLength;i++)
		{
			ezNegotiateTableRow = new EziOrderNegotiateTableRow();
			String line 	    = String.valueOf((i+1)*10);
			iRowCount           = iRowCount + 1;

			qType		= request.getParameter("qType"+line);
			qComments	= request.getParameter("QComments"+line);
			if(qComments!=null && !"null".equals(qComments) && !"".equals(qComments))
				qComments	= qComments.replaceAll("\'","`");
			
			log4j.log("qType>>>>>>>>>>>>"+qType,"D");
			log4j.log("qComments>>>>>>>>>>>>"+qComments,"D");
			
			qType		    = ((qType == null) || (("").equals(qType)))?"N/A":qType;
			qComments	    = ((qComments == null) || (("").equals(qComments)))?"N/A":qComments;	

			negReasons = negReasons+"for item"+line+":"+qComments;

			ezNegotiateTableRow.setOrderNo(weborno);
			ezNegotiateTableRow.setItemNo(line);
			ezNegotiateTableRow.setIndexNo(indexNO);
			ezNegotiateTableRow.setCreatedBy(createdBy);
			ezNegotiateTableRow.setCreatedOn(createdOn);
			ezNegotiateTableRow.setModifiedBy(Session.getUserId());
			ezNegotiateTableRow.setText(qComments);
			ezNegotiateTableRow.setStatus(negStat);
			ezNegotiateTableRow.setQuestionType(qType);
			ezNegotiateTableRow.setQuesAnsrFlag("A");

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
	catch(Exception e)
	{
		ezc.ezcommon.EzLog4j.log("Exception in  ezAddOrderNegotiate >>>>>>>>>>>>"+e,"D");
	}
	if("NEGOTIATED".equals(status))
	{
		EzcParams mainParamsSalesDoc= new EzcParams(false);
		EziMiscParams miscParamsSalesDoc = new EziMiscParams();		
		miscParamsSalesDoc.setIdenKey("MISC_UPDATE");
		miscParamsSalesDoc.setQuery("UPDATE EZC_SALES_DOC_HEADER SET ESDH_STATUS='APPROVED',ESDH_MODIFIED_ON=GETDATE(),ESDH_MODIFIED_BY='"+Session.getUserId()+"' WHERE ESDH_DOC_NUMBER = '"+weborno+"'");

		mainParamsSalesDoc.setLocalStore("Y");
		mainParamsSalesDoc.setObject(miscParamsSalesDoc);
		Session.prepareParams(mainParamsSalesDoc);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParamsSalesDoc.getQuery()::::::::"+miscParamsSalesDoc.getQuery() ,"I");
			ezMiscManager.ezUpdate(mainParamsSalesDoc);
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}
	}

	if(!("TRANSFERED").equals(status))
	{
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

		statusType = "QUERY";

		String userFName_A = (String)session.getValue("FIRSTNAME");
		String userLName_A = (String)session.getValue("LASTNAME");

		reasons = "Query has been raised by "+userFName_A+" "+userLName_A+"("+(String)Session.getUserId()+")";
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
	}

	String msg_N	 = "";
	
      	session.putValue("EzMsg",msg_N);
%>	
	
