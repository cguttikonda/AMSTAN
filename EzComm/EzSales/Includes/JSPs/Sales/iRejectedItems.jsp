<%@ page import ="ezc.ezutil.FormatDate,java.util.*" %>
<%@ page import ="ezc.ezparam.*,ezc.client.*,java.util.*"%>
<%@ page import="ezc.sales.material.params.*,ezc.ezparam.*" %>
<jsp:useBean id="EzcMaterialManager" class="ezc.sales.material.client.EzcMaterialManager" />
<%
	Vector authorisedUsres = new Vector();
	if("3".equals((String)session.getValue("UserType")))
	{
		EzcParams mainParamsMisc_CHK= new EzcParams(false);
		EziMiscParams miscParams_CHK = new EziMiscParams();

		ReturnObjFromRetrieve authSoldTos = null;
		
		int authUsersCnt =0;
		
		miscParams_CHK.setIdenKey("MISC_SELECT");
		miscParams_CHK.setQuery("SELECT DISTINCT(EC_PARTNER_NO), EC_ERP_CUST_NO FROM EZC_CUSTOMER WHERE EC_ERP_CUST_NO='"+session.getValue("AgentCode")+"' AND EC_BUSINESS_PARTNER='"+session.getValue("BussPart")+"' AND EC_PARTNER_FUNCTION='WE'");

		mainParamsMisc_CHK.setLocalStore("Y");
		mainParamsMisc_CHK.setObject(miscParams_CHK);
		Session.prepareParams(mainParamsMisc_CHK);

		try
		{		
			authSoldTos = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc_CHK);
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log(">>>>>>>authorisedUsres>>>>>>>>>>>>>>>>>>>>>>"+e,"E");
		}
		if(authSoldTos!=null && authSoldTos.getRowCount()>0)
		{
			authUsersCnt = authSoldTos.getRowCount();
			for(int i=0;i<authUsersCnt;i++)
			{
				authorisedUsres.add(authSoldTos.getFieldValueString(i,"EC_ERP_CUST_NO")+""+authSoldTos.getFieldValueString(i,"EC_PARTNER_NO"));
			}
			
		}
		ezc.ezcommon.EzLog4j.log(">>>>>>>authorisedUsres>>>>>>>>>>>>>>>>>>>>>>"+authorisedUsres,"D");
		//ezc.ezcommon.EzLog4j.log(">>>>>>>authSoldTos>>>>>>>>>>>>>>>>>>>>>>"+authSoldTos.toEzcString(),"D");	
	}	
	
	String soNum	= request.getParameter("webOrNo");
	String customer	= request.getParameter("soldTo");
	if("Y".equals((String)session.getValue("OFFLINE")))
	{
		soNum 	 = (String)session.getValue("webOrNo");
		customer = (String)session.getValue("DocSoldTo");
	}
	
	String salesAreaCode_E = request.getParameter("sysKey");
	
	if(salesAreaCode_E==null || "null".equalsIgnoreCase(salesAreaCode_E) || "".equals(salesAreaCode_E))
		salesAreaCode_E = (String)session.getValue("SalesAreaCode");

	String orderStatus = "NEW";//request.getParameter("orderStatus");
	String loginUser = (String)Session.getUserId();
	String modifiedBy ="";
	String authCheck = "";
	boolean NegotiateFlag = false;
	//out.println("salesAreaCode_E::::::"+salesAreaCode_E+":::::customer::::::"+customer+":::::soNum:::::"+soNum);
	ezc.ezcommon.EzLog4j.log(">>>>>>>soNum>>>>>>>>>>>>>>>>>>>>>>"+soNum,"D");

	if("'NEW'".equals(orderStatus))NegotiateFlag = true;

	boolean actTaken = false;
	String status_Ord = request.getParameter("status");

	if(status_Ord!=null && !"null".equalsIgnoreCase(status_Ord))
	{
		EzcParams mainParamsOrdChk = new EzcParams(false);
		EziMiscParams miscParamsOrdChk = new EziMiscParams();

		ReturnObjFromRetrieve retOrdChk = null;
		miscParamsOrdChk.setIdenKey("MISC_SELECT");
		miscParamsOrdChk.setQuery("SELECT ESDH_DOC_NUMBER,ESDH_PO_NO,ESDH_STATUS FROM EZC_SALES_DOC_HEADER WHERE ESDH_DOC_NUMBER in ('"+soNum+"')");
		mainParamsOrdChk.setLocalStore("Y");
		mainParamsOrdChk.setObject(miscParamsOrdChk);
		Session.prepareParams(mainParamsOrdChk);

		try
		{
			retOrdChk = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsOrdChk);
		}
		catch(Exception e){}

		String showMsg_A = "";
		if(retOrdChk!=null && retOrdChk.getRowCount()>0)
		{
			String ordHeadStatus = retOrdChk.getFieldValueString(0,"ESDH_STATUS");
			String ordPoNumber = retOrdChk.getFieldValueString(0,"ESDH_PO_NO");

			if("SUBMITTED".equals(status_Ord))
			{
				if(ordHeadStatus!=null && !"SUBMITTED".equalsIgnoreCase(ordHeadStatus.trim()))
				{
					actTaken = true;
					showMsg_A = "Action has been taken on this PO "+ordPoNumber+". Please check this order in FD Approved/Rejected option in Orders Dashboard.";
				}
			}
			if("NEGOTIATED".equals(status_Ord))
			{
				if(ordHeadStatus!=null && !"NEGOTIATED".equalsIgnoreCase(ordHeadStatus.trim()) && "TRANSFERED".equalsIgnoreCase(ordHeadStatus.trim()))
				{
					actTaken = true;
					showMsg_A = "Action has been taken on this PO "+ordPoNumber+". Please check this order in Orders Dashboard.";
				}
			}
		}
		if(actTaken)
		{
%>
			<div class="main-container col2-layout middle account-pages">
			<div class="main">
			<div class="col-main1 roundedCorners">
			<div class="page-title">
				<ul class="success-msg"><li><span><%=showMsg_A%></span></li></ul>
			</div>
			</div> <!-- col-main -->
			</div> <!--main -->
			</div> <!-- main-container col1-layout -->
			<%@ include file="../../../Sales/JSPs/Misc/ezFooter.jsp"%>
<%
			return;
		}
	}


	/************************Saved order details from portal DB****************************/

	ReturnObjFromRetrieve mainRet = null;

	ReturnObjFromRetrieve retHeader = null;
	ReturnObjFromRetrieve retLines = null;
	ReturnObjFromRetrieve retDeliverySchedules = null;
	ReturnObjFromRetrieve retLineMatId = null;
	ReturnObjFromRetrieve sdHeader = null;
	ReturnObjFromRetrieve sdSoldTo = null;
	ReturnObjFromRetrieve sdShipTo = null;

	EzcSalesOrderParams ezcSOParams = new EzcSalesOrderParams();
	ezcSOParams.setLocalStore("Y");
	Session.prepareParams(ezcSOParams);

	EziSalesOrderStatusParams iSOStatusParams = new EziSalesOrderStatusParams();
	EziSalesHeaderParams iSOHeader = new EziSalesHeaderParams();
	EzSalesOrderStructure SOStrut = new EzSalesOrderStructure();

	ezcSOParams.setObject(iSOStatusParams);
	ezcSOParams.setObject(iSOHeader);
	ezcSOParams.setObject(SOStrut);

	iSOHeader.setDocNumber(soNum.trim());
	iSOHeader.setType("");
	iSOHeader.setSoldTo(customer);
	iSOHeader.setSalesArea(salesAreaCode_E);

	SOStrut.setDeliverySchedules("X");
	SOStrut.setLines("H");   

	try
	{
			log4j.log("ezSalesOrderStatus Starts>>>>>>>>>>>","D");

		EzoSalesOrderStatus soStatus  = (EzoSalesOrderStatus) EzSalesOrderManager.ezSalesOrderStatus(ezcSOParams);
		
			log4j.log("ezSalesOrderStatus Ends>>>>>>>>>>>","D");

		mainRet = soStatus.getReturn();
		retHeader		= (ReturnObjFromRetrieve)mainRet.getObject("SALES_HEADER");
		retLines 		= (ReturnObjFromRetrieve)mainRet.getObject("SALES_LINES");
		retDeliverySchedules 	= (ReturnObjFromRetrieve)mainRet.getObject("DELIVERY_LINES");
		retLineMatId         	= (ReturnObjFromRetrieve)mainRet.getObject("ITEM_MATID"); 
		sdHeader 		= (ReturnObjFromRetrieve)retHeader.getObject("SdHeader");
		sdSoldTo 		= (ReturnObjFromRetrieve)retHeader.getObject("SdSoldTo");
		sdShipTo 		= (ReturnObjFromRetrieve)retHeader.getObject("SdShipTo");
	}
	catch(Exception e){log4j.log("Check222222222>>>>>>>>>>>"+e,"D");	}
	
	int retLinesCount = 0;
	int sdHeaderCount = 0;
	
	if(retLines!=null) retLinesCount = retLines.getRowCount();
	if(sdHeader!=null) 
	{
		sdHeaderCount = sdHeader.getRowCount();
		modifiedBy = sdHeader.getFieldValueString(0,"MOD_ID");
		
	}
	if(sdSoldTo!=null && sdShipTo!=null)
	{
		authCheck = sdHeader.getFieldValueString(0,"AGENT_CODE")+""+sdShipTo.getFieldValueString(0,"SHIP_TO_CODE");	
	}
	if(modifiedBy==null || "null".equals(modifiedBy)) modifiedBy="";
	modifiedBy = modifiedBy.trim();
	log4j.log("Check3333333333>>>>>>>>>>>","D");	
	
	if(loginUser==null || "null".equals(loginUser)) loginUser="";
	loginUser = loginUser.trim();
	
	if(!loginUser.equals(modifiedBy))NegotiateFlag=true;
	
	log4j.log("Check44444444>>>>>>>>>>>","D");	
	
	if(retDeliverySchedules!=null)
		session.putValue("EzDeliveryLines",retDeliverySchedules);
		
		
	log4j.log("Check555555>>>>>>>>>>>","D");	
	
	/*out.println("retHeader:::::::::::"+retHeader.toEzcString());
	out.println("retLines:::::::::::"+retLines.toEzcString());
	out.println("retDeliverySchedules:::::::::::"+retDeliverySchedules.toEzcString());
	out.println("retLineMatId:::::::::::"+retLineMatId.toEzcString());
	out.println("sdHeader:::::::::::"+sdHeader.toEzcString());
	out.println("sdSoldTo:::::::::::"+sdSoldTo.toEzcString());
	out.println("sdShipTo:::::::::::"+sdShipTo.toEzcString());*/

	/************************Saved order details from portal DB****************************/

	/************************Files Attached******************************************/

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
	/*ezc.ezupload.client.EzUploadManager uploadManager = new ezc.ezupload.client.EzUploadManager();
	ezc.ezparam.EzcParams myParams	= new ezc.ezparam.EzcParams(true);
	ezc.ezupload.params.EziUploadDocsParams uDocsParams = new ezc.ezupload.params.EziUploadDocsParams();
	uDocsParams.setObjectNo("'"+salesAreaCode_E+"SO"+soNum+"'");
	myParams.setObject(uDocsParams);
	Session.prepareParams(myParams);*/
	EzcParams uploadMain= new EzcParams(false);
	EziMiscParams uDocsParams = new EziMiscParams();
	
	uploadMain= new EzcParams(false);
	uDocsParams = new EziMiscParams();
	uDocsParams.setIdenKey("MISC_SELECT");
	uDocsParams.setQuery("SELECT  EUD_UPLOAD_NO  UPLOADNO,EUD_SYSKEY  SYSKEY,EUD_OBJECT_TYPE  OBJECTTYPE,EUD_OBJECT_NO  OBJECTNO,EUD_STATUS  STATUS,EUD_CREATED_ON  CREATEDON,EUD_CREATED_BY  CREATEDBY , EUF_TYPE TYPE, EUF_CLIENT_FILE_NAME CLIENTFILENAME, EUF_SERVER_FILE_NAME SERVERFILENAME    FROM EZC_UPLOAD_DOCS,EZC_UPLOADDOC_FILES  WHERE EUF_UPLOAD_NO = EUD_UPLOAD_NO  AND EUD_SYSKEY + EUD_OBJECT_TYPE + EUD_OBJECT_NO IN ('"+salesAreaCode_E+"SO"+soNum+"') ORDER BY EUD_UPLOAD_NO");

	uploadMain.setLocalStore("Y");
	uploadMain.setObject(uDocsParams);
	Session.prepareParams(uploadMain);	
	try
	{
		retUploadDocs = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(uploadMain);
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
	//out.println("noOfDocs::::"+retUploadDocs.toEzcString());
	
	/************************Files Attached******************************************/
%>
