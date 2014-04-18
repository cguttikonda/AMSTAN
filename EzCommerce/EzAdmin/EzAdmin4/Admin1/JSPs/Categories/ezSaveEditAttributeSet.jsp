<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>
<%
	
	String old_atrId 	= request.getParameter("old_atrId");	
	String old_atrStatus 	= request.getParameter("old_atrStatus");
	String old_atrDesc 	= request.getParameter("old_atrDesc");
	String attrId 		= request.getParameter("attrId").trim();
	String attrStatus 	= request.getParameter("attrStatus").trim();
	String attrDesc 	= request.getParameter("attrDesc").trim();
	
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();

	miscParams.setIdenKey("MISC_UPDATE");
	miscParams.setQuery("UPDATE EZC_ATTRIBUTE_SET set EAS_ID='"+attrId+"',EAS_STATUS='"+attrStatus+"',EAS_DESC='"+attrDesc+"' where EAS_ID='"+old_atrId+"' AND EAS_STATUS='"+old_atrStatus+"' AND EAS_DESC='"+old_atrDesc+"'");
	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);
	try
	{
		ezMiscManager.ezUpdate(mainParams);

	}
	catch(Exception e)
	{}
	
	response.sendRedirect("ezAttributeSetList.jsp?status=U");

%>