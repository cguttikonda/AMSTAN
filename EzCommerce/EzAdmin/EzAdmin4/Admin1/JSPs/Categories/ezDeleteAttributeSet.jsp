<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>
<%
	String attrID[]		= request.getParameterValues("attrID");
	String splitattrID[];

	ezc.ezparam.EzcParams mainParams 	= new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams 		= new EziMiscParams();
	
	for(int i=0;i<attrID.length;i++)
	{
		splitattrID	= attrID[i].split("¥");
		
		miscParams.setIdenKey("MISC_DELETE");
		miscParams.setQuery("DELETE FROM EZC_ATTRIBUTE_SET WHERE EAS_ID='"+splitattrID[0]+"' AND EAS_STATUS='"+splitattrID[1]+"' AND EAS_DESC='"+splitattrID[2]+"'");
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
	response.sendRedirect("ezAttributeSetList.jsp?status=D");
%>