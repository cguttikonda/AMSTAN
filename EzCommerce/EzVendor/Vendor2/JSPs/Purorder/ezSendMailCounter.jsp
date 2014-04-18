<%@ page import="java.util.*,java.io.*" %>
<%@ page import="javax.mail.*,javax.mail.internet.*,javax.activation.*" %>
<%@ page import="ezc.forums.params.*,ezc.messaging.params.*,ezc.trans.messaging.params.*" %>
<%@ page import="ezc.client.*,ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<jsp:useBean id="Manager" 	class="ezc.client.EzMessagingManager" 	scope="session"/>
<jsp:useBean id="ForumsManager" class="ezc.client.EzForumsManager" 	scope="session"/>
<jsp:useBean id="TransManager" 	class="ezc.client.EzTransactionManager" scope="session"/>
<jsp:useBean id="UManager" 	class="ezc.client.EzUserAdminManager" 	scope="session"/>
<jsp:useBean id="AUM" 		class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session"/>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%
	
	/****************************************************************************************
	 *      ADD THE FOLLOWING CODE WHILE INCLUDE THIS PAGE TO ANY OTHER PAGE		*		
	 *      ---------------------------------------------------------------- 		*
	 *	Hashtable mailData = new Hashtable();						*
	 *	String  msgType ="";								*
	 *	boolean sendToExt = true ;							*
	 *      boolean isVendor = true;               						*
	 ****************************************************************************************/
	sendToExt = true;
	String sendToUser = "";
	String toVendor   = "";
	String to = "";
	String cc = "";
	String 	msgSubject = ""; //SET MSG SUB 
	String 	msgText = ""; 	 //SET MSG TEXT 
	String  data = "";
	String  sysKeyVal = "";
	String  template = "";
	
	String[]  VendSysKey = {"",""};
	java.util.Hashtable  templatehash = (Hashtable) session.getValue("TEMPLATES");//REFFROM: iSelectSoldTo.jsp
	
	Enumeration enumMailIds  = mailData.keys()  ;
	
	 
	while(enumMailIds.hasMoreElements()){
		
		
		toVendor = (String)enumMailIds.nextElement();
		data 	 = (String)mailData.get(toVendor);
		if("POREL".equals(msgType) || "POREMIND".equals(msgType)){
			try{
				VendSysKey = toVendor.split("##");
				toVendor   =  VendSysKey[0];
				sysKeyVal  =  VendSysKey[1];
				template   =  (String)templatehash.get(sysKeyVal);
			}catch(Exception e2){
				ezc.ezcommon.EzLog4j.log("Exception Ocuured Getting Vendor and SysKey","I");
			}	
		}
		ezc.ezcommon.EzLog4j.log("TO VENDOR::>"+toVendor+">sysKeyVal:>"+sysKeyVal+"::template>>"+template,"I");
		
		if("POREL".equals(msgType)){
		
			msgSubject 	= "Purchase Order(s) Released.";
			msgText 	= "<br>Dear User,<br><br>\n\n"; 
			msgText 	= msgText+"Sub: "+msgSubject+"<br><br>\n\n";
			msgText 	= msgText+"Following Purchase Order(s) Released for your Acknowledgemnet.<br>\n\n";
			msgText 	= msgText+"	"+data+". \n\n";
			msgText		=  msgText+"<br><br>Best Regards, <br>\n";
			msgText 	=  msgText+"<b>EzCommerce Suite.</b> <br>\n";
			
		
		}else if("POACK".equals(msgType)){
		
			msgSubject 	= "Purchase Order(s) Acknowledged.";
			msgText 	= "<br>Dear Sir,<br><br>\n\n"; 
			msgText 	= msgText+"Sub: "+msgSubject+"<br><br>\n\n";
			msgText 	= msgText+"Following Purchase Order(s) Acknowledged.<br>\n\n";
			msgText 	= msgText+"	"+data+" \n\n";
			msgText		= msgText+"<br><br>Best Regards, <br>\n";
			msgText 	= msgText+"<b>"+toVendor+". </b> <br>\n";
		
		}else if("POREMIND".equals(msgType)){
			
			msgSubject 	= "Reminder for Acknowledgement Of PO(s).";
			msgText 	= "<br>Dear User,<br><br>\n\n"; 
			msgText 	= msgText+"Sub: "+msgSubject+"<br><br>\n\n";
			msgText 	= msgText+"Reminder for Acknowledgement Of PO Nos.<br>\n\n";
			msgText 	= msgText+"	"+data+". \n\n";
			msgText		= msgText+"<br><br>Best Regards, <br>\n";
			msgText 	= msgText+"<b>EzCommerce Suite.</b> <br>\n";
		}else if("CHGADD".equals(msgType)){
		
			msgSubject 	= "Change of Address";
			msgText 	= "<br>Dear User,<br><br>\n\n"; 
			msgText 	= msgText+"Sub: "+msgSubject+"<br><br>\n\n";
			msgText 	= msgText+"This is to inform you that vendor "+data+" changed his address.<br>\n\n";
			msgText		= msgText+"<br><br>Best Regards, <br>\n";
			msgText 	= msgText+"<b>"+toVendor+" .</b> <br>\n";
		
		
		}else if("CHGPROFILE".equals(msgType)){
			msgSubject 	= "Change of Profile";
			msgText 	= "<br>Dear User,<br><br>\n\n"; 
			msgText 	= msgText+"Sub: "+msgSubject+"<br><br>\n\n";
			msgText 	= msgText+"This is to inform you that vendor "+data+" changed his Profile.<br>\n\n";
			msgText		= msgText+"<br><br>Best Regards, <br>\n";
			msgText 	= msgText+"<b>"+toVendor+" .</b> <br>\n";

		}
		msgText = msgText+"<br>\n<sup><b>*</b></sup>This is electronically generated mail/document. Hence signature not required. <br>\n";
				
		ReturnObjFromRetrieve retUser = null;
		
		EzMsgStructure msgStruc = null;
		EzPersonalMsgStructure[] msgDetails = null;
		EzPersonalMsgStructure[] msgDetails1 = null;
		
		EzcMessageParams  ezcMessageParams = new EzcMessageParams();
		EzMessageParams   ezMessageParams  = new EzMessageParams();
		
		Vector toIds	= new Vector();
		Vector dispIds	= new Vector();
		Vector failedIds= new Vector();
		
		msgStruc = new EzMsgStructure();
		msgStruc.setClient("200");
		msgStruc.setPriorityFlag("U");
		msgStruc.setMsgHeader(msgSubject);
		msgStruc.setMsgContent1(msgText);
		msgStruc.setMsgContent2("");
		msgStruc.setLnkExtInfo("Lnk");

		ezMessageParams.setEzMsgStructure(msgStruc);
		ezcMessageParams.setObject(ezMessageParams);
		Session.prepareParams(ezcMessageParams);
		
		ReturnObjFromRetrieve retUserData=null;
		EzcUserParams uparamsN= new EzcUserParams();
		EzcUserNKParams ezcUserNKParamsN = new EzcUserNKParams();
		
		String uId = "";
		
		if(isVendor || "POREL".equals(msgType) || "POREMIND".equals(msgType)){
			
			sendToUser = "";
			ArrayList desiredSteps=new ArrayList();
			
			if("POREL".equals(msgType))
				desiredSteps.add("1");
			else if(isVendor)
				desiredSteps.add("-1");
			
			//desiredSteps.add("-2");
			//desiredSteps.add("-3");
		
			ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
			
			if("POREL".equals(msgType) || "POREMIND".equals(msgType)){
				params.setTemplate(template);
				params.setSyskey(sysKeyVal);	
			}else{
				params.setTemplate((String)session.getValue("TEMPLATE"));
				params.setSyskey((String) session.getValue("SYSKEY"));
			
			}
			params.setParticipant((String) session.getValue("USERGROUP"));
			params.setDesiredSteps(desiredSteps);
			
			mainParams.setObject(params);
			Session.prepareParams(mainParams);
			ezc.ezcommon.EzLog4j.log("Getting Users List based on WF Starts","I");
			retUser=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParams);
			retUser.toEzcString();
			ezc.ezcommon.EzLog4j.log("Getting Users List based on WF Ends","I");
			if(retUser!=null)
			{
				for(int i=0;i<retUser.getRowCount();i++){
					toIds.add(retUser.getFieldValueString(i,"EU_ID"));
				}
				if(!isVendor)
					toIds.add(toVendor);
				
				
				for(int i=0;i<toIds.size();i++)
				{
					uId = (String)toIds.get(i);
					ezc.ezcommon.EzLog4j.log("GETTING PORTAL USERID AND SENDING LOCAL MAIL>"+i+">STARTS:>"+uId,"I");
							
					msgDetails = new EzPersonalMsgStructure[1];
					msgDetails[0] = new EzPersonalMsgStructure();
					msgDetails[0].setClient("200");
					msgDetails[0].setRecUserId(uId.toUpperCase());			
					msgDetails[0].setExpiryDate("99999999");
					msgDetails[0].setExpiryDays(10);
					msgDetails[0].setReminderDate("0");
					msgDetails[0].setFolderId("1000");
					ezMessageParams.setEzPersonalMsgStructure(msgDetails);
									
					try{
						Manager.createPersonalMsg(ezcMessageParams);
						dispIds.addElement(sendToUser);
						ezc.ezcommon.EzLog4j.log("GETTING PORTAL USERID AND SENDING LOCAL MAIL>"+i+">ENDS-SUCCESS:>"+uId,"I");
					}
					catch(Exception e){  
						failedIds.addElement(sendToUser);
						ezc.ezcommon.EzLog4j.log("GETTING PORTAL USERID AND SENDING LOCAL MAIL>"+i+">ENDS-FAILED:>"+uId,"I");
					}
							
					ezcUserNKParamsN.setLanguage("EN");
					uparamsN.setUserId(uId);		
					uparamsN.createContainer();
					uparamsN.setObject(ezcUserNKParamsN);
					Session.prepareParams(uparamsN);
					
					
					retUserData = (ReturnObjFromRetrieve)UManager.getUserData(uparamsN);
					
					sendToUser=sendToUser+retUserData.getFieldValueString("EU_EMAIL")+",";

				}
			}
			if(sendToUser.length()>0)
				to = sendToUser.substring(0,sendToUser.length()-1);
			
			ezc.ezcommon.EzLog4j.log("sendToUserListforExtMails>>>>>:--->"+sendToUser,"I");
		}
	  }
						
		if(sendToExt){
			ezc.ezcommon.EzLog4j.log("SENDING EXT MAILS STARTS-to:>>"+to,"I");
			try{
				if("POREL".equals(msgType) || "POACK".equals(msgType) || "POREMIND".equals(msgType))
				{
					cc = "";//ADD CC IDS HERE
					//msgText += "<BR> <BR> **An email from <a  href='mailto:ezcsupport@answerthink.com'>ezcsupport@answerthink.com</a> is a real Message.<BR> **An email from <a  href='mailto:b2bdev@kissusa.com'>b2bdev@kissusa.com</a> is a testing from QA sever";	
				}	

				ezc.ezcommon.EzLog4j.log("Session.getUserId():------->"+Session.getUserId(),"I");
				ezc.ezcommon.EzLog4j.log("Message is sent to:>>>"+to+":--->"+msgText,"I");

				ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();	
				mailParams.setGroupId("Ezc");
				mailParams.setTo(to);
				mailParams.setCC(cc);
				mailParams.setMsgText(" "+msgText);
				mailParams.setSubject(msgSubject+"[ " + Session.getUserId() +" ]");
				mailParams.setSendAttachments(false);
				mailParams.setContentType("text/html");
				ezc.ezmail.EzMail myMail=new ezc.ezmail.EzMail();
				boolean value=myMail.ezSend(mailParams,Session);

				ezc.ezcommon.EzLog4j.log("SENDING EXT MAILS ENDS-STATUS>>"+value,"I");
			}
			catch(Exception e){

				ezc.ezcommon.EzLog4j.log("Failed to Send Ext Mails Plz Chk Mail Config","I");
			}

			ezc.ezcommon.EzLog4j.log("SENDING EXT MAILS COMPLETED","I");
		}
%>





