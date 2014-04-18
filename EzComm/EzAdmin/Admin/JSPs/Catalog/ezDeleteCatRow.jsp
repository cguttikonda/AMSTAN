<%@ page import="ezc.ezparam.*" %>
<%@ page import="ezc.ezmisc.params.*" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>


<%

	String catId = request.getParameter("id");
	ReturnObjFromRetrieve prodDetailsRetObjDelFav = null;

	String queryDelFav="DELETE FROM EZC_CATALOG_CATEGORIES WHERE ECC_CATEGORY_ID = '"+catId+"';

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

