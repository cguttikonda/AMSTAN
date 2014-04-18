
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" /> 
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />

<%
	ezc.ezparam.EzcUserParams uparams= new ezc.ezparam.EzcUserParams();
	ezc.ezparam.EzcUserNKParams ezcUserNKParams = new ezc.ezparam.EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	ezcUserNKParams.setSys_Key("0");
	uparams.createContainer();
	uparams.setUserId(Session.getUserId());
	uparams.setObject(ezcUserNKParams);
	Session.prepareParams(uparams);
	ezc.ezparam.ReturnObjFromRetrieve retObj = (ezc.ezparam.ReturnObjFromRetrieve)(UManager.getAddUserDefaults(uparams));

	int retCount = retObj.getRowCount();
	String server=null,protocol=null,user=null;
	for(int i=0;i<retCount;i++)
	{
		if("POP3HOST".equals(retObj.getFieldValueString(i,"EUD_KEY")))
			server = retObj.getFieldValueString(i,"EUD_VALUE");
		if("POP3PROTOCOL".equals(retObj.getFieldValueString(i,"EUD_KEY")))
			protocol = retObj.getFieldValueString(i,"EUD_VALUE");
		if("POP3USERID".equals(retObj.getFieldValueString(i,"EUD_KEY")))
			user = retObj.getFieldValueString(i,"EUD_VALUE");	
	}
	
	if(server == null || "".equals(server) || " ".equals(server))
	{
		response.sendRedirect("ezListPersMsgs.jsp?temp=allmess");
	}
%>

<html>
<head>
<script>
	function showView()
	{
		dialogValue = showModalDialog('ezShowInboxSession.jsp?server=<%=server%>&protocol=<%=protocol%>&user=<%=user%>',"hello",'center:yes;dialogWidth:31;dialogHeight:15;status:no;minimize:no;close:no;')
		if(dialogValue == "Cancel")
		{
			<%
				response.sendRedirect("ezListPersMsgs.jsp?temp=allmess");
			%>
		}	
		else	
			document.location.href = dialogValue
	}
</script>
</head>
<body >
<%
	String val = (String)session.getValue("SERVER");
	if(val == null)
	{
%>
		<script>
			showView()
		</script>
<%
	}
	else
	{
		response.sendRedirect("ezListPersMsgs.jsp?temp=allmess");
	}
%>

</body>
</html>