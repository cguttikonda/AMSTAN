<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*"%>
<% 


	EzcParams mainParams=null;
 	EziMiscParams loginParams = null;
	ReturnObjFromRetrieve loginRet = null;
	String entMail = request.getParameter("entEmail");
	ezc.ezcommon.EzLog4j.log("entMail::::::::::::::"+entMail,"D");
	String emailStat = "N"	;

	if(entMail!=null && !"null".equals(entMail))
	{
		mainParams  = new ezc.ezparam.EzcParams(false);
		loginParams = new EziMiscParams();
		loginRet    = new ReturnObjFromRetrieve();

		loginParams.setIdenKey("MISC_SELECT");
		loginParams.setQuery("SELECT EU_ID FROM EZC_USERS,EZC_USER_DEFAULTS WHERE EU_ID = EUD_USER_ID AND EU_EMAIL = '"+entMail+"' AND EUD_KEY='USERROLE' AND EUD_VALUE!='RE'");

		mainParams.setLocalStore("Y");
		mainParams.setObject(loginParams);
		Session.prepareParams(mainParams);	

		try
		{
			loginRet = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams);
			if(loginRet!=null && loginRet.getRowCount()>0)	
				emailStat = "Y";
			out.println(emailStat);	


		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}
	}	
	
%>	