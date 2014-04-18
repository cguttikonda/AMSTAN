<%!
final String FORUM_ID = "EFI_FORUM_ID";
final String FORUM_NAME = "EFI_FORUM_NAME";
%>

<%
	// Key Variables
	ReturnObjFromRetrieve retForumList = null;

	EzcForumParams  ezcForumParams = new EzcForumParams(false);
	EzForumParams ezForumParams = new EzForumParams();
	ezForumParams.setClient("200");
	ezForumParams.setLanguage("EN");
	ezForumParams.setAccessIndicator("T");
	ezcForumParams.setObject(ezForumParams);

	Session.prepareParams(ezcForumParams);

	// Get List of Forums
	retForumList = (ReturnObjFromRetrieve)ForumsManager.getListOfSubForums(ezcForumParams);
	retForumList.check();
%>
