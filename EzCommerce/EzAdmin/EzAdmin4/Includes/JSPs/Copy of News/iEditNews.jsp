<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<%@ page import="ezc.ezparam.*,ezc.ezutil.FormatDate,java.util.*"%>
<%@ include file="../../../Includes/JSPs/News/iNewsTypes.jsp"%>
<%
	String editStr = request.getParameter("chk1");
	
	ezc.ezbasicutil.EzStringTokenizer Tokens = new ezc.ezbasicutil.EzStringTokenizer(editStr,"$$");
	java.util.Vector Vect = Tokens.getTokens();
	String syskey="",newsid = "";
	if(editStr!=null)
	{
		newsid 		= (String)Vect.elementAt(0);
		syskey 		= (String)Vect.elementAt(1);
	}

	int retObjPAsCnt = 0;
	int myNewsRetCnt = 0;

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	ezc.ezparam.ReturnObjFromRetrieve retObjPAs   = (ezc.ezparam.ReturnObjFromRetrieve)sysManager.getPurchaseAreas(sparams);
	
	if(retObjPAs!=null) retObjPAsCnt = retObjPAs.getRowCount();
	ezc.ezparam.ReturnObjFromRetrieve myNewsRet = null;
	
	
	if(syskey!=null && newsid!=null)
	{
		ezc.ezparam.EzcParams mainParams1=new ezc.ezparam.EzcParams(false);
		ezc.eznews.client.EzNewsManager newsManager = new ezc.eznews.client.EzNewsManager();
		ezc.eznews.params.EziNewsParams newsParam = new ezc.eznews.params.EziNewsParams();
		newsParam.setNewsSyskey("EZN_SYSKEY ='"+syskey+"' AND  EZN_ID='"+newsid+"'");
		mainParams1.setLocalStore("Y");
		mainParams1.setObject(newsParam);
		Session.prepareParams(mainParams1);
		myNewsRet=(ezc.ezparam.ReturnObjFromRetrieve)newsManager.ezGetNews(mainParams1);
	}	
	
	if(myNewsRet!=null && myNewsRet.getRowCount()>0)
		myNewsRetCnt = myNewsRet.getRowCount();

	String news = "",newsrole="",newsType="",group="",startdate="",enddate="";		
	if(myNewsRet!=null)
	{
		startdate	= myNewsRet.getFieldValueString(0,"START_DATE_CHAR");
		enddate		= myNewsRet.getFieldValueString(0,"END_DATE_CHAR");
		news 		= myNewsRet.getFieldValueString(0,"EZN_TEXT");;
		startdate 	= startdate.substring(0,10);
		enddate 	= enddate.substring(0,10);
		newsrole	= myNewsRet.getFieldValueString(0,"EZN_ROLE");;
		newsType	= myNewsRet.getFieldValueString(0,"EZN_TYPE");
		group		= myNewsRet.getFieldValueString(0,"EZN_GROUP");;		
	}
	String[] sDate = new String[3];
	String[] eDate = new String[3];
	int d=0;
	StringTokenizer st = new StringTokenizer(startdate,"-");
	while(st.hasMoreElements())
	{
		sDate[d] = (String)st.nextElement();	
		d++;
	
	}
		startdate  = sDate[1]+"/"+sDate[2]+"/"+sDate[0];
	
	d=0;
	
	StringTokenizer st1 = new StringTokenizer(enddate,"-");
	while(st1.hasMoreElements())
	{
		eDate[d] = (String)st1.nextElement();	
		d++;

	}
	enddate  = eDate[1]+"/"+eDate[2]+"/"+eDate[0];
		
%>
