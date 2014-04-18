<%@ include file="../../Library/Globals/errorPagePath.jsp"%>  
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/JSPs/Labels/iListPO_Labels.jsp"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iEzDateConvertion.jsp" %>
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
<%@ include file="../../../Includes/JSPs/Purorder/iListPOHash.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<%
	String searchFlag	= request.getParameter("SearchFlag");
	String materialNumber	= request.getParameter("MaterialNumber");
	String POSearch		= request.getParameter("POSearch");
	String POMatSearch	= request.getParameter("POMatSearch");
	String backFlg 		= request.getParameter("backFlg");
	String shortText	= request.getParameter("ShortText");
	String fromDate		= request.getParameter("FromDate");
	String toDate		= request.getParameter("ToDate");
	String orderType	= request.getParameter("OrderType");
	String dcno 		= request.getParameter("DCNO");
	String PurchaseOrder 	= request.getParameter("PurchaseOrder");
	String posearchno 	= request.getParameter("posearchno");
	String SearchFlagDc 	= request.getParameter("SearchFlagDc");
	String userType		= (String)session.getValue("UserType");
	
	String header  = poNum_L+","+orderDate_L+","+early_L+","+latest_L+","+"Ship Date"+","+cur_L+","+value_L;
	String widths  = "15,14,14,14,14,14,15";
	String colTyps = "ro,ro,ro,ro,ro,ro,ro";
	String aligns  = "center,center,center,center,center,center,right";
	String colSort = "str,date,date,date,str,str,int";
	String reqUrl = "";
	String showGrid = "Y";
	boolean isShowDates = false;
	String selAllChk = "<input style='cursor:hand' type=checkbox name=checkAll onclick='selectCheckAll()'  alt='Select/Deselect All'>";
	
		
	if("Open".equals(orderType) && !userType.equals("3"))
	{
			
		header  = selAllChk+","+poNum_L+","+orderDate_L+","+early_L+","+latest_L+",Ship Date,"+cur_L+","+value_L;
		widths  = "5,15,13,13,13,13,13,15";
		aligns  = "center,center,center,center,center,center,center,right";
		colTyps = "ro,ro,ro,ro,ro,ro,ro,ro";
		colSort = "str,str,date,date,date,str,str,int";
	}
	
	if(searchFlag==null || "null".equals(searchFlag) || "".equals(searchFlag)){
		isShowDates = true;
	}
	else{
		showGrid = "Y";
	
	}
	
	if("Yes".equals(POSearch)){
		isShowDates = false;
		showGrid = "Y";
		if("Y".equals(backFlg)){
			PurchaseOrder = posearchno;
					
		}
	}	
	reqUrl = "SearchFlag="+searchFlag+"&MaterialNumber="+materialNumber+"&POSearch="+POSearch+"&POMatSearch="+POMatSearch+"&ShortText="+shortText+"&OrderType="+orderType+"&DCNO="+dcno+"&PurchaseOrder="+PurchaseOrder+"&SearchFlagDc="+SearchFlagDc;
	
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
	function ezPrint()
	{
		location.href='ezPrint.jsp?PurchaseOrder=4500000167&vendorNo=s-1006'
	}
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
<%
		if(isShowDates)
		{
%>
			  
			mygrid.loadXML("ezListPOsGrid.jsp?noCache='"+((new Date()).valueOf())+"'&<%=reqUrl%>&FromDate="+document.myForm.FromDate.value+"&ToDate="+document.myForm.ToDate.value);
			
<%			
		}
		else{
%>
				
			
			mygrid.loadXML("ezListPOsGrid.jsp?<%=reqUrl%>");
<%
		}
%>
			

		
		
	}	
	function doOnUnLoad()
	{
		if(mygrid)
			mygrid=mygrid.destructor();
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
<%
/*
	String callFun = ""; 
	if("Y".equals(showGrid) || "Y".equals(backFlg) ){
		callFun = "doOnLoad()"; 
	}
*/	
%>
<body onLoad="getDefaultsFromTo();doOnLoad();" scroll=no>
<form name="myForm" method="post" >
<input type="hidden" name="chkField">
<input type="hidden" name ="chkbox">
<input type="hidden" name=selAllImg value="0">

<%	
	if(orderType == null) 
		orderType="";
		
	String clickString = "onclick='ezSubmit()'";
	String display_header = (String)hashReqStmt.get(orderType);
	String noDataStatement = (String)hashReqType.get(orderType);
	ezc.ezcommon.EzLog4j.log("poNumber:::::::::::"+display_header,"I");
	ezc.ezcommon.EzLog4j.log("poNumber:::::::::::"+noDataStatement,"I");
%>		
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<%
	if(isShowDates)
	{
			
	
%>
		<input type="hidden" name="showGrid" value="Y"  >
		<%@ include file="../Misc/ezSelectDate.jsp"%>		
<%
	}
	else
	{
%>
		<input type="hidden" name="showGrid" value="Y" >	
<%
	}
%>


	<%@ include file="../Misc/ezDisplayGrid.jsp" %>		


<Div id="ButtonDiv" style="position:absolute;top:95%;width:100%;visibility:hidden">
	<center>
<%
		if(orderType.equals("Open") && !userType.equals("3")){
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			
			buttonName.add("Back");
			buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");

			buttonName.add("Block");
			buttonMethod.add("formEvents()");
			
			buttonName.add("Print");
			buttonMethod.add("ezPrint()");

			out.println(getButtonStr(buttonName,buttonMethod));
			
			
		}   
		else
		{
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Back");
			buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
			out.println(getButtonStr(buttonName,buttonMethod));
		}
			
%>
	</center>
</Div>
<%@ include file="../Misc/backButton.jsp" %>

<%@ include file="../Misc/AddMessage.jsp" %>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
