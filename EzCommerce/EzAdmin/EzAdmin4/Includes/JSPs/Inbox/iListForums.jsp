<%!
final String FORUM_ID = "EFI_FORUM_ID";
final String FORUM_NAME = "EFI_FORUM_NAME";
%>

<%

       // Key Variables
        ReturnObjFromRetrieve retForumList = null;

	String language = "EN";
	String client = "200";
	EzcForumParams  ezcForumParams= new EzcForumParams();
	EzForumParams ezForumParams = new EzForumParams();

	// Set the Input Parameters
	ezForumParams.setClient(client);
	ezForumParams.setLanguage(language);

	// Set Input Parameter Object in the Container
	ezcForumParams.setObject(ezForumParams);
	Session.prepareParams(ezcForumParams); // Preapare Parameters for Call
	retForumList =(ReturnObjFromRetrieve) ForumsManager.getListOfSubForums(ezcForumParams);
%>
