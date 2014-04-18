<%@ page import="java.util.*,java.io.*" %>
<%@ page import="javax.mail.*,javax.mail.internet.*,javax.activation.*" %>
<%@ page import="ezc.forums.params.*,ezc.messaging.params.*,ezc.trans.messaging.params.*" %>
<%@ page import="ezc.client.*,ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>

<%

	if("CU".equals(userRole.toUpperCase()))
	{
		String[] sendToUser = null;
		String to 	  = "";
		//**********This for reteriving internal user List  *************//
					
		String participant="";
		ArrayList desiredStep=new ArrayList();
		desiredStep.add("-1");

		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
		params.setTemplate(template);
		params.setSyskey(catalog_area);
		params.setParticipant((String)session.getValue("Participant"));
		//out.println("ParticipantParticipant  "+(String)session.getValue("Participant"));
		
		//params.setDesiredStep((String)desiredStep.get(i));
		params.setDesiredSteps(desiredStep);

		mainParams.setObject(params);

		Session.prepareParams(mainParams);


		retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams);

	//********** End of reteriving internal user List*************/

		sendToUser = new String[retsoldto.getRowCount()];

		if(retsoldto!=null)
		{
			for(int j=0;j<retsoldto.getRowCount();j++)
			{
				sendToUser[j] = retsoldto.getFieldValueString(j,"EU_ID");
				to = to+retsoldto.getFieldValueString(j,"EU_EMAIL")+",";
			}
		}

		to=to.substring(0,to.length()-1);
			
		EzMsgStructure msgStruc = null;
		EzPersonalMsgStructure[] msgDetails = null;

		//Fill in the message structure
		msgStruc = new EzMsgStructure();
			
		msgStruc.setClient(client);
		msgStruc.setPriorityFlag("U");
		msgStruc.setMsgHeader(subject);
		msgStruc.setMsgContent1(msgInt);
		msgStruc.setMsgContent2("");
		msgStruc.setLnkExtInfo("Lnk");
		
		/*************************This for Internal Mail*****************************************
		*	sendToUser : has external mail id's of all internal users. 			*
		*	msg:has the message information. 		                		*
		*	subject: has  the subject information		        			*
		*****************************************************************************************/

		EzcMessageParams  ezcMessageParams = new EzcMessageParams();
		EzMessageParams ezMessageParams    = new EzMessageParams();
		ezMessageParams.setEzMsgStructure(msgStruc);

		// Set Input Parameter Object in the Container
		ezcMessageParams.setObject(ezMessageParams);
		Session.prepareParams(ezcMessageParams); 
		
		// Preapare Parameters for Call
		try
		{	
			if(sendToUser!=null)
			{
				for(int j=0;j<sendToUser.length;j++)
				{
					msgDetails = new EzPersonalMsgStructure[1];
					msgDetails[0] = new EzPersonalMsgStructure();
					msgDetails[0].setClient(client);
					msgDetails[0].setRecUserId(sendToUser[j].toUpperCase());			
					msgDetails[0].setExpiryDate("99999999");
					msgDetails[0].setExpiryDays(10);
					msgDetails[0].setReminderDate("0");
					msgDetails[0].setFolderId("1000");
					ezMessageParams.setEzPersonalMsgStructure(msgDetails);
					MsgManager.createPersonalMsg(ezcMessageParams);
				}
			}	
		
		}catch(Exception e){
			out.println("ExceptionException "+e);
		}
		
		
		/**************************** End of Internal Mail*******************************/
	
		/*************************This for External Mail*********************************
		*	to : has external mail id's of all internal users.  			*
		*	msg:has the message information. 		    			*
		*	subject: has  the subject information		    			*
		*********************************************************************************/
		
		try
		{
			
			
			
			ezc.ezcommon.EzLog4j.log("Message is sent to:"+to+":--->"+msgExt,"I");	
			
			ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();	
			mailParams.setGroupId("Ezc");
			mailParams.setTo("jjillelamudi@answerthink.com,rsanapala@answerthink.com");
			mailParams.setMsgText(msgExt);
			mailParams.setSubject(subject);
			mailParams.setSendAttachments(false);
			mailParams.setContentType("text/html");
			ezc.ezmail.EzMail myMail=new ezc.ezmail.EzMail();
			boolean value=myMail.ezSend(mailParams,Session);

			ezc.ezcommon.EzLog4j.log("End of the ezSend mail.","I");


		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Failed to Get User MailId.Probably b'coz wrong UserId","I");
		}
		
	
		/**************************** End of External Mail *******************************/
	}
	
%>	
	