<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>
<%@ page import="java.util.*" %>
<%
	String temp="false";
	ReturnObjFromRetrieve retMsgList = null;
	ReturnObjFromRetrieve retFoldList = null;
	String folderID="";
	String folderName="";
	String type="";

	ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();
	folderName = request.getParameter("FolderName");
	if (folderName == null)
		folderName="Inbox";
	mailParams.setFolderName(folderName);

	type=request.getParameter("type");
	if(type==null)
	{
		type="allmess";
	}
	String language = "EN";
	folderID = request.getParameter("FolderID");
	if(folderID == null)
	{
		folderID = "1000";
	}
	String client = "200";
	EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();
	ezMessageParams.setClient(client);
	ezMessageParams.setToFolderId(folderID);
	ezMessageParams.setLanguage(language);
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams);
	String newFlag = request.getParameter("msgFlag");
	if (newFlag == null)
	{
		newFlag = "0";
	}
	if(newFlag.equals("1"))
	{
		retMsgList = (ReturnObjFromRetrieve)Manager.getPersonalNewMsgHeader(ezcMessageParams);
	}
	else
	{
		retMsgList = (ReturnObjFromRetrieve)Manager.getPersonalAllMsgHeader(ezcMessageParams);
	}
	temp="false";
	//retMsgList.check();
	retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParams);

%>
