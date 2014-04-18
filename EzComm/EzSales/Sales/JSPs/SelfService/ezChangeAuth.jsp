<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*"%>
<% 


	EzcParams mainParams=null;
 	EziMiscParams loginParams = null;
	ReturnObjFromRetrieve loginRet = null;
	String authVal = request.getParameter("authVal");
	ezc.ezcommon.EzLog4j.log("authVal::::::::::::::"+authVal,"D");
	String updateStat = "N"	;

	if(authVal!=null && !"null".equals(authVal))
	{
		mainParams  = new ezc.ezparam.EzcParams(false);
		loginParams = new EziMiscParams();
		loginRet    = new ReturnObjFromRetrieve();

		loginParams.setIdenKey("MISC_UPDATE");
		//loginParams.setQuery("UPDATE EZC_USER_DEFAULTS SET EUD_VALUE='"+authVal+"' WHERE EUD_USER_ID = '"+((String)Session.getUserId()).toUpperCase()+"' AND EUD_KEY='SHOWIMAGES'");
		String myMergeString ="MERGE EZC_USER_DEFAULTS AS ttable	USING ( SELECT '"+
		                      ((String)Session.getUserId()).toUpperCase()+"' AS EUD_USER_ID,'SHOWIMAGES' AS EUD_KEY,'NOT' AS EUD_SYS_KEY ,'D' AS EUD_DEFAULT_FLAG,'Y' AS EUD_IS_USERA_KEY) AS sourcetable"+
		                      " ON ttable.EUD_USER_ID = sourcetable.EUD_USER_ID "+
		                      " AND ttable.EUD_KEY = sourcetable.EUD_KEY " + 
		                      " WHEN MATCHED THEN UPDATE SET ttable.EUD_VALUE = '"+ authVal+ "' "+
		                      "	WHEN NOT MATCHED THEN INSERT (EUD_USER_ID,EUD_SYS_KEY,EUD_KEY,EUD_VALUE,EUD_DEFAULT_FLAG,EUD_IS_USERA_KEY) " +
				      " VALUES ('"+((String)Session.getUserId()).toUpperCase()+"','NOT','SHOWIMAGES','"+authVal+"','D','Y');";		                      
		                      
		loginParams.setQuery(myMergeString);
		mainParams.setLocalStore("Y");
		mainParams.setObject(loginParams);
		Session.prepareParams(mainParams);	

		try
		{
			ezMiscManager.ezUpdate(mainParams);
			updateStat = "Y";
			
			out.println(updateStat);	


		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
			updateStat = "N";
		}
		session.removeValue("SHOWIMAGES");
		session.putValue("SHOWIMAGES",authVal);
	}	
	
%>	