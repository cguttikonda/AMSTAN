<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>
<%
	
	String catID[] 	= request.getParameterValues("catID");	
	String splitcatID[];
	
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();
	
	for(int i=0;i<catID.length;i++)
	{
		splitcatID	= catID[i].split("¥");
		
		miscParams.setIdenKey("MISC_DELETE");
		miscParams.setQuery("DELETE FROM EZC_CATALOG_CATEGORIES WHERE ECC_CATALOG_ID='"+splitcatID[1]+"' AND ECC_CATEGORY_ID='"+splitcatID[0]+"'");
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
	
	response.sendRedirect("ezViewCatalogCategories.jsp?status=D");
%>