<%@ page import = "ezc.ezsap.*"%>
<%@ page import ="ezc.customer.invoice.params.*,ezc.ezsalesquote.params.*" %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ page import ="ezc.ezparam.*,ezc.client.*,ezc.ezbasicutil.*"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp" %>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<jsp:useBean id="SQManager" class="ezc.ezsalesquote.client.EzSalesQuoteManager"/>
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
	String webQuoteNo = request.getParameter("soNum");
	String apStatus = request.getParameter("apStatus");
	String poDate = request.getParameter("poDate");
	String carrierName = request.getParameter("shipType");
	String paymentterms = request.getParameter("selPayTerm");
	String poNo = request.getParameter("poNo");
	String reqDate = request.getParameter("reqDate");
	String soldTo = request.getParameter("soldTo");
	String shipTo = soldTo;
	String SalesAreaCode=(String)session.getValue("SalesAreaCode");
	
	String UserRole = (String)session.getValue("UserRole");
	UserRole=UserRole.trim();
	
	String freightPrice 	= request.getParameter("freightVal");
	String freightIns	= request.getParameter("freightIns");

	String[] prodCode_1 	= request.getParameterValues("matno");		
	String[] prodDesc_1 	= request.getParameterValues("prodDesc");	
	String[] prodCQty_1 	= request.getParameterValues("Reqqty");	
	String[] prodPack_1 	= request.getParameterValues("uom");
	String[] custprodCode	= request.getParameterValues("custprodCode");
	String[] prodItemCat_1 	= request.getParameterValues("ItemCat");
	String[] lineNo_1 	= request.getParameterValues("lineNo"); 
	String[] delDate_1 	= request.getParameterValues("delDate");
	String[] itemListPrice_1= request.getParameterValues("itemSAPPrice");
	
	int prodCodeLength =prodCode_1.length;  
	
	ReturnObjFromRetrieve itemoutTable 	= null;    
	ReturnObjFromRetrieve orderError=null;
	ReturnObjFromRetrieve orders =null;
	
	String msg  = null;
	String user = Session.getUserId();
	user=user.trim();
	String ErrorType 	="";
	String ErrorMessage 	="";
	boolean SAPnumber 	=true;
   	String sDocNumber 	= null;	
   	String sTempDocNumber 	= null;	

	String Div	=(String)session.getValue("division");
	String DC 	=(String)session.getValue("dc");
	String SalesOrg	=(String)session.getValue("salesOrg");
	String docType	=(String)session.getValue("docType");  
	String wfParticipant = (String)session.getValue("Participant");
	boolean Approve = true;
	
	String msgText		= "";
	String msgSubject	= "";
	String sendToUser	= "";
	
	String agent = (String)session.getValue("Agent");
	String custName_M = "";
	
	if(agent!=null && !"null".equals(agent))
		custName_M = "("+agent+")";	

	boolean appQuote = false;
	boolean createSO = false;
	boolean sendMail = false;
	
	if("AP".equals(apStatus)) appQuote = true;
	if("CRSO".equals(apStatus)) createSO = true;
	if("AP_CRSO".equals(apStatus))
	{
		appQuote = true;
		createSO = true;
	}
%>
<Html>
<Body>
<Form target=main>   
<%
	if(createSO) 
	{
		try
		{
%>		
			<%@ include file="../../../Includes/JSPs/Quotation/iCreateSOFromQT.jsp"%>        
<%	
		}
		catch(Exception e)
		{
			log4j.log("Error in iApproveCreateSOFromQT.jsp","E");  
		}
		log4j.log("SAPnumber>>>>>"+SAPnumber,"I");
		log4j.log("apStatus>>>>>"+apStatus,"I");
	}
	if(appQuote && SAPnumber)
	{
		ezc.ezworkflow.params.EziWFParams 		eziWfparams = new ezc.ezworkflow.params.EziWFParams();
		ezc.ezworkflow.params.EziWFDocHistoryParams 	eziWfDocHis = new ezc.ezworkflow.params.EziWFDocHistoryParams();

		ezc.ezparam.EzcParams ezcParams = new ezc.ezparam.EzcParams(true);

		eziWfparams.setRole((String)session.getValue("WFRole"));
		eziWfparams.setParticipant(wfParticipant);

		eziWfDocHis.setSysKey(SalesAreaCode);
		eziWfDocHis.setTemplateCode((String)session.getValue("Template"));
		eziWfDocHis.setStatus("APPROVED");
		eziWfDocHis.setAuthKey("SQ_CREATE");
		eziWfDocHis.setModifiedBy(user);
		eziWfDocHis.setCreatedBy(user);
		eziWfDocHis.setSoldTo((String)session.getValue("AgentCode"));
		eziWfDocHis.setParticipant(wfParticipant);
		eziWfDocHis.setDocId(webQuoteNo);
		eziWfDocHis.setRef2(" ");
		eziWfDocHis.setAction("100067");	//for APPROVED

		ezcParams.setObject(eziWfparams);
		ezcParams.setObject(eziWfDocHis);
		Session.prepareParams(ezcParams);

		ReturnObjFromRetrieve retSQWorkFlow = null;

		try
		{
			retSQWorkFlow = (ReturnObjFromRetrieve)EzWorkFlow.updateWFDoc(ezcParams);

			String reason = request.getParameter("reasons");
			String qcsCount = request.getParameter("qcsCount");

			//** add comments to DB **//

			if(reason!=null && !"".equals(reason) && reason.trim().length()>0)
			{
				reason = replaceString(reason,"'","`");    //reason.replace("'","`");

				ezc.ezparam.EzcParams qcfMainParams = new ezc.ezparam.EzcParams(true);
				qcfMainParams.setLocalStore("Y");
				ezc.ezsalesquote.params.EziQcfCommentParams qcfParams= new ezc.ezsalesquote.params.EziQcfCommentParams();
				qcfParams.setQcfCode(webQuoteNo);
				qcfParams.setCommentNo(qcsCount);
				qcfParams.setQcfUser(Session.getUserId());
				qcfParams.setQcfComments(reason);
				qcfParams.setQcfType("COMMENTS");
				qcfParams.setQcfDestUser(Session.getUserId());
				qcfParams.setQcfExt1("$$");
				qcfMainParams.setObject(qcfParams);
				Session.prepareParams(qcfMainParams);
				SQManager.addComment(qcfMainParams);
			}

			//** add comments to DB **//

			//** file attachment **//

			String attachString = request.getParameter("attachString");

			if(attachString != null)
			{
				if(!"".equals(attachString))
				{
					String objNo 		= webQuoteNo;
					String documentType 	= "SQ";
%>
					<%@ include file="../UploadFiles/ezSaveAttachFiles.jsp" %>
<%
				}
			}

			//** file attachment **//
		}
		catch(Exception e)
		{
			Approve = false;
		}
		if(Approve)
		{
			msg = "Sales Quote <font color=red>"+quoteNo+"</font> has been Approved<BR>";
		}
		else
		{
			msg = "Error occured while approving Sales Quote "+quoteNo+"<BR><font color=red>Please try again later</font><BR>";
		}
	}
	if(createSO && SAPnumber)
	{
		log4j.log("In update sd doc>>","I");
		EzcParams mainParams = new EzcParams(true);
		EziSalesQuoteParams sqParams= new EziSalesQuoteParams();
		EzBapisdheadStructure sdHead = new EzBapisdheadStructure();
		
		sqParams.setType("UPD_SDHEAD_SO");
		
		sdHead.setModifiedBy(user);
		sdHead.setRef1(sDocNumber);
		sdHead.setDocNumber(webQuoteNo);
		sdHead.setSalesArea(SalesAreaCode);
		
		mainParams.setLocalStore("Y");
		mainParams.setObject(sqParams);
		mainParams.setObject(sdHead);		
		Session.prepareParams(mainParams);
		
		try{
			SQManager.ezChangeSalesDoc(mainParams);
		}catch(Exception e){}
		
		msg = "Sales Order <font color=red>"+sDocNumber+"</font> is successfully created against approved Sales Quote <font color=red>"+quoteNo+"</font>";
		
	}
	if(createSO && !SAPnumber)
	{
		msg = "Problem occured while creating Sales Order<BR>"+ErrorMessage;
	
	}
	
	if(appQuote && Approve && !createSO)
	{
		msgSubject = "Sales Quotation "+quoteNo+" has been Approved";
		msgText = "Dear Concerned<br><br>Sales Quotation "+quoteNo+" has been Approved.<br>";
		msgText += "<br>Regards,<br>"+Session.getUserId()+" "+custName_M;
		
		sendMail = true;
	}
	if(createSO && SAPnumber && !appQuote)
	{
		msgSubject = "New Sales Order "+sDocNumber+" has been Created";
		msgText = "Dear Concerned<br><br>New Sales Order "+sDocNumber+" has been Created against Sales Quotation "+quoteNo+".<br>";
		msgText += "<br>Regards,<br>"+Session.getUserId()+" "+custName_M;
		
		sendMail = true;
	}
	if(appQuote && createSO && Approve && SAPnumber)
	{
		msgSubject = "Sales Quotation "+quoteNo+" has been Approved";
		msgText = "Dear Concerned<br><br>Sales Quotation "+quoteNo+" has been Approved.<br><br>New Sales Order "+sDocNumber+" is created against the quotation.<br>";
		msgText += "<br>Regards,<br>"+Session.getUserId()+" "+custName_M;
		
		sendMail = true;
	}
	
	//** email triggering **//

	if("CU".equals(UserRole))
	{
		/*java.util.ArrayList desiredStep_mail =new java.util.ArrayList();
		desiredStep_mail.add("-1");

		ezc.ezparam.EzcParams mainParams_Q = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams params_Q= new ezc.ezworkflow.params.EziWFParams();
		params_Q.setTemplate((String)session.getValue("Template"));
		params_Q.setSyskey(SalesAreaCode);
		params_Q.setParticipant(wfParticipant);
		params_Q.setDesiredSteps(desiredStep_mail);
		mainParams_Q.setObject(params_Q);
		Session.prepareParams(mainParams_Q);

		ezc.ezparam.ReturnObjFromRetrieve retsoldto_Q = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams_Q);

		if(retsoldto_Q!=null && retsoldto_Q.getRowCount()>0)
		{
			for(int l=0;l<retsoldto_Q.getRowCount();l++)
			{
				String tmpSendToUser = retsoldto_Q.getFieldValueString(l,"EU_ID");
				if(tmpSendToUser!=null && !"null".equals(tmpSendToUser)) tmpSendToUser = tmpSendToUser.trim();
				sendToUser = sendToUser + "," + tmpSendToUser;
			}
		}

		if(sendToUser.startsWith(","))
			sendToUser = sendToUser.substring(1);*/
			
		String salesRep = (String)session.getValue("SALESREPRES");

		try
		{
			StringTokenizer stEcadVal = new StringTokenizer(salesRep,"¥");

			while(stEcadVal.hasMoreTokens())
			{
				String salesRep_A = (String)stEcadVal.nextElement();
				String salesRep_AId = salesRep_A.split("¤")[0];

				sendToUser = sendToUser+","+salesRep_AId;
			}
		}
		catch(Exception e){}
	}
	
	if(sendToUser.startsWith(","))
		sendToUser = sendToUser.substring(1);

	//** email triggering **//
	
	if(sendMail)
	{
%>
		<%@ include file="../../../Sales2/JSPs/Misc/ezSendMail.jsp" %>
<%
	}
	
	session.putValue("EzMsg",msg);
%>
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
<jsp:forward page="../Misc/ezOutMsg.jsp"></jsp:forward>