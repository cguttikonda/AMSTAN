<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezcommon.*" %>
<%@ page import="ezc.ezupload.params.*" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<jsp:useBean id="EzUploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />

<%
	String clientfile=request.getParameter("clientfile");
	String serverfile=request.getParameter("serverfile");
	mainParams=new EzcParams(false);
	EziUploadDocFilesParams docfiles=new EziUploadDocFilesParams();
	docfiles.setClientFileName(clientfile);
	docfiles.setServerFileName(serverfile);
	mainParams.setObject(docfiles);
	EzUploadManager.getFile(mainParams,response);
%>
<Div id="MenuSol"></Div>
