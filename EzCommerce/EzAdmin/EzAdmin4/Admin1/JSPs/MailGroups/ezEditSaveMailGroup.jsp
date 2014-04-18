<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/MailGroupBean.jsp" %>


<%


	EzcParams eParams = new EzcParams(false);

	EziMailGroupStructure struct = new EziMailGroupStructure();

	String grpId=request.getParameter("groupId");
	struct.setMailGroupId(grpId);
	struct.setMailGroupDesc(request.getParameter("groupDesc"));
	String password = request.getParameter("pass");

	if(request.getParameter("authRequired")!=null)
		struct.setIsAuthRequired("Y");
	else
		struct.setIsAuthRequired("N");

	struct.setUserId(request.getParameter("user"));
	if(!("********".equals(password)))
		struct.setPassword(password);

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
	Mail.ezUpdateMailGroup(eParams);


	try
	{
		javax.ejb.Handle myHandle=(javax.ejb.Handle)eParams.getEjbHandle();
		ezc.ezcsm.EzUser myUser= (ezc.ezcsm.EzUser)myHandle.getEJBObject();
		String connStr=grpId+"_"+myUser.getConnGroup();
		
		if(ezc.ezmail.EzMail.htable.get(connStr) != null)
			ezc.ezmail.EzMail.htable.remove(connStr);

	} catch(Exception e)
	{
		out.println(e);
	}



	response.sendRedirect("ezListMailGroups.jsp");


%>
