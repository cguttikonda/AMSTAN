<%!
	private boolean authCheck(ezc.session.EzSession Session,String userId,String sysNo,String authKey)
	{
		ezc.ezparam.ReturnObjFromRetrieve authChkRetObj = null;

		try
		{
			ezc.ezparam.EzcParams authParamsMisc= new ezc.ezparam.EzcParams(false);
			ezc.ezmisc.params.EziMiscParams authParams = new ezc.ezmisc.params.EziMiscParams();
			ezc.ezmisc.client.EzMiscManager miscManager = new ezc.ezmisc.client.EzMiscManager();

			if(authKey!=null && !"null".equals(authKey) && !"".equals(authKey))
			{
				String query1 = "";
				authParams.setIdenKey("MISC_SELECT");

				query1="SELECT * FROM EZC_USER_AUTH WHERE EUA_USER_ID='"+userId+"' AND EUA_SYS_NO='"+sysNo+"' AND EUA_AUTH_KEY='"+authKey+"'";

				authParams.setQuery(query1);

				authParamsMisc.setLocalStore("Y");
				authParamsMisc.setObject(authParams);
				Session.prepareParams(authParamsMisc);	

				authChkRetObj = (ezc.ezparam.ReturnObjFromRetrieve)miscManager.ezSelect(authParamsMisc);
			}
		}
		catch(Exception ex){}

		if(authChkRetObj!=null && authChkRetObj.getRowCount()>0)
			return true;
		else
			return false;
	}
%>