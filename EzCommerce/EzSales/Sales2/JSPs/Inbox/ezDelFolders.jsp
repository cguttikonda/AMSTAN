<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>
<%
	int selCount = 0;
	int selFoldersCnt = 0;
	String[] selFolders = request.getParameterValues("CheckBox");
	
	if (selFolders != null) 
		selFoldersCnt = selFolders.length;
	
	for ( int i = 0 ; i < selFoldersCnt; i++ ) 
	{
		if (selFolders != null)
		{
			selCount = selCount + 1;
		}
	}
	
	String [] folders = new String[selCount];
	selCount = 0;
	for ( int i = 0 ; i < selFoldersCnt; i++ ) 
	{
		if (selFolders != null)
		{
			folders[selCount] = new String(selFolders[i]);
			selCount++;
		}
	}
	
	if (folders != null) 
	{
		EzcMessageParams  ezcMessageParams = new EzcMessageParams();
		EzMessageParams ezMessageParams = new EzMessageParams();
		ezMessageParams.setFolderId(folders);
		ezMessageParams.setClient("200");

		ezcMessageParams.setObject(ezMessageParams);
		Session.prepareParams(ezcMessageParams); 

		Manager.deleteFolders(ezcMessageParams);

	
	}

	response.sendRedirect("ezListFolders.jsp");
%>
