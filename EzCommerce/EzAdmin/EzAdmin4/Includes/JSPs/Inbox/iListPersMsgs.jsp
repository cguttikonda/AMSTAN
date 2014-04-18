<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<jsp:useBean id="Mail" class="ezc.ezmail.client.EzMailManager" scope="session"></jsp:useBean>
<%@ page import="java.util.*" %>
<%
	ReturnObjFromRetrieve retExternal = null;
	ReturnObjFromRetrieve retMsgList = null;
	ReturnObjFromRetrieve retFoldList = null;
	ReturnObjFromRetrieve GlobObj = null;
	global.setDateFormat("MM/dd/yyyy HH:mm:ss");

	String language = "EN";
	String client = "200";

	String folderID = request.getParameter("FolderID");
	if(folderID == null)
		folderID = "1000";

	String folderName = request.getParameter("FolderName");
	if (folderName == null)
		folderName="Inbox";

	String msgFlag = request.getParameter("msgFlag");

	try
	{
		ezc.ezmail.EzcMailParams mailParams = new ezc.ezmail.EzcMailParams();
		mailParams.setGroupId("Ezc");
		mailParams.setFolderName("Inbox");
		ezc.ezmail.EzMail mail=new ezc.ezmail.EzMail();

		EzcMessageParams  ezcMessageParams = new EzcMessageParams();
		EzMessageParams ezMessageParams = new EzMessageParams();
		ezMessageParams.setClient(client);
		ezMessageParams.setToFolderId(folderID);
		ezMessageParams.setLanguage(language);
		ezcMessageParams.setObject(ezMessageParams);
		Session.prepareParams(ezcMessageParams);

		if(msgFlag.equals("1"))
		{
			retMsgList = (ReturnObjFromRetrieve)Manager.getPersonalNewMsgHeader(ezcMessageParams);
			try
			{
				retExternal = mail.getNewMails(mailParams,Session);
			}
			catch(Exception e1)
			{}
		}
		else
		{
			retMsgList = (ReturnObjFromRetrieve)Manager.getPersonalAllMsgHeader(ezcMessageParams);
			try
			{
				retExternal = mail.getAllMails(mailParams,Session);
			}
			catch(Exception e1)
			{}
		}
		retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParams);
	}
	catch(Exception e)
	{
		out.println(e);
	}

	if(retMsgList.getRowCount()>0)
	{
		java.util.Vector types = new java.util.Vector();
		types.addElement("date");
		global.setColTypes(types);

		java.util.Vector names = new java.util.Vector();
		names.addElement(MSG_CREATED_DATE);
		global.setColNames(names);

		GlobObj = (ReturnObjFromRetrieve)global.getGlobal(retMsgList);
	}

	int extMailCount=0;
	ReturnObjFromRetrieve extGlob=null;
	if(retExternal != null)
	{
		extMailCount=retExternal.getRowCount();

		if(extMailCount > 0)
		{
			java.util.Vector types = new java.util.Vector();
			types.addElement("date");
			global.setColTypes(types);

			java.util.Vector names = new java.util.Vector();
			names.addElement("DATE");
			global.setColNames(names);

			extGlob = (ReturnObjFromRetrieve)global.getGlobal(retExternal);

		}
	}
%>