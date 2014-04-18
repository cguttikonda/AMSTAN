<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%
	String type = request.getParameter("type");
	String header  = "";
	String widths  = "";
	String colTyps = "";
	String aligns  = "";
	String colSort = "";
	
	header  = "RFQ, RFQ Date, RFQ Closing Date";
	widths  = "40,30,30";
	aligns  = "center,center,center";
	colTyps = "ro,ro,ro";
	colSort = "str,date,date";
%>
<html>
<head>    
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<link rel="STYLESHEET" type="text/css" href="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.css">
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXCommon.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGridCell.js"></Script>
<Script>
	function doOnLoad()
	{
		
		mygrid = new dhtmlXGridObject('gridbox');
		mygrid.imgURL = "../../../../EzCommon/Images/Grid/";
		mygrid.setHeader("<%=header%>");
		mygrid.setNoHeader(false)
		mygrid.setInitWidthsP("<%=widths%>")
		mygrid.setColAlign("<%=aligns%>")
		mygrid.setColTypes("<%=colTyps%>");
		mygrid.setColSorting("<%=colSort%>")
		mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
		mygrid.enableBuffering(100);
		mygrid.init();
		mygrid.loadXML("ezListRFQsGrid.jsp?type=<%=type%>");
	}	
	function doOnUnLoad()
	{
		if(mygrid)
			mygrid=mygrid.destructor();
	}	
</Script>
</head>
<body onLoad="doOnLoad();" scroll=no>
<form name="myForm">
<%
	String display_header	= "List of RFQs";
	if("New".equalsIgnoreCase(type))
		display_header = "List  of  New  RFQs";
	String noDataStatement	= "No RFQs exist.";
%>
	<input type="hidden" name="type" value=<%=type%> >
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
	<%@ include file="../Misc/ezDisplayGrid.jsp" %>		
		
<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:hidden">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Back");
	buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
<%@ include file="../Misc/backButton.jsp" %>
<%@ include file="../Misc/AddMessage.jsp" %>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

