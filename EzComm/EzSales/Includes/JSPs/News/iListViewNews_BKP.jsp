<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import = "ezc.ezparam.*,ezc.ezmisc.params.*" %>
<%
	String listNewsId	=	request.getParameter("newsId");
	ezc.ezparam.EzcParams mainParams_N=null;
	ezc.eznews.params.EziNewsParams newsParam = null;
	ezc.eznews.client.EzNewsManager newsManager = null;
	ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
	ezc.ezparam.ReturnObjFromRetrieve listNewsObj=null;
	
	mainParams_N=new ezc.ezparam.EzcParams(true);

	miscParams.setIdenKey("MISC_SELECT");
	String query_A="SELECT * FROM EZC_NEWS WHERE EZN_ID="+listNewsId+"";
	miscParams.setQuery(query_A);

	mainParams_N.setLocalStore("Y");
	mainParams_N.setObject(miscParams);
	Session.prepareParams(mainParams_N);
	String tempId="";

	try
	{
		listNewsObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_N);
	}
	catch(Exception e)
	{
		System.out.println("ERROR::::::::::::::::::::"+e);
	}	
%>
	