<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>
<%
	
	String oldCatgDesc 	= request.getParameter("oldCatgDesc");	
	String catalogId 	= request.getParameter("catalogId");
	String newCatgDesc 	= request.getParameter("newCatgDesc");

	
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();

	miscParams.setIdenKey("MISC_UPDATE");
	miscParams.setQuery("UPDATE EZC_CATALOG_CATEGORIES set ECC_CATEGORY_ID='"+newCatgDesc+"' WHERE ECC_CATALOG_ID='"+catalogId+"' AND ECC_CATEGORY_ID='"+oldCatgDesc+"' ");
	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);
	try
	{
		ezMiscManager.ezUpdate(mainParams);

	}
	catch(Exception e)
	{}
	
	response.sendRedirect("ezViewCatalogCategories.jsp?status=U");

%>