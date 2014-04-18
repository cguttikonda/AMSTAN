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
<jsp:useBean id="MailManager" class="ezc.client.EzMessagingManager" scope="session" />
<jsp:useBean id="ForumsManager" class="ezc.client.EzForumsManager" scope="session" />
<jsp:useBean id="TransManager" class="ezc.client.EzTransactionManager" scope="session" />
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>

<%
	String sendToUser = "";
	String ipAddr = request.getServerName();
	String syskey =(String)session.getValue("SYSKEY");

	
	Vector extMailIds= new Vector();
	java.util.StringTokenizer myStk = null;
	String  poNum    	= "";
	String  vendor   	= "";
	String 	msgSubject 	= "";
	String 	msgText 	= "";
	
	for(int k = 0;k<poVndr.length;k++)
	{
		myStk 		= new java.util.StringTokenizer(poVndr[k],"¥");	
		poNum    	= myStk.nextToken();
		vendor   	= myStk.nextToken();
				
		
		
		//msgSubject 	= pocon+" has been created with the number "+poNum+" in Purchase Area "+syskey;
		msgSubject =  pocon+" "+poNum+" from Answerthink(India) Ltd.";

		//msgText 	= "This is a Request for Acknowledgement of created "+pocon+" from Answerthink(India) Ltd.\n\n";
		msgText 	= "Kindly acknowledge the Purchase Order and arrange for the shipments as per the schedule(s) mentioned.\n\n";



		String mySoldTo = "";

		try
		{
			int SoldTo = Integer.parseInt(vendor);      
			mySoldTo = "0000000000"+vendor;
			mySoldTo = mySoldTo.substring((mySoldTo.length()-10),mySoldTo.length());        
		}
		catch(Exception e)
		{
			mySoldTo = vendor;
		}
        
		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setSyskeys((String)session.getValue("SYSKEY"));
		adminUtilsParams.setPartnerValueBy(vendor);

		EzcParams mainParams = new EzcParams(false);
		mainParams.setObject(adminUtilsParams);
		Session.prepareParams(mainParams);

		ReturnObjFromRetrieve partnersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams);
		sendToUser = partnersRet.getFieldValueString(0,"EU_ID"); 
		
		ezc.ezparam.EzcUserParams uparams= new ezc.ezparam.EzcUserParams();
		ezc.ezparam.EzcUserNKParams ezcUserNKParams = new ezc.ezparam.EzcUserNKParams();
		ezcUserNKParams.setLanguage("EN");
		ezcUserNKParams.setSys_Key("0");
		uparams.createContainer();
		uparams.setUserId(sendToUser);
		
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
				MailManager.createPersonalMsg(ezcMessageParams);
				dispIds.addElement(useri);
			}
			catch(Exception e)
			{  
				failedIds.addElement(useri); 
			}
		}
%>
	<%@include file="../Inbox/ezSendExternalMail.jsp" %>
<%
	}
%>
