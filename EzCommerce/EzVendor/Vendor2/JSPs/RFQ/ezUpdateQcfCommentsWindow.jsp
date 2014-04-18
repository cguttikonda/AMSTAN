<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/Jsps/Inbox/iGetUploadTempDir.jsp" %>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%
	String qcfcomment 	= request.getParameter("qcfComments");
	String qcfcode		= request.getParameter("qcf_code");
	String comment_nm	= request.getParameter("qcf_comment_no");
	
	ezc.ezpreprocurement.client.EzPreProcurementManager qcfManager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	mainParams.setLocalStore("Y");
	ezc.ezpreprocurement.params.EziQcfCommentParams qcfParams= new ezc.ezpreprocurement.params.EziQcfCommentParams();
	qcfParams.setQcfExt1("еее");
	qcfParams.setQcfCode(qcfcode);
	qcfParams.setCommentNo(comment_nm);
	qcfParams.setQcfComments(qcfcomment);
	mainParams.setObject(qcfParams);
	Session.prepareParams(mainParams);
	qcfManager.addQcfComment(mainParams);
%>	

<html>
<head>
<script>
	function closeWin()
	{
		alert("Comments for <%=qcfcode%> updated successfully")
		window.opener = window.dialogArguments
		opener.document.myForm.submit();
		window.close();
	}
</Script>	
</head>
<body onLoad='closeWin()'>
</html>