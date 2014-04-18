<%@ page import ="java.util.*,ezc.ezutil.*,ezc.ezpreprocurement.params.*,ezc.ezparam.*" %>
<%@ include file="../Misc/iCheckQuery.jsp" %>
<%!
	public String ezCheckForNull(String str,String defStr)
	{
		if((str==null) || ("null".equals(str)) || ((str.trim()).length() == 0) || ("0".equals(str)))
			str = defStr;
		return str.trim();
	}
%>
<%

	String type 		= request.getParameter("Type");
	String PAGE		= request.getParameter("PAGE");
	java.util.Hashtable propPrices = new java.util.Hashtable();
	String disableByUsrRole="";
	boolean globalDisFlg=false;


	String scrollInit = "";
	String loginType = (String)session.getValue("OFFLINE");
	String qcfHeight = "45%";
	if(loginType != null && "Y".equals(loginType))
	{
		scrollInit="10";
		qcfHeight = "65%";
	}	
	else
	{
		scrollInit="100";
		qcfHeight = "45%";
	}	
	for(int cnt=myRetCnt-1;cnt>=0;cnt--)
	{
		if("N".equals(myRet.getFieldValueString(cnt,"STATUS")))
		{
			myRet.deleteRow(cnt);
		}
	}
	myRetCnt = myRet.getRowCount();
	if("RFQLINK".equals(type))
	{
		for(int cnt=myRetCnt-1;cnt>=0;cnt--)
		{
			if("N".equals(myRet.getFieldValueString(cnt,"RELEASE_INDICATOR")))
			{
				myRet.deleteRow(cnt);
			}
		}
	}	
	
	ezc.ezparam.ReturnObjFromRetrieve rankRetObj = new ezc.ezparam.ReturnObjFromRetrieve();
	String[] rankHeads = {"RANK1","VENDOR","EFFWR"};
	rankRetObj.addColumns(rankHeads);
	
	String userRole = (String)session.getValue("USERROLE");
	String userDefRole = (String)session.getValue("ROLE");
	String userGroup = (String)session.getValue("USERGROUP");
	boolean allowPropose = false;
	boolean showRequote = false;
	boolean showStatus = true;
	
	if(userRole.equals("SP") || userRole.equals("MG") || "SM".equals(userRole))
	{
		allowPropose = true;
		showRequote = true;
	}	
		
		
	
/*** Variables **/
	
	String qcfNetPrice 		= "";
	String commentNo  		= "";
	String sysKey			= (String)session.getValue("SYSKEY");
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	
	
	String isdelegate 	= request.getParameter("isdelegate");
	String offlineQCF	=	"";
	if(session.getValue("OFFLINE") != null)
		offlineQCF	= (String)session.getValue("OFFLINE");	
		
	if(request.getParameterValues("chk1") != null)
	{
		String[] rfqs = request.getParameterValues("chk1");
		rfqVector.clear();
		for(int i=0;i<rfqs.length;i++)
		{
			rfqVector.addElement(rfqs[i]);
		}
	}
	else
	{
		/*int rfqcnt =0;
		rfqVector.clear();
		for(int cnt=0;cnt<myRetCnt;cnt++)		
		{
			if("N".equals((myRet.getFieldValueString(cnt,"RELEASE_INDICATOR")).trim()))
			{
				rfqVector.addElement(myRet.getFieldValueString(cnt,"RFQ_NO"));
				rfqcnt++;				
			}else if("R".equals((myRet.getFieldValueString(cnt,"RELEASE_INDICATOR")).trim())){
				rfqVector.addElement(myRet.getFieldValueString(cnt,"RFQ_NO"));
				rfqcnt++;
			}
				
		}*/
	}
	
