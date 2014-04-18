<%!
	public String getUserEmail(ezc.session.EzSession Session,String userId)
	{
		String userEmail = "";

		ezc.ezparam.ReturnObjFromRetrieve retUserData_UE = null;

		ezc.ezparam.EzcUserParams uparamsN_UE = new ezc.ezparam.EzcUserParams();
		ezc.ezparam.EzcUserNKParams ezcUserNKParamsN_UE = new ezc.ezparam.EzcUserNKParams();
		ezcUserNKParamsN_UE.setLanguage("EN");
		uparamsN_UE.setUserId(userId);
		uparamsN_UE.createContainer();
		uparamsN_UE.setObject(ezcUserNKParamsN_UE);
		Session.prepareParams(uparamsN_UE);

		try
		{
			ezc.client.EzUserAdminManager UManager = new ezc.client.EzUserAdminManager();
			retUserData_UE = (ezc.ezparam.ReturnObjFromRetrieve)UManager.getUserData(uparamsN_UE);
			userEmail = retUserData_UE.getFieldValueString("EU_EMAIL");
		}
		catch(Exception e){}

		return userEmail;
	}
	public String getOpsCCEmail(ezc.session.EzSession Session,String shipToState)
	{
		String userCCEmail = "";

		ezc.ezparam.EzcParams shipParamsMisc = new ezc.ezparam.EzcParams(false);
		ezc.ezmisc.params.EziMiscParams shipParams = new ezc.ezmisc.params.EziMiscParams();

		ezc.ezparam.ReturnObjFromRetrieve shipToActRetObj = null;

		String shStateToAct = "US"+(shipToState.trim());
		String query_S = "";
		shipParams.setIdenKey("MISC_SELECT");

		query_S="SELECT VALUE2 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='STATEOPSEMAIL' AND VALUE1='"+shStateToAct+"'";

		shipParams.setQuery(query_S);

		shipParamsMisc.setLocalStore("Y");
		shipParamsMisc.setObject(shipParams);
		Session.prepareParams(shipParamsMisc);	

		try
		{
			ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
			shipToActRetObj = (ezc.ezparam.ReturnObjFromRetrieve)ezMiscManager.ezSelect(shipParamsMisc);
		}
		catch(Exception e){}

		if(shipToActRetObj!=null)
		{
			userCCEmail = shipToActRetObj.getFieldValueString(0,"VALUE2");
		}

		return userCCEmail;
	}
	public void sendEmail(ezc.session.EzSession Session,String toEmail,String ccEMail,String msgText,String msgSubject)
	{
		ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();
		mailParams.setGroupId("Amstan");
		mailParams.setTo(toEmail);
		mailParams.setCC(ccEMail);
		//mailParams.setBCC("");
		mailParams.setMsgText(msgText);
		mailParams.setSubject(msgSubject);
		mailParams.setSendAttachments(false);
		mailParams.setContentType("text/html");
		ezc.ezmail.EzMail soMails=new ezc.ezmail.EzMail();

		boolean value = false;
		try
		{
			value=soMails.ezSend(mailParams,Session);
		}
		catch(Exception ex)
		{
			ezc.ezcommon.EzLog4j.log("Exception in ezSend mail : "+ex.getMessage(),"E");
			value = false;
		}
		finally
		{
			ezc.ezcommon.EzLog4j.log("End of the ezSend mail : "+value,"D");
		}
	}
	public String getBussUsers(ezc.session.EzSession Session,String sysKey,String soldToCode)
	{
		String sendToUser = "";

		ezc.ezparam.ReturnObjFromRetrieve partnersRet_C = null;

		if(soldToCode!=null)
		{
			soldToCode = soldToCode.trim();

			String mySoldTo = "";

			try
			{
				soldToCode = Long.parseLong(soldToCode)+"";
				mySoldTo = "0000000000"+soldToCode;
				mySoldTo = mySoldTo.substring((mySoldTo.length()-10),mySoldTo.length());
			}
			catch(Exception ex)
			{
				mySoldTo = soldToCode;
			}

			ezc.ezadmin.ezadminutils.params.EziAdminUtilsParams adminUtilsParams = new ezc.ezadmin.ezadminutils.params.EziAdminUtilsParams();
			adminUtilsParams.setSyskeys(sysKey);
			adminUtilsParams.setPartnerValueBy(mySoldTo);

			ezc.ezparam.EzcParams mainParams_C = new ezc.ezparam.EzcParams(false);
			mainParams_C.setObject(adminUtilsParams);
			Session.prepareParams(mainParams_C);

			try
			{
				ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager AUM = new ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager();
				partnersRet_C = (ezc.ezparam.ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams_C);
			}
			catch(Exception e){}

			if(partnersRet_C!=null && partnersRet_C.getRowCount()>0)
			{
				for(int l=0;l<partnersRet_C.getRowCount();l++)
				{
					String tmpSendToUser = partnersRet_C.getFieldValueString(l,"EU_ID");

					if(tmpSendToUser!=null && !"null".equals(tmpSendToUser)) 
					{
						tmpSendToUser = tmpSendToUser.trim();

						ezc.client.EzUserAdminManager UAdminManager = new ezc.client.EzUserAdminManager();
						ezc.ezparam.EzcUserParams uparams= new ezc.ezparam.EzcUserParams();
						ezc.ezparam.EzcUserNKParams ezcUserNKParams = new ezc.ezparam.EzcUserNKParams();
						ezcUserNKParams.setLanguage("EN");
						ezcUserNKParams.setSys_Key("0");
						uparams.createContainer();
						uparams.setUserId(tmpSendToUser);
						uparams.setObject(ezcUserNKParams);
						Session.prepareParams(uparams);

						ezc.ezparam.ReturnObjFromRetrieve retObjSubUser = null;

						try
						{
							retObjSubUser = (ezc.ezparam.ReturnObjFromRetrieve)(UAdminManager.getAddUserDefaults(uparams));
						}
						catch(Exception e){}

						String isSubUser = null;
						String userStatus = null;

						if(retObjSubUser!=null && retObjSubUser.getRowCount()>0)
						{
							for(int i=0;i<retObjSubUser.getRowCount();i++)
							{
								if("ISSUBUSER".equals(retObjSubUser.getFieldValueString(i,"EUD_KEY")))
								{
									isSubUser=retObjSubUser.getFieldValueString(i,"EUD_VALUE");
								}
								if("STATUS".equals(retObjSubUser.getFieldValueString(i,"EUD_KEY")))
								{
									userStatus=retObjSubUser.getFieldValueString(i,"EUD_VALUE");
								}
							}
						}

						//if(isSubUser!=null && ("Y".equals(isSubUser) || "".equals(isSubUser)) && userStatus!=null && "A".equals(userStatus))
						//	sendToUser = sendToUser + "," + tmpSendToUser;
						if("Y".equals(isSubUser))
						{
							if("A".equals(userStatus))
								sendToUser = sendToUser + "," + tmpSendToUser;
						}
						else
						{
							sendToUser = sendToUser + "," + tmpSendToUser;
						}
					}
				}
				if(sendToUser.startsWith(","))
					sendToUser = sendToUser.substring(1);
			}
		}
		return sendToUser;
	}
	public String getSalesRep(String salesRep)
	{
		String sendToUser = "";

		try
		{
			java.util.StringTokenizer stEcadVal = new java.util.StringTokenizer(salesRep,"¥");

			while(stEcadVal.hasMoreTokens())
			{
				String salesRep_A = (String)stEcadVal.nextElement();
				String salesRep_AId = salesRep_A.split("¤")[0];

				sendToUser = sendToUser+","+salesRep_AId;
			}

			if(sendToUser.startsWith(","))
				sendToUser = sendToUser.substring(1);
		}
		catch(Exception e){}

		return sendToUser;
	}
	public String getUserName(ezc.session.EzSession Session,String userId)
	{
		String retName=userId;

		ezc.ezparam.ReturnObjFromRetrieve retUserData=null;

		ezc.ezparam.EzcUserParams uparamsN= new ezc.ezparam.EzcUserParams();
		ezc.ezparam.EzcUserNKParams ezcUserNKParamsN = new ezc.ezparam.EzcUserNKParams();
		ezc.client.EzUserAdminManager UManager = new ezc.client.EzUserAdminManager();
		ezcUserNKParamsN.setLanguage("EN");
		uparamsN.setUserId(userId);
		uparamsN.createContainer();
		uparamsN.setObject(ezcUserNKParamsN);
		Session.prepareParams(uparamsN);

		try
		{					
			retUserData = (ezc.ezparam.ReturnObjFromRetrieve)UManager.getUserData(uparamsN);
		}
		catch(Exception e){}

		if(retUserData!=null && retUserData.getRowCount()>0)
		{
			retName = retUserData.getFieldValueString(0,"EU_FIRST_NAME")+" "+retUserData.getFieldValueString(0,"EU_LAST_NAME");
		}
		return retName;
	}
	public static String replaceString(String theString,String from,String to)
	{
		int go=0;
		String ret=theString;
		while (ret.indexOf(from,go)>=0)
		{
			go=ret.indexOf(from,go);
			ret=ret.substring(0,go)+to+ret.substring(go+from.length());
			go=go+to.length();
		}
		return ret;
	}
%>