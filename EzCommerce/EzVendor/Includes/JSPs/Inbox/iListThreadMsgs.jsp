<%!
final String FORUM_MSG_ID = "EFA_MSG_ID";
final String FORUM_MSG_HEADER = "EFA_MSG_HEADER";
final String FORUM_MSG_CONTENT1 = "EFA_MSG_CONTENT1";
final String FORUM_MSG_CONTENT2 = "EFA_MSG_CONTENT2";
final String FORUM_MSG_CREATED_BY = "EFA_CREATED_BY";

final String FORUM_MSG_CREATED_DATE =  "EFA_MSG_CREATION_DATE";
final String FORUM_MSG_CREATED_TIME =  "EFA_MSG_CREATION_TIME";

final String FORUM_MSG_DSP_LEVEL = "EFA_DSPL_LEVEL";
final String FORUM_MSG_DSP_ID = "EFA_DSPL_ID";
//EFA_LAST_NUMBER
%>

<%
	// Key Variables
	ReturnObjFromRetrieve retMsgList = null;

	String language = "EN";
	String client = "200";

	String forumID = request.getParameter("ForumID");
	String threadID = request.getParameter("MessageID");

	EzcForumParams  ezcForumParams= new EzcForumParams();
	EzForumParams ezForumParams = new EzForumParams();

	// Set the Input Parameters
	ezForumParams.setClient(client);
	ezcForumParams.setForumId(forumID);
	ezForumParams.setMsgThread(threadID);
	ezForumParams.setLanguage(language);

	// Set Input Parameter Object in the Container	
	ezcForumParams.setObject(ezForumParams);
	Session.prepareParams(ezcForumParams); // Preapare Parameters for Call


	// Get List of Thread Message Headers
	retMsgList = (ReturnObjFromRetrieve)ForumsManager.getForumThreadMsgs(ezcForumParams);
	retMsgList.check();
%>
