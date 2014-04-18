<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%!
	public static String replaceString(String theString,String from,String to)
	{
		  int go=0;
		  String ret=theString;
		  while (ret.indexOf(from,go)>0)
		  {
			   go=ret.indexOf(from,go);
			   ret=ret.substring(0,go)+to+ret.substring(go+from.length());
			   go=go+to.length();
		  }
		  return ret;
	}
%>

<%	
	String syskey = (String)session.getValue("SYSKEY");
	String CollectiveRFQNo = request.getParameter("CollectiveRFQNo");
	String mat = request.getParameter("material");
	
	
	String soldTos = "";
	if(request.getParameter("soldTos") != null)
	{
		soldTos = request.getParameter("soldTos");
		soldTos = replaceString(soldTos,",","','");	
	}	

	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager 	= new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams ezcparams				     		= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams 	= new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	ezc.ezparam.ReturnObjFromRetrieve myRet = null;
	
	ezirfqheaderparams.setExt1("CRM");
	if(soldTos != null)
	{
		ezirfqheaderparams.setExt2(mat);	
		ezirfqheaderparams.setSoldTo(soldTos);
		ezirfqheaderparams.setSysKey(syskey);
	}
	else 
		ezirfqheaderparams.setExt2(mat);

	ezcparams.setObject(ezirfqheaderparams);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);
	try
	{
		myRet = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQList(ezcparams);	
		myRet.sort(new String[]{"COLLECTIVE_RFQ_NO"},false);
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured while getting QCFs List:"+e);
	}
%>	