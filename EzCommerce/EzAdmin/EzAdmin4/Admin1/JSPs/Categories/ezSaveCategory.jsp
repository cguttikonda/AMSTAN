<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>
<%
	
	String categoryId 	= request.getParameter("categoryId");	
	String catgStatus 	= request.getParameter("catgStatus");
	String catgParent 	= request.getParameter("catgParent");
	String catgVisible 	= request.getParameter("catgVisible");
	String catgImage 	= request.getParameter("catgImage");
	String catgThumb 	= request.getParameter("catgThumb");
	out.println("catgImage::::"+catgImage);
	if("null".equals(catgParent) || null==catgParent)catgParent="";
	if("null".equals(catgImage) || null==catgImage || "".equals(catgImage))catgImage="NULL";
	if("null".equals(catgThumb) || null==catgThumb || "".equals(catgThumb))catgThumb="NULL";
	
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();

	miscParams.setIdenKey("MISC_INSERT");
	miscParams.setQuery("INSERT INTO EZC_CATEGORIES values ('"+categoryId+"','"+catgStatus+"','"+catgParent+"','"+catgVisible+"',"+catgImage+","+catgThumb+")");
	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);
	try
	{
		ezMiscManager.ezAdd(mainParams);

	}
	catch(Exception e)
	{}
	
	response.sendRedirect("ezCategoriesList.jsp?status=A");

%>