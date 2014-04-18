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

	String mailFooterText = "<B>This is electronically generated mail/document. Hence signature not required</B>";

	
	msgText += "<BR><BR><BR>"+mailFooterText;
	
	// if you want to send to External accounts also put "N" 

	String sendToExt = "Y";
	String language  = "EN";
	String client 	 = "200";

	EzMsgStructure msgStruc			= null;
	EzPersonalMsgStructure[] msgDetails 	= null;

	// Get Parameters from the Compose Page
	//Fill in the message structure

	msgStruc = new EzMsgStructure();
	msgStruc.setClient(client);
	msgStruc.setPriorityFlag("U");
	msgStruc.setMsgHeader(msgSubject);
	msgStruc.setMsgContent1(msgText);
	msgStruc.setMsgContent2(session.getId());
	msgStruc.setLnkExtInfo("Lnk");


	EzcMessageParams  ezcMessageParams	= new EzcMessageParams();
	EzMessageParams ezMessageParams		= new EzMessageParams();
	ezMessageParams.setEzMsgStructure(msgStruc);
	
	// Set Input Parameter Object in the Container	
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams); // Preapare Parameters for Call

	////////////////////////////
	//Fill in the message details structure

	
	
	java.util.StringTokenizer strFullUser = new java.util.StringTokenizer(sendToUser, ",");
	Vector dispIds	 = new Vector(); //Only For displaying Users Ids
	Vector failedIds = new Vector(); //Only to List the Users of failed Ids



	Vector extMailIds = new Vector();
	
	int numUsers	  = strFullUser.countTokens();
	
	

	for(int i=0; i<numUsers; i++)
	{
	
	
		String useri = strFullUser.nextToken();
		
		//For temporary purpose
		
		if("VICE_PRESIDENT".equals(useri.trim()))
			useri = "VPRESIDENT";	
		
		//Ends Here
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

				ezc.ezmisc.client.EzMiscManager MiscManager = new ezc.ezmisc.client.EzMiscManager();
				ezc.ezmisc.params.EziMiscParams miscParams_E = new ezc.ezmisc.params.EziMiscParams();
				EzcParams miscMainParams_E = new EzcParams(true);

				miscParams_E.setQuery("SELECT * FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID ='"+useri+"' AND EUD_KEY='MAILNOTE'");
				miscMainParams_E.setObject(miscParams_E);
				miscMainParams_E.setLocalStore("Y");

				Session.prepareParams(miscMainParams_E);
				ReturnObjFromRetrieve retObj_E = (ReturnObjFromRetrieve)MiscManager.ezSelect(miscMainParams_E);
			
				String emailNote_Status = "";
				
				if(retObj_E!=null)
					emailNote_Status = retObj_E.getFieldValueString(0,"EUD_VALUE");
				
				log4j.log("useriuseriuseri:::------->"+useri,"I");
				log4j.log("emailNote_Status::------->"+emailNote_Status,"I");
				
				if(!"N".equals(emailNote_Status))
				{
					ReturnObjFromRetrieve retUserData=null;

					EzcUserParams uparamsN= new EzcUserParams();
					EzcUserNKParams ezcUserNKParamsN = new EzcUserNKParams();
					ezcUserNKParamsN.setLanguage("EN");
					uparamsN.setUserId(useri);
					uparamsN.createContainer();
					uparamsN.setObject(ezcUserNKParamsN);
					Session.prepareParams(uparamsN);
					try
					{					
						retUserData = (ReturnObjFromRetrieve)UManager.getUserData(uparamsN);
						extMailIds.addElement(retUserData.getFieldValueString("EU_EMAIL"));
					}
					catch(Exception e)
					{
						log4j.log("Failed to Get User MailId.Probably b'coz wrong UserId","I");
					}
				}
			}
		}

		
		msgDetails	= new EzPersonalMsgStructure[1];
		msgDetails[0]	= new EzPersonalMsgStructure();

		msgDetails[0].setClient(client);
		msgDetails[0].setRecUserId(useri.toUpperCase());
		msgDetails[0].setExpiryDate("99999999");
		msgDetails[0].setExpiryDays(10);
		msgDetails[0].setReminderDate("0");
		msgDetails[0].setFolderId("1000");

		//Setting Parameter to container
		ezMessageParams.setEzPersonalMsgStructure(msgDetails);
 
		// Send Message Call
		//IBObject.createPersonalMsg(SBObject, servlet, msgStruc, msgDetails);
		try 
		{
			
			Manager.createPersonalMsg(ezcMessageParams);
			dispIds.addElement(useri);
		}
		catch(Exception e)
		{  
			failedIds.addElement(useri); 
		}

	}//end for

	//After sending the message go back to inbox

	// Include file to send mail to external Accounts
%>

<%@include file="../Inbox/ezSendExternalMail.jsp"%>
<Div id="MenuSol"></Div>
