<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iListPendingDcs_Labels.jsp"%>
<% 
	String display_header 	= penDns_L; 
	String noDataStatement 	= moDnsPen_L;
%>

<html>
<head>
<%@include file="../Misc/ezDataTableScript.jsp"%>
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
		mygrid.setHeader("<%=dnNo_L%>,<%=dnDate_L%>,<%=poNo_L%>,<%=grNo_L%>,<%=grDate_L%>,<%=desc_L%>,<%=qty_L%>");
		mygrid.setNoHeader(false)
		mygrid.setInitWidthsP("12,10,10,12,10,33,13")
		mygrid.setColAlign("center,center,center,center,center,left,right")
		mygrid.setColTypes("ro,ro,ro,ro,ro,ro,ro");
		mygrid.setColSorting("str,str,int,int,str,str,int")
		mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
		mygrid.enableBuffering(50);
		mygrid.init();
		mygrid.loadXML("ezListPendingDcsGrid.jsp");  
	}	
	function doOnUnLoad()
	{
		if(mygrid)
			mygrid=mygrid.destructor();
	}	
</Script>	
</head>
<body scroll=no onLoad="doOnLoad()">
<form name="myForm"  method="post">
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<%@ include file="../Misc/ezDisplayGrid.jsp" %>
<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:hidden">
<Center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Back");
	buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</Center>
</Div>
<%@ include file="../Misc/backButton.jsp" %>
<Div id="MenuSol"></Div>
</body>
</html>
