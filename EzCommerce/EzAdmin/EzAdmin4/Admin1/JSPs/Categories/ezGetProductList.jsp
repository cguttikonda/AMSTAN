<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" />
<%@ page import="ezc.ezmisc.params.*,ezc.ezparam.*,java.lang.String.*" %>
<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>


<%
	String catgId = request.getParameter("catgId");
	ReturnObjFromRetrieve retProdsList = null;
	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();
	int cntretProdsList =0;

	miscParams.setIdenKey("MISC_SELECT");
	miscParams.setQuery("SELECT * FROM EZC_CATEGORY_PRODUCTS WHERE ECP_CATEGORY_CODE ='"+catgId+"' ");
	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);
	try
	{		
		retProdsList = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams);
			
	}
	catch(Exception e)
	{}		
	
	if(retProdsList!=null && retProdsList.getRowCount() > 0)cntretProdsList =  retProdsList.getRowCount();		
			

%>
