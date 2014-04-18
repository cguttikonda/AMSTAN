<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>

<html>
<head>
<%
	int selCount = 0;
	String[] pCheckBox = request.getParameterValues("CheckBox");
	for ( int i = 0 ; i < pCheckBox.length; i++ ) {
	if ( pCheckBox != null ){
		selCount = selCount + 1;
	}
	}
	String [] folders = new String[selCount];
	selCount = 0;
	for ( int i = 0 ; i < pCheckBox.length; i++ ) {
	 if ( pCheckBox != null ){
		folders[selCount] = new String(pCheckBox[i]);
		selCount++;
	}
	}// End For
	if ( folders != null ) 
	{
		EzcMessageParams  ezcMessageParams = new EzcMessageParams();
		EzMessageParams ezMessageParams = new EzMessageParams();
		ezMessageParams.setFolderId(folders);
		ezMessageParams.setClient("200");
		// Set Input Parameter Object in the Container	
		ezcMessageParams.setObject(ezMessageParams);
		Session.prepareParams(ezcMessageParams); // Preapare Parameters for Call

	// Delete selected folders
	//IBObject.deleteFolders(AdminObject, servlet, folders);
	Manager.deleteFolders(ezcMessageParams);

	
}


// Redirect to display folders page
response.sendRedirect("ezListFolders.jsp");
%>
<Title>Inbox: Delete Folders</Title>
</head>
<Div id="MenuSol"></Div>
</html>