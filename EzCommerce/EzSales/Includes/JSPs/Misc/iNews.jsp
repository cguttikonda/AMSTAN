
<%
	
	//String syskey = (String)session.getValue("SalesAreaCode");
	//out.println("syskeysyskeysyskeysyskeysyskey  "+syskey);
	String selectStr = "1=1";
	String selectStrPrivate = "GETDATE() BETWEEN EZN_START_DATE AND EZN_END_DATE AND EZN_SYSKEY = '"+(String)session.getValue("SalesAreaCode")+"' and EZN_TYPE IN('G','P') ";  
	if("3".equals((String)session.getValue("UserType")))
		selectStrPrivate = "GETDATE() BETWEEN EZN_START_DATE AND EZN_END_DATE AND EZN_SYSKEY = '"+(String)session.getValue("SalesAreaCode")+"' and EZN_TYPE='G'";  
	
	ezc.ezparam.ReturnObjFromRetrieve newsRetObj = new ezc.ezparam.ReturnObjFromRetrieve();
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	ezc.eznews.client.EzNewsManager newsManager = new ezc.eznews.client.EzNewsManager();
	ezc.eznews.params.EziNewsParams newsParam = new ezc.eznews.params.EziNewsParams();
	
	newsParam.setNewsSyskey(selectStrPrivate);
	mainParams.setLocalStore("Y");
	mainParams.setObject(newsParam);
	Session.prepareParams(mainParams);

	try
	{
		newsRetObj = (ezc.ezparam.ReturnObjFromRetrieve)newsManager.ezGetNews(mainParams);
	}catch(Exception e){}
	
	
	int vectSize =0;
	java.util.Vector newsVector = new java.util.Vector();
	
	
	if(newsRetObj!=null && newsRetObj.getRowCount()>0)
	{
			for(int j=0;j<newsRetObj.getRowCount();j++)
			{
				newsVector.add(newsRetObj.getFieldValueString(j,"EZN_TEXT"));
			}
		
	}	
	vectSize = newsVector.size();
	
	
	
%>