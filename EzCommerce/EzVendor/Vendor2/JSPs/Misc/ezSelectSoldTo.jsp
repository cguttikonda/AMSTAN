<%@ include file="../../../Vendor2/Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iSelectSoldTo.jsp"%>
<html>
<head>
	<title><%=(String)session.getValue("TITLE")%></title>
</head>
<body>
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0 >
<TR>
	<TD>
		<IMG src="../../../../EzCommon/Images/Banner/ezc_logo.jpg" border=0>
	</TD>
	<TD>
		<IMG src="../../../../EzCommon/Images/Banner/banner_ext.jpg" border=0>
	</TD>
</TR>
</TABLE>

<%
	if((soldtoRows >=1)&& (catareaRows >=1))
	{
		String soldTo 		= retsoldto.getFieldValueString(0,"EC_ERP_CUST_NO");
		String vendorName 	= retsoldto.getFieldValueString(0,"ECA_NAME");
		PurManager.setPurAreaAndVendor(catalog_area,soldTo);
		session.putValue("SYSKEY",catalog_area);
		session.putValue("Catalog",retcatarea.getFieldValueString(0,SYSTEM_KEY_DESCRIPTION));
		session.putValue("SOLDTO",soldTo.trim());
		session.putValue("Vendor",retsoldto.getFieldValueString(0,"ECA_NAME"));
		response.sendRedirect("../Misc/ezRedirect.jsp");
	}
	else 
	{
		String noDataStatement = "";
		if (catareaRows == 0)
			noDataStatement = "Purchase Areas not configured";
		else if (soldtoRows ==0)
			noDataStatement = "Vendors not configured";
%>
		 <%@ include file="ezDisplayNoData.jsp"%>
<%		
	}
%>
<Div id="MenuSol"></Div>
</body>
</html>