/** End **/

	ezc.ezpreprocurement.client.EzPreProcurementManager ezpreprocurementmanager  = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	EzcParams 		ezparams	= new ezc.ezparam.EzcParams(false);
	EziPreProcurementParams params		= new ezc.ezpreprocurement.params.EziPreProcurementParams();
	EziPOItemTable		itemTable	= new EziPOItemTable();	
	EziPOItemTableRow 	itemRow		= null;

	params.setCollRfqNo(collNo);
	
	int rfqVectorLength = rfqVector.size();
	
	for(int i=0;i<rfqVectorLength;i++)
	{
		itemRow     =  new EziPOItemTableRow();
		itemRow.setExt1((String)rfqVector.get(i));
		itemTable.appendRow(itemRow);
		
	}	
	
	ezparams.setObject(params);
	ezparams.setObject(itemTable);
	Session.prepareParams(ezparams);
	ReturnObjFromRetrieve finalRet = (ezc.ezparam.ReturnObjFromRetrieve)ezpreprocurementmanager.ezQuoteComparisionForm(ezparams);
  ReturnObjFromRetrieve qcfRet   = new ReturnObjFromRetrieve();
  ReturnObjFromRetrieve reportRet= new ReturnObjFromRetrieve();
  
  
  if(finalRet!=null&&finalRet.getRowCount()>0){
    qcfRet=(ReturnObjFromRetrieve)finalRet.getFieldValue(0,"QCFRECRET");
    reportRet=(ReturnObjFromRetrieve)finalRet.getFieldValue(0,"REPORTRET");
    
  } 
  
	
	int lastPODtlCount=0;
  String lastPOCurr="";
  double lastPOPrice=0;
  String myMatNo=matNumber;
  myMatNo="000000000000000000"+myMatNo;
  EzcParams ezContainer	= new EzcParams(false);
  EziPOItemTable rfqItemTab = new EziPOItemTable();
  EziPOItemTableRow rfqItemTabRow = new EziPOItemTableRow();
  rfqItemTabRow.setMaterial(myMatNo.substring(myMatNo.length()-18,myMatNo.length()));
  rfqItemTab.appendRow(rfqItemTabRow);
  ezContainer.setObject(rfqItemTab);
  Session.prepareParams(ezContainer);
  ReturnObjFromRetrieve lastPODtl = (ReturnObjFromRetrieve)ezpreprocurementmanager.ezGetLastPODetails(ezContainer);
  if(lastPODtl!=null){
      lastPODtlCount=lastPODtl.getRowCount();
      if(lastPODtlCount>0){
        lastPOCurr=lastPODtl.getFieldValueString(0,"CURRENCY");  
        try{
          lastPOPrice=Double.parseDouble(lastPODtl.getFieldValueString(0,"NET_PRICE"));
        }catch(Exception err){lastPOPrice=0;}
      }  
  }   
  
  
	
	
	java.util.Vector quotedVend=new java.util.Vector();
	for(int k=0;k<myRetCnt;k++)
	{
		if("Y".equalsIgnoreCase((myRet.getFieldValueString(k,"STATUS")).trim())){
			quotedVend.add((myRet.getFieldValueString(k,"RFQ_NO")).trim());
		}
	}
	int qcfCount = 0;
	if(qcfRet !=null)
		qcfCount = qcfRet.getRowCount();
	
	for(int k=qcfCount-1;k>=0;k--)	
	{
		if("".equals(qcfRet.getFieldValueString(k,"EBELN").trim()))
		{
			qcfRet.deleteRow(k);
		}
	}
	if(qcfRet !=null)
		qcfCount = qcfRet.getRowCount();
		
	//qcfRet.sort(new String[]{"RANK1"},true);
	
	java.math.BigDecimal propsdValue = new java.math.BigDecimal(0.0) ;
	double propsdQty=0.0;
	String propsdUOM="";
	String myQCFAlertMsg="";
	boolean alertTypeOne=false;
	boolean alertTypeTwo=false;
	for(int i=0;i<qcfCount;i++)
	{
		for(int k=0;k<myRetCnt;k++)
		{
			String chkPropose = myRet.getFieldValueString(k,"VEND_TYPE");
			
			
			
			int 	myTempRFQRank	= 0;
			double  myTempRFQPrice	= 0;
			String 	myTempRFQCurr	=""; 
			String myTempRFQUOM	=""; 
				
			
			if((myRet.getFieldValueString(k,"RFQ_NO").trim().equals(qcfRet.getFieldValueString(i,"EBELN").trim())) && ("R".equals(myRet.getFieldValueString(k,"RELEASE_INDICATOR").trim())))
			{
				rankRetObj.setFieldValue("RANK1",qcfRet.getFieldValueString(i,"RANK3"));
				rankRetObj.setFieldValue("VENDOR",myRet.getFieldValueString(k,"VENDOR"));
				rankRetObj.setFieldValue("EFFWR",qcfRet.getFieldValueString(i,"EFFWR"));
				propPrices.put(myRet.getFieldValueString(k,"RFQ_NO"),qcfRet.getFieldValueString(i,"EFFWR"));
				rankRetObj.addRow();
				propsdValue = propsdValue.add(new java.math.BigDecimal(qcfRet.getFieldValueString(i,"EFFWR")));
				propsdQty +=(new Double(qcfRet.getFieldValueString(i,"KTMNG"))).doubleValue();
				if("".equals(propsdUOM)){
				  propsdUOM=qcfRet.getFieldValueString(i,"MEINS");
				}else if(!propsdUOM.equalsIgnoreCase(qcfRet.getFieldValueString(i,"MEINS"))){
				  propsdUOM="MLUOM";
				}
				
				myTempRFQCurr = qcfRet.getFieldValueString(i,"WAERS");
				myTempRFQUOM  = qcfRet.getFieldValueString(i,"BPRME");
				try{
					myTempRFQRank=Integer.parseInt(qcfRet.getFieldValueString(i,"RANK3"));
				}catch(Exception err){
					myTempRFQRank=0;
				}try{
					myTempRFQPrice=Double.parseDouble(qcfRet.getFieldValueString(i,"NETPR_ORG"));
				}catch(Exception err){
					myTempRFQPrice=0;
				}
				
				if(lastPODtlCount>0 && myTempRFQCurr.equals(lastPOCurr) && myTempRFQPrice>lastPOPrice){
					alertTypeTwo=true;
				}
				if(myTempRFQRank>1 ){
					alertTypeOne=true;
					
					
				}	
				
				
				
				
				
				
				
				
          
        
			}	
		}
	}
	
	
		
	if(alertTypeOne){
		myQCFAlertMsg="<font color='#FF0000'><b>Vendor L1 is not recommended</font>";
	}else if(alertTypeTwo && alertTypeOne){
		myQCFAlertMsg="<font color='#FF0000'><b>Vendor L1 is not recommended <br> Recommended vendor price(s)  higher than last Purchase price</font>";
	}else if(alertTypeTwo){
		myQCFAlertMsg="<font color='#FF0000'><b>Recommended vendor price(s)  higher than last Purchase price</font>";
	}
	
	
	rankRetObj.sort(new String[]{"RANK1"},true);
	int rowCount = rankRetObj.getRowCount();
	qcfNetPrice = rankRetObj.getFieldValueString(rowCount-1,"EFFWR");
	qcfNetPrice = myFormat.getCurrencyString(qcfNetPrice)+"";
	while(qcfNetPrice.indexOf(",") != -1)
	{
		java.lang.StringBuffer sbuff = new java.lang.StringBuffer(qcfNetPrice);
		sbuff.replace(qcfNetPrice.indexOf(","),qcfNetPrice.indexOf(",")+1,"");
		qcfNetPrice = sbuff.substring(0);
	}
