<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<%@ page import="ezc.ezparam.*"%>

<%
	String fromDate	= request.getParameter("fromDate");
	String toDate	= request.getParameter("toDate");
	ezc.ezutil.FormatDate getFormat = new ezc.ezutil.FormatDate();
	
	if(fromDate==null || toDate==null)
	{
		java.util.Date today = new java.util.Date();
		java.util.Date tomorrow = new java.util.Date();
		
		today.setDate(today.getDate());
		tomorrow.setDate(tomorrow.getDate()+15);
		fromDate	= getFormat.getStringFromDate(today,"/",ezc.ezutil.FormatDate.DDMMYYYY);
		toDate		= getFormat.getStringFromDate(tomorrow,"/",ezc.ezutil.FormatDate.DDMMYYYY);
	
	}
	
	//out.println("fromDate::::::"+fromDate+":::toDate:::"+toDate);
	int myNewsRetCnt=0;
	ezc.ezparam.ReturnObjFromRetrieve myNewsRet = null;
	ezc.ezparam.EzcParams mainParams=null;
	ezc.eznews.client.EzNewsManager newsManager = null;
	ezc.eznews.params.EziNewsParams newsParam = null;	
	global.setDateFormat("MM/dd/yyyy");
	ReturnObjFromRetrieve GlobObj = null;
	if(fromDate!=null && toDate!=null)
	{
		mainParams=new ezc.ezparam.EzcParams(false);
		newsManager = new ezc.eznews.client.EzNewsManager();
		newsParam = new ezc.eznews.params.EziNewsParams();
		
		newsParam.setNewsStartDate(fromDate);
		newsParam.setNewsEndDate(toDate);
		newsParam.setQType("L");

		mainParams.setLocalStore("Y");
		mainParams.setObject(newsParam);
		Session.prepareParams(mainParams);

		myNewsRet=(ezc.ezparam.ReturnObjFromRetrieve)newsManager.ezGetNews(mainParams);
		if(myNewsRet!=null )
			myNewsRetCnt = myNewsRet.getRowCount();
	}
	if(myNewsRetCnt>0)
	{
		Vector types= new Vector();
		types.addElement("date");
		types.addElement("date");
		types.addElement("date");

		Vector cols= new Vector();
		cols.addElement("EZN_CREATED_DATE");
		cols.addElement("EZN_START_DATE");
		cols.addElement("EZN_END_DATE");
		global.setColTypes(types);
		global.setColNames(cols);
		GlobObj = global.getGlobal(myNewsRet);
	}
		
	//out.println("myNewsRet:::::::::::::::::::"+myNewsRet.toEzcString());
		
%>
