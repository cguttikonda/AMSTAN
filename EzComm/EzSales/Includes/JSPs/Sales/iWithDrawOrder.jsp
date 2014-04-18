<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<%@ page import = "ezc.ezparam.*,ezc.ezmisc.params.*" %>

<%
	String webWithDraw	= request.getParameter("webOrNo");
	webWithDraw = webWithDraw.trim();
	
	ezc.ezparam.EzcParams mainParamsWithDraw	= null;
	ezc.eznews.params.EziNewsParams withDrawParam	= null;
	ezc.eznews.client.EzNewsManager withDrawManager	= null;
		
	ezc.ezparam.EzcParams mainParamsWithDraw1	= null;
	ezc.ezmisc.params.EziMiscParams miscParamsWithDraw1	= new ezc.ezmisc.params.EziMiscParams();
	ezc.ezparam.ReturnObjFromRetrieve withDrawOrderObj1	= null;

	mainParamsWithDraw1	= new ezc.ezparam.EzcParams(true);

	miscParamsWithDraw1.setIdenKey("MISC_UPDATE");
	String query_W1	= "UPDATE EZC_SALES_DOC_HEADER SET ESDH_STATUS='CLOSED' WHERE ESDH_PO_NO = '"+webWithDraw+"'";
	miscParamsWithDraw1.setQuery(query_W1);
	mainParamsWithDraw1.setLocalStore("Y");
	mainParamsWithDraw1.setObject(miscParamsWithDraw1);
	Session.prepareParams(mainParamsWithDraw1);
	try
	{
		withDrawOrderObj1	= (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsWithDraw1);
	}
	catch(Exception e)
	{
			System.out.println("ERROR::::::::::::::::::::"+e);
	}
	
	ezc.ezcommon.EzLog4j.log("query_W1::::::::"+query_W1 ,"I");
	
	ezc.ezparam.EzcParams mainParamsWithDraw2	= null;
	ezc.ezmisc.params.EziMiscParams miscParamsWithDraw2	= new ezc.ezmisc.params.EziMiscParams();
	ezc.ezparam.ReturnObjFromRetrieve withDrawOrderObj2	= null;

	mainParamsWithDraw2	= new ezc.ezparam.EzcParams(true);

	miscParamsWithDraw2.setIdenKey("MISC_UPDATE");
	String query_W2	= "UPDATE EZC_ORDER_NEGOTIATE SET EON_STATUS='CLOSED' WHERE EON_ORDER_NO='"+webWithDraw+"'";
	miscParamsWithDraw2.setQuery(query_W2);

	mainParamsWithDraw2.setLocalStore("Y");
	mainParamsWithDraw2.setObject(miscParamsWithDraw2);
	Session.prepareParams(mainParamsWithDraw2);
	try
	{
		withDrawOrderObj2	= (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsWithDraw2);
	}
	catch(Exception e)
	{
			System.out.println("ERROR::::::::::::::::::::"+e);
	}
	ezc.ezcommon.EzLog4j.log("query_W2::::::::"+query_W2 ,"I");
	
	ezc.ezparam.EzcParams mainParamsWithDraw3	= null;
	ezc.ezmisc.params.EziMiscParams miscParamsWithDraw3	= new ezc.ezmisc.params.EziMiscParams();
	ezc.ezparam.ReturnObjFromRetrieve withDrawOrderObj3	= null;

	mainParamsWithDraw3	= new ezc.ezparam.EzcParams(true);

	miscParamsWithDraw3.setIdenKey("MISC_UPDATE");
	String query_W3	= "UPDATE EZC_WF_AUDIT_TRAIL SET EWAT_TYPE='CLOSED' WHERE EWAT_DOC_ID='"+webWithDraw+"'";
	miscParamsWithDraw3.setQuery(query_W3);

	mainParamsWithDraw3.setLocalStore("Y");
	mainParamsWithDraw3.setObject(miscParamsWithDraw3);
	Session.prepareParams(mainParamsWithDraw3);
	try
	{
		withDrawOrderObj3	= (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsWithDraw3);
	}
	catch(Exception e)
	{
			System.out.println("ERROR::::::::::::::::::::"+e);
	}
	
	ezc.ezcommon.EzLog4j.log("query_W3::::::::"+query_W3 ,"I");
%>
	