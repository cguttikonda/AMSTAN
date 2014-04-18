<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iListInv_Labels.jsp"%>
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
<%@ page import = "java.util.*"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>


<%
	String searchField = request.getParameter("searchField");
	String base = request.getParameter("base");
	String invoiceFlag = request.getParameter("InvStat");
	String vendor=(String) session.getValue("SOLDTO");
	String purnum = "";
	String fromDate		= request.getParameter("FromDate");
	String toDate		= request.getParameter("ToDate");
	boolean isShowDates = false;
	if(searchField==null || "null".equals(searchField) || "".equals(searchField) )
	{
			isShowDates = true;
	}
%>
<html>
<head>
<script src="../../Library/JavaScript/ezConvertDates.js"></Script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<link rel="STYLESHEET" type="text/css" href="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.css">
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXCommon.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGridCell.js"></Script>
<% String header = vendorInvNum_L+","+sapInvNum_L+","+invDate_L+",Clearing Date,"+payNum_L+","+cur_L+","+amount_L; %>
<Script>

	function doOnLoad()
	{
		mygrid = new dhtmlXGridObject('gridbox');
		mygrid.imgURL = "../../../../EzCommon/Images/Grid/";
		mygrid.setHeader('<%=header%>')
		mygrid.setNoHeader(false)
		mygrid.setInitWidthsP("16,16,13,13,16,8,18")
		mygrid.setColAlign("left,center,center,center,center,center,right")
		mygrid.setColTypes("ro,ro,ro,ro,ro,ro,ro");
		mygrid.setColSorting("int,str,date,str,int,str,int")
		mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
		mygrid.enableBuffering(150);
		mygrid.init();
<%
		if(isShowDates){
%>
			mygrid.loadXML("ezListInvGrid.jsp?InvStat=<%=invoiceFlag%>&searchField=<%=searchField%>&base=<%=base%>&FromDate="+document.myForm.FromDate.value+"&ToDate="+document.myForm.ToDate.value);
<%
		}else{
%>
			mygrid.loadXML("ezListInvGrid.jsp?InvStat=<%=invoiceFlag%>&searchField=<%=searchField%>&base=<%=base%>");		
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
	function funLinkInvoice(fileName,invnum,purNum,compCode,docType,invDate,invCur,invAmount,PostDate)
	{
<%
		if(isShowDates){
%>
		document.location.href=fileName+"?invnum="+invnum+"&purNum="+purNum+"&compCode="+compCode+"&docType="+docType+"&invDate="+invDate+"&invCur="+invCur+"&invAmount="+invAmount+"&PostDate="+PostDate+"&InvStat=<%=invoiceFlag%>&listBack=Y&searchField=<%=searchField%>&FromDate="+document.myForm.FromDate.value+"&ToDate="+document.myForm.ToDate.value
<%
		}else{
%>
		document.location.href=fileName+"?invnum="+invnum+"&purNum="+purNum+"&compCode="+compCode+"&docType="+docType+"&invDate="+invDate+"&invCur="+invCur+"&invAmount="+invAmount+"&PostDate="+PostDate+"&InvStat=<%=invoiceFlag%>&listBack=Y&searchField=<%=searchField%>"
<%
		  }	
%>
	}
	function ezSubmit(){
		if(document.myForm.showGrid!=null)
			document.myForm.showGrid.value = "Y";
			
		document.myForm.action = "ezListInv.jsp?InvStat=<%=invoiceFlag%>";
		document.myForm.submit();
	}
	
	
	
	
	
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
</Script>
</head>
	
<body onLoad="getDefaultsFromTo();doOnLoad()" scroll=no>
<form method="post" name="myForm">
<% 
	String clickString = "onclick='ezSubmit()'";
	ezc.ezparam.EzInvoice SeqInv = new ezc.ezparam.EzInvoice();
	
	if ( invoiceFlag == null ) invoiceFlag="A";
		
	Hashtable no_htable = new Hashtable();
	no_htable.put("A",noInvExist_L);
	no_htable.put("C",noCloseInvExist_L);
	no_htable.put("O",noOpenInvExist_L);
	no_htable.put("P",noInvExist_L);
	
	Hashtable header_ht = new Hashtable();
	header_ht.put("A",allInvList_L);
	header_ht.put("C",closeInv_L);
	header_ht.put("O",openInv_L);
	header_ht.put("P",invoiceList_L);
			
	String noDataStatement =null;
	String display_header= null;
	
	if (invoiceFlag.equals("A")){
		noDataStatement=(String)no_htable.get("A");
		display_header=(String)header_ht.get("A");	
	}	
	else if (invoiceFlag.equals("C")){
		noDataStatement=(String)no_htable.get("C");
		display_header=(String)header_ht.get("C");
	}	
	else if (invoiceFlag.equals("O")){
		noDataStatement=(String)no_htable.get("O");
		display_header=(String)header_ht.get("O");
	}	
	else{ 
		noDataStatement=(String)no_htable.get("P");
		display_header=(String)header_ht.get("P");
	}
	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<%
	if(isShowDates){
%>
		
		<%@ include file="../Misc/ezSelectDate.jsp"%>		
<%
	}
%>
		

<%@ include file="../Misc/ezDisplayGrid.jsp" %>		

<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:hidden">
	<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	if(isShowDates){
	buttonName.add("Back");
	buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
	}

	out.println(getButtonStr(buttonName,buttonMethod));
%>
	</center>
</Div>
<input type="hidden" name="showGrid" value="Y"  >
<%@ include file="../Misc/backButton.jsp" %>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
