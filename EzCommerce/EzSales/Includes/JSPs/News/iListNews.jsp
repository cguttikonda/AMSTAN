<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<%@ include file="../../../Includes/JSPs/News/iNewsTypes.jsp"%>
<%
	String syskey = request.getParameter("syskey");
	int retObjPAsCnt = 0;
	int myNewsRetCnt = 0;
	ezc.ezparam.ReturnObjFromRetrieve retObjPAs  =null;
	
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	
	String areaFlag="C";
	if ( areaFlag.equals("C") )
	{
		retObjPAs = (ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);
		
	}else if( areaFlag.equals("V") ){
	
		retObjPAs = (ReturnObjFromRetrieve) sysManager.getPurchaseAreas(sparams);
	}
		
	if(retObjPAs!=null && retObjPAs.getRowCount()>0)
		retObjPAsCnt = retObjPAs.getRowCount();
	
	
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
	
	if(myNewsRet!=null && myNewsRet.getRowCount()>0)
		myNewsRetCnt = myNewsRet.getRowCount();
		
%>
