<%@ page import="java.util.*"%>
<%@ page import = "ezc.shopping.cart.params.*,ezc.shopping.cart.client.*,ezc.shopping.cart.common.*,ezc.sales.params.*" %>
<%@ include file="../Lables/iAddModifyInfo_Lables.jsp" %>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp" %>
<%!
	public static String replaceString(String theString,String from,String to)
	{
		int go=0;
		String ret=theString;
		while (ret.indexOf(from,go)>=0)
		{
		go=ret.indexOf(from,go);
		ret=ret.substring(0,go)+to+ret.substring(go+from.length());
		go=go+to.length();
		}
		return ret;
	}
%>
<%
	if(("RETNEW").equals(status)) 
	{
%>
		<%@ include file="iEditSaveSapQuote.jsp" %>
<%
	}

	String msgText		= "";
	String msgSubject	= "";
	String sendToUser	= "";

	if(SAPnumber)
	{
		EzBapisdheadStructure ezHeader = new EzBapisdheadStructure();
		
		EzBapiiteminTable ezIteminTable = new EzBapiiteminTable();
		EzBapiiteminTableRow ezIteminRow = null;
		
		ezc.ezsalesquote.params.EziSalesQuoteParams eziSalesQuoteParams = new ezc.ezsalesquote.params.EziSalesQuoteParams();
		ezc.ezsalesquote.client.EzSalesQuoteManager ezSalesQuote = new ezc.ezsalesquote.client.EzSalesQuoteManager();		
		ezc.ezparam.EzcParams negParams = new ezc.ezparam.EzcParams(true);
		
		eziSalesQuoteParams.setType("UPD_PRICE");
		
		ezHeader.setModifiedBy(user);
		ezHeader.setPmnttrms(paymentTerm);
		ezHeader.setDocNumber(soNum);
		ezHeader.setSalesArea(salesAreaCode);
		
		String requiredPrice,listPrice;

		for(int j=0;j<prodCodeLength;j++)
		{
			ezIteminRow = new EzBapiiteminTableRow();
			
			requiredPrice	= requiredPrice_1[j];
			requiredPrice 	= ((requiredPrice == null) || (("").equals(requiredPrice)))?"0":requiredPrice;
			
			listPrice	= listPrice_1[j];
			listPrice 	= ((listPrice == null) || (("").equals(listPrice)))?"0":listPrice;
			
			ezIteminRow.setConfirmedPrice(new java.math.BigDecimal(listPrice));
			ezIteminRow.setReqPrice(new java.math.BigDecimal(requiredPrice));
			ezIteminRow.setDocNumber(soNum);
			ezIteminRow.setItmNumber(new java.math.BigInteger(soLineNo_1[j]));
			
			ezIteminTable.insertRow(j,ezIteminRow);
		}
		
		negParams.setObject(eziSalesQuoteParams);
		negParams.setObject(ezHeader);
		negParams.setObject(ezIteminTable);
		negParams.setLocalStore("Y");
		Session.prepareParams(negParams);
		
		try
		{
			ezSalesQuote.ezChangeSalesDoc(negParams);
		}
		catch(Exception e){}
		
		String wfParticipant = (String)session.getValue("Participant");

		ezc.ezworkflow.params.EziWFParams 		eziWfparams = new ezc.ezworkflow.params.EziWFParams();
		ezc.ezworkflow.params.EziWFDocHistoryParams 	eziWfDocHis = new ezc.ezworkflow.params.EziWFDocHistoryParams();

		ezc.ezparam.EzcParams ezcParams = new ezc.ezparam.EzcParams(true);

		log4j.log("WFRole>>>>"+(String)session.getValue("WFRole"),"I");
		log4j.log("wfParticipant>>"+wfParticipant,"I");
		log4j.log("salesAreaCode>>"+salesAreaCode,"I");
		log4j.log("template>>>>"+(String)session.getValue("Template"),"I");
		log4j.log("AgentCode>>>>"+(String)session.getValue("AgentCode"),"I");
		
		eziWfparams.setRole((String)session.getValue("WFRole"));
		eziWfparams.setParticipant(wfParticipant);

		eziWfDocHis.setSysKey(salesAreaCode);
		eziWfDocHis.setTemplateCode((String)session.getValue("Template"));
		eziWfDocHis.setStatus(status);
		eziWfDocHis.setAuthKey("SQ_CREATE");
		eziWfDocHis.setModifiedBy(user);
		eziWfDocHis.setCreatedBy(user);
		eziWfDocHis.setSoldTo((String)session.getValue("AgentCode"));
		
		eziWfDocHis.setDocId(soNum);
		
		eziWfDocHis.setAction("100066");	//for UPDATED

		if("RETNEW".equals(status))
		{
			eziWfDocHis.setRef1("Y#0");
		}
		eziWfDocHis.setRef2(" ");
		eziWfDocHis.setParticipant(wfParticipant);

		ezcParams.setObject(eziWfparams);
		ezcParams.setObject(eziWfDocHis);
		Session.prepareParams(ezcParams);

		ReturnObjFromRetrieve retSQWorkFlow = null;

		try
		{
			retSQWorkFlow = (ReturnObjFromRetrieve)EzWorkFlow.updateWFDoc(ezcParams);
			
			if(retSQWorkFlow!=null)
			{
				String reason = request.getParameter("reasons");
				String qcsCount = request.getParameter("qcsCount");

				//** add comments to DB **//

				if(reason!=null && !"".equals(reason) && reason.trim().length()>0)
				{
					reason = replaceString(reason,"'","`");    //reason.replace("'","`");

					ezc.ezsalesquote.client.EzSalesQuoteManager qcfManager = new ezc.ezsalesquote.client.EzSalesQuoteManager();
					ezc.ezparam.EzcParams qcfMainParams = new ezc.ezparam.EzcParams(true);
					qcfMainParams.setLocalStore("Y");
					ezc.ezsalesquote.params.EziQcfCommentParams qcfParams= new ezc.ezsalesquote.params.EziQcfCommentParams();
					qcfParams.setQcfCode(soNum);
					qcfParams.setCommentNo(qcsCount);
					qcfParams.setQcfUser(Session.getUserId());
					qcfParams.setQcfComments(reason);
					qcfParams.setQcfType("COMMENTS");
					qcfParams.setQcfDestUser(Session.getUserId());
					qcfParams.setQcfExt1("$$");
					qcfMainParams.setObject(qcfParams);
					Session.prepareParams(qcfMainParams);
					qcfManager.addComment(qcfMainParams);
				}

				//** add comments to DB **//
				
				//** email triggering **//

				if("CU".equals(UserRole))
				{
					java.util.ArrayList desiredStep_mail =new java.util.ArrayList();
					desiredStep_mail.add("-1");

					ezc.ezparam.EzcParams mainParams_Q = new ezc.ezparam.EzcParams(false);
					ezc.ezworkflow.params.EziWFParams params_Q= new ezc.ezworkflow.params.EziWFParams();
					params_Q.setTemplate((String)session.getValue("Template"));
					params_Q.setSyskey(salesAreaCode);
					params_Q.setParticipant(wfParticipant);
					params_Q.setDesiredSteps(desiredStep_mail);
					mainParams_Q.setObject(params_Q);
					Session.prepareParams(mainParams_Q);

					ezc.ezparam.ReturnObjFromRetrieve retsoldto_Q = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams_Q);

					if(retsoldto_Q!=null && retsoldto_Q.getRowCount()>0)
					{
						for(int l = 0 ;l<retsoldto_Q.getRowCount();l++)
						{
							String tmpSendToUser = retsoldto_Q.getFieldValueString(l,"EU_ID");
							if(tmpSendToUser!=null && !"null".equals(tmpSendToUser)) tmpSendToUser = tmpSendToUser.trim();
							sendToUser = sendToUser + "," + tmpSendToUser;
						}
					}

					if(sendToUser.startsWith(","))
						sendToUser = sendToUser.substring(1);
				}
				else if("CM".equals(UserRole))
				{
					sendToUser = createdBy;
				}
					
				msgSubject = "Sales Quotation "+quoteNo+" has been submitted for further processing";
				msgText = "Dear Concerned<br><br>Sales Quotation "+quoteNo+" with ref. no "+soNum+" has been submitted for further processing.<br>";
				msgText += "<br>Regards,<br>"+Session.getUserId();
				
				//** email triggering **//
%>
				<%@ include file="../../../Sales2/JSPs/Misc/ezSendMail.jsp" %>
<%
			}
		}
		catch(Exception e){}
	}

	String strCust = "";
	
	if("RETNEW".equals(status))
	{
		strCust = "to customer";
	}
	else if("SUBMITTED".equals(status))
	{
		strCust = "to CRI";
	}

	if(SAPnumber)
	{
		msg = "Sales Quote has been sent "+strCust+" for further processing";
	}
	else
	{
		msg = "Sales Quote has not been sent "+strCust+" <br><font color=red> Error:"+ ErrorMessage +"</font>";
	}
	
	session.putValue("EzMsg",msg);
%>