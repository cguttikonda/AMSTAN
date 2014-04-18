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
<jsp:useBean id="Manager" class="ezc.client.EzMessagingManager" scope="session" />
<jsp:useBean id="ForumsManager" class="ezc.client.EzForumsManager" scope="session" />
<jsp:useBean id="TransManager" class="ezc.client.EzTransactionManager" scope="session" />
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%
	String sendToUser = "";
	String ipAddr = request.getServerName();

	String [] myChk = request.getParameterValues("chk1");
	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager	= new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams ezcparams			= new ezc.ezparam.EzcParams(false);
	
	ezc.ezpreprocurement.params.EziRFQHeaderTable ezirfqheadertable 	     = new ezc.ezpreprocurement.params.EziRFQHeaderTable();
	ezc.ezpreprocurement.params.EziRFQHeaderTableRow ezirfqheadertablerow        = null;
	ezc.ezpreprocurement.params.EziRFQDetailsTable ezirfqdetailstable 	     = new ezc.ezpreprocurement.params.EziRFQDetailsTable();
	
	Vector extMailIds= new Vector();
	java.util.StringTokenizer myStk = null;
	String  collectiveRFQNo = "";
	String  rfqNo    	= "";
	String  vendor   	= "";
	String 	msgSubject 	= "";
	String 	msgText 	= "";
	String 	msgText11 	= "";
	
	//for(int k = 0;k<myChk.length;k++)
	//{
		/*msgSubject 	= "Request For Re Quote From Ranbaxy Laboratories";
		msgText 	= "This is a Request For Re Quote from Ranbaxy Laboratories.\n\n";
		msgText 	= msgText+"Please click on the following link to View and Re Quote for the Material\n\n";
		myStk 		= new java.util.StringTokenizer(myChk[k],"¥");	
		rfqNo    	= myStk.nextToken();
		vendor   	= myStk.nextToken();
		collectiveRFQNo = myStk.nextToken();
		*/ 
		
		msgText = "Mail tesing for Query";


		
		ezc.ezparam.EzcUserParams uparams= new ezc.ezparam.EzcUserParams();
		ezc.ezparam.EzcUserNKParams ezcUserNKParams = new ezc.ezparam.EzcUserNKParams();
		ezcUserNKParams.setLanguage("EN");
		ezcUserNKParams.setSys_Key("0");
		uparams.createContainer();
		uparams.setUserId(destusr);
		uparams.setObject(ezcUserNKParams);
		Session.prepareParams(uparams);
		ezc.ezparam.ReturnObjFromRetrieve reterpdef = (ezc.ezparam.ReturnObjFromRetrieve)(UManager.getAddUserDefaults(uparams));


		String defValue = "";
		int cnt  = reterpdef.getRowCount();
		for(int i=0;i<cnt;i++)
		{
			if(reterpdef.getFieldValueString(i,"EUD_KEY").equals("SMS"))
			{
	    			defValue = (String)reterpdef.getFieldValue(i,"EUD_VALUE");
			}	
		}
		sendToUser = sendToUser+","+defValue;
		
        
		String sendToExt="Y";
		String language = "EN";
		String client2 = "200";

		EzMsgStructure msgStruc = null;
		EzPersonalMsgStructure[] msgDetails = null;

		msgStruc = new EzMsgStructure();
		msgStruc.setClient(client2);
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


		int numUsers = strFullUser.countTokens();
		for(int i=0; i<numUsers; i++)
		{
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
					try
					{
						retUserData = (ReturnObjFromRetrieve)UManager.getUserData(uparamsN);
						extMailIds.addElement(retUserData.getFieldValueString("EU_EMAIL"));
					}
					catch(Exception e)
					{
						System.out.println("Failed to Get User MailId.Probably b'coz wrong UserId");
				 	}
				}
			}

			msgDetails = new EzPersonalMsgStructure[1];
			msgDetails[0] = new EzPersonalMsgStructure();

			msgDetails[0].setClient(client2);
			msgDetails[0].setRecUserId(useri.toUpperCase());
			msgDetails[0].setExpiryDate("99999999");
			msgDetails[0].setExpiryDays(10);
			msgDetails[0].setReminderDate("0");
			msgDetails[0].setFolderId("1000");

			ezMessageParams.setEzPersonalMsgStructure(msgDetails);

			try
			{
				Manager.createPersonalMsg(ezcMessageParams);
				dispIds.addElement(useri);
			}
			catch(Exception e)
			{  
				failedIds.addElement(useri); 
			}
		}
		
	//}
	
%>
	<%//@include file="../Inbox/ezSendExternalMail.jsp" %>
<%
	//String message = "A Mail has been sent successfully for the Selected Vendors requesting for Re Quote.";
	//response.sendRedirect("../Shipment/ezMessage.jsp?Msg="+message );	
%>
<Div id="MenuSol"></Div>