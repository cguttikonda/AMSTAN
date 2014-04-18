<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<%@ page import="ezc.ezparam.*,java.util.*"%>
<%@ include file="../../../Includes/JSPs/News/iNewsTypes.jsp"%>
<%

	String syskey = request.getParameter("syskey");
	if(syskey == null || "null".equals(syskey) )
		syskey = (String)session.getValue("SYSKEY");	
		
	int purGrpCnt = 0;
	int myNewsRetCnt = 0;
	int retObjPAsCnt = 0;
	String tempPA = "";
	String valKey = "";
	
	java.util.Hashtable  purGroupsHash	= (java.util.Hashtable)session.getValue("PURGROUPS");
	
	
	ezc.ezparam.ReturnObjFromRetrieve retObjPAs  =null;
	
	
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	
	retObjPAs = (ReturnObjFromRetrieve) sysManager.getPurchaseAreas(sparams);
		
	if(retObjPAs!=null && retObjPAs.getRowCount()>0)
		retObjPAsCnt = retObjPAs.getRowCount();
	
	for(int i=0;i<retObjPAsCnt;i++)	{
		tempPA = retObjPAs.getFieldValueString(i,"ESKD_SYS_KEY");
		if(purGroupsHash.containsKey(tempPA)){
			purGroupsHash.put(tempPA,retObjPAs.getFieldValueString(i,"ESKD_SYS_KEY_DESC"));

		}	
	}
	
	purGrpCnt = purGroupsHash.size();
	Enumeration purGrpEnum =  purGroupsHash.keys();	
	
	//TO GET NEWS BASED ON SYS KEY.
	ezc.ezparam.ReturnObjFromRetrieve myNewsRet = null;
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	ezc.eznews.client.EzNewsManager newsManager = new ezc.eznews.client.EzNewsManager();
	ezc.eznews.params.EziNewsParams newsParam = new ezc.eznews.params.EziNewsParams();
	
	newsParam.setNewsSyskey("EZN_SYSKEY ='"+syskey+"'");
	
	mainParams.setLocalStore("Y");
	mainParams.setObject(newsParam);
	Session.prepareParams(mainParams);
	
	if(syskey!=null)
		myNewsRet=(ezc.ezparam.ReturnObjFromRetrieve)newsManager.ezGetNews(mainParams);
	
	if(myNewsRet!=null)
		myNewsRetCnt = myNewsRet.getRowCount();
		
		
		
		
%>
