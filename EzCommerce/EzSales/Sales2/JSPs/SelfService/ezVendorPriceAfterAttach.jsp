<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="EzUploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />
<%@ page import = "ezc.ezutil.FormatDate"%>

<%
    	String dirName     = request.getParameter("dirName");
    	String attachFile  = request.getParameter("filename");
    	String objId       = (String)session.getValue("AgentCode");
    	String currSysKey  = (String)session.getValue("SalesAreaCode");
    	String today	   = FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY);
    	
    	ezc.ezparam.EzcParams addMainParams = null;
	ezc.ezupload.params.EziUploadDocsParams addParams= null;
	
	ezc.ezupload.params.EziUploadDocFilesTable tabParams= new ezc.ezupload.params.EziUploadDocFilesTable();
	ezc.ezupload.params.EziUploadDocFilesTableRow rowParams= null;
	
	addMainParams = new ezc.ezparam.EzcParams(false);
	addParams= new ezc.ezupload.params.EziUploadDocsParams();
	addParams.setSysKey(currSysKey);
	addParams.setObjectType("VENDPRICE");			
	addParams.setObjectNo(objId);
	addParams.setStatus("");
	addParams.setCreatedOn(today);
	addParams.setCreatedBy(Session.getUserId());
	addParams.setUploadDirectory(dirName);
	addMainParams.setObject(addParams);
	
	rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
	rowParams.setType("VPF");
	rowParams.setClientFileName(attachFile);
	tabParams.appendRow(rowParams);
		
	addMainParams.setObject(tabParams);
	Session.prepareParams(addMainParams);
	EzUploadManager.uploadDoc(addMainParams);	
	
    	
%>


<html>
<head>
<title> </title>
<script>
function funClose()
{
	parent.opener.document.myForm.action="ezVendorPriceUpload.jsp";
	parent.opener.document.myForm.submit();
	parent.window.close();  
}
</script>
</head>
<form name=myForm>

<body scroll=no>
<br>
<TABLE width="90%" align=left>
<tr><td class="blankcell"><b>Files Attached.</b></Td></Tr>
<tr><td class="blankcell"><hr></Td></Tr>
<tr><td class="blankcell">The following file has been attached: </Td></Tr>
<tr><td class="blankcell"><%=attachFile%></Td></Tr>
<tr><td class="blankcell"><hr></Td></Tr>
<tr><td class="blankcell">Click on the 'Done' button</Td></Tr>
<tr><td class="blankcell"><input type="button" name="Done" value="Done" onclick="funClose()"></Td></Tr>
<tr><td class="blankcell"><hr></Td></Tr>
</table>
<input type="hidden" name="n1" value="<%=attachFile%>" >
<input type="hidden" name="dirName" value="<%=dirName%>" >

</form>
<Div id="MenuSol"></Div>
</body>
</html>
