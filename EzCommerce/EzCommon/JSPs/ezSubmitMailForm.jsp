<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<%@ page import ="ezc.ezparam.*,java.util.*"%>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult" %>
<html>
<head>
<link rel="stylesheet" href="../../EzVendor/Vendor2/Library/Styles/ezThemePink.css">
<Script>
	function closeWindow()
	{
		window.close();
	}
	function changeClass(obj, new_style)
	{
		obj.className = new_style;
	}
</Script>
</head>
<body scroll="no">
<%
	
	String userId		= request.getParameter("userID");
	String eMail		= request.getParameter("eMail");
	boolean sendMail	= false;
	String mailLoginUser	= "ezcadmin";
	String mailLoginPasswd	= "myindia";
	String mailLoginSite	= "200";
	String mailDominName	= "www.answerthink.com";
	
	String MAIL_HOST	= "10.1.2.6";
	String MAIL_USERID	= "ezcom";
	String MAIL_PASSWORD	= "ezcom";
	String MAIL_FROM	= "ezcom@kissusa.com";
	String MAIL_TO		= "";
	String MAIL_CC		= "";
	String MAIL_BCC		= "";
	String msgText		= "";	
	String msgSub		= "";
	String noDataStatement 	= "";
	
	try
	{
		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
	
		String fileName = "ezSubmitMailForm.jsp";
		String filePath=request.getRealPath(fileName);
		filePath=filePath.substring(0,filePath.indexOf(fileName));
		String filePath1 = filePath+"\\..\\..\\EzAdmin\\EzAdmin4\\Admin1\\JSPs\\User\\ezInfo.xml";
		
		java.io.File fileObj = new java.io.File(filePath1);
		if(!fileObj.exists())
		{
			filePath1 = filePath+"\\ezInfo.xml";
		}
		Document doc = docBuilder.parse("file:"+filePath1);
		Element root = doc.getDocumentElement();
		NodeList list = root.getElementsByTagName("info");
		Element element=null;
		Node node=null;
		node=list.item(0);
		String oldPassword = ((Element)node).getElementsByTagName("data").item(0).getFirstChild().getNodeValue();
		mailLoginPasswd	= oldPassword;
		
		
		filePath1 = filePath+"\\..\\..\\EzCommon\\XMLs\\ezData.xml";
		
		fileObj = new java.io.File(filePath1);
		if(!fileObj.exists())
		{
			filePath1 = filePath+"\\EzCommerce\\EzCommon\\XMLs\\ezData.xml";
		}
		doc 	= docBuilder.parse("file:"+filePath1);
		root 	= doc.getDocumentElement();
		list 	= root.getElementsByTagName("Portal");
		node	= list.item(0);
		mailDominName 	= ((Element)node).getElementsByTagName("domain").item(0).getFirstChild().getNodeValue();
		if(mailDominName == null || "null".equals(mailDominName))
			mailDominName = "www.answerthink.com";
	}
	catch(Exception e){}




	
	
	ezc.session.EzLogonStructure logs = new ezc.session.EzLogonStructure();		
	logs.setUserId(mailLoginUser);
	logs.setPassWd(mailLoginPasswd);
	logs.setConnGroup(mailLoginSite);
	ezc.ezparam.EzLogonStatus LogonStatus =  (ezc.ezparam.EzLogonStatus)Session.logon(logs);
	if(LogonStatus.IsSuccess())
	{
		try
		{
			EzcUserParams uparamsN= new EzcUserParams();
			EzcUserNKParams ezcUserNKParamsN = new EzcUserNKParams();
			ezcUserNKParamsN.setLanguage("EN");
			uparamsN.setUserId(userId);
			uparamsN.createContainer();
			uparamsN.setObject(ezcUserNKParamsN);
			Session.prepareParams(uparamsN);
			ReturnObjFromRetrieve retUserData = (ReturnObjFromRetrieve)UManager.getUserData(uparamsN);
			if(retUserData!=null)
			{
				if(retUserData.getRowCount() > 0)
				{
					MAIL_TO = retUserData.getFieldValueString(0,"EU_EMAIL");
					if(eMail.equalsIgnoreCase(MAIL_TO))
					{
						sendMail = true;
						ezc.ezbasicutil.EzMassVendSynch mySynch= new ezc.ezbasicutil.EzMassVendSynch("999","0");
						mySynch.setPassword();
						String decryptPassword = mySynch.getPassword();
						EzcUserParams uparams		= new EzcUserParams();
						EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
						ezcUserNKParams.setPassword(decryptPassword);
						uparams.createContainer();
						uparams.setUserId(userId);
						boolean result_flag = uparams.setObject(ezcUserNKParams);
						Session.prepareParams(uparams);
						UManager.changeUserPassword(uparams);
						msgText	= "Dear "+retUserData.getFieldValueString(0,"EU_FIRST_NAME")+""+retUserData.getFieldValueString(0,"EU_LAST_NAME")+"<BR><BR>Your Password is changed to <B>\""+decryptPassword+"\"</B>....<BR><BR>";
						msgText += "Remember, you can change your password at any time by logging on to <a href='http://"+mailDominName+"' target='_blank'>Kiss b2b Portal.</a>";
						msgText += "<BR><BR>Best Regards,<BR>Portal Admin"; 
					}
					else
					{
						sendMail = false;
						msgSub	 = "Email";
					}
				}
				else
				{
					sendMail = false;
					msgSub	 = "User ID";
				}
			}
			else
			{
				sendMail = false;
				msgSub	 = "User ID";
			}
		}
		catch(Exception e)
		{
			sendMail = false;
			msgSub	 = "User ID";
		}
	}	
	else
	{
		sendMail = false;
		msgSub	 = "User ID";
	}	
	
	
	if(sendMail)
	{
		try
		{
			ezc.ezmail.EzcMailParams mailParams	= new ezc.ezmail.EzcMailParams();
			mailParams.setContentType("text/html");
			mailParams.setCC(MAIL_CC);
			mailParams.setBCC(MAIL_BCC);
			mailParams.setIsAuthRequired("N");
			mailParams.setHost(MAIL_HOST);
			mailParams.setUserId(MAIL_USERID);
			mailParams.setPassword(MAIL_PASSWORD);
			mailParams.setFrom(MAIL_FROM);
			mailParams.setTo(MAIL_TO);
			mailParams.setMsgText(msgText);
			mailParams.setSubject("Requesting Password for User:"+userId);
			ezc.ezmail.EzMail myMail = new ezc.ezmail.EzMail();
			boolean value = myMail.ezSend(mailParams,Session);
			ezc.ezcommon.EzLog4j.log("After Sending Mail for requesting Password:"+value,"I");
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Got Exception while sending Mail from ezSubmitMailForm.jsp: "+e,"E");
		}
		noDataStatement = "Password will be sent after validating userid and email";
	}	
	else
		noDataStatement = "Given "+msgSub+" is not a valid one......<BR><BR>Please check and submit again";
	
	
%>	
	<Div id='NoDataDiv' style='position:relative;align:center;top:3%;width:100%;height:100%'>
	<Table width="98%" height="20%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
	<Tr>
		<Td height="5" style="background-color:'F3F3F3'" width="5" background="../Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../Images/Table_Corners/Cb_c1.gif"></Td>
		<Td height="5" style="background-color:'F3F3F3'" background="../Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../Images/Table_Corners/Cb_e1.gif"></Td>
		<Td height="5" style="background-color:'F3F3F3'" width="5" background="../Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../Images/Table_Corners/Cb_c2.gif"></Td>
	</Tr>
	<Tr height=100px>
		<Td width="5" style="background-color:'F3F3F3'" background="../Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../Images/Table_Corners/Cb_e2.gif"></Td>
		<Td style="background-color:'F3F3F3';" valign=middle align=center>
			<font color="#660000" size=2> <b><%=noDataStatement%></b></font>
		</Td>
		<Td width="5" style="background-color:'F3F3F3'" background="../Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
	</Tr>
	<Tr>
		<Td width="5" style="background-color:'F3F3F3'" height="5" background="../Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../Images/Table_Corners/Cb_c3.gif"></Td>
		<Td height="5" style="background-color:'F3F3F3'" background="../Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../Images/Table_Corners/Cb_e4.gif"></Td>
		<Td width="5" style="background-color:'F3F3F3'" height="5" background="../Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../Images/Table_Corners/Cb_c4.gif"></Td>
	</Tr>
	</Table>
	</Div>

<Div id="ButtonDiv" style="position:absolute;top:85%;width:100%;visibility:visible">
<Center>
	<table border=0 cellspacing=3 cellpadding=5 class=buttonTable>
	<tr>
<%
	if(sendMail)
	{
%>	
		<td nowrap class='TDCmdBtnOff' onMouseDown='changeClass(this,"TDCmdBtnDown")' onMouseUp='changeClass(this,"TDCmdBtnUp")' onMouseOver='changeClass(this,"TDCmdBtnUp")' onMouseOut='changeClass(this,"TDCmdBtnOff")' onClick='window.close()' valign=top title = 'Click here to Back'>
			<b>&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;</b>
		</td>
<%
	}
	else
	{
%>
		<td nowrap class='TDCmdBtnOff' onMouseDown='changeClass(this,"TDCmdBtnDown")' onMouseUp='changeClass(this,"TDCmdBtnUp")' onMouseOver='changeClass(this,"TDCmdBtnUp")' onMouseOut='changeClass(this,"TDCmdBtnOff")' onClick='history.go(-1)' valign=top title = 'Click here to Back'>
			<b>&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;</b>
		</td>
	
<%
	}
	try
	{ 
		Session.logOut(); 
	} 
	catch(Exception e) 
	{ 
		ezc.ezcommon.EzLog4j.log("Exception while logout in Forgot Password","E"); 
	}	
%>
	</tr>
	</table>
</Center>
</Div>
</body>
</html>