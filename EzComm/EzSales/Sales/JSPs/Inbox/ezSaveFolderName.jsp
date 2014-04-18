<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>
<html>
<head>
<%
	String folderName = request.getParameter("FolderName");
	
	ReturnObjFromRetrieve retFoldList = null;
	EzcMessageParams  ezcMessageParamsF = new EzcMessageParams();
	EzMessageParams ezMessageParamsF = new EzMessageParams();

	ezMessageParamsF.setClient("200");
	ezMessageParamsF.setLanguage("EN");

	// Set Input Parameter Object in the Container	
	ezcMessageParamsF.setObject(ezMessageParamsF);
	Session.prepareParams(ezcMessageParamsF); 

	// Get List of Folders
	retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParamsF);
	retFoldList.check();

	if (folderName != null)
	{
		folderName = folderName.trim();
		String retFolderName = "";
		int foldCount=retFoldList.getRowCount();
		boolean foldExists = false;
		for ( int i = 0; i<foldCount; i++)
		{
			retFolderName = retFoldList.getFieldValueString(i,"EFI_FOLDER_NAME");
			retFolderName = (retFolderName.toUpperCase()).trim();
			if(retFolderName.equals(folderName.toUpperCase().trim()))
			{
				foldExists = true;
				break;
			}
		}
		
		if (foldExists)
		{
			response.sendRedirect("ezAddFolder.jsp?Folder="+folderName);
			return;
		}
	}

	EzFolderStructure  foldStruc = new EzFolderStructure();

	foldStruc.setFolderName(folderName);
	foldStruc.setLanguage("EN");
	foldStruc.setClient("200");

	EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();
	ezMessageParams.setEzFolderStructure(foldStruc);
	
	// Set Input Parameter Object in the Container	
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams); 

	Manager.createMsgFolder(ezcMessageParams);

	response.sendRedirect("../Inbox/ezListFolders.jsp");
%>
</head>
<body>
<Div id="MenuSol"></Div>
</body>
</html>