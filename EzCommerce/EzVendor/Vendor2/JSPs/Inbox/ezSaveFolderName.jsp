<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<html>
<head>

<%
/** Added by Venkat on 5/2/2001 **/
	ReturnObjFromRetrieve retFoldList = null;
	EzcMessageParams  ezcMessageParamsF = new EzcMessageParams();
	EzMessageParams ezMessageParamsF = new EzMessageParams();

	// Set the Input Parameters
	ezMessageParamsF.setClient("200");
	ezMessageParamsF.setLanguage("EN");

	// Set Input Parameter Object in the Container	
	ezcMessageParamsF.setObject(ezMessageParamsF);
	Session.prepareParams(ezcMessageParamsF); // Preapare Parameters for Call

	// Get List of Folders
	retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParamsF);
	retFoldList.check();
/** Changes end here **/

String folderName = request.getParameter("FolderName");

/** Added by Venkat on 5/2/2001 **/
if ( folderName != null )
{
	folderName = folderName.trim();
	String retFolderName = "";
	int foldCount=retFoldList.getRowCount();
	boolean foldExists = false;
	for ( int i = 0; i<foldCount; i++)
	{
		retFolderName = retFoldList.getFieldValueString(i,"EFI_FOLDER_NAME");
		retFolderName = (retFolderName.toUpperCase()).trim();
		if( retFolderName.equals(folderName.toUpperCase().trim()) )
		{
			foldExists = true;
			break;
		}
	}
	if ( foldExists )
	{
		response.sendRedirect("ezAddFolder.jsp?Folder="+folderName);
		return;
	}
}
/** Changes end here **/


String language = "EN";
String client = "200";

	EzFolderStructure foldStruc = null;

	foldStruc = new EzFolderStructure();

	foldStruc.setFolderName(folderName);
	foldStruc.setLanguage(language);
	foldStruc.setClient(client);

	EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();
	ezMessageParams.setEzFolderStructure(foldStruc);
	
	// Set Input Parameter Object in the Container	
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams); // Preapare Parameters for Call



//Create New Folder
//IBObject.createMsgFolder(AdminObject, servlet, foldStruc);
Manager.createMsgFolder(ezcMessageParams);


//Redirect to List Folders Page
response.sendRedirect("../Inbox/ezListFolders.jsp");
%>
</head>
<body>
<Div id="MenuSol"></Div>
</body>
</html>