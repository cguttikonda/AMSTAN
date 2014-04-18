<%@page import="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO,java.util.*,ezc.ezutil.*,ezc.ezparam.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ConfigMgr" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%@ include file="../Misc/iWFMethods.jsp" %>
<%@ include file="../Misc/iCheckQuery.jsp" %>
<%
	java.util.Hashtable collSysHash=(java.util.Hashtable)session.getValue("COLLSYSKEY");

	String agmtNo    	= request.getParameter("agmtNo");
	String collSys   	= (String)collSysHash.get(agmtNo);    
	String userType  	= (String)session.getValue("UserType");
	String userRole  	= (String)session.getValue("USERROLE");
	String wfRole 		= (String)session.getValue("ROLE");
	String finalLevel   	= (String)session.getValue("FINAL");
	String loginType    	= (String)session.getValue("OFFLINE"); 
	
	String RQSTFROM     	= request.getParameter("RQSTFROM");
	String POORCONTRACT 	= request.getParameter("POORCONTRACT");
	String viewType     	= request.getParameter("viewType");
	
	
	System.out.println(agmtNo+":::");
	
    	String orderType    	= "Contract";
    
	String scrollInit = "",orderDate = "",contractTargetValue = "";	    
	String conPONum = "",vndr = "",conType="",pmntTrms="";
    	String netOrderAmount = "",userGroup = "",soldToStr = "",newtemplet = "";
    	String queryCheck 	= "N";
    	String display_header 	= "Contract Details";

	java.util.Hashtable conHash = new java.util.Hashtable();	
	conHash.put("MK","Quantity Contract");
	conHash.put("WK","Value Contract");	
	
	java.util.Hashtable fileHash = new java.util.Hashtable();	
	fileHash.put("VIEW","../Purorder/ezGetContractsList.jsp");
	fileHash.put("BLOCK","../Purorder/ezListBlockedContractsInPortal.jsp");
	fileHash.put("UNREL","../Purorder/ezListOfflineBlockedContracts.jsp?type=Contract");
	
	String navigateFileName = (String)fileHash.get(viewType);
	
	boolean showSubmit = false,showRelease=false,showReject=false;
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	int cnt = 0;

	
	
	if("VIEW".equals(viewType))
		navigateFileName = "";
	if("BLOCK".equals(viewType))
		navigateFileName = "";
	if("UNREL".equals(viewType))
		navigateFileName = "";	

	java.util.Hashtable hashOrderType = new java.util.Hashtable();	
	hashOrderType.put("Contract","CON_RELEASE");
	hashOrderType.put("Amend","PO_RELEASE");    

	if(collSys!=null)
	{
		ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
		ReturnObjFromRetrieve retsoldto = (ReturnObjFromRetrieve)PurManager.getUserVendors(collSys);
		if(retsoldto!=null&&retsoldto.getRowCount()>0)
		soldToStr = retsoldto.getFieldValueString(0,"EC_ERP_CUST_NO");
		PurManager.setPurAreaAndVendor(collSys,soldToStr);
		session.putValue("SYSKEY",collSys);

		EzcSysConfigParams sparams2 = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams2 = new EzcSysConfigNKParams();
		snkparams2.setLanguage("EN");
		snkparams2.setSystemKey(collSys);
		snkparams2.setSiteNumber(200);
		sparams2.setObject(snkparams2);
		Session.prepareParams(sparams2);
		ReturnObjFromRetrieve retTemplate = (ReturnObjFromRetrieve)ConfigMgr.getCatAreaDefaults(sparams2);
		int retcnt=retTemplate.getRowCount();
		for(int z=0;z<retcnt;z++)
		{
			if("WFTEMPLATE".equals((retTemplate.getFieldValueString(z,"ECAD_KEY")).toUpperCase()) )
			{
				newtemplet = retTemplate.getFieldValueString(z,"ECAD_VALUE");
				session.putValue("TEMPLATE",newtemplet);
			}
		}

		if(!userType.equals("3"))
		{
			ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWorkGroupsParams params= new ezc.ezworkflow.params.EziWorkGroupsParams();
			params.setUserId(Session.getUserId()+ "' AND EWWU_SYSKEY='"+collSys);
			mainParams.setObject(params);
			Session.prepareParams(mainParams);
			ezc.ezparam.ReturnObjFromRetrieve ret=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkGroupsList(mainParams);
			if(ret!=null && ret.getRowCount()>0)
				userGroup 	= ret.getFieldValueString(0,"GROUP_ID");

			if(!"".equals(userGroup))
			{	
				session.putValue("USERGROUP",userGroup);
			}
			int templateStep=0;
			java.util.Vector desiredSteps=new java.util.Vector();
			ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziTemplateStepsParams params1= new ezc.ezworkflow.params.EziTemplateStepsParams();
			params1.setCode(newtemplet);
			mainParams1.setObject(params1);
			Session.prepareParams(mainParams1);
			ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getTemplateStepsList(mainParams1);
			if(listRet!=null)
			{
				for(int i=0;i<listRet.getRowCount();i++)
				{
					if(userRole.equals((listRet.getFieldValueString(i,"STEP_DESC")).trim()))
					{
						templateStep = 	Integer.parseInt(listRet.getFieldValueString(i,"STEP"));
						desiredSteps.add(templateStep-1+"");
						if(i == listRet.getRowCount()-1)
							session.putValue("FINAL","Y");
						else	
							session.putValue("FINAL","N");
						if(i == 1)
							session.putValue("FIRST","Y");
						else	
							session.putValue("FIRST","N"); 
					}
				}
			}	
		}
	}
    
   
    
	java.util.ResourceBundle rc  = java.util.ResourceBundle.getBundle("EzPurPayTerms");

	

	int POsToConCnt = 0;
	int ConItemsCnt = 0;

	ezc.ezpreprocurement.client.EzPreProcurementManager PreProcurementManager=new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezpreprocurement.params.EziPOHeaderParams headerParams = new ezc.ezpreprocurement.params.EziPOHeaderParams();
	headerParams.setPONo(agmtNo);
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(true);
	mainParams.setObject(headerParams);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve myRet=(ezc.ezparam.ReturnObjFromRetrieve)PreProcurementManager.ezGetContractDetails(mainParams);

	ezc.ezparam.ReturnObjFromRetrieve ConHeader = (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("PO_HEADER");
	ezc.ezparam.ReturnObjFromRetrieve ConAddr   = (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("PO_ADDR");
	ezc.ezparam.ReturnObjFromRetrieve ConItems  = (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("PO_ITEMS");
	ezc.ezparam.ReturnObjFromRetrieve POsToCon  = (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("XADO");
	ezc.ezparam.ReturnObjFromRetrieve OpenQty   = (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("XADOS");
	
	ezc.ezparam.ReturnObjFromRetrieve headerTextXML = (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("HEADERTEXT");
	ezc.ezparam.ReturnObjFromRetrieve itemTextXML   = (ezc.ezparam.ReturnObjFromRetrieve)myRet.getFieldValue("ITEMTEXT");

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
	
	String conTypeHeader 	= "";
	String targetData 	= "";
	String retColumn 	= "";
	if(cnt>0)
	{
		conPONum 	= ConHeader.getFieldValueString("PO_NUMBER");
		vndr 		  = ConHeader.getFieldValueString("VENDOR");
		conType 	= ConHeader.getFieldValueString("DOC_TYPE");
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

	if("UNREL".equals(viewType))
	{
		contractTargetValue 	= ConHeader.getFieldValueString(0,"TARGET_VAL");
		orderDate 		= ConHeader.getFieldValueString("CREATED_ON");
		netOrderAmount 		= contractTargetValue;
%>
		<%@ include file="../Purorder/iWFPOConConditions.jsp" %>	
<%
        	queryCheck = checkQueries(Session,agmtNo,(String)Session.getUserId());;
    	}
%>

<%
	String fromDate = "01/01/2004";
	java.util.Date dateObj = new java.util.Date();
	String toDate = dateObj.getDate()+"/"+(dateObj.getMonth()+1)+"/"+(dateObj.getYear()+1900)+" 23:59:59";
	String vndrCodes = (String)session.getValue("SOLDTOS");
	String poconQCFNumber = checkForQCF(Session,vndrCodes,fromDate,toDate,collSys,agmtNo);
%>


<%
	String commentNo = "";
	int qcsCount	 = 0;
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
	if(commentsRet != null)
	{
		qcsCount = commentsRet.getRowCount();
	}
	System.out.println("COUNT : "+qcsCount);
%>

<%
	String uploadFilePathDir="";

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
	ezc.ezparam.EzcParams myParams	= new ezc.ezparam.EzcParams(true);
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
	
	int noOfDocs = 0;
	int noOfFiles = 0;
	if(retUploadDocs!= null)
	{
		noOfDocs = retUploadDocs.getRowCount();
	}
	String onLoadString = "";
	String fadeString = "";
	if(noOfDocs > 0)
	{
		for(int i=0;i<noOfDocs;i++)
		{
			ezc.ezparam.ReturnObjFromRetrieve fileListRet = (ezc.ezparam.ReturnObjFromRetrieve)retUploadDocs.getFieldValue(i,"FILES");
			noOfFiles += fileListRet.getRowCount();
		}
		onLoadString = "onload=\"fade('changingSpan')\"";
		fadeString   = noOfFiles+" file(s) attached.";
	}	
%>