<%@ page import ="ezc.ezutil.FormatDate,java.util.*" %>
<%@ page import ="ezc.ezparam.*,ezc.client.*,java.util.*"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%@ page import="ezc.sales.material.params.*,ezc.ezparam.*" %>
<jsp:useBean id="EzcMaterialManager" class="ezc.sales.material.client.EzcMaterialManager" />
<%@ page import="ezc.fedex.freight.params.*"%>
<jsp:useBean id="EzFreightManager" class="ezc.fedex.freight.client.EzFreightManager" scope="page"/>
<%
	String soNum	= request.getParameter("webOrNo");
	String customer	= request.getParameter("soldTo");
	String salesAreaCode = request.getParameter("sysKey");
	String orderStatus = request.getParameter("orderStatus");
	String loginUser = (String)Session.getUserId();
	String modifiedBy ="";
	boolean NegotiateFlag = false;
	
	if("'NEW'".equals(orderStatus))NegotiateFlag = true;
	
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

	iSOHeader.setDocNumber(soNum);
	iSOHeader.setType("");
	iSOHeader.setSoldTo(customer);
	iSOHeader.setSalesArea(salesAreaCode);

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
	catch(Exception e){}
	
	int retLinesCount = 0;
	int sdHeaderCount = 0;
	
	if(retLines!=null) retLinesCount = retLines.getRowCount();
	if(sdHeader!=null) 
	{
		sdHeaderCount = sdHeader.getRowCount();
		modifiedBy = sdHeader.getFieldValueString(0,"MOD_ID");
	}
	if(modifiedBy==null || "null".equals(modifiedBy)) modifiedBy="";
	modifiedBy = modifiedBy.trim();
	
	
	if(loginUser==null || "null".equals(loginUser)) loginUser="";
	loginUser = loginUser.trim();
	
	if(!loginUser.equals(modifiedBy))NegotiateFlag=true;
	
	
	
	if(retDeliverySchedules!=null)
		session.putValue("EzDeliveryLines",retDeliverySchedules);
	
	//out.println("retHeader:::::::::::"+retHeader.toEzcString());
	//out.println("retLines:::::::::::"+retLines.toEzcString());
	//out.println("retDeliverySchedules:::::::::::"+retDeliverySchedules.toEzcString());
	//out.println("retLineMatId:::::::::::"+retLineMatId.toEzcString());
	//out.println("sdHeader:::::::::::"+sdHeader.toEzcString());
	//out.println("sdSoldTo:::::::::::"+sdSoldTo.toEzcString());
	//out.println("sdShipTo:::::::::::"+sdShipTo.toEzcString());

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
	ezc.ezupload.client.EzUploadManager uploadManager = new ezc.ezupload.client.EzUploadManager();
	ezc.ezparam.EzcParams myParams	= new ezc.ezparam.EzcParams(true);
	ezc.ezupload.params.EziUploadDocsParams uDocsParams = new ezc.ezupload.params.EziUploadDocsParams();
	uDocsParams.setObjectNo("'"+salesAreaCode+"SO"+soNum+"'");
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
	
	/************************Files Attached******************************************/

	/************************Prices for products*****************************/

	java.util.Hashtable cnetPriceHash = new java.util.Hashtable();
	
	if(retLinesCount>0)
	{
		String[] materialsP 	= new String[retLinesCount];
		String[] manufacturersP	= new String[retLinesCount];
		String[] mfrPartNosP 	= new String[retLinesCount];

    		for(int i=0;i<retLinesCount;i++)
		{
			materialsP[i]	 	= retLines.getFieldValueString(i,"NOTES");
			manufacturersP[i]	= retLines.getFieldValueString(i,"INVOICE");
			mfrPartNosP[i]		= retLines.getFieldValueString(i,"CUST_MAT");
		}
		
		EzcMaterialParams ezcPParams = new EzcMaterialParams();
		EziCnetPriceParams cnetPParams = new EziCnetPriceParams();

		cnetPParams.setMaterials(materialsP);	
		cnetPParams.setManufacturers(manufacturersP);	
		cnetPParams.setMfrPartNos(mfrPartNosP);	
		cnetPParams.setType("CNET_PRICES_MAT_MF_MFP");
		ezcPParams.setObject(cnetPParams);
		ezcPParams.setLocalStore("Y");
		Session.prepareParams(ezcPParams);
		ReturnObjFromRetrieve cnetPriceRet = (ReturnObjFromRetrieve)EzcMaterialManager.ezGetCNETPrices(ezcPParams);

		if(cnetPriceRet!=null && cnetPriceRet.getRowCount()>0)
		{
			log4j.log("cnetPriceRet >>>>>"+cnetPriceRet.toEzcString(),"I");
			for(int k=0;k<cnetPriceRet.getRowCount();k++)
			{
				String matNo = cnetPriceRet.getFieldValueString(k,"ECP_MFR_NO");
				String cPrice = cnetPriceRet.getFieldValueString(k,"ECP_PRICE");
				if(!"NA".equals(cPrice))
					cnetPriceHash.put(matNo,cPrice);
			}
		}
	}
	
	/************************Prices for products*****************************/

	/*************************Freight Service Type - Start*****************************/
	
	java.util.Hashtable freightServHash = new java.util.Hashtable();
	
	int stCnt = 0;
	EziServiceTypeParams eziStParams = new EziServiceTypeParams();
	EzcParams params = new EzcParams(false);
	
	eziStParams.setType("GET_ALL_SERVICE_TYPES");
	eziStParams.setExt1("");
	params.setObject(eziStParams);
	Session.prepareParams(params);
	ReturnObjFromRetrieve stRet = (ReturnObjFromRetrieve)EzFreightManager.ezGetType(params);
	
	if(stRet!=null)
		stCnt = stRet.getRowCount();

	for(int i=0;i<stCnt;i++)
	{
		String stId = stRet.getFieldValueString(i,"EFS_STYPE_CODE");
		String desc = stRet.getFieldValueString(i,"EFS_STYPE_DESC");

		freightServHash.put(stId,desc);
	}
	
	String frInsVal = (String)session.getValue("FRINSVAL");
	
	/*************************Freight Service Type - End*******************************/
%>