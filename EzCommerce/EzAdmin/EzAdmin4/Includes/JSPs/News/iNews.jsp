<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%

	String syskey = (String)session.getValue("SYSKEY");
	ezc.ezparam.ReturnObjFromRetrieve newsRet = null;
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	ezc.eznews.client.EzNewsManager newsManager = new ezc.eznews.client.EzNewsManager();
	ezc.eznews.params.EziNewsParams newsParam = new ezc.eznews.params.EziNewsParams();

	newsParam.setNewsSyskey("EZN_SYSKEY ='"+syskey+"'");

	mainParams.setLocalStore("Y");
	mainParams.setObject(newsParam);
	Session.prepareParams(mainParams);

	if(syskey!=null)
	{
		try{
			newsRet=(ezc.ezparam.ReturnObjFromRetrieve)newsManager.ezGetNews(mainParams);
		}catch(Exception e){}
	}	
		
%>