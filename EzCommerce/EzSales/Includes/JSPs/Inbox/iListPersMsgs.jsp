<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInbox.jsp"%>
<%@ page import="java.util.*" %>
<%

	ReturnObjFromRetrieve retExternal = new ReturnObjFromRetrieve();
	ReturnObjFromRetrieve retExternalNew = new ReturnObjFromRetrieve();
	ReturnObjFromRetrieve retMsgList = null;
	ReturnObjFromRetrieve retFoldList = null;
	String folderID="";
	String folderName="";
	String type="";
	String test="false";
	String temp="false";

	String language = "EN";
	String client = "200";
	
	test="true";
	
	type=request.getParameter("type");
	
	
	if(type==null)
	       type="allmess";
	       
	folderID = request.getParameter("FolderID");
	if(folderID == null)
		folderID = "1000";
	
	folderName = request.getParameter("FolderName");
	if (folderName == null) 
		folderName="Inbox";
	

	ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();
	mailParams.setFolderName(folderName);		

	
	EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();
	
	//Set the Input Parameters
	ezMessageParams.setClient(client);
	ezMessageParams.setToFolderId(folderID);
	ezMessageParams.setLanguage(language);

	//Set Input Parameter Object in the Container
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams); 

	String newFlag = request.getParameter("msgFlag");
	if (newFlag == null)
	{
		newFlag = "0";
	}
	if(newFlag.equals("1"))
	{
		//Get List of New Message Headers Only(Subjects not details).
		retMsgList = (ReturnObjFromRetrieve)Manager.getPersonalNewMsgHeader(ezcMessageParams);
	}
	else
	{
		retMsgList = (ReturnObjFromRetrieve)Manager.getPersonalAllMsgHeader(ezcMessageParams);
	}
	
	temp="false";
	retMsgList.check();
	retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParams);
	System.out.println("end of the page in try:"+retFoldList.getRowCount()+","+retMsgList.getRowCount());

%>
