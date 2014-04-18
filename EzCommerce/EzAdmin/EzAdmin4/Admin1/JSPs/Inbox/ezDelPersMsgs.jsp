<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%
	String msgFlag = request.getParameter("msgFlag");
	String client = "200";
	String deleteFlag = request.getParameter("DelFlag");
	String moveToFolder = request.getParameter("ToFolder");
	String fromFolder = request.getParameter("FolderID");
	String FolderName=request.getParameter("FolderName");

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
	if(fromFolder==null)
	{
		fromFolder = "1000";
	}
	response.sendRedirect("ezListPersMsgs.jsp?msgFlag="+msgFlag);
%>