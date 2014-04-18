<jsp:useBean id="EzUploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />

<%
	String addressNo = null;
	addressNo = request.getParameter("chk1");
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezupload.params.EziAddressParams params = new ezc.ezupload.params.EziAddressParams();
      	
      	if(addressNo!=null || "null".equals(addressNo))
      		params.setNo(addressNo);
        mainParams.setObject(params);
	Session.prepareParams(mainParams);
	
	ezc.ezparam.ReturnObjFromRetrieve ret=(ezc.ezparam.ReturnObjFromRetrieve)EzUploadManager.getAddress(mainParams); 
	
%>