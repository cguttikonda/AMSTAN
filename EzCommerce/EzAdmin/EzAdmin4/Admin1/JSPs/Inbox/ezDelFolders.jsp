<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%
	String msgFlag = request.getParameter("msgFlag");
	int selCount = 0;
	String[] pCheckBox = request.getParameterValues("CheckBox");
	for ( int i = 0 ; i < pCheckBox.length; i++ ) 
	{
		if ( pCheckBox != null )
		{
			selCount = selCount + 1;
		}
	}
	String [] folders = new String[selCount];
	selCount = 0;
	for ( int i = 0 ; i < pCheckBox.length; i++ ) 
	{
	 	if ( pCheckBox != null )
	 	{
			folders[selCount] = new String(pCheckBox[i]);
			selCount++;
		}
	}
	if ( folders != null ) 
	{
		EzcMessageParams  ezcMessageParams = new EzcMessageParams();
		EzMessageParams ezMessageParams = new EzMessageParams();
		ezMessageParams.setFolderId(folders);
		ezMessageParams.setClient("200");
		ezcMessageParams.setObject(ezMessageParams);
		Session.prepareParams(ezcMessageParams);
		Manager.deleteFolders(ezcMessageParams);
	}
	response.sendRedirect("ezListFolders.jsp?msgFlag="+msgFlag);
%>