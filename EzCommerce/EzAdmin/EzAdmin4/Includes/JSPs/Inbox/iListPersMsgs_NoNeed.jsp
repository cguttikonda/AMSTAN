<%


	// Key Variables
	ReturnObjFromRetrieve retMsgList = null;
	ReturnObjFromRetrieve retFoldList = null;
	String language = "EN";
	String folderID = request.getParameter("FolderID");
	if(folderID == null)
	{
		folderID = "1000";
	}
	String folderName = request.getParameter("FolderName");
	if (folderName == null) 
		folderName="Inbox";

	String client = "200";

	//EzMessagingManager mManager = new EzMessagingManager();
	EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();

	// Set the Input Parameters
	ezMessageParams.setClient(client);
	ezMessageParams.setToFolderId(folderID);
	ezMessageParams.setLanguage(language);

	// Set Input Parameter Object in the Container
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams); // Preapare Parameters for Call

	String newFlag = request.getParameter("msgFlag");

	if (newFlag == null)
		{
		newFlag = "0";
		}
	if(newFlag.equals("1"))
		{
		// Get List of New Message Headers Only
		retMsgList = (ReturnObjFromRetrieve)Manager.getPersonalNewMsgHeader(ezcMessageParams);
		}
	else
		{
		retMsgList = (ReturnObjFromRetrieve)Manager.getPersonalAllMsgHeader(ezcMessageParams);
		}
		retMsgList.check();

		retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParams);
%>