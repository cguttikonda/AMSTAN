<%!
final String FORUM_ID = "EFI_FORUM_ID";
final String FORUM_NAME = "EFI_FORUM_NAME";
%>
<%
	// Key Variables
	ReturnObjFromRetrieve retForumList = null;
	ReturnObjFromRetrieve retSubForumList = null;

	EzcForumParams  ezcForumParams = new EzcForumParams(false);
	EzForumParams ezForumParams = new EzForumParams();
	ezForumParams.setClient("200");
	ezForumParams.setLanguage("EN");
	ezForumParams.setAccessIndicator("T");
	ezcForumParams.setObject(ezForumParams);

	Session.prepareParams(ezcForumParams);

	retForumList = (ReturnObjFromRetrieve)ForumsManager.getListOfForums(ezcForumParams);
	retForumList.check();

	retSubForumList =(ReturnObjFromRetrieve) ForumsManager.getListOfSubForums(ezcForumParams);
	retSubForumList.check();
%>
