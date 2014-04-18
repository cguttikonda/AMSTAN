<%@ page import="java.util.*,java.io.*" %>
<%@ page import="javax.mail.*,javax.mail.internet.*,javax.activation.*" %>
<%@ page import="ezc.forums.params.*,ezc.messaging.params.*,ezc.trans.messaging.params.*" %>
<%@ page import="ezc.client.*,ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>

<%

	if("CU".equals(userRole.toUpperCase()))
	{
		String agent		=(String)session.getValue("Agent");
		String sendToExt="N";
		String client = "200";
		String subject="Change of Address Info for:"+agent;
		String tbillAddr = billAddr1+","+billAddr2;
		
		//String msgInt ="Change of Address Information for : "+agent+"\n\n Address &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+tbillAddr+"\n City &nbsp;\t\t&nbsp;&nbsp;&nbsp;&nbsp; "+billCity+"\n Zip\t\t&nbsp;&nbsp;&nbsp;&nbsp; "+billZip+"\n State \t\t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+billState+"\n Country \t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+billCountry+"\n Phone\t\t &nbsp;&nbsp;&nbsp;&nbsp;"+phone+"\n Ship To Address1 &nbsp;&nbsp;&nbsp;"+shipAddr1+"\n Ship To Address2 &nbsp;&nbsp;&nbsp;"+shipAddr2+"\n Web Address &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "+webAddr+"\n\n Regards,\n &nbsp;"+Session.getUserId();
		
		String msgExt ="<b>Change of Address Information for : "+agent+"</b><BR><BR> <b>Address</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "+tbillAddr+"<BR> <b>City</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "+billCity+"<BR> <b>Zip</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "+billZip+"<BR> <b>State</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+billState+"<BR> <b>Country</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+billCountry+"<BR> <b>Phone</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;"+phone+"<BR> <b>Ship To Address1</b> &nbsp;&nbsp;&nbsp;"+shipAddr1+"<BR> <b>Ship To Address2</b> &nbsp;&nbsp; "+shipAddr2+"<BR> <b>Web Address</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "+webAddr+"<BR><BR> Regards,<BR> &nbsp;"+Session.getUserId();
		
		String msgInt = "";
		
		if(msgExt!=null)
		{
			
			msgInt = msgExt.replaceAll("<BR>","\n");			
			msgInt = msgInt.replaceAll("<b>","");
			msgInt = msgInt.replaceAll("</b>","");
		
		}
		
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
	