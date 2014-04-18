<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>

<%
	String client = "200";

	String deleteFlag = request.getParameter("DelFlag");
	String moveToFolder = request.getParameter("ToFolder");
	String fromFolder = request.getParameter("FolderID");
	String FolderName=request.getParameter("FolderName");
	String msgType = request.getParameter("type");
	String msgFlag="";
	if("allmess".equals(msgType))msgFlag="0";
	if("newmess".equals(msgType))msgFlag="1";
	
	//If coming from Message Details Page.
	String fromPage = "";//request.getParameter("PageID");
	
	ezc.ezcommon.EzLog4j.log("msgType::::::"+msgType,"D");
	ezc.ezcommon.EzLog4j.log("fromFolder::::::"+fromFolder,"D");
	ezc.ezcommon.EzLog4j.log("FolderName::::::"+FolderName,"D");
	
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
			Manager1.deletePersonalMsg(ezcMessageParams);

		}
		else
		{
			Manager1.moveMsgToFolder(ezcMessageParams);
		}
	}
	
	String[] pCheckBox = request.getParameterValues("CheckBox1");
	for (int i = 0 ; i < pCheckBox.length; i++)
	{
		if ( pCheckBox != null )
		{
			ezc.ezcommon.EzLog4j.log("pCheckBox[i]::::::"+pCheckBox[i],"D");
			ezcMessageParams.setMsgId(pCheckBox[i]);
			if(deleteFlag.equals("Y"))
			{
				Manager1.deletePersonalMsg(ezcMessageParams);

			}
			else
			{
				Manager1.moveMsgToFolder(ezcMessageParams);

			}
		}
	}

	//Incase from folder comes null, it will be set to 1000(Inbox).
	if(fromFolder==null)
	{
		fromFolder = "1000";
	}


	//response.sendRedirect("ezListPersMsgsMain.jsp?type="+msgType+"&FolderID="+fromFolder+"&FolderName="+FolderName+"&msgFlag="+msgFlag);
%>