/** For Comments **/	

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziQcfCommentParams qcfParams= new ezc.ezpreprocurement.params.EziQcfCommentParams();
	qcfParams.setQcfCode(collNo);
	qcfParams.setQcfType("COMMENTS");
	qcfParams.setQcfExt1("$$");
	mainParams.setLocalStore("Y");
	mainParams.setObject(qcfParams);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve commentsRet = (ezc.ezparam.ReturnObjFromRetrieve)ezpreprocurementmanager.getMaxCommentNo(mainParams);
	
	if(commentsRet!= null || !"null".equals(commentsRet))
	{
		commentNo = commentsRet.getFieldValueString(0,"COMMENT_NO");
		if(commentNo == "null" || "null".equals(commentNo))
			commentNo = "1";
	}		
	else
		commentNo = "1";
	System.out.println("==================================123456789");
	commentsRet = (ezc.ezparam.ReturnObjFromRetrieve)ezpreprocurementmanager.getQcfCommentList(mainParams);
	System.out.println("==================================987654321");
	int qcsCount = 0;
	if(commentsRet != null)
	{
		qcsCount = commentsRet.getRowCount();
	}
/** End Comments **/

/** For Work Flow Action List **/
	java.util.Hashtable  purGroupsHash	= (java.util.Hashtable)session.getValue("PURGROUPS");
	String currentPurchaseGroup =  (String)purGroupsHash.get(sysKey);
	ezc.ezworkflow.client.EzWorkFlowManager ezWorkFlowManager = new ezc.ezworkflow.client.EzWorkFlowManager();
	ezc.ezworkflow.params.EziActionsParams  wfp = new ezc.ezworkflow.params.EziActionsParams();
	ezc.ezparam.EzcParams wfMainP = new ezc.ezparam.EzcParams(false);
	wfp.setFlag("Y");
	wfp.setRole((String)session.getValue("ROLE"));
	wfp.setAuthKey("QCF_RELEASE");
	wfp.setUserId(Session.getUserId());
	wfp.setPurchaseGroup(currentPurchaseGroup);
	wfp.setValue(propsdValue.toString());
	wfMainP.setObject(wfp);
	Session.prepareParams(wfMainP);
	ezc.ezparam.ReturnObjFromRetrieve wfr=(ezc.ezparam.ReturnObjFromRetrieve)ezWorkFlowManager.getActionsList(wfMainP);
	String actionsList = "";
	if(wfr!=null)
	{
		actionsList = wfr.getFieldValueString(0,"ACTIONS");	
	}	
	
	System.out.println("actionsListactionsListactionsListactionsList:::"+actionsList);
/** End Work Flow Action List **/
/** For Work Flow Doc Details **/

	ezc.ezparam.EzcParams wfMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams wfParams= new ezc.ezworkflow.params.EziWFDocHistoryParams();
	wfParams.setAuthKey("QCF_RELEASE");
	wfParams.setSysKey(sysKey);
	wfParams.setDocId(collNo);
	wfParams.setSoldTo("0");
	wfMainParams.setObject(wfParams);
	Session.prepareParams(wfMainParams);
	ezc.ezparam.ReturnObjFromRetrieve wfDetailsRet=(ezc.ezparam.ReturnObjFromRetrieve)ezWorkFlowManager.getWFDocDetails(wfMainParams);	
	int wfDetailCount = 0;
	String initiator = "";
	if(wfDetailsRet!= null)
	{
		wfDetailCount = wfDetailsRet.getRowCount();
		if(wfDetailCount > 0)
		{
			initiator 	= wfDetailsRet.getFieldValueString(0,"INITIATOR");
			
		}	
	}
	String wfStatus		= wfDetailsRet.getFieldValueString(wfDetailsRet.getRowCount()-1,"STATUS");
	String actionCheck 	= wfDetailsRet.getFieldValueString(wfDetailsRet.getRowCount()-1,"ACTION");
	String nextParticipant	= wfDetailsRet.getFieldValueString(wfDetailsRet.getRowCount()-1,"NEXTPARTICIPANT");
	String lastModifiedDate = wfDetailsRet.getFieldValueString(wfDetailsRet.getRowCount()-1,"ACTIONON");
	
/** End Work Flow Doc Details **/	
/** For knowing, Is there any attachments for a Collective RFQ Number? **/
	
	ezc.ezparam.ReturnObjFromRetrieve   retUploadDocs = null;
	ezc.ezupload.client.EzUploadManager uploadManager = new ezc.ezupload.client.EzUploadManager();
	ezc.ezparam.EzcParams 		    myParams	  = new ezc.ezparam.EzcParams(true);
	ezc.ezupload.params.EziUploadDocsParams uDocsParams = new ezc.ezupload.params.EziUploadDocsParams();
	uDocsParams.setObjectNo("'"+(String)session.getValue("SYSKEY")+"QCF"+collNo+"'");
	myParams.setObject(uDocsParams);
	Session.prepareParams(myParams);
	try
	{
		retUploadDocs = (ezc.ezparam.ReturnObjFromRetrieve)uploadManager.getUploadedDocs(myParams);
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured while getting Upload docs:"+e);	
	}
	int noOfDocs = 0;
	if(retUploadDocs!= null)
	{
		noOfDocs = retUploadDocs.getRowCount();
	}
	
/** End Upload **/	 




/** For QUERY **/	
	String userId = Session.getUserId();
	/*
	ezc.ezparam.EzcParams queryMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziQcfCommentParams queryParams= new ezc.ezpreprocurement.params.EziQcfCommentParams();
	queryParams.setQcfCode(collNo);
	queryParams.setQcfType("QUERY','REPLY");
	queryParams.setQcfUser(userId);
	queryParams.setQcfExt1("$$");
	queryMainParams.setLocalStore("Y");
	queryMainParams.setObject(queryParams);
	Session.prepareParams(queryMainParams);
	ezc.ezparam.ReturnObjFromRetrieve qcfQueryRet = (ezc.ezparam.ReturnObjFromRetrieve)ezpreprocurementmanager.getQcfCommentList(queryMainParams);
	
	if(qcfQueryRet != null)
	{	
		qcfQueryCount = qcfQueryRet.getRowCount();
		for(int i=qcfQueryCount-1;i>=0;i--)
		{
			if(userId.equals(qcfQueryRet.getFieldValueString(i,"QCF_USER")) && (!"null".equals(qcfQueryRet.getFieldValueString(i,"QCF_QUERY_MAP"))) && (!"0".equals(qcfQueryRet.getFieldValueString(i,"QCF_QUERY_MAP"))))
				qcfQueryRet.deleteRow(i);
		}
		qcfQueryCount = qcfQueryRet.getRowCount();
	}*/
	int qcfQueryCount = 0;
	String queryCheck = checkQueries(Session,collNo,Session.getUserId());
	if("Q".equals(queryCheck))
		qcfQueryCount = 1;
	
/** End QUERY **/


	boolean showApprove = false;
	String finalValue = (String)session.getValue("FINAL");
	if(actionsList.indexOf("APPROVED") >= 0)
		showApprove = true;
	if("Y".equals(finalValue))
		showApprove = true;
		

	boolean showSubmit = false;
	if(actionsList.indexOf("APPROVED") == -1)
		showSubmit = true;
	if(showApprove)
	{
		showSubmit = false;
	}
	boolean showReject = true;
	boolean showQuery = true;
	String firstValue = (String)session.getValue("FIRST");
	
	if(actionsList.indexOf("REJECTED") == -1 && !"".equals(actionsList))
		showReject = false;
	if(wfDetailCount == 0)
		showReject = false;	
	
	if("Y".equals(firstValue))
	{
		showReject = false;
		showApprove = false;
		showSubmit = true;
		//showQuery = false;
	}

	String checkStringx = userRole+":"+userDefRole+":"+userGroup+":"+userId;
	
	if(nextParticipant==null || "null".equals(nextParticipant))
		nextParticipant = "";
	
	
	
	//if("APPROVED".equals(wfStatus) || (checkStringx.indexOf(nextParticipant) == -1) || "RFQLINK".equals(type))
	boolean showTextAreas 	= true;
	if("APPROVED".equals(wfStatus) || (checkStringx.indexOf(nextParticipant) == -1 && !"D".equals(type)) || "RFQLINK".equals(type) || "VR".equals(userRole))
	{
		showReject 	= false;
		showApprove 	= false;
		showSubmit 	= false;
		showRequote	= false;
		allowPropose	= false;
		showTextAreas   = false;
		
	}
	
	if("RFQLINK".equals(type) || "CR".equals(request.getParameter("status")))
		showStatus = false;

	
		
	System.out.println("QCFSTATUS"+actionsList+":"+showApprove+":"+firstValue+":"+checkStringx+":"+nextParticipant+":"+wfStatus+":"+type);
	String tabHeight = "";
	if(showTextAreas)
		tabHeight = "40%";
	else	
		tabHeight = "60%";
		
	if(allowPropose)
		disableByUsrRole = "";
	else	
		disableByUsrRole = "disabled";
%>
