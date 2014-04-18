<jsp:useBean id="UploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session"></jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<%
	String sampleId = request.getParameter("sampleId");

	ezc.ezparam.ReturnObjFromRetrieve retOther = null;

 	ezc.ezparam.EzcParams oParams = new ezc.ezparam.EzcParams(true);

  	ezc.ezupload.params.EziDocumentTextsTable table =  new ezc.ezupload.params.EziDocumentTextsTable();
  	ezc.ezupload.params.EziDocumentTextsTableRow tableRow=null;
	    	
    	tableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
   	tableRow.setDocType("SAMPLES");
    	tableRow.setDocNo(sampleId);
    	tableRow.setSysKey((String)session.getValue("SYSKEY"));
    	tableRow.setKey("MATERIALSPEC");
    	table.appendRow(tableRow);

  	oParams.setObject(table);	
   	Session.prepareParams(oParams);
	retOther=(ezc.ezparam.ReturnObjFromRetrieve)UploadManager.getDocumentTextDetails(oParams);

%>