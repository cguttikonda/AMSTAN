<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>
<%
	
	String attrId 		= request.getParameter("attrId");	
	String attrStatus 	= request.getParameter("attrStatus");
	String attrDesc 	= request.getParameter("attrDesc");

	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();

	miscParams.setIdenKey("MISC_INSERT");
	miscParams.setQuery("INSERT INTO EZC_ATTRIBUTE_SET values ('"+attrId+"','"+attrStatus+"','"+attrDesc+"')");
	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);
	try
	{
		ezMiscManager.ezAdd(mainParams);

	}
	catch(Exception e)
	{}
	
	response.sendRedirect("ezAttributeSetList.jsp?status=A");

%>