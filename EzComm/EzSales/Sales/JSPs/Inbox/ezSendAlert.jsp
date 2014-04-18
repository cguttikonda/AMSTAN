<%@ page import="java.io.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="ezc.forums.params.*" %>
<%@ page import="ezc.messaging.params.*" %>
<%@ page import="ezc.trans.messaging.params.*" %>


<%@ page import="ezc.ezparam.*"%>
<%@ page import = "ezc.client.*" %>

<%@ page import = "ezc.ezutil.FormatDate" %>

<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="MsgManager" class="ezc.client.EzMessagingManager" scope="session"/>
<jsp:useBean id="ForumsManager" class="ezc.client.EzForumsManager" scope="session"/>
<jsp:useBean id="TransManager" class="ezc.client.EzTransactionManager" scope="session"/>

<%

	System.out.println("sendToExtsendToExtsendToExtsendToExtsendToExtsendToExt");

	String sendToExt="N";
	String language = "EN";
	String client = "200";

	EzMsgStructure msgStruc = null;
	EzPersonalMsgStructure[] msgDetails = null;






	//Fill in the message structure
	msgStruc = new EzMsgStructure();

	msgStruc.setClient(client);
	msgStruc.setPriorityFlag("U");
	msgStruc.setMsgHeader(msgSubject);
	msgStruc.setMsgContent1(msgText);
	msgStruc.setMsgContent2("");
	msgStruc.setLnkExtInfo("Lnk");


	EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();
	ezMessageParams.setEzMsgStructure(msgStruc);

	// Set Input Parameter Object in the Container
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams); // Preapare Parameters for Call


	// String sendToUser = request.getParameter("toUser");

	java.util.StringTokenizer strFullUser = new java.util.StringTokenizer(sendToUser, ",");

	Vector extMailIds= new Vector();

	int numUsers = strFullUser.countTokens();
	for(int i=0; i<numUsers; i++){

		String useri = strFullUser.nextToken();

		if(useri.indexOf("@")!=-1)
		{
			extMailIds.addElement(useri);
			continue;
		}
		else
		{

			if(sendToExt.equals("Y"))
			{

				ReturnObjFromRetrieve retUserData=null;

				EzcUserParams uparamsN= new EzcUserParams();
				EzcUserNKParams ezcUserNKParamsN = new EzcUserNKParams();
				ezcUserNKParamsN.setLanguage("EN");
				uparamsN.setUserId(useri);
				uparamsN.createContainer();
				uparamsN.setObject(ezcUserNKParamsN);
				Session.prepareParams(uparamsN);
				retUserData = (ReturnObjFromRetrieve)UManager.getUserData(uparamsN);
				extMailIds.addElement(retUserData.getFieldValueString("EU_EMAIL"));


			}
		}


		ezc.ezutil.EzSystem.out.println("Users**** " + useri);

		msgDetails = new EzPersonalMsgStructure[1];
		msgDetails[0] = new EzPersonalMsgStructure();

		msgDetails[0].setClient(client);
		msgDetails[0].setRecUserId(useri);
		msgDetails[0].setExpiryDate("99999999");
		msgDetails[0].setExpiryDays(10);
		msgDetails[0].setReminderDate("0");
		msgDetails[0].setFolderId("1000");

		//Setting Parameter to container
		ezMessageParams.setEzPersonalMsgStructure(msgDetails);

		// Send Message Call
		//IBObject.createPersonalMsg(SBObject, servlet, msgStruc, msgDetails);
		MsgManager.createPersonalMsg(ezcMessageParams);


	}




%>
<%@ include file="ezSendShipmenExternalMail.jsp"%>
