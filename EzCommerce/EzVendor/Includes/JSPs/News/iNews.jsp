<%
	String syskey = (String)session.getValue("SYSKEY");
	String newsId = request.getParameter("newsid");
	ezc.ezparam.ReturnObjFromRetrieve newsRet = null;
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	ezc.eznews.client.EzNewsManager newsManager = new ezc.eznews.client.EzNewsManager();
	ezc.eznews.params.EziNewsParams newsParam = new ezc.eznews.params.EziNewsParams();
	newsParam.setNewsSyskey("EZN_SYSKEY ='"+syskey+"'");
	mainParams.setLocalStore("Y");
	mainParams.setObject(newsParam);
	Session.prepareParams(mainParams);
	int newsCount = 0;
	if(syskey!=null)
	{
		try
		{
			newsRet=(ezc.ezparam.ReturnObjFromRetrieve)newsManager.ezGetNews(mainParams);
			if(newsRet != null)
				newsCount = newsRet.getRowCount();
		}
		catch(Exception e){}
	}	
		
%>