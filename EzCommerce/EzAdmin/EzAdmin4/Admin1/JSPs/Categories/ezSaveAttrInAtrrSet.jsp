<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>
<%
	
	String attrSetId	= request.getParameter("attrSetId");	
	String attrID	 	= request.getParameter("attrID").trim();

	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();

	miscParams.setIdenKey("MISC_INSERT");
	miscParams.setQuery("INSERT INTO EZC_ATTRIBUTE_SET_ATTR values ('"+attrSetId+"','"+attrID+"')");
	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);
	try
	{
		ezMiscManager.ezAdd(mainParams);

	}
	catch(Exception e)
	{}
	
	response.sendRedirect("ezAttributesInAttrSetList.jsp?status=A");

%>