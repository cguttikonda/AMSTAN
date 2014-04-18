<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.ezmisc.params.*" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>


<%
	EzcParams prodParamsMiscDelFav = new EzcParams(false);
	EziMiscParams prodParamsDelFav = new EziMiscParams();
	String userSes = Session.getUserId();
	String userSys = (String)session.getValue("SalesAreaCode");
	String userProdCode = request.getParameter("pcode");
	ReturnObjFromRetrieve prodDetailsRetObjDelFav = null;

	prodParamsDelFav.setIdenKey("MISC_DELETE");
	String queryDelFav="DELETE FROM EZC_USER_PRODUCT_FAVORITES WHERE EPF_USER_ID = '"+userSes+"' AND EPF_SYS_KEY = '"+userSys+"' AND EPF_MAT_NO = '"+userProdCode+"'  AND EPF_TYPE='CNET'";

	prodParamsDelFav.setQuery(queryDelFav);

	prodParamsMiscDelFav.setLocalStore("Y");
	prodParamsMiscDelFav.setObject(prodParamsDelFav);
	Session.prepareParams(prodParamsMiscDelFav);	

	try
	{
		ezc.ezcommon.EzLog4j.log("queryDelFav::::::::"+queryDelFav ,"I");
		ezMiscManager.ezDelete(prodParamsMiscDelFav);
		ezc.ezcommon.EzLog4j.log("queryDelFav::::::::"+queryDelFav ,"I");
	}
	catch(Exception e){}
%>

