<%@ page import ="ezc.ezparam.*" %>
<%@ page import ="ezc.ezmail.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />


<html>
<head>
</head>
<body>
<center>
<%
	
	
	String name=request.getParameter("name");
	String description=request.getParameter("description");

	String messageType=request.getParameter("messageType");
	String ext1=request.getParameter("ext1");

	String parameterName=request.getParameter("parameterName");
	String parameterValue=request.getParameter("parameterValue");

	String userName=request.getParameter("userName");
	String userType=request.getParameter("userType");
	String mailType=request.getParameter("mailType");
	String mailPriority=request.getParameter("mailPriority");
	String mailDate=request.getParameter("mailDate");

	String mailText=request.getParameter("mailText");

	String sortValue=request.getParameter("sortValue");
	String changable=request.getParameter("changable");
	String client=request.getParameter("client");
	String system=request.getParameter("system");

	String execCommand =request.getParameter("execCommand");
	String execType=request.getParameter("execType");
	



	

	out.println(name + "<br>");
	out.println(description + "<br>");
	out.println(messageType + "<br>");
	out.println(ext1 + "<br>");
	out.println(parameterName + "<br>");
	out.println(parameterValue + "<br>");
	out.println(userName+ "<br>");
	out.println(userType + "<br>");
	out.println(mailPriority + "<br>");
	out.println(mailType+ "<br>");
	out.println(mailDate + "<br>");
	out.println(mailText + "<br>");
	out.println("system" + system);


	EzSAPMailParams mailParams= new EzSAPMailParams();
	
	mailParams.setName(name);
	mailParams.setDescription(description);
	mailParams.setExt1(" ");
	mailParams.setMessageType(messageType);
	mailParams.setExecSystem(system);
	mailParams.setExecClient(client);
	mailParams.setExecCommand(execCommand);
	mailParams.setExecType(execType);
	mailParams.setLang("E");
	mailParams.setSensitivity("P");	
	//mailParams.setChangable(changable);
	mailParams.setDirectScreen("X");
	


	EzMailRecieverTable mailToTable=new EzMailRecieverTable();
	EzMailRecieverTableRow mailToTableRow = new EzMailRecieverTableRow();

	mailToTableRow.setUserName(userName);
	mailToTableRow.setUserType(userType);
	mailToTableRow.setMailPriority("X");
	mailToTableRow.setMailDate("20030803");
	mailToTableRow.setMailDate(null);

	mailToTableRow.setMailType("X");
	
	mailToTable.appendRow(mailToTableRow);

	
	ezc.ezparam.EzReportSelectTable pTable =new ezc.ezparam.EzReportSelectTable() ; 
	ezc.ezparam.EzReportSelectRow pTableRow = new ezc.ezparam.EzReportSelectRow();

	pTableRow.setParameterName(parameterName);
	pTableRow.setParameterValueLow(parameterValue);
	pTable.appendRow(pTableRow);


	int mailTextLength=mailText.length();
	
	int mailTextRows= mailTextLength/255;
	
	int mod=mailTextLength%255;
	
	EzMailTextsTable mailContentTable = new EzMailTextsTable();
	

	int start=0;


	for(int i=0;i<mailTextRows;i++)
	{
		
		EzMailTextsTableRow mailContentTableRow = new EzMailTextsTableRow();
		String tempText=mailText.substring(start,start+255);
		out.println(tempText);
		mailContentTableRow.setContent(tempText);
		mailContentTable.appendRow(mailContentTableRow);
		start=start+255;
	}
	out.println(start);
	if(mod!=0)
	{
		EzMailTextsTableRow mailContentTableRow = new EzMailTextsTableRow();
		String tempText=mailText.substring(start,start+mod);
		out.println(tempText);
		mailContentTableRow.setContent(tempText);
		mailContentTable.appendRow(mailContentTableRow);
	}	
	
	

	
	mailParams.setReciver(mailToTable);
	mailParams.setParams(pTable);
	mailParams.setContent(mailContentTable);

	ezc.ezmail.client.EzMailManager mailManager= new ezc.ezmail.client.EzMailManager();
	ezc.ezparam.EzcParams myParams= new EzcParams(true);
	myParams.setObject(mailParams);
	Session.prepareParams(myParams);
	mailManager.ezSendR3Mail(myParams);

	out.println("HCEK:" + mailToTableRow.getMailType() + mailToTableRow.getMailPriority());

	out.println("STARTTS................<BR><BR>");
	out.println("mailParams.getMessageType()" + mailParams.getMessageType()  + "<br>");
	out.println("mailParams.getExecType()" + mailParams.getExecType() + "<br>");
	out.println("mailParams.getChangable()" + mailParams.getChangable() + "<br>");
	out.println("mailParams.getSensitivity()" + mailParams.getSensitivity() + "<br>");
	out.println("mailParams.getExecClient()" + mailParams.getExecClient() + "<br>");

	out.println("mailParams.getExecCommand()" + mailParams.getExecCommand() + "<br>");	
	out.println("mailParams.getExecSystem()" + mailParams.getExecSystem() + "<br>");	
	out.println("mailParams.getDirectScreen()" + mailParams.getDirectScreen() + "<br>");	
	/*out.println(mailParams.getExecType()" + mailParams.getExecType() + "<br>");	
	out.println(mailParams.getExecType()" + mailParams.getExecType() + "<br>");	*/





	

	



%>
