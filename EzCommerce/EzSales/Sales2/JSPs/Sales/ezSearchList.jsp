<html>
<head>
		<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

	<Title>List of Sales Orders-Powered by EzCommerce Inc</title>
	<link rel="STYLESHEET" type="text/css" href="../../Library/Styles/dhtmlXGrid.css">
	<Script src="../../Library/JavaScript/Grid/dhtmlXCommon.js"></Script>
	<script src="../../Library/JavaScript/Grid/dhtmlXGrid.js"></script>		
	<script src="../../Library/JavaScript/Grid/dhtmlXGridCell.js"></script>
	
	<Script>
	
	
	
	
	
		function doOnLoad()
		{
			mygrid = new dhtmlXGridObject('gridbox');			
			mygrid.imgURL = "../../Images/Grid/";	
			
			mygrid.setHeader("Web Order No,Web Order Date,Po No,Created By,Customer");
			mygrid.setNoHeader(false)
			mygrid.setInitWidthsP("15,15,15,15,40")
			mygrid.setColAlign("center,center,center,center,left")
			mygrid.setColTypes("ro,ro,ro,ro,ro");
			mygrid.setColSorting("str,str,str,str,str")
			mygrid.setColumnColor(",#D5F1FF,,,,")
			mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
			mygrid.enableBuffering(250);
			mygrid.init();		
			mygrid.loadXML("ezSearchOrdersXML.jsp");
			
			
			
			
			
			
			
		}
		function doOnUnLoad()
		{
			if (mygrid) 
				mygrid=mygrid.destructor();
		}
		
		function funShowEdit(SoNo,SoldTo)
		{

		     if(document.SOForm.onceSubmit.value!=1){

			document.SOForm.onceSubmit.value=1
			document.SOForm.Back.value=SoNo
			document.SOForm.SoldTo.value=SoldTo
			document.SOForm.pageUrl.value="EditBackOrder"
			document.SOForm.status.value="O"
			//document.SOForm.target = "main"
			document.SOForm.action="../Sales/ezBackWaitSalesDisplay.jsp"
			document.body.style.cursor="wait"
			document.SOForm.submit();
		       }
		}
	</Script>
	</head>
<body onLoad="doOnLoad();" onUnLoad="doOnUnLoad();" scroll=no>
<form name=SOForm method="post" action="../Sales/ezSavedOrdersList.jsp">
<input type="hidden" name="SoldTo">
<input type="hidden" name="SONumber">
<input type="hidden" name="status">
<input type="hidden" name="pageUrl">
<input type="hidden" name="Back">


<input type="hidden" name="onceSubmit" value=0>

<%
	String display_header = "";
	String noDataStatement= "No  Orders to list";

%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

<%@ include file="../Misc/ezDisplayGrid.jsp"%>

</form>
<Div id="MenuSol"></Div>
</body>
</html>