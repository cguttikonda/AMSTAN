<%@ page import="ezc.ezparam.*,java.util.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="MiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"></jsp:useBean>
<%
	String changeStatus = request.getParameter("changeStatus");
	String userId = request.getParameter("userId");
	
	/******************** Update Email Note Auth - Start **********************/
	
	if(userId!=null && !"null".equals(userId) && !"".equals(userId))
	{
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		EzcParams miscMainParams = new EzcParams(true);

		miscParams.setQuery("UPDATE EZC_USER_DEFAULTS SET EUD_VALUE='"+changeStatus.trim()+"' WHERE EUD_USER_ID='"+userId.trim()+"' AND EUD_KEY='MAILNOTE'");
		miscMainParams.setObject(miscParams);
		miscMainParams.setLocalStore("Y");

		Session.prepareParams(miscMainParams);
		MiscManager.ezUpdate(miscMainParams);
	}

	/******************** Update Email Note Auth - End **********************/
	
	response.sendRedirect("ezEmailNotification.jsp");
%>