<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>
<%
	
	String categoryId 	= request.getParameter("categoryId");	
	String catLang 		= request.getParameter("catLang");
	String catDesc	 	= request.getParameter("catDesc");
	String catDesc1 	= request.getParameter("catDesc1");

	/*out.println("catgImage::::"+catgImage);
	if("null".equals(catgParent) || null==catgParent)catgParent="";
	if("null".equals(catgImage) || null==catgImage || "".equals(catgImage))catgImage="NULL";
	if("null".equals(catgThumb) || null==catgThumb || "".equals(catgThumb))catgThumb="NULL";
	*/
	
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();

	miscParams.setIdenKey("MISC_INSERT");
	miscParams.setQuery("INSERT INTO EZC_CATEGORY_DESCRIPTION values ('"+categoryId+"','"+catLang+"','"+catDesc+"','"+catDesc1+"')");
	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);
	try
	{
		ezMiscManager.ezAdd(mainParams);

	}
	catch(Exception e)
	{}
	
	response.sendRedirect("ezCategoryDescList.jsp?status=A");

%>