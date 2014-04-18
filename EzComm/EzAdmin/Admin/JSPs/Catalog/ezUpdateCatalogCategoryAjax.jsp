<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*"%>
<%
	String col1 = request.getParameter("col1");
	String col2 = request.getParameter("col2");
	String col3 = request.getParameter("col3");

	//out.println("col1"+col1);
	//out.println("col2"+col2)
	//out.println("col3"+col3);
	
	if(col1!=null) col1 = col1.trim();
	if(col2!=null) col2 = col2.trim();
	if(col3!=null) col3 = col3.trim();

	EzcParams catalogParamsMisc= new EzcParams(false);
	EziMiscParams catalogParams = new EziMiscParams();

	catalogParams.setIdenKey("MISC_UPDATE");
	String query="UPDATE EZC_CATALOG_CATEGORIES SET ECC_CATEGORY_ID = '"+col2+"' WHERE ECC_CATEGORY_ID = '"+col3+"' AND ECC_CATALOG_ID = '"+col1+"'";

	catalogParams.setQuery(query);

	catalogParamsMisc.setLocalStore("Y");
	catalogParamsMisc.setObject(catalogParams);
	Session.prepareParams(catalogParamsMisc);	

	try
	{		
		ezMiscManager.ezUpdate(catalogParamsMisc);
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
	out.print(col1+"##"+col2+"##"+col3);
%>