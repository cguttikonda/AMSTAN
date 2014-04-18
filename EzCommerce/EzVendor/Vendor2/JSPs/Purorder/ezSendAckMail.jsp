<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="ezc.forums.params.*" %>
<%@ page import="ezc.messaging.params.*" %>
<%@ page import="ezc.trans.messaging.params.*" %>
<%@ page import="ezc.client.*" %>
<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="Manager" class="ezc.client.EzMessagingManager" scope="session">
</jsp:useBean>
<jsp:useBean id="ForumsManager" class="ezc.client.EzForumsManager" scope="session">
</jsp:useBean>
<jsp:useBean id="TransManager" class="ezc.client.EzTransactionManager" scope="session">
</jsp:useBean>
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />


<%

	String sendToExt="Y";
	String language = "EN";
	String client = "200";

	EzMsgStructure msgStruc = null;
	EzPersonalMsgStructure[] msgDetails = null;

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

	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams);

	java.util.StringTokenizer strFullUser = new java.util.StringTokenizer(sendToUser, ",");

	Vector dispIds=new Vector();
	Vector failedIds= new Vector();

	Vector extMailIds= new Vector();

	int numUsers = strFullUser.countTokens();
	for(int i=0; i<numUsers; i++){
		
		String useri = strFullUser.nextToken();
		
		//User info		

		if(useri.trim().length()==0)
			continue;


		if(useri.indexOf("@")!=-1)
		{
			extMailIds.addElement(useri);
			dispIds.addElement(useri);
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
				try{
				retUserData = (ReturnObjFromRetrieve)UManager.getUserData(uparamsN);
				extMailIds.addElement(retUserData.getFieldValueString("EU_EMAIL"));
				}catch(Exception e){
					System.out.println("Failed to Get User MailId.Probably b'coz wrong UserId");
				 }

			}
		}



		msgDetails = new EzPersonalMsgStructure[1];
		msgDetails[0] = new EzPersonalMsgStructure();

		msgDetails[0].setClient(client);
		msgDetails[0].setRecUserId(useri.toUpperCase());
		msgDetails[0].setExpiryDate("99999999");
		msgDetails[0].setExpiryDays(10);
		msgDetails[0].setReminderDate("0");
		msgDetails[0].setFolderId("1000");

		ezMessageParams.setEzPersonalMsgStructure(msgDetails);

		try{

			Manager.createPersonalMsg(ezcMessageParams);
			dispIds.addElement(useri);
		   }catch(Exception e){  failedIds.addElement(useri); }

	}


%>
<%@include file="../Inbox/ezSendExternalMail.jsp" %>
<Div id="MenuSol"></Div>
