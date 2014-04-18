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

	String language_I = "EN";
	String client_I = "200";
	
	test="true";
	
	type=request.getParameter("type");
	
	
	if(type==null)
	       type="newmess";
	       
	folderID = request.getParameter("FolderID");
	if(folderID == null)
		folderID = "1000";
	
	folderName = request.getParameter("FolderName");
	if (folderName == null) 
		folderName="Inbox";
	

	ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();
	mailParams.setFolderName(folderName);		

	
	EzcMessageParams  ezcMessageParams_I = new EzcMessageParams();
	EzMessageParams ezMessageParams_I = new EzMessageParams();
	
	//Set the Input Parameters
	ezMessageParams_I.setClient(client_I);
	ezMessageParams_I.setToFolderId(folderID);
	ezMessageParams_I.setLanguage(language_I);

	//Set Input Parameter Object in the Container
	ezcMessageParams_I.setObject(ezMessageParams_I);
	Session.prepareParams(ezcMessageParams_I); 

	String newFlag = request.getParameter("msgFlag");
	if (newFlag == null)
	{
		newFlag = "1";
	}
	ezc.ezcommon.EzLog4j.log(" newFlag::::::::"+newFlag,"D");
	ezc.ezcommon.EzLog4j.log(" folderName::::::"+folderName,"D");
	ezc.ezcommon.EzLog4j.log(" type::::::"+type,"D");
	ezc.ezcommon.EzLog4j.log(" folderID::::::"+folderID,"D");
	
	/*******Changes Starts*****/
	int messageCnt =0;
	if(session.getValue("ASB_USR_PERS_MSGS")!=null)
	{
		retMsgList=(ezc.ezparam.ReturnObjFromRetrieve)session.getValue("ASB_USR_PERS_MSGS");
	}
	else
	{
		if(newFlag.equals("1"))
		{
			//Get List of New Message Headers Only(Subjects not details).
			retMsgList = (ReturnObjFromRetrieve)Manager1.getPersonalNewMsgHeader(ezcMessageParams_I);
			//ezc.ezcommon.EzLog4j.log("IN IFFF retMsgList"+retMsgList.toEzcString(),"D");
			session.putValue("ASB_USR_PERS_MSGS",retMsgList);
		}
		else
		{
			ezc.ezcommon.EzLog4j.log("IN ESLE","D");
			retMsgList = (ReturnObjFromRetrieve)Manager1.getPersonalAllMsgHeader(ezcMessageParams_I);
			//ezc.ezcommon.EzLog4j.log("IN ESLE retMsgList"+retMsgList.toEzcString(),"D");
			session.putValue("ASB_USR_PERS_MSGS",retMsgList);
		}
	}

	if(retMsgList!=null)
		messageCnt = retMsgList.getRowCount();

	temp="false";
	retMsgList.check();

	if(session.getValue("ASB_USR_FOLDERS")!=null)
	{
		retFoldList=(ezc.ezparam.ReturnObjFromRetrieve)session.getValue("ASB_USR_FOLDERS");
	}
	else
	{

		retFoldList = (ReturnObjFromRetrieve)Manager1.getFolderList(ezcMessageParams_I);
		//ezc.ezcommon.EzLog4j.log("end of the page in try:"+retFoldList.getRowCount()+","+retMsgList.getRowCount(),"D");
		session.putValue("ASB_USR_FOLDERS",retFoldList);
	}
	/*******Changes End*****/
		
%>