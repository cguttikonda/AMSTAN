<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iListInv_Labels.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<link rel="STYLESHEET" type="text/css" href="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.css">
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXCommon.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGridCell.js"></Script>
<% String header = vendorInvNum_L+","+sapInvNum_L+","+invDate_L+","+payDueDate_L+","+payNum_L+","+cur_L+","+amount_L; %>
<Script>
	
	
	function doOnLoad()
	{
		mygrid = new dhtmlXGridObject('gridbox');
		mygrid.imgURL = "../../../../EzCommon/Images/Grid/";
		mygrid.setHeader('<%=header%>')
		mygrid.setNoHeader(false)
		mygrid.setInitWidthsP("16,16,13,13,16,8,18")
		mygrid.setColAlign("center,center,center,center,center,center,right")
		mygrid.setColTypes("ro,ro,ro,ro,ro,ro,ro");
		mygrid.setColSorting("int,str,date,date,int,str,int")
		mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
		mygrid.enableBuffering(50);
		mygrid.init();
		mygrid.loadXML("ezListOpenInvoiceGrid.jsp");
	}	
	function doOnUnLoad()
	{
		if(mygrid)
			mygrid=mygrid.destructor();
	}	
</Script>

<script>
	function funLinkInvoice(fileName,invnum,purNum,compCode,docType,invDate,invCur,invAmount,PostDate)
	{
		document.location.href=fileName+"?invnum="+invnum+"&purNum="+purNum+"&compCode="+compCode+"&docType="+docType+"&invDate="+invDate+"&invCur="+invCur+"&invAmount="+invAmount+"&PostDate="+PostDate
	}
</script>
</head>
<body onLoad="doOnLoad()" scroll=no>
<form name="myForm" method="post">			
<% 
	String display_header = openInv_L;
	String noDataStatement =noOpenInvExist_L;
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
</Div>
<%@ include file="../Misc/backButton.jsp" %>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
