<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/DeliverySchedule/iDeliverySchedules.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddDelSchedule_Lables.jsp"%>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%!
	public String eliminateDecimals(String myStr)
	{
		String remainder = "";
		if(myStr.indexOf(".")!=-1)
		{
			remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
			myStr = myStr.substring(0,myStr.indexOf("."));
		}
		return myStr;
	}
%>
<%
   String[] matDesc 	= request.getParameterValues("matdesc");
   String[] lineNo 	= request.getParameterValues("lineNo");

   String fromDate 	= request.getParameter("FromDate");  
   String toDate 	= request.getParameter("ToDate");
   String newFilter 	= request.getParameter("newFilter");
   
   
%>

<html>
<head>
	<title>Delivery Schedules Details</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="55%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<script>
	function displayWindow(fieldName)
	{
		newWindow = window.open("ezDateEntry.jsp","Mywin","resizable=no,left=250,top=100,height=350,width=400,status=no,toolbar=no,menubar=no,location=no")
		newWindow.name="parent.opener."+fieldName
	}
	function ezBack()
		{
			<%
				String status = request.getParameter("status");
			%>
			document.forms[0].action="../Sales/ezBackEndSODetails.jsp?SONumber=<%=soNum%>&status=<%=status%>"
			document.forms[0].submit();
		}
	</script>
	<!--
	<link rel="STYLESHEET" type="text/css" href="../../Library/Styles/dhtmlXGrid.css">
	<Script src="../../Library/JavaScript/Grid/dhtmlXCommon.js"></Script>
	<script src="../../Library/JavaScript/Grid/dhtmlXGrid.js"></script>		
	<script src="../../Library/JavaScript/Grid/dhtmlXGridCell.js"></script>
	-->
	<link rel="STYLESHEET" type="text/css" href="../../Library/Styles/dhtmlXGrid.css">
	<Script src="../../Library/JavaScript/Grid_2.5BA/dhtmlxcommon.js"></Script>
	<Script src="../../Library/JavaScript/Grid_2.5BA/dhtmlxgrid.js"></Script>
	<Script src="../../Library/JavaScript/Grid_2.5BA/dhtmlxgridcell.js"></Script>		
	
	
	<Script>	
		function doOnLoad()
		{
			/*mygrid = new dhtmlXGridObject('gridbox');			
			mygrid.imgURL = "../../Images/Grid/";	
			mygrid.setHeader("Product,Customer Material,Description,UOM,Required Qty,Req.Deliv.Date,Confirmed Qty,Exp. Delivery Date");
			mygrid.setNoHeader(false)
			mygrid.setInitWidthsP("10,10,27,5,10,14,10,14")
			mygrid.setColAlign("left,left,left,center,right,center,right,center")
			mygrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro");
			mygrid.setColSorting("str,str,str,str,str,date,str,date")
			mygrid.setColumnColor(",#D5F1FF,,,,")
			mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
			mygrid.enableBuffering(250);
			mygrid.init();	
			mygrid.loadXML("ezExpDeliveriesXML.jsp?SalesOrder=<%=backEndOrNo%>&soldTo=<%=aSoldTo%>");*/
			
			mygrid = new dhtmlXGridObject('gridbox');
			mygrid.setImagePath("../../Images/Grid_2.5BA/");
			//mygrid.setHeader("Product,Customer Material,Description,UOM,Required Qty,Req.Deliv.Date,Confirmed Qty,Exp. Delivery Date");
			mygrid.setHeader("ConRes Part#,Ordered Part#,Description,Required Qty,Required Delivery Date,Confirmed Qty,Expected Delivery Date");
			mygrid.setNoHeader(false)
			mygrid.setInitWidthsP("10,10,30,10,16,10,14")
			mygrid.setColAlign("left,left,left,center,right,center,right,center")
			mygrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro");
			mygrid.setColSorting("str,str,str,str,str,date,str,date")
			//mygrid.setColumnColor(",#D5F1FF,,,,")
			//mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
			mygrid.setSkin("dhx_skyblue");
			//mygrid.enableBuffering(250);
			mygrid.init();
			mygrid.loadXML("ezExpDeliveriesXML.jsp?SalesOrder=<%=backEndOrNo%>&soldTo=<%=aSoldTo%>");						
			//document.SOForm.action="ezExpDeliveriesXML.jsp?SalesOrder=<%=backEndOrNo%>&soldTo=<%=aSoldTo%>"
			//document.SOForm.submit()			
		}
		function doOnUnLoad() 
		{
			if (mygrid) 
				mygrid=mygrid.destructor();
		
		}
	</Script>	
</head>
<body onLoad="doOnLoad();" onUnLoad="doOnUnLoad();" scroll=no>
<form name="generalForm" method="post">

<input type="hidden" name="chkBrowser" value="0">
<input type="hidden" name="FromForm" value="ClosedOrderList"> 
<input type="hidden" name="FromDate" value="<%=fromDate%>">
<input type="hidden" name="ToDate" value="<%=toDate%>">
<input type=hidden name="newFilter"  value="<%=newFilter%>">
<%
	String display_header = "Expected Delivery Schedules for SO No : "+Integer.parseInt(backEndOrNo);//expDeliSchSONo_L
	String noDataStatement= "No Deliveries to list";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

<Div align=center style="width:100%;">
<br>
	<Div  id="GridBoxDiv" align=center style="background-color:whitesmoke;width:95%;border:1px solid;border-color:lightgrey;padding:2px;">
		<Div id="gridbox" height="300px" width="100%" style="overflow:hidden;visibility:hidden;"></Div>	
	</Div>		
	<Div id="dataRetrieve" width="100%" height="40px" style="overflow:hidden;visibility:visible;position:absolute;top:40%;left:2%">
		<Table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<Tr>
				<Td style="background:transparent" align='center'><br><b>Loading data, please wait...</b><br><br><img src="../../Images/ImagesGrid/loading.gif"/></Td>
			</Tr>
		</Table>
	</Div>   
	<Div id="NoData" width="100%" height="40px" style="overflow:hidden;visibility:hidden;position:absolute;top:40%;left:2%">
		<Table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<Tr>
				<Td style="background:transparent" align='center'><br><b><%=noDataStatement%></b></Td>
			</Tr>
		</Table>
	</Div> 
	<Div id="ServerBusy" width="100%" height="40px" style="overflow:hidden;visibility:hidden;position:absolute;top:35%;left:2%">
		<Table align=center height="100%" border="0" cellpadding="0" cellspacing="0" width="100%">
			<Tr>
				<Td style="background:transparent" align='right'><img border=0 src="../../Images/sbusy.gif" ></Td>
				<Td style="background:transparent" align='center'><font color="CC0000"><b>System Error.<BR> Please try again but if the error message reappears then contact us.</b></font></Td>
			</Tr>
		</Table>
	</Div> 
</Div>
<div id="buttonDiv" align=center style='position:absolute;width:100%;top:90%'>
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		buttonMethod.add("ezBack()");
		out.println(getButtonStr(buttonName,buttonMethod));
	%>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
