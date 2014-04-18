<%@page import="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO,java.util.*,ezc.ezutil.*,ezc.ezparam.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ include file="../Misc/iWFMethods.jsp" %>
<%@ include file="../Misc/iCheckQuery.jsp" %>
<%
	String finalLevel 	= (String)session.getValue("FINAL");
	String loginType 	= (String)session.getValue("OFFLINE");    
	String userRole 	= (String)session.getValue("USERROLE");
	String wfRole 		= (String)session.getValue("ROLE");
	
	String RQSTFROM 	= request.getParameter("RQSTFROM");
	String POORCONTRACT 	= request.getParameter("POORCONTRACT");
	String agmtNo 		= request.getParameter("agmtNo");
	String viewType 	= request.getParameter("viewType");
	String newtemplet 	= (String)session.getValue("TEMPLATE");
	String contractTargetValue = "" ,navigateFileName = "" ,netOrderAmount = "",scrollInit = "",orderDate = "";
	String conPONum = "",vndr = "",conType = "",pmntTrms = "";
 	String conTypeHeader = "",targetData = "",retColumn = "";
       
	String orderType  	= "Contract";
	String display_header 	= "Contract Details";
	String queryCheck 	= "N";
	
	int cnt = 0,POsToConCnt = 0,ConItemsCnt = 0;
	
	boolean showSubmit = false,showRelease=false,showReject=false;
	    
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();

	java.util.Hashtable hashOrderType = new java.util.Hashtable();	
	hashOrderType.put("Contract","CON_RELEASE");
	hashOrderType.put("Amend","PO_RELEASE");    
	

	java.util.Hashtable conHash = new java.util.Hashtable();	
	conHash.put("MK","Quantity Contract");
	conHash.put("WK","Value Contract");

	if(loginType != null && "Y".equals(loginType))
		scrollInit="10";
	else
		scrollInit="100";

	if("VIEW".equals(viewType))
		navigateFileName = "../Purorder/ezGetContractsList.jsp";
	if("BLOCK".equals(viewType))
		navigateFileName = "../Purorder/ezListBlockedContractsInPortal.jsp";
	if("UNREL".equals(viewType))
		navigateFileName = "../Purorder/ezListBlockedContracts.jsp?type=Contract";

    
	ezc.ezpreprocurement.client.EzPreProcurementManager PreProcurementManager=new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezpreprocurement.params.EziPOHeaderParams headerParams = new ezc.ezpreprocurement.params.EziPOHeaderParams();
	headerParams.setPONo(agmtNo);
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(true);
	mainParams.setObject(headerParams);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve myRet=(ezc.ezparam.ReturnObjFromRetrieve)PreProcurementManager.ezGetContractDetails(mainParams);

	ezc.ezparam.ReturnObjFromRetrieve ConHeader 	= (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("PO_HEADER");
	ezc.ezparam.ReturnObjFromRetrieve ConAddr   	= (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("PO_ADDR");
	ezc.ezparam.ReturnObjFromRetrieve ConItems  	= (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("PO_ITEMS");
	ezc.ezparam.ReturnObjFromRetrieve OpenQty   	= (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("XADOS");
	ReturnObjFromRetrieve headerTextXML 		= (ReturnObjFromRetrieve)myRet.getFieldValue("HEADERTEXT");
	ReturnObjFromRetrieve itemTextXML   		= (ReturnObjFromRetrieve)myRet.getFieldValue("ITEMTEXT");
	ezc.ezparam.ReturnObjFromRetrieve POsToCon  	= (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("XADO");
	if(POsToCon!=null)
		POsToConCnt = POsToCon.getRowCount();	
	
	
	String exchRateCur = "";
	
		
	int headerTextXMLCount=0;
	int itemTextXMLCount=0;
	String headerText="";	
	java.util.Hashtable itemTextHT=new java.util.Hashtable();
	String itemNo="";
	String textLine="";
	
	if(headerTextXML!=null)headerTextXMLCount=headerTextXML.getRowCount();
	if(itemTextXML!=null)itemTextXMLCount=itemTextXML.getRowCount();
	
	if(headerTextXMLCount>0){
		headerText=headerTextXML.getFieldValueString(0,"TEXTLINE");
		for(int i=1;i<headerTextXMLCount;i++){
			headerText +="\n"+headerTextXML.getFieldValueString(i,"TEXTLINE");
		}	
	}
		
		
		
	if(itemTextXMLCount>0){
		for(int i=0;i<itemTextXMLCount;i++){
			itemNo=itemTextXML.getFieldValueString(i,"PO_ITEM");
			textLine=itemTextXML.getFieldValueString(i,"TEXTLINE");
			if(textLine==null||"null".equals(textLine)) textLine="";
			if(itemNo!=null){
	
				if(!itemTextHT.containsKey(itemNo)){
					itemTextHT.put(itemNo,textLine);
				}else{
					textLine=(String)itemTextHT.get(itemNo)+"\n"+textLine;
					itemTextHT.put(itemNo,textLine);
				}
			}
		}	
	
	}
	
	
	
	
	
	
	cnt 		= ConHeader.getRowCount();
	ConItemsCnt 	= ConItems.getRowCount();
	
	if(cnt>0)
	{
		conPONum 	= ConHeader.getFieldValueString("PO_NUMBER");
		vndr 		  = ConHeader.getFieldValueString("VENDOR");
		conType 	= ConHeader.getFieldValueString("DOC_TYPE");
		exchRateCur 	= ConHeader.getFieldValueString(0,"EXCH_RATE");;
		if("WK".equals(conType.trim()))
		{
			conType 	= "Value Contract["+conType+"]";
			conTypeHeader 	= "Target Value";
			retColumn 	= "TARGET_VAL";
		}	
		else if("MK".equals(conType.trim()))
		{
			conType 	= "Quantity Contract["+conType+"]";	
			conTypeHeader 	= "Target Quantity";
			retColumn 	= "TARGET_QTY";
		}
	} 	
	
	ezc.ezworkflow.client.EzWorkFlowManager ezWorkFlowManager = new ezc.ezworkflow.client.EzWorkFlowManager();
	ezc.ezparam.EzcParams wfMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams wfParams= new ezc.ezworkflow.params.EziWFDocHistoryParams();
	wfParams.setAuthKey("CON_RELEASE");
	wfParams.setSysKey((String) session.getValue("SYSKEY"));
	wfParams.setDocId(agmtNo);
	wfParams.setSoldTo(ConHeader.getFieldValueString(0,"VENDOR"));
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
	String participantType  = wfDetailsRet.getFieldValueString(wfDetailsRet.getRowCount()-1,"PARTICIPANTTYPE");
	String currency = "";
   	if("UNREL".equals(viewType))
       	{
       		contractTargetValue = ConHeader.getFieldValueString(0,"TARGET_VAL");
       		currency = ConHeader.getFieldValueString(0,"CURRENCY");
       		orderDate = ConHeader.getFieldValueString("CREATED_ON");
        	netOrderAmount = contractTargetValue;
		/**** Following  block for converting price into INR *****/
		if(!"INR".equals(currency))
		{
			netOrderAmount = (Double.parseDouble(exchRateCur) * Double.parseDouble(netOrderAmount))+"";
		}

%>
		<%@ include file="../Purorder/iWFPOConConditions.jsp" %>	
<%
		queryCheck = checkQueries(Session,agmtNo,(String)Session.getUserId());;
       }
%>

<%
   	String fromDate = "01/01/2004";
   	java.util.Date dateObj 	= new java.util.Date();
   	String toDate 		= dateObj.getDate()+"/"+(dateObj.getMonth()+1)+"/"+(dateObj.getYear()+1900)+" 23:59:59";
   	String vndrCodes 	= (String)session.getValue("SOLDTOS");
   	String poconQCFNumber 	= checkForQCF(Session,vndrCodes,fromDate,toDate,(String) session.getValue("SYSKEY"),agmtNo);
   	
   	
%>
   
   
<%
       String commentNo = "";
       ezc.ezpreprocurement.client.EzPreProcurementManager ezpreprocurementmanager  = new ezc.ezpreprocurement.client.EzPreProcurementManager();
       ezc.ezparam.EzcParams mainCommentParams = new ezc.ezparam.EzcParams(false);
       ezc.ezpreprocurement.params.EziQcfCommentParams qcfParams= new ezc.ezpreprocurement.params.EziQcfCommentParams();
       qcfParams.setQcfCode(agmtNo);
       qcfParams.setQcfType("COMMENTS");
       qcfParams.setQcfExt1("$$");
       mainCommentParams.setLocalStore("Y");
       mainCommentParams.setObject(qcfParams);
       Session.prepareParams(mainCommentParams);
       ezc.ezparam.ReturnObjFromRetrieve commentsRet = (ezc.ezparam.ReturnObjFromRetrieve)ezpreprocurementmanager.getQcfCommentList(mainCommentParams);
       int qcsCount = 0;
       if(commentsRet != null)
       {
         qcsCount = commentsRet.getRowCount();
       }
%>
   
<%
   	String uploadFilePathDir="";
	String onLoadString 	= "";
   	String fadeString	= "";   
	int noOfDocs  		= 0;
   	int noOfFiles 		= 0;   	
   	
   	ResourceBundle site=null;
   	try
   	{
   		uploadFilePathDir = site.getString("UPLOADFILEPATHDIR");
   		uploadFilePathDir = uploadFilePathDir.replace('\\','/');
   	}
   	catch(Exception e)
   	{ 
   	    System.out.println("Got Exception while getting Upload Temp Dir "+e);	
   	}	
   	
   	uploadFilePathDir = "j2ee/"+uploadFilePathDir;
   	
   	ezc.ezparam.ReturnObjFromRetrieve retUploadDocs = null;
   	ezc.ezupload.client.EzUploadManager uploadManager = new ezc.ezupload.client.EzUploadManager();
   	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(true);
   	ezc.ezupload.params.EziUploadDocsParams uDocsParams = new ezc.ezupload.params.EziUploadDocsParams();
   	uDocsParams.setObjectNo("'"+(String) session.getValue("SYSKEY")+"CONT"+agmtNo+"'");
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
   	
   	
   	if(retUploadDocs!= null)
   	{
   		noOfDocs = retUploadDocs.getRowCount();
   	}
   	
   	if(noOfDocs > 0)
   	{
   		for(int i=0;i<noOfDocs;i++)
   		{
   			ezc.ezparam.ReturnObjFromRetrieve fileListRet = (ezc.ezparam.ReturnObjFromRetrieve)retUploadDocs.getFieldValue(i,"FILES");
   			noOfFiles += fileListRet.getRowCount();
   		}
   		onLoadString = ";fade('changingSpan')";
   		fadeString   = noOfFiles+" file(s) attached.";
   	}	
%>