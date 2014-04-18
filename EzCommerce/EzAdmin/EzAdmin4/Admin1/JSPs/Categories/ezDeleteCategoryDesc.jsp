<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>
<%
	String catgID[]		= request.getParameterValues("catgID");
	String splitcatgID[];

	ezc.ezparam.EzcParams mainParams 	= new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams 		= new EziMiscParams();
	
	for(int i=0;i<catgID.length;i++)
	{
		splitcatgID	= catgID[i].split("¥");
		
		miscParams.setIdenKey("MISC_DELETE");
		miscParams.setQuery("DELETE FROM EZC_CATEGORY_DESCRIPTION WHERE ECD_CODE='"+splitcatgID[0]+"' AND ECD_LANG='"+splitcatgID[1]+"' AND ECD_DESC='"+splitcatgID[2]+"'");
		mainParams.setLocalStore("Y");
		mainParams.setObject(miscParams);
		Session.prepareParams(mainParams);
		try
		{
			ezMiscManager.ezDelete(mainParams);
		}
		catch(Exception e)
		{}	
	}	
	response.sendRedirect("ezCategoryDescList.jsp?status=D");
%>