<%@ page import = "ezc.ezparam.*,ezc.ezbasicutil.*,ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp" %>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp" %>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
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
	String quoteNo = request.getParameter("quoteNo");
	String soNum = request.getParameter("soNum");
	String status = request.getParameter("status");
	String salesAreaCode = (String)session.getValue("SalesAreaCode");
	String UserRole = (String)session.getValue("UserRole");
	UserRole=UserRole.trim();

	String msg = null;
	String user = Session.getUserId();
	user=user.trim();

	String msgText		= "";
	String msgSubject	= "";
	String sendToUser	= "";

	boolean Reject = true;

	if(Reject)
	{
		String wfParticipant = (String)session.getValue("Participant");

		ezc.ezworkflow.params.EziWFParams 		eziWfparams = new ezc.ezworkflow.params.EziWFParams();
		ezc.ezworkflow.params.EziWFDocHistoryParams 	eziWfDocHis = new ezc.ezworkflow.params.EziWFDocHistoryParams();

		ezc.ezparam.EzcParams ezcParams = new ezc.ezparam.EzcParams(false);

		eziWfparams.setRole((String)session.getValue("WFRole"));
		eziWfparams.setParticipant(wfParticipant);

		eziWfDocHis.setSysKey(salesAreaCode);
		eziWfDocHis.setTemplateCode((String)session.getValue("Template"));
		eziWfDocHis.setStatus(status);
		eziWfDocHis.setAuthKey("SQ_CREATE");
		eziWfDocHis.setModifiedBy(user);
		eziWfDocHis.setCreatedBy(user);
		eziWfDocHis.setSoldTo((String)session.getValue("AgentCode"));
		eziWfDocHis.setParticipant(wfParticipant);
		eziWfDocHis.setDocId(soNum);
		eziWfDocHis.setRef2(" ");
		eziWfDocHis.setAction("100068");	//for REJECTED

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
			
				msgSubject = "Sales Quotation "+quoteNo+" has been rejected";
				msgText = "Dear Concerned<br><br>Sales Quotation "+quoteNo+" has been rejected.<br>";
				msgText += "<br>Regards,<br>"+Session.getUserId();

				//** email triggering **//
%>
				<%@ include file="../../../Sales2/JSPs/Misc/ezSendMail.jsp" %>
<%				
			}
		}
		catch(Exception e)
		{
			Reject = false;
		}
	}
	
	if(Reject)
	{
		msg = "Sales Quote has been Rejected";
	}
	else
	{
		msg = "Error occured while rejecting Sales Quote<br><font color=red>Please try again later</font>";
	}
	
	session.putValue("EzMsg",msg);
%>
<jsp:forward page="../Misc/ezOutMsg.jsp"></jsp:forward>