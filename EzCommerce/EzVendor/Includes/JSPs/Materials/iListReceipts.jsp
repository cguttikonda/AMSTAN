<%@ page import = "ezc.ezparam.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />


<%@ page import = "ezc.ezvendorapp.client.*" %>
<%@ page import = "ezc.ezvendorapp.params.*" %>
<jsp:useBean id="EzUploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />

<%

	String currSysKey = (String)session.getValue("SYSKEY");
	String defErpVendor = (String)session.getValue("SOLDTO");

	EzSampleMaterialStructure inStructSample=new EzSampleMaterialStructure();
	EzcParams sampleParams=new EzcParams(true);
	EzVendorAppManager vendorManager= new EzVendorAppManager();

	inStructSample.setSoldTo(defErpVendor);
	inStructSample.setSysKey(currSysKey);
	sampleParams.setLocalStore("Y");
	sampleParams.setObject(inStructSample);
	Session.prepareParams(sampleParams);
	ReturnObjFromRetrieve sampmat=(ReturnObjFromRetrieve)vendorManager.ezListSampleMaterial(sampleParams);

%>
