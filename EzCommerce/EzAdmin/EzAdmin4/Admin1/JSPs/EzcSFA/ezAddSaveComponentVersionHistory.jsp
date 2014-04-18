
<%--@ include file="../../Library/Globals/errorPagePath.jsp"--%>
<%@ page import="java.util.Enumeration,javax.servlet.*,javax.servlet.http.*,java.io.*" %>
<%@ include file="../../../Includes/Lib/iEzMain1.jsp" %>

<%
	String attachDoc = request.getParameter("attachs");
	String attachFile = request.getParameter("attachx");
	ResourceBundle rb=ResourceBundle.getBundle("Site");
	String tempDir=rb.getString("INBOXPATH")+session.getId();
	String code=request.getParameter("code");
	
	String userName = request.getParameter("uName");
	if("".equals(userName) || userName == null)
		userName = "ALL";

//This block is for taking version of the page;

	ezc.ezparam.EzcParams compParams = new ezc.ezparam.EzcParams(false);
	EziComponentsParams ezicomponenentsparams= new EziComponentsParams();
	ReturnObjFromRetrieve retComponentDetails=null;
	ezicomponenentsparams.setCode(code);
	compParams.setObject(ezicomponenentsparams);
	Session.prepareParams(compParams);
	retComponentDetails=(ezc.ezparam.ReturnObjFromRetrieve)cmanager.getComponentsDetails(compParams);

	String version=retComponentDetails.getFieldValueString(0,"VERSION");

	String desc=retComponentDetails.getFieldValueString(0,"DESCRIPTION");

	if(desc!=null && version!=null)
	{
		if(version.indexOf(".")>0)
		{
			String pres=version.substring(version.indexOf(".")+1);
			String mVal=version.substring(0,version.indexOf("."));
			
			int a=Integer.parseInt(pres);
			int b=Integer.parseInt(mVal);
			a++;
			
			if(a == 10)
			{
				a=0;
				b++;
			}
			version = b +"."+ a;
		}
		else
		{
			version = version + ".1";
		}
		

		ezc.ezparam.EzcParams compParams1 = new ezc.ezparam.EzcParams(false);
		EziComponentsParams ezicomponenentsparams1= new EziComponentsParams();
		ReturnObjFromRetrieve retComponentUpdate=null;
		ezicomponenentsparams1.setCode(code);

		ezicomponenentsparams1.setVersion(version);
		ezicomponenentsparams1.setDescription(desc);
		compParams1.setObject(ezicomponenentsparams1);
		Session.prepareParams(compParams1);
		retComponentUpdate=(ezc.ezparam.ReturnObjFromRetrieve)cmanager.updateComponents(compParams1);
	
	}



	
	String releasedOn=request.getParameter("releasedOn");

	String myid=(String)session.getValue("userId");
	ReturnObjFromRetrieve retPatchNo=null;
 	ezc.ezupload.client.EzUploadManager uploadManager= new ezc.ezupload.client.EzUploadManager();
	ezc.ezupload.params.EziUploadDocFilesTable tabParams;
	ezc.ezupload.params.EziUploadDocFilesTableRow rowParams;

	ezc.ezparam.EzcParams myParams= new ezc.ezparam.EzcParams(false);
	//myParams.setLocalStore("Y");
	ezc.ezupload.params.EziUploadDocsParams uDocsParams= new ezc.ezupload.params.EziUploadDocsParams();
	uDocsParams.setUploadDirectory(tempDir);
	uDocsParams.setObjectType("VERSION");
	uDocsParams.setObjectNo(code);
	uDocsParams.setStatus("U");
	uDocsParams.setSysKey("555555");
	uDocsParams.setCreatedBy(Session.getUserId());
	myParams.setObject(uDocsParams);
	int i=1;

		StringTokenizer fileToken = new StringTokenizer(attachFile,",");
		tabParams = new ezc.ezupload.params.EziUploadDocFilesTable();
		while(fileToken.hasMoreElements())
		{
			String finalfile=(String)fileToken.nextToken();
			if(!finalfile.equals("NA"))
			{
				rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
				rowParams.setType(String.valueOf(i));
				rowParams.setClientFileName(finalfile);
				tabParams.appendRow(rowParams);
			}
			i++;
		}
	myParams.setObject(tabParams);
	Session.prepareParams(myParams);
	retPatchNo = (ReturnObjFromRetrieve )uploadManager.uploadDoc(myParams);

	String patchNo="";
	if(retPatchNo !=null)
	patchNo=retPatchNo.getFieldValueString(0,"UPLOADNO");
%>
	
<%
	rowParams = (ezc.ezupload.params.EziUploadDocFilesTableRow)tabParams.getRow(0);
	String serverFileName = "F:\\ora9ias\\j2ee\\home\\default-web-app\\EzCom\\Upload\\"+rowParams.getServerFileName();
	
	System.out.println("Server File Name ::: "+serverFileName);
	
	new EzUnzipToTempHtml().doUnzip(serverFileName);
	
	ezc.ezparam.EzcParams ezcparams = new ezc.ezparam.EzcParams(false);
	ezcparams.setLocalStore("Y");
	EziComponentVersionHistoryParams ezicomponentversionhistoryparams= new EziComponentVersionHistoryParams();
	ReturnObjFromRetrieve retComponentVersionHistory=null;
	ezicomponentversionhistoryparams.setPatch(patchNo);
	ezicomponentversionhistoryparams.setReleasedOn(releasedOn);

	ezicomponentversionhistoryparams.setVersion(version);
	ezicomponentversionhistoryparams.setCode(code);
	ezcparams.setObject(ezicomponentversionhistoryparams);
	Session.prepareParams(ezcparams);
	retComponentVersionHistory=(ezc.ezparam.ReturnObjFromRetrieve)cmanager.addComponentVersionHistory(ezcparams);
	
	String historyNo = "";
	if(retComponentVersionHistory.getFieldValueString(0,"HISTORY_NO") != null)
		historyNo = retComponentVersionHistory.getFieldValueString(0,"HISTORY_NO");
%>
<%@ include file="ezPostPatch.jsp" %>
<%
	response.sendRedirect("ezComponentsVersionHistoryList.jsp");
%>