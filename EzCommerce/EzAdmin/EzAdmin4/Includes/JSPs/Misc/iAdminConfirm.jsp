<%@ page import = "ezc.ezparam.*" %>
<%@ page import="ezc.ezparam.EzLogonStatus" %>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="ezc.session.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	String userId = request.getParameter( "username" );
	String passWord = request.getParameter( "password" );
	String ConnGroup=request.getParameter("ConnGroup");
	userId =  userId.toUpperCase();

	EzLogonStructure logstruct = new EzLogonStructure();
	logstruct.setUserId(userId);
	logstruct.setPassWd(passWord);
	logstruct.setUserGroup("0");
        logstruct.setConnGroup(ConnGroup);
	EzLogonStatus logonstatus = (EzLogonStatus)Session.logon(logstruct);

%>
