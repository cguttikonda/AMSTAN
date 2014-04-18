<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>
<%
	
	String catgLanOld 	= request.getParameter("catgLanOld");
	String catgDescOld 	= request.getParameter("catgDescOld");
	
	String categoryId 	= request.getParameter("categoryId");
	String catLang	 	= request.getParameter("catLang");
	String catDesc	 	= request.getParameter("catDesc");
	String catDesc1	 	= request.getParameter("catDesc1");
	
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();

	miscParams.setIdenKey("MISC_UPDATE");
	miscParams.setQuery("UPDATE EZC_CATEGORY_DESCRIPTION SET ECD_CODE='"+categoryId+"',ECD_LANG='"+catLang+"',ECD_DESC='"+catDesc+"',ECD_TEXT='"+catDesc1+"' WHERE ECD_CODE='"+categoryId+"' AND ECD_LANG='"+catgLanOld+"' AND ECD_DESC='"+catgDescOld+"'");
	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);
	try
	{
		ezMiscManager.ezUpdate(mainParams);

	}
	catch(Exception e)
	{}
	
	response.sendRedirect("ezCategoryDescList.jsp?status=U");

%>