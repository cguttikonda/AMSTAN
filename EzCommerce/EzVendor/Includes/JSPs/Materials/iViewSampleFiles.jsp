<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="UploadManager" class="ezc.ezupload.client.EzUploadManager" />
<%@page import="ezc.ezparam.*"%>

<%
	String sysKey = request.getParameter("sysKey");
	String sampleId = request.getParameter("sampleId");

  	ezc.ezparam.EzcParams listMainParams = null;
  	ezc.ezupload.params.EziUploadDocsParams listParams= null;

	listMainParams = new ezc.ezparam.EzcParams(false);
	listParams= new ezc.ezupload.params.EziUploadDocsParams();
	listParams.setObjectNo("'"+sysKey+"SAMPLES"+sampleId+"'");
	listMainParams.setObject(listParams);
	Session.prepareParams(listMainParams);
	ReturnObjFromRetrieve retUpload = (ReturnObjFromRetrieve)UploadManager.getUploadedDocs(listMainParams);
	ReturnObjFromRetrieve retFiles = (ReturnObjFromRetrieve)retUpload.getFieldValue(0,"FILES");

	int filesCount = retFiles.getRowCount();
	
	
%>