<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezshipment.client.*" %>
<%@ page import = "ezc.ezshipment.params.*" %>

<%@ page import = "ezc.ezvendorapp.client.*" %>
<%@ page import = "ezc.ezvendorapp.params.*" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<jsp:useBean id="EzUploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />



<%
	String currSysKey = (String)session.getValue("SYSKEY");
	String defErpVendor =(String)session.getValue("SOLDTO");

	String SampleId = request.getParameter("SampleId");
	String materialdesc=request.getParameter("materialdesc");

	EzSampleMaterialStructure inStructSample=new EzSampleMaterialStructure();
	EzcParams sampleParams=new EzcParams(true);
	EzVendorAppManager vendorManager= new EzVendorAppManager();
	inStructSample.setSampleId(SampleId);
	sampleParams.setLocalStore("Y");
	sampleParams.setObject(inStructSample);
	Session.prepareParams(sampleParams);
	ReturnObjFromRetrieve sampmat=(ReturnObjFromRetrieve)vendorManager.ezGetSampleMaterial(sampleParams);


	EzShipmentManager shipManager= new EzShipmentManager();
	EziShipmentInfoParams inParams =new EziShipmentInfoParams();
	inParams.setSelection("A");
	inParams.setPurchaseOrderNumber("Samples");
	inParams.setSysKey(currSysKey);
	inParams.setSoldTo(defErpVendor);
	inParams.setShipId(sampmat.getFieldValueString(0,"SHIPMENTID"));
	EzcParams ezcparams= new EzcParams(true);
	ezcparams.setLocalStore("Y");
	ezcparams.setObject(inParams);
	inParams.setStatus("Y");
	Session.prepareParams(ezcparams);
	ReturnObjFromRetrieve ret=(ReturnObjFromRetrieve)shipManager.ezGetShipmentInfo(ezcparams);

	ReturnObjFromRetrieve retHead = new ReturnObjFromRetrieve();
	ReturnObjFromRetrieve retLines = new ReturnObjFromRetrieve();
	ReturnObjFromRetrieve retSchedules = new ReturnObjFromRetrieve();

	if ((ret!=null)&&(ret.getRowCount()>0)){
		retHead = (ReturnObjFromRetrieve)ret.getFieldValue("HEADER");
		retLines=(ReturnObjFromRetrieve)ret.getFieldValue("LINES");
		retSchedules=(ReturnObjFromRetrieve)ret.getFieldValue("SCHEDULES");


	}


	ezc.ezparam.EzcParams detailsMainParams = new ezc.ezparam.EzcParams(false);
	detailsMainParams.setLocalStore("Y");
	ezc.ezupload.params.EziAddressParams detailsParams= new ezc.ezupload.params.EziAddressParams();
	
	String suppAddr = sampmat.getFieldValueString(0,"SUPPLIERADDRID");
	if(suppAddr.equals("0"))
	{
		detailsParams.setNo(sampmat.getFieldValueString(0,"MSADDRID"));
	}
	else
	{
		detailsParams.setNo(sampmat.getFieldValueString(0,"MSADDRID")+","+sampmat.getFieldValueString(0,"SUPPLIERADDRID"));
	}

	detailsMainParams.setObject(detailsParams);
	Session.prepareParams(detailsMainParams);
	ezc.ezparam.ReturnObjFromRetrieve detailsRet=(ezc.ezparam.ReturnObjFromRetrieve)EzUploadManager.getAddress(detailsMainParams);

	ezc.ezparam.EzcParams listCoaParams = new ezc.ezparam.EzcParams(true);
	listCoaParams.setLocalStore("Y");
	ezc.ezshipment.params.EziCOAParams iParams= new ezc.ezshipment.params.EziCOAParams();
	iParams.setDocumentNo(SampleId);
	listCoaParams.setObject(iParams);
	Session.prepareParams(listCoaParams);
	ezc.ezparam.ReturnObjFromRetrieve listCOA=(ezc.ezparam.ReturnObjFromRetrieve)shipManager.ezListCOA(listCoaParams);


%>
