<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>

<%
	String client = "200";

	String deleteFlag = request.getParameter("DelFlag");
	String moveToFolder = request.getParameter("ToFolder");
	String fromFolder = request.getParameter("FolderID");
	String FolderName=request.getParameter("FolderName");
	
	//If coming from Message Details Page.
	String fromPage = request.getParameter("PageID");
	
	EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();
	
	ezMessageParams.setClient(client);
	ezMessageParams.setToFolderId(moveToFolder);

	
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams); 
	


	if(fromPage != null)
	{
		String msgID = request.getParameter("MessageID");

		ezcMessageParams.setMsgId(msgID);

		if(deleteFlag.equals("Y"))
		{
			Manager.deletePersonalMsg(ezcMessageParams);

		}
		else
		{
			Manager.moveMsgToFolder(ezcMessageParams);
		}
	}
	
	String[] pCheckBox = request.getParameterValues("CheckBox");
	for (int i = 0 ; i < pCheckBox.length; i++)
	{
		if ( pCheckBox != null )
		{
			ezcMessageParams.setMsgId(pCheckBox[i]);
			if(deleteFlag.equals("Y"))
			{
				Manager.deletePersonalMsg(ezcMessageParams);

			}
			else
			{
				Manager.moveMsgToFolder(ezcMessageParams);

			}
		}
	}

	//Incase from folder comes null, it will be set to 1000(Inbox).
	if(fromFolder==null)
	{
		fromFolder = "1000";
	}


	response.sendRedirect("ezListPersMsgs.jsp?type=allmess&FolderID="+fromFolder+"&FolderName="+FolderName);
%>

