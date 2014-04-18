<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ page import = "ezc.ezparam.*,ezc.ezmisc.params.*" %>
<%
	String webWithDraw	= request.getParameter("webOrNo");
	String poNumber		= request.getParameter("poNumber");
	webWithDraw = webWithDraw.trim();

	ezc.ezparam.EzcParams mainParams		= new ezc.ezparam.EzcParams(true);
	ezc.ezmisc.params.EziMiscParams miscParams	= new ezc.ezmisc.params.EziMiscParams();
	ezc.ezparam.ReturnObjFromRetrieve withDraw	= null;

	miscParams.setIdenKey("MISC_SELECT");
	String queryS	= "SELECT ESDH_STATUS FROM EZC_SALES_DOC_HEADER WHERE ESDH_DOC_NUMBER='"+webWithDraw+"'";
	miscParams.setQuery(queryS);
	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);

	try
	{
		withDraw = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams);
	}
	catch(Exception e){}

	String statusForDoc = withDraw.getFieldValueString(0,"ESDH_STATUS");
	statusForDoc = statusForDoc.trim();

	if(!"CLOSED".equals(statusForDoc))
	{
		ezc.ezparam.EzcParams mainParamsWithDraw1	= new ezc.ezparam.EzcParams(true);
		ezc.ezmisc.params.EziMiscParams miscParamsWithDraw1	= new ezc.ezmisc.params.EziMiscParams();
		ezc.ezparam.ReturnObjFromRetrieve withDrawOrderObj1	= null;

		miscParamsWithDraw1.setIdenKey("MISC_UPDATE");
		String query_W1	= "UPDATE EZC_SALES_DOC_HEADER SET ESDH_STATUS='CLOSED' WHERE ESDH_DOC_NUMBER = '"+webWithDraw+"'";
		miscParamsWithDraw1.setQuery(query_W1);
		mainParamsWithDraw1.setLocalStore("Y");
		mainParamsWithDraw1.setObject(miscParamsWithDraw1);
		Session.prepareParams(mainParamsWithDraw1);
		try
		{
			withDrawOrderObj1	= (ReturnObjFromRetrieve)ezMiscManager.ezUpdate(mainParamsWithDraw1);
		}
		catch(Exception e){}

		ezc.ezparam.EzcParams mainParamsWithDraw2	= new ezc.ezparam.EzcParams(true);
		ezc.ezmisc.params.EziMiscParams miscParamsWithDraw2	= new ezc.ezmisc.params.EziMiscParams();
		ezc.ezparam.ReturnObjFromRetrieve withDrawOrderObj2	= null;

		miscParamsWithDraw2.setIdenKey("MISC_UPDATE");
		String query_W2	= "UPDATE EZC_ORDER_NEGOTIATE SET EON_STATUS='CLOSED' WHERE EON_ORDER_NO='"+webWithDraw+"'";
		miscParamsWithDraw2.setQuery(query_W2);

		mainParamsWithDraw2.setLocalStore("Y");
		mainParamsWithDraw2.setObject(miscParamsWithDraw2);
		Session.prepareParams(mainParamsWithDraw2);
		try
		{
			withDrawOrderObj2	= (ReturnObjFromRetrieve)ezMiscManager.ezUpdate(mainParamsWithDraw2);
		}
		catch(Exception e){}

		ezc.ezparam.EzcParams mainParamsWithDraw3	= new ezc.ezparam.EzcParams(true);
		ezc.ezmisc.params.EziMiscParams miscParamsWithDraw3	= new ezc.ezmisc.params.EziMiscParams();
		ezc.ezparam.ReturnObjFromRetrieve withDrawOrderObj3	= null;

		miscParamsWithDraw3.setIdenKey("MISC_UPDATE");
		String query_W3	= "UPDATE EZC_WF_DOC_HISTORY_HEADER SET EWDHH_WF_STATUS='CLOSED' WHERE EWDHH_DOC_ID='"+webWithDraw+"'";
		miscParamsWithDraw3.setQuery(query_W3);

		mainParamsWithDraw3.setLocalStore("Y");
		mainParamsWithDraw3.setObject(miscParamsWithDraw3);
		Session.prepareParams(mainParamsWithDraw3);
		try
		{
			withDrawOrderObj3	= (ReturnObjFromRetrieve)ezMiscManager.ezUpdate(mainParamsWithDraw3);
		}
		catch(Exception e){}
	
		response.sendRedirect("ezOrderCreationDashBoard.jsp?poNum="+poNumber+"&status=S");
	}
	else
	{
		response.sendRedirect("ezOrderCreationDashBoard.jsp?poNum="+poNumber+"&status=F");
	}
%>

