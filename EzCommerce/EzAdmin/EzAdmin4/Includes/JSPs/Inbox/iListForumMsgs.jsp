<%!
final String FORUM_MSG_ID = "EFA_MSG_ID";
final String FORUM_MSG_HEADER = "EFA_MSG_HEADER";
final String FORUM_MSG_CONTENT1 = "EFA_MSG_CONTENT1";
final String FORUM_MSG_CONTENT2 = "EFA_MSG_CONTENT2";
final String FORUM_MSG_CREATED_BY = "EFA_CREATED_BY";
final String FORUM_MSG_CREATED_DATE =  "EFA_MSG_CREATION_DATE";
final String FORUM_MSG_CREATED_TIME =  "EFA_MSG_CREATION_TIME";
%>

<%
	// Key Variables
	ReturnObjFromRetrieve retMsgList = null;

	String language = "EN";
	String client = "200";
	String forumID = request.getParameter("ForumID");

	EzcForumParams  ezcForumParams= new EzcForumParams();
	EzForumParams ezForumParams = new EzForumParams();

	// Set the Input Parameters
	ezForumParams.setClient(client);
	ezcForumParams.setForumId(forumID);
	ezForumParams.setLanguage(language);

	// Set Input Parameter Object in the Container
	ezcForumParams.setObject(ezForumParams);
	Session.prepareParams(ezcForumParams); // Preapare Parameters for Call

	// Get List of Forum Message Headers
	retMsgList = (ReturnObjFromRetrieve)ForumsManager.getForumMsgs(ezcForumParams);
	retMsgList.check();
%>
