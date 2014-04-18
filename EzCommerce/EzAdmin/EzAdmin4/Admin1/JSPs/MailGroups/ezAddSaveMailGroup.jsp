<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/MailGroupBean.jsp" %>


<%


	EzcParams eParams = new EzcParams(false);


	EziMailGroupStructure struct = new EziMailGroupStructure();

	if(request.getParameter("authRequired")!=null)
		struct.setIsAuthRequired("Y");
	else
		struct.setIsAuthRequired("N");

	String pwd=request.getParameter("pass");
	struct.setUserId(request.getParameter("user"));
	if(!(pwd == null || "null".equals(pwd) || "".equals(pwd)))
		struct.setPassword(pwd);

	struct.setMailGroupId(request.getParameter("groupId"));
	struct.setMailGroupDesc(request.getParameter("groupDesc"));
	struct.setHost(request.getParameter("host"));
	struct.setFrom(request.getParameter("from"));
	if(request.getParameter("debug") !=null)
		struct.setDebug("Y");
	else
		struct.setDebug("N");
	struct.setLogFile(request.getParameter("logfile"));
	struct.setExceptionListener(request.getParameter("listener"));


	//if  new groupid supports the incoming mails
	if(request.getParameter("supportInMail")!=null)
		struct.setSupportIncoming("Y");
	else
		struct.setSupportIncoming("N");

	struct.setIncomingProtocol(request.getParameter("inProtocol"));
	struct.setIncomingPort(request.getParameter("inPort"));

	//if  new groupid supports the outgoing mails
	if(request.getParameter("supportOutMail")!=null)
		struct.setSupportOutgoing("Y");
	else
		struct.setSupportOutgoing("N");

	struct.setOutgoingPort(request.getParameter("outPort"));

	//if  new groupid supports JMS

	if(request.getParameter("JMSEnabled")!=null)
	   struct.setJMSEnabled("Y");
	else
		struct.setJMSEnabled("N");

	struct.setDestinationType(request.getParameter("destType"));
	struct.setProviderURL(request.getParameter("providerURL"));
	struct.setContextFactory(request.getParameter("contextFactory"));
	struct.setDestinationFactory(request.getParameter("destFactory"));
	struct.setDestinationName(request.getParameter("destName"));

	eParams.setObject(struct);
	Session.prepareParams(eParams);

	Mail.ezAddMailGroup(eParams);
	

	response.sendRedirect("ezListMailGroups.jsp");

%>
