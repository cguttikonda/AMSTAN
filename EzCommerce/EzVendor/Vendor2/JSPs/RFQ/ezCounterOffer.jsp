<%@include file="../../Library/Globals/errorPagePath.jsp"%>
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
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%!
	private String ezEncrypt(String str)
	{
	
	
		int[] offsets =null;
		char[] chars =null;
		String finalStr = "";
		
		try{
		try{
		
		offsets=new int[str.length()];
		chars=new char[str.length()];
		
		// Need to do dynamic
		offsets[0]=9; offsets[1]=15; offsets[2]=7; offsets[3]=23; offsets[4]=3; offsets[5]=20; offsets[6]=18;
		offsets[7]=0; offsets[8]=5; offsets[9]=22; offsets[10]=2; offsets[11]=24; offsets[12]=16; offsets[13]=10;
		offsets[14]=12; offsets[15]=1; offsets[16]=14; offsets[17]=17; offsets[18]=19; offsets[19]=6; offsets[20]=21;
		offsets[21]=11; offsets[22]=8; offsets[23]=4; offsets[24]=13; offsets[25]=25;
		////
		}catch(Exception e){}
		if(chars!=null)
		{
			for(int i=0;i<str.length();i++)
			{
				chars[offsets[i]] = str.charAt(i);
			}

			
			for(int i=0;i<str.length();i++)
			{
				finalStr += chars[i];
			}
		}
		return finalStr;
		}catch(Exception ex1){return str;}
		
	}
%>
<%
	String sendToUser = "";
	String ipAddr = request.getServerName();
	String syskey =(String)session.getValue("SYSKEY");

	String [] myChk = request.getParameterValues("chk1");
	String isInvite = "N";
	if(request.getParameterValues("reqFrom") != null)
		isInvite = request.getParameter("reqFrom");
		
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
	
	for(int k = 0;k<myChk.length;k++)
	{
		if("InviteGrp".equals(isInvite))
		{
			msgSubject 	= "Invitation For Quotation From Ranbaxy Laboratories Ltd";
			msgText 	= "This is a Invitation for Request For Quotationfrom Ranbaxy Laboratories Ltd.\n\n";
			msgText 	= msgText+"Please click on the following link to View and Quote for the Material\n\n";
		}
		else
		{
			msgSubject 	= "Request For Re Quote From Ranbaxy Laboratories";
			msgText 	= "This is a Request For Re Quote from Ranbaxy Laboratories.\n\n";
			msgText 	= msgText+"Please click on the following link to View and Re Quote for the Material\n\n";
		}	
		myStk 		= new java.util.StringTokenizer(myChk[k],"¥");	
		rfqNo    	= myStk.nextToken();
		vendor   	= myStk.nextToken();
		collectiveRFQNo = myStk.nextToken();
				
		 
		ezirfqheadertablerow   = new ezc.ezpreprocurement.params.EziRFQHeaderTableRow();
		ezirfqheadertablerow.setRFQNo(rfqNo); 
		if("InviteGrp".equals(isInvite))
			ezirfqheadertablerow.setExt3("Y"); 
		else
			ezirfqheadertablerow.setStatus("N"); 
			
		ezirfqheadertablerow.setModifiedBy(Session.getUserId()); 
		ezirfqheadertable.appendRow(ezirfqheadertablerow);

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

				
		//msgText11 = msgText + "<a href=http://192.168.128.107/ezPrePostQuote.jsp?rfq="+rfqNo+"&user="+sendToUser+" target=_blank>";	
		//msgText11 = msgText11+"http://192.168.128.107/PostQuote";
		//msgText11 = msgText11+"</a>";
		
		//ezc.ezbasicutil.EzCipherExt ezcipher = new ezc.ezbasicutil.EzCipherExt();
		//String encVal = ezcipher.encrypt(rfqNo+"$"+sendToUser+"$"+syskey);
		
		//msgText = msgText+"<a href=\"http://"+ipAddr+"/j2ee/EzCommerce/EzVendor/EzRanbaxyVendor/Offline/Quote/ezPrePostQuote.jsp?val="+encVal+"\">http://"+ipAddr+"/j2ee/EzCommerce/EzVendor/EzRanbaxyVendor/Offline/Quote/ezPrePostQuote.jsp?val="+encVal+"</a>";
		//msgText = msgText+"<a href=\"http://"+ipAddr+"/EzCommerce/EzVendor/EzRanbaxyVendor/Offline/Quote/ezPrePostQuote.jsp?rfq="+rfqNo+"&user="+sendToUser+"&skey="+syskey+"\">http://"+ipAddr+"/EzCommerce/EzVendor/EzRanbaxyVendor/Offline/Quote/ezPrePostQuote.jsp?rfq="+rfqNo+"&user="+sendToUser+"&skey="+syskey+"</a>";
		
		String toEncStr=rfqNo+sendToUser+syskey;
		
		String encId=ezEncrypt(toEncStr);
		
		msgText = msgText+"<Br><a href=\"http://"+ipAddr+"/j2ee/EzCommerce/EzVendor/EzRanbaxyVendor/Offline/JSPs/ezPrePostQuote.jsp?id="+encId+"\" target=_blank>Click here to post quotation.</a>";
	
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
				Manager.createPersonalMsg(ezcMessageParams);
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
	
	ezcparams.setObject(ezirfqheadertable);
	ezcparams.setObject(ezirfqdetailstable);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);
	ezrfqmanager.ezUpdateRFQ(ezcparams);
%>
	
<%
	String message = "A Mail has been sent successfully for the Selected Vendors requesting for Re Quote.";
	if("InviteGrp".equals(isInvite))
	{
		message = "A Mail has been sent successfully for the Selected Vendors requesting for Quotation.";
	}
	response.sendRedirect("../Shipment/ezMessage.jsp?Msg="+message+"&RFQRETPAGE="+isInvite);	
%>
<Div id="MenuSol"></Div>