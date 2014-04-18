<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="ezc.client.*,ezc.ezparam.*"%>
<%@ page import="ezc.ezpurchase.params.*,java.util.*,ezc.ezutil.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@page import="ezc.ezvendorapp.params.*"%>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session" ></jsp:useBean>
<%
	String matDesc = request.getParameter("MatDesc");
	String uom = request.getParameter("UOM");
	String totQty = request.getParameter("TotQty");
	if (totQty == null)
		totQty = "0";
	else if (totQty.trim().length() == 0)
		totQty = "0";
	int batchCount = 0;
	String batchNo[] = request.getParameterValues("BatchNo");
	if (batchNo!=null)
		batchCount = batchNo.length;

	String batchQty[] = request.getParameterValues("BatchQty");
	EzPurchaseManager PoManager= new EzPurchaseManager();

	EzcPurchaseParams purParams= new EzcPurchaseParams();
	EziPurchaseOrderCreateParams ioparams = new EziPurchaseOrderCreateParams ();
	EzPSIInputParameters iparams = new EzPSIInputParameters();

	//ekko-Header   ekpo--Item    eket--Schedules

	EzBapiekkocStructure poHeader=new EzBapiekkocStructure();
	String purGrp = request.getParameter("purGrp");
	poHeader.setPurGroup(purGrp);

	//poHeader.setDocType("NB");
	//poHeader.setDocCat("F");
	poHeader.setDocDate(new Date());

	EzBapiekpocTable itemTable = new EzBapiekpocTable();
	EzBapiekpocTableRow itemRow = new EzBapiekpocTableRow();
	itemRow.setPoItem(new java.math.BigInteger("10"));
	itemRow.setDispQuan(new java.math.BigDecimal(totQty));
	String matNum = request.getParameter("matNum");
	itemRow.setMaterial(matNum);
	itemRow.setPlant(request.getParameter("plant"));
	itemRow.setPurMat(matNum);


	itemRow.setNetPrice(new java.math.BigDecimal("0"));
	itemRow.setPoPrice("X");
	itemTable.appendRow(itemRow);
	EzBapieketTable schedTable=new EzBapieketTable();	
	EzBapieketTableRow schedRow=null;

		for (int j=0; j< batchCount;j++)
		{
			schedRow = new EzBapieketTableRow();
			schedRow.setPoItem(new java.math.BigInteger("10")); 
			if (batchQty[j] == null)
				schedRow.setQuantity(new java.math.BigDecimal("0"));
			else if (batchQty[j].trim().length() == 0)
				schedRow.setQuantity(new java.math.BigDecimal("0"));
			else
				schedRow.setQuantity(new java.math.BigDecimal(batchQty[j]));

			schedRow.setSerialNo(new java.math.BigInteger(String.valueOf(j+1)));
			schedRow.setDelivDate(new Date());
			schedTable.appendRow(schedRow);
		}
	ioparams.setPoHeader(poHeader);
	ioparams.setPoItems(itemTable);
	ioparams.setPoItemSchedules(schedTable);
	purParams.setObject(ioparams);
	purParams.setObject(iparams);
	Session.prepareParams(purParams);
	EzoPurchaseOrderCreate purObj=(EzoPurchaseOrderCreate)PoManager.ezCreatePurchaseOrder(purParams);
	ReturnObjFromRetrieve itemoutTable =(ReturnObjFromRetrieve)purObj.getPoItems();
	//ReturnObjFromRetrieve orderHeader =(ReturnObjFromRetrieve)purObj.getPoHeader();
	ReturnObjFromRetrieve retObj = (ReturnObjFromRetrieve)purObj.getReturnBapi();
	
	String ErrMsg="";
	for (int i=0;i<retObj.getRowCount();i++){
		String type=retObj.getFieldValueString(i,"TYPE");
		if (type.equals("E"))
			ErrMsg=ErrMsg+(i+1)+" . "+retObj.getFieldValueString("MSG")+"<br>";
	}

	String poNo = null;
	try{
		poNo = itemoutTable.getFieldValueString(0,"PoNumber");
	}catch(Exception e){}

	if ((poNo!=null)&&(poNo.trim().length()!=0)&&(!"null".equalsIgnoreCase(poNo)))
	{

		EzSampleMaterialStructure inStructSample=new EzSampleMaterialStructure();
		EzcParams sampleParams=new EzcParams(true);
	
		inStructSample.setPoNo(poNo);
		inStructSample.setPoDate(FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY));
		inStructSample.setSampleId(request.getParameter("SampleId"));
		sampleParams.setLocalStore("Y");
		sampleParams.setObject(inStructSample);
		Session.prepareParams(sampleParams);
		AppManager.ezUpdateSampleMaterial(sampleParams);
		response.sendRedirect("../Shipment/ezMessage.jsp?Msg=Purchase Order created Successfully with PO No:"+ poNo);
	}
	else{
		response.sendRedirect("../Shipment/ezMessage.jsp?Msg=<b>Error: Purchase Order has not Created for the Sample.Error with the following<br><br>"+ErrMsg);
	}
			
%>
<Div id="MenuSol"></Div>
