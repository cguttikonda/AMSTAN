<jsp:useBean id="ezMiscManagers" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="Sessions" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<%@ page import = "ezc.ezparam.*,ezc.ezmisc.params.*" %>

<%
	String poNum	= request.getParameter("poNumber");
	String soldToWithDraw	= (String)session.getValue("AgentCode");
	
	ezc.ezparam.EzcParams mainParamsWithDraw	= null;
	ezc.eznews.params.EziNewsParams withDrawParam	= null;
	ezc.eznews.client.EzNewsManager withDrawManager	= null;
	ezc.ezmisc.params.EziMiscParams miscParamsWithDraw	= new ezc.ezmisc.params.EziMiscParams();
	ezc.ezparam.ReturnObjFromRetrieve withDrawOrderObj	= null;
	
	mainParamsWithDraw	= new ezc.ezparam.EzcParams(true);

	miscParamsWithDraw.setIdenKey("MISC_SELECT");
	String query_Ws	= "SELECT * FROM EZC_SALES_DOC_HEADER WHERE ESDH_PO_NO ='"+poNum+"' AND ESDH_CREATED_BY='"+soldToWithDraw+"'";
	miscParamsWithDraw.setQuery(query_Ws);

	mainParamsWithDraw.setLocalStore("Y");
	mainParamsWithDraw.setObject(miscParamsWithDraw);
	Sessions.prepareParams(mainParamsWithDraw);
	try
	{
		withDrawOrderObj	= (ReturnObjFromRetrieve)ezMiscManagers.ezSelect(mainParamsWithDraw);
	}
	catch(Exception e)
	{
		System.out.println("ERROR::::::::::::::::::::"+e);
	}
	ezc.ezcommon.EzLog4j.log("query_Ws::::::::"+query_Ws ,"I");

	String webOrderNo = withDrawOrderObj.getFieldValueString(0,"ESDH_DOC_NUMBER");
		
	ezc.ezparam.EzcParams mainParamsWithDraw1	= null;
	ezc.ezmisc.params.EziMiscParams miscParamsWithDraw1	= new ezc.ezmisc.params.EziMiscParams();
	ezc.ezparam.ReturnObjFromRetrieve withDrawOrderObj1	= null;

	mainParamsWithDraw1	= new ezc.ezparam.EzcParams(true);

	miscParamsWithDraw1.setIdenKey("MISC_UPDATE");
	String query_W1	= "UPDATE EZC_SALES_DOC_HEADER SET ESDH_STATUS='CLOSED' WHERE ESDH_PO_NO = '"+poNum+"'";
	miscParamsWithDraw1.setQuery(query_W1);

	mainParamsWithDraw1.setLocalStore("Y");
	mainParamsWithDraw1.setObject(miscParamsWithDraw1);
	Sessions.prepareParams(mainParamsWithDraw1);
	try
	{
		withDrawOrderObj1	= (ReturnObjFromRetrieve)ezMiscManagers.ezSelect(mainParamsWithDraw1);
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
	String query_W2	= "UPDATE EZC_ORDER_NEGOTIATE SET EON_STATUS='CLOSED' WHERE EON_ORDER_NO='"+webOrderNo+"'";
	miscParamsWithDraw2.setQuery(query_W2);

	mainParamsWithDraw2.setLocalStore("Y");
	mainParamsWithDraw2.setObject(miscParamsWithDraw2);
	Sessions.prepareParams(mainParamsWithDraw2);
	try
	{
		withDrawOrderObj2	= (ReturnObjFromRetrieve)ezMiscManagers.ezSelect(mainParamsWithDraw2);
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
	String query_W3	= "UPDATE EZC_WF_AUDIT_TRAIL SET EWAT_TYPE='CLOSED' WHERE EWAT_DOC_ID='"+webOrderNo+"'";
	miscParamsWithDraw3.setQuery(query_W3);

	mainParamsWithDraw3.setLocalStore("Y");
	mainParamsWithDraw3.setObject(miscParamsWithDraw3);
	Sessions.prepareParams(mainParamsWithDraw3);
	try
	{
		withDrawOrderObj3	= (ReturnObjFromRetrieve)ezMiscManagers.ezSelect(mainParamsWithDraw3);
	}
	catch(Exception e)
	{
			System.out.println("ERROR::::::::::::::::::::"+e);
	}
	
	ezc.ezcommon.EzLog4j.log("query_W3::::::::"+query_W3 ,"I");
%>
	