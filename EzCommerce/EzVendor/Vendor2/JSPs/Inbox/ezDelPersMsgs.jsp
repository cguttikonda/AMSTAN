<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>

<%
String client = "200";

String deleteFlag = request.getParameter("DelFlag");
String moveToFolder = request.getParameter("ToFolder");
String fromFolder = request.getParameter("FolderID");
String FolderName=request.getParameter("FolderName");
	//If coming from Message Details Page
	String fromPage = request.getParameter("PageID");
	EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();
	

	ezMessageParams.setClient(client);
	ezMessageParams.setToFolderId(moveToFolder);

	
	// Set Input Parameter Object in the Container
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams); // Preapare Parameters for Call


if(fromPage != null)
{
	String msgID = request.getParameter("MessageID");

	// Set Input Parameter in the Container
	ezcMessageParams.setMsgId(msgID);

	if(deleteFlag.equals("Y"))
	{
		//Delete Message Call
		//IBObject.deletePersonalMsg(AdminObject, servlet, client, msgID);
		Manager.deletePersonalMsg(ezcMessageParams);

	}else{
		//Move Message to a Folder Call
		//IBObject.moveMsgToFolder(AdminObject, servlet, client, msgID, moveToFolder);
		Manager.moveMsgToFolder(ezcMessageParams);

	}
}


// Loop thru the last selection
	
String[] pCheckBox = request.getParameterValues("CheckBox");
for (int i = 0 ; i < pCheckBox.length; i++)
{
 	if ( pCheckBox != null )
 	{
		// Set Input Parameter in the Container	
		ezcMessageParams.setMsgId(pCheckBox[i]);
		if(deleteFlag.equals("Y"))
		{
			//Delete Message Call
			//IBObject.deletePersonalMsg(AdminObject, servlet, client, pMessageID);
			Manager.deletePersonalMsg(ezcMessageParams);

		}else{
			//Move Message to a Folder Call
			//IBObject.moveMsgToFolder(AdminObject, servlet, client, pMessageID, moveToFolder);
			Manager.moveMsgToFolder(ezcMessageParams);

		}
	}
}// End For

if(fromFolder==null){
	fromFolder = "1000";
}

// Redirect to display messages page
response.sendRedirect("ezListPersMsgs.jsp?type=allmess&FolderID="+fromFolder+"&FolderName="+FolderName);

%>
<html>
<head>
<Title>Inbox: Delete Personal Messages</Title>
</head>
<Div id="MenuSol"></Div>
</html>
