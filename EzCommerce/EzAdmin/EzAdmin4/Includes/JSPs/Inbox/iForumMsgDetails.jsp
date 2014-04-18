<%!
final String FORUM_ID = "EFA_FORUM_ID";
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
	ReturnObjFromRetrieve retMsgInfo = null;

	String language = "EN";
	String client = "200";

	String forumID = request.getParameter("ForumID");

	// Get Message Id from Message List Page
	String msgID = request.getParameter("MessageID");

	EzcForumParams  ezcForumParams= new EzcForumParams();
	EzForumParams ezForumParams = new EzForumParams();

	// Set the Input Parameters
	ezForumParams.setClient(client);
	ezcForumParams.setForumId(forumID);
	ezForumParams.setMsgId(msgID);
	ezForumParams.setLanguage(language);

	// Set Input Parameter Object in the Container	
	ezcForumParams.setObject(ezForumParams);
	Session.prepareParams(ezcForumParams); // Preapare Parameters for Call

	// Get Message Details
	retMsgInfo =(ReturnObjFromRetrieve)ForumsManager.getForumMsgDetails(ezcForumParams);
	retMsgInfo.check();

	String msgSubject = (String)retMsgInfo.getFieldValue(0, FORUM_MSG_HEADER);
	String msgFrom = (String)retMsgInfo.getFieldValue(0, FORUM_MSG_CREATED_BY);
	String msgDate = (String)retMsgInfo.getFieldValue(0, FORUM_MSG_CREATED_DATE);
	String msgContent1 = (String)retMsgInfo.getFieldValue(0, FORUM_MSG_CONTENT1);
	String msgContent2 = (String)retMsgInfo.getFieldValue(0, FORUM_MSG_CONTENT2);

	String msgContent = null;
	if(msgContent1 != null)
		{
		msgContent = msgContent1;
		if(msgContent2 != null)
		 msgContent = msgContent + msgContent2;
		}
	else
	     msgContent = " ";
		
%>
