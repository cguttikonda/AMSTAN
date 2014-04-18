<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<%@ page import="ezc.ezparam.*"%>
<%
	ezc.record.util.EzOrderedDictionary userAuthConfig = Session.getUserAuth();
	
	String authNewsChk	= "EZN_CATEGORY IN (";
	if(userAuthConfig.containsKey("VIEW_PL_NEWS")) authNewsChk = authNewsChk + " 'PL', "; 
	if(userAuthConfig.containsKey("VIEW_PSPEC_NEWS")) authNewsChk = authNewsChk  +" 'PRODSPEC', "; 
	if(userAuthConfig.containsKey("VIEW_NPROD_NEWS")) authNewsChk = authNewsChk  +" 'NP', "; 
	if(userAuthConfig.containsKey("VIEW_DC_NEWS")) authNewsChk = authNewsChk  +" 'DP', "; 
	if(userAuthConfig.containsKey("VIEW_PS_NEWS")) authNewsChk = authNewsChk  +" 'PS', "; 
	if(userAuthConfig.containsKey("VIEW_PCHNG_NEWS")) authNewsChk = authNewsChk  +" 'PCA', "; 
	if(userAuthConfig.containsKey("VIEW_PROMO_NEWS")) authNewsChk = authNewsChk  +" 'PA', "; 
	if(userAuthConfig.containsKey("VIEW_GA_NEWS")) authNewsChk = authNewsChk  +" 'GA', "; 
	if(userAuthConfig.containsKey("VIEW_SLOB_NEWS")) authNewsChk = authNewsChk  +" 'SLOB' "; 
	if(authNewsChk.endsWith(",")) authNewsChk = authNewsChk.substring(0,authNewsChk.lastIndexOf(',')); 
	if(!"".equals(authNewsChk) ) authNewsChk =authNewsChk + ")";
	
	
	ezc.ezparam.EzcParams mainParamsConfigN		= null;
	ezc.eznews.params.EziNewsParams newsParam	= null;
	ezc.eznews.client.EzNewsManager newsManager	= null;
	ezc.ezmisc.params.EziMiscParams miscParamsN	= new ezc.ezmisc.params.EziMiscParams();
	ezc.ezparam.ReturnObjFromRetrieve configNewsListObj	= null;
	
	mainParamsConfigN	= new ezc.ezparam.EzcParams(true);

	miscParamsN.setIdenKey("MISC_SELECT");
	String query_A	= "SELECT * FROM EZC_NEWS WHERE "+authNewsChk+"";
	miscParamsN.setQuery(query_A);

	mainParamsConfigN.setLocalStore("Y");
	mainParamsConfigN.setObject(miscParamsN);
	Session.prepareParams(mainParamsConfigN);
	try
	{
		configNewsListObj	= (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsConfigN);
	}
	catch(Exception e)
	{
		System.out.println("ERROR::::::::::::::::::::"+e);
	}	
%>
	