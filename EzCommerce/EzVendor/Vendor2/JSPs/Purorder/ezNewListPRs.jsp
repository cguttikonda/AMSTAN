<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iEzDateConvertion.jsp" %>
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<%
	String Status 	= request.getParameter("Status");
	String matNo 	= request.getParameter("matNo");
	String plant 	= request.getParameter("selplant");
	String fromDate = request.getParameter("fromDate");
	String toDate 	= request.getParameter("toDate");
	
	String header  = "PR - Item"+","+"Created Date"+","+Release Date+","+Delivery Date+","+"Material"+","+Description+","+Plant","+Quantity+","+UOM;
	String widths  = "12,12,12,12,12,16,7,12,5";
	String colTyps = "ro,ro,ro,ro,ro,ro,ro,ro,ro";
	String aligns  = "center,center,center,center,center,center,center,right,center";
	String colSort = "str,date,date,date,str,str,str,int,str";
	
	String reqUrl  = "";
	String selAllChk = "<input style='cursor:hand' type=checkbox name=checkAll onclick='selectCheckAll()'  alt='Select/Deselect All'>";
	
	if("R".equals(Status) ){
		header  = selAllChk+"PR - Item"+","+"Created Date"+","+Release Date+","+Delivery Date+","+"Material"+","+Description+","+Plant","+Quantity+","+UOM;
		widths  = "4,12,11,11,11,12,16,7,11,5";
		colTyps = "ro,ro,ro,ro,ro,ro,ro,ro,ro,ro";
		aligns  = "center,center,center,center,center,center,center,center,right,center";
		colSort = "str,str,date,date,date,str,str,str,int,str";
	}	
	
	reqUrl = "Status="+Status+"&matNo="+matNo+"&selplant="+plant+"&fromDate="+fromDate+"&toDate="+toDate;
	//////out.println(searchFlag+"----"+showGrid);
%>
<html>
<head>
<script src="../../Library/JavaScript/ezConvertDates.js"></Script>
<link rel="STYLESHEET" type="text/css" href="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.css">
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXCommon.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGridCell.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.js"></Script>

<Script>
	function doOnLoad()
	{
		mygrid = null;
		mygrid = new dhtmlXGridObject('gridbox');
		mygrid.imgURL = "../../../../EzCommon/Images/Grid/";
		mygrid.setHeader("<%=header%>");
		mygrid.setNoHeader(false)
		mygrid.setInitWidthsP("<%=widths%>")
		mygrid.setColAlign("<%=aligns%>")
		mygrid.setColTypes("<%=colTyps%>");
		mygrid.setColSorting("<%=colSort%>")
		mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
		mygrid.enableBuffering(50);
		mygrid.init();
			mygrid.loadXML("ezListPRsGrid.jsp?<%=reqUrl%>");
	}	
		
</Script>
<Script>
	var showTotalDiv = false
	var selAtlOnePoBl_L = '<%=selAtlOnePoBl_L%>';
	
	function formEvents()
	{
		var selectedLength = 0
		var checkObj = document.myForm.chk1
		if(checkObj != null)
		{
			var checkLength = checkObj.length;
			if(isNaN(checkLength))
			{
				if(document.myForm.chk1.checked)
					selectedLength++;
			}
			else
			{
				for(i=0;i<checkLength;i++)
				{
					if(document.myForm.chk1[i].checked)
						selectedLength++;
				}
			}	
		}
		if(selectedLength == 0)
		{
			alert(selAtlOnePoBl_L)
		}
		else
		{
			setMessageVisible();
			document.myForm.action="ezBlockPurchaseOrder.jsp";
			document.myForm.submit();
		}	
	}
	
	function funLinkOpen(fileName,PurchaseOrder,NetAmount,Currency,orderType)
	{
		if(<%=isShowDates%>){
			document.location.href=fileName+"?PurchaseOrder="+PurchaseOrder+"&NetAmount="+NetAmount+"&Currency="+Currency+"&orderType="+orderType+"&listBack=Y&FromDate="+document.myForm.FromDate.value+"&ToDate="+document.myForm.ToDate.value+"&SearchFlag=<%=searchFlag%>&POSearch=<%=POSearch%>&MaterialNumber=<%=materialNumber%>&DCNO=<%=dcno%>&posearchno=<%=PurchaseOrder%>";
		}else{
			document.location.href=fileName+"?PurchaseOrder="+PurchaseOrder+"&NetAmount="+NetAmount+"&Currency="+Currency+"&orderType="+orderType+"&listBack=Y&SearchFlag=<%=searchFlag%>&POSearch=<%=POSearch%>&MaterialNumber=<%=materialNumber%>&DCNO=<%=dcno%>&posearchno=<%=PurchaseOrder%>";
		}
		
	}

	function funLinkNew(fileName,PurchaseOrder,NetAmount,Currency,orderType,sysKey,soldTo)
	{
		if(<%=isShowDates%>)
		{
			document.location.href=fileName+"?PurchaseOrder="+PurchaseOrder+"&NetAmount="+NetAmount+"&Currency="+Currency+"&orderType="+orderType+"&sysKey="+sysKey+"&soldTo="+soldTo+"&listBack=Y&FromDate="+document.myForm.FromDate.value+"&ToDate="+document.myForm.ToDate.value+"&SearchFlag=<%=searchFlag%>&POSearch=<%=POSearch%>&MaterialNumber=<%=materialNumber%>&DCNO=<%=dcno%>&posearchno=<%=PurchaseOrder%>"
		}
		else
		{
			document.location.href=fileName+"?PurchaseOrder="+PurchaseOrder+"&NetAmount="+NetAmount+"&Currency="+Currency+"&orderType="+orderType+"&sysKey="+sysKey+"&soldTo="+soldTo+"&listBack=Y&SearchFlag=<%=searchFlag%>&POSearch=<%=POSearch%>&MaterialNumber=<%=materialNumber%>&DCNO=<%=dcno%>&posearchno=<%=PurchaseOrder%>"	
		}
	}
	/* FOR DATE SELECTION AND TO LOAD DEFAULT DATES */
	
	function getDefaultsFromTo(){
<%
		if(isShowDates){
		if(fromDate!= null && toDate != null){
%>
			document.myForm.ToDate.value = "<%=toDate%>";
			document.myForm.FromDate.value = "<%=fromDate%>";
<%
		}
		else{
%>
			
			
			
			toDate = new Date();
			today = toDate.getDate();
			thismonth = toDate.getMonth()+1;
			thisyear = toDate.getYear();
			
			fromDate =  new Date();
			fromDate.setDate((toDate.getDate()-30));
			prevdate =  fromDate.getDate();
			prevmonth = fromDate.getMonth()+1;
			prevyear =  fromDate.getYear();
			
			if(!document.all){
				thisyear = thisyear+1900;
				prevyear = prevyear+1900;
			}
			if(today < 10)
				today = "0"+today;
			if(prevdate < 10)
				prevdate = "0"+prevdate;	
				
			if(thismonth < 10)
				thismonth = "0" + thismonth;
			if(prevmonth < 10)
				prevmonth = "0" + prevmonth;	
				
			document.myForm.ToDate.value = ConvertDateFormat(today+'.'+thismonth+'.'+thisyear,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>','<%=(String)session.getValue("DATESEPERATOR")%>');
			document.myForm.FromDate.value = ConvertDateFormat(prevdate+'.'+prevmonth+'.'+prevyear,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>','<%=(String)session.getValue("DATESEPERATOR")%>');
				
<%
		
		}
	}	
%>
	}
	
	function ezSubmit(){
		if(document.myForm.showGrid!=null)
			document.myForm.showGrid.value = "Y";
		
		document.myForm.action = "ezListPOs.jsp?OrderType=<%=orderType%>";
		document.myForm.submit();
	}
	
	/* END */
</Script>

</head>
<body onLoad="doOnLoad();" scroll=no>
<form name="myForm" method="post" >
<input type="hidden" name="chkField">
<input type="hidden" name ="chkbox">
<input type="hidden" name=selAllImg value="0">

<%	
	//String clickString = "onclick='ezSubmit()'";
	String noDataStatement = "No Purchase Requisitions List Exist";
	String display_header = "List Of Purchase Requisitions";
	if(Status.equals("R"))
		display_header = "List Of Released Purchase Requisitions";
	else if(Status.equals("U"))
		display_header = "List Of Unreleased Purchase Requisitions";
%>		
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
	<%@ include file="../Misc/ezDisplayGrid.jsp" %>		

<Div id="ButtonDiv" style="position:absolute;top:95%;width:100%;visibility:hidden">
	<center>
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
			
		buttonName.add("Back");
		buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");

		buttonName.add("Block");
		buttonMethod.add("formEvents()");

		out.println(getButtonStr(buttonName,buttonMethod));
%>
	</center>
</Div>
<%@ include file="../Misc/backButton.jsp" %>
<%@ include file="../Misc/AddMessage.jsp" %>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
