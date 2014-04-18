<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/icontract_Labels.jsp"%>
<%
	String orderType=request.getParameter("OrderType");
	String header  = "";
	String widths  = "";
	String colTyps = "";
	String aligns  = "";
	String colSort = "";
	
	header  = "Agreement, Date, Value";
	widths  = "40,30,30";
	aligns  = "center,center,right";
	colTyps = "ro,ro,ro";
	colSort = "str,date,str";
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
		mygrid.loadXML("ezContractGrid.jsp?OrderType=<%=orderType%>");
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
	String display_header="";
	String noDataStatement	= "";
	Hashtable ht = new Hashtable();
	ht.put("Open",openAgree_L);
	ht.put("Closed",closeAgree_L);
	ht.put("New",newAgree_L);
	ht.put("All",allAgree_L);
	Hashtable htData = new Hashtable();
	htData.put("Open",noOpenAgreeExist_L);
	htData.put("Closed",noCloseAgreeExist_L);
	htData.put("No",noAgreeExist_L);
	htData.put("All",noAgreeExist_L);
	
	
	
	try{
		display_header=(String)ht.get(orderType.trim());
		noDataStatement = (String)htData.get(orderType.trim());
	}catch(Exception e){}
	
	if(display_header==null)
		display_header ="";
	if(noDataStatement==null)
		noDataStatement ="";	
		
%>
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
<div id="head1" style="position:absolute;top:95%;width:100%">
	<center><font size=1>The value of the Agreement is before Discounts,taxes, duties and levies</font></center>
</div>
<%@ include file="../Misc/backButton.jsp" %>
<%@ include file="../Misc/AddMessage.jsp" %>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
