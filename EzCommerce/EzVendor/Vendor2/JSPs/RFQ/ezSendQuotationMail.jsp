<jsp:useBean id="Manager1" class="ezc.client.EzMessagingManager" scope="session" />
<jsp:useBean id="ForumsManager" class="ezc.client.EzForumsManager" scope="session" />
<jsp:useBean id="TransManager" class="ezc.client.EzTransactionManager" scope="session" />
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />

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
<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>

<%
	String sendToUser = "";
	
	String mailFooterText = "<B>This is electronically generated mail/document.Hence signature not required</B>";
	
	//Added by satya at ranbaxy on 28042005..
	String mailIp = request.getServerName();
	String syskey =(String)session.getValue("SYSKEY");
	int Count = ezirfqheadertable.getRowCount();
	Vector extMailIds= new Vector();
	for(int m=0;m<Count;m++)
	{
		String 	msgSubject 	= "Request For Quotation From Ranbaxy Laboratories";
		String 	msgText 	= "This is a Request For Quotation from Ranbaxy Laboratories.\n\n";
			msgText 	= msgText+"Please click on the following link to View and Quote for the Material\n\n";
     
		ezirfqheadertablerow = (ezc.ezpreprocurement.params.EziRFQHeaderTableRow)ezirfqheadertable.getRow(m);

		String soldTo	= ezirfqheadertablerow.getSoldTo();
		String rfqNo 	= ezirfqheadertablerow.getRFQNo();
		String mySoldTo = "";

		try
		{
			int SoldTo = Integer.parseInt(soldTo);      
			mySoldTo = "0000000000"+soldTo;
			mySoldTo = mySoldTo.substring((mySoldTo.length()-10),mySoldTo.length());        
		}
		catch(Exception e)
		{
			mySoldTo = soldTo;
		}

		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setSyskeys((String)session.getValue("SYSKEY"));
		adminUtilsParams.setPartnerValueBy(soldTo);

		EzcParams mainParams1 = new EzcParams(false);
		mainParams1.setObject(adminUtilsParams);
		Session.prepareParams(mainParams1);

		ReturnObjFromRetrieve partnersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams1);
		sendToUser = partnersRet.getFieldValueString(0,"EU_ID"); 
		
		if("N".equals(vendType[m]))
			msgText = msgText+"<Br><a href='http://"+mailIp+"/ezPrePostQuote.jsp?rfq="+rfqNo+"'>http://"+mailIp+"/ezPrePostQuote.jsp?rfq="+rfqNo+"</a>";
		else
			msgText = msgText+"<Br><a href='http://"+mailIp+"/ezPrePostQuote.jsp?rfq="+rfqNo+"&user="+sendToUser+"&skey="+syskey+"'>http://"+mailIp+"/ezPrePostQuote.jsp?rfq="+rfqNo+"&user="+sendToUser+"&skey="+syskey+"</a>";

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
        
        
        	msgText += "<BR><BR><BR>"+mailFooterText;
        
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
					if("N".equals(vendType[m]))
					{
						ezc.ezpreprocurement.client.EzPreProcurementManager agentManager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
						ezc.ezparam.EzcParams cparams	= new ezc.ezparam.EzcParams(false);
						ezc.ezpreprocurement.params.EziAgentParams eziagentparams= new ezc.ezpreprocurement.params.EziAgentParams();

						eziagentparams.setVendorCode(vendor[m]);	 
						eziagentparams.setMatCode(material);	 
						eziagentparams.setAgentCode(agentCode[m]);	 

						cparams.setObject(eziagentparams);
						cparams.setLocalStore("Y");
						Session.prepareParams(ezcparams);

						ezc.ezparam.ReturnObjFromRetrieve agentDetails = null;	
						try
						{
							agentDetails = (ezc.ezparam.ReturnObjFromRetrieve)agentManager.ezGetAgentDetails(ezcparams);
							extMailIds.addElement(agentDetails.getFieldValueString("EVA_AGENT_MAILID"));
						}
						catch(Exception e)
						{
							System.out.println("Exception:"+e);
						}					
					}
					else
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
			}
			System.out.println("+++++++++++++++++++++++++++++++++++++++++++++"+extMailIds);
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
				Manager1.createPersonalMsg(ezcMessageParams);
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
<Div id="MenuSol"></Div>