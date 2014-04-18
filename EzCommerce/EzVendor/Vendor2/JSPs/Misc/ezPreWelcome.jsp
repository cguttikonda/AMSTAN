<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import ="ezc.ezparam.*"%>
<%@ page import="ezc.client.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%
	ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);

	String catalogArea = request.getParameter("CatalogArea");
	String soldTo = request.getParameter("SoldTo");

	System.out.println("Catalog Area == " + catalogArea);
	System.out.println("Sold To == " + soldTo);
	
	PurManager.setPurAreaAndVendor(catalogArea,soldTo); 

	ReturnObjFromRetrieve retcatarea = (ReturnObjFromRetrieve) PurManager.getUserPurAreas();
	ReturnObjFromRetrieve retsoldto = (ReturnObjFromRetrieve) PurManager.getUserVendors(catalogArea);

	int catareaRows = retcatarea.getRowCount();
	for ( int c = 0 ; c < catareaRows ; c++ )
	{		
		if (catalogArea.equals(retcatarea.getFieldValueString(c,"ESKD_SYS_KEY"))){
			session.putValue("SYSKEY", catalogArea);
			session.putValue("Catalog",retcatarea.getFieldValueString(c,"ESKD_SYS_KEY_DESC"));
			break;		
		}
	}
	int soldtoRows =retsoldto.getRowCount() ;
	for ( int j = 0 ; j < soldtoRows; j++ )
	{		
		if(soldTo.equals(retsoldto.getFieldValueString(j,"EC_ERP_CUST_NO")))
		{
			session.putValue("SOLDTO", soldTo.trim());	
			session.putValue("Vendor", retsoldto.getFieldValueString(j,"ECA_NAME"));
			break;
		}
	}
	%>
	<%@ include file="../../../Includes/JSPs/Misc/iAddWebStats.jsp"%>
	<%
	response.sendRedirect("../Misc/ezMenuframeset.jsp");
%>
<Div id="MenuSol"></Div>

