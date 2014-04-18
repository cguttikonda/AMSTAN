<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>

<%!
final String FOLDER_ID = "EFI_FOLDER_ID";
final String FOLDER_NAME = "EFI_FOLDER_NAME";

%>

<%
// Key Variables
ReturnObjFromRetrieve retFoldList = null;

String language = "EN";
String client = "200";
	EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();

	// Set the Input Parameters
	ezMessageParams.setClient(client);
	ezMessageParams.setLanguage(language);

	// Set Input Parameter Object in the Container	
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams); // Preapare Parameters for Call


// Get List of Folders
//retFoldList = (ReturnObjFromRetrieve)IBObject.getFolderList(AdminObject, servlet, client, language);
retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParams);
retFoldList.check();


%>