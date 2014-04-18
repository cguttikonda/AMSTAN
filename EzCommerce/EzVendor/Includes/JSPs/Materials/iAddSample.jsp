<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezvendorapp.client.*" %>
<%@ page import = "ezc.ezvendorapp.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session" />
<jsp:useBean id="UploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />

<%

	String manAddress1Id = "";
	String manAddress2Id = "";
	String manAddress3Id = "";
	
	String isAddressAvailable = "N";
	int addressCount = 0;

	String sysKey= (String)session.getValue("SYSKEY");
	String soldTo = (String)session.getValue("SOLDTO");

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	ezc.ezvendorapp.params.EzVendorProfileStructure profileStruct =  new ezc.ezvendorapp.params.EzVendorProfileStructure();	

	profileStruct.setSysKey(sysKey);
	profileStruct.setSoldTo(soldTo.trim());

	mainParams.setObject(profileStruct);	
	mainParams.setLocalStore("Y");	
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve retProfile= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetVendorProfile(mainParams);	
	int profileCount=retProfile.getRowCount();
	ezc.ezparam.ReturnObjFromRetrieve retAddress=null;
        ReturnObjFromRetrieve retVendor=null;

	if(profileCount>0)
	{

		EzVendorAppManager appManager= new EzVendorAppManager();
		EzVendorQuestionnaireStructure struct =new EzVendorQuestionnaireStructure();
		struct.setSysKey(sysKey);
		struct.setSoldTo(soldTo.trim());
		EzcParams ezcparams= new EzcParams(true);
		ezcparams.setLocalStore("Y");
		ezcparams.setObject(struct);
		Session.prepareParams(ezcparams);
		retVendor=(ReturnObjFromRetrieve)appManager.ezGetVendorQuestionnaire(ezcparams);
		
		
		manAddress1Id = retProfile.getFieldValueString(0,"MFADDRESS1ID");
	     	manAddress2Id = retProfile.getFieldValueString(0,"MFADDRESS2ID");
	     	manAddress3Id = retProfile.getFieldValueString(0,"MFADDRESS3ID");       	

		ezc.ezparam.EzcParams eParams = new ezc.ezparam.EzcParams(true);
		ezc.ezupload.params.EziAddressParams params =  new ezc.ezupload.params.EziAddressParams();	
	        String no = manAddress1Id+","+manAddress2Id+","+manAddress3Id;
        	params.setNo(no);
		eParams.setObject(params);	
		Session.prepareParams(eParams);
	    	retAddress=(ezc.ezparam.ReturnObjFromRetrieve)UploadManager.getAddress(eParams);	
    		addressCount = retAddress.getRowCount();
    	    
	}
	



%>
