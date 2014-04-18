<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="UploadManager" class="ezc.ezupload.client.EzUploadManager" />
<%@page import="ezc.ezparam.*"%>

<%
	String sysKey = request.getParameter("sysKey");
	String soldTo = request.getParameter("soldTo");

  	ezc.ezparam.EzcParams listMainParams = null;
  	ezc.ezupload.params.EziUploadDocsParams listParams= null;

	listMainParams = new ezc.ezparam.EzcParams(false);
	listParams= new ezc.ezupload.params.EziUploadDocsParams();
	listParams.setObjectNo("'"+sysKey+"PROFILE"+soldTo+"'");
	listMainParams.setObject(listParams);
	Session.prepareParams(listMainParams);
	ReturnObjFromRetrieve retUpload = (ReturnObjFromRetrieve)UploadManager.getUploadedDocs(listMainParams);
        ReturnObjFromRetrieve retFiles=null;
	int filesCount=0;

        if(retUpload.getRowCount()>0)
	{
     	 	retFiles = (ReturnObjFromRetrieve)retUpload.getFieldValue(0,"FILES");
		filesCount = retFiles.getRowCount();
        }
	

%>