<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ include file="../../../Includes/JSPs/Misc/iEzDateConvertion.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iListTobeDelivered_Labels.jsp"%>
<% 
	String display_header	= tobeDelMat_L;
	String clickString 	= "onclick='ezSubmit()'";
	String noDataStatement 	= noDelExtSelPerd_L;

	String fromDate		= request.getParameter("FromDate");
	String toDate		= request.getParameter("ToDate");
	String loadXML		= request.getParameter("loadXML");

	if(fromDate == null || toDate == null)
	{
		
		Date fromDateObj =  new Date();
		int prevdate =  fromDateObj.getDate();
		int prevmonth = fromDateObj.getMonth()+1;
		int prevyear =  fromDateObj.getYear()+1900;
				
		Date toDateObj 	= new Date();
		toDateObj.setDate((fromDateObj.getDate()+30));
		int today 	= toDateObj.getDate();
		int thismonth  	= toDateObj.getMonth()+1;
		int thisyear 	= toDateObj.getYear()+1900;
		
		String todayStr 	= "";
		String prevdateStr 	= "";
		String thismonthStr 	= "";
		String prevmonthStr 	= "";

		if(today < 10)
			todayStr = "0"+today;
		else
			todayStr = ""+today;

		if(prevdate < 10)
			prevdateStr = "0"+prevdate;
		else
			prevdateStr = ""+prevdate;

		if(thismonth < 10)
			thismonthStr = "0" + thismonth;
		else
			thismonthStr = "" + thismonth;

		if(prevmonth < 10)
			prevmonthStr = "0" + prevmonth;	
		else	
			prevmonthStr = "" + prevmonth;

		fromDate = prevmonthStr+(String)session.getValue("DATESEPERATOR")+prevdateStr+(String)session.getValue("DATESEPERATOR")+prevyear;
		toDate   = thismonthStr+(String)session.getValue("DATESEPERATOR")+todayStr+(String)session.getValue("DATESEPERATOR")+thisyear;
		
	}	
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
<link rel="STYLESHEET" type="text/css" href="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.css">
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXCommon.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGridCell.js"></Script>
<Script>
	function doOnLoad()
	{
		mygrid = new dhtmlXGridObject('gridbox');
		mygrid.imgURL = "../../../../EzCommon/Images/Grid/";
		mygrid.setHeader('<%=poNum_L%>,<%=line_L%>,<%=mat_L%>,<%=desc_L%>,<%=uom_L%>,<%=qty_L%>,<%=delDate_L%>,<%=comDate_L%>')
		mygrid.setNoHeader(false)
		mygrid.setInitWidthsP("12,6,11,30,7,8,13,13")
		mygrid.setColAlign("center,center,left,left,left,right,center,center")
		mygrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro");
		mygrid.setColSorting("int,int,str,str,str,int,date,date")
		mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
		mygrid.enableBuffering(50);
		mygrid.init();
		mygrid.loadXML("ezListToBeDeliveredGrid.jsp?FromDate="+document.myForm.FromDate.value+"&ToDate="+document.myForm.ToDate.value);
	}	
	function doOnUnLoad()
	{
		if(mygrid)
			mygrid=mygrid.destructor();
	}	
</Script>

<script src="../../Library/JavaScript/ezConvertDates.js"></Script>

<%
      
      Date today = new Date();
%>
	<script>
	var plzSelFDate_A = '<%=plzSelFDate_A%>';
	var plzSelTDate_A = '<%=plzSelTDate_A%>';
	var fDateLessTDate_A = '<%=fDateLessTDate_A%>';
	var FDateGTCurr_L = '<%=FDateGTCurr_L%>';
	function funLinkOpen(fileName,PurchaseOrder,NetAmount,Currency,flag)
	{
		document.location.href=fileName+"?PurchaseOrder="+PurchaseOrder+"&NetAmount="+NetAmount+"&Currency="+Currency+"&flag="+flag+"&FromDate="+document.myForm.FromDate.value+"&ToDate="+document.myForm.ToDate.value+"&listBack=D";
	}

	function chkDates() 
	{
		var fd = document.myForm.FromDate.value;
		var td = document.myForm.ToDate.value;
	
		var curDate = new Date('<%=today.getYear()+1900%>',parseInt('<%=today.getMonth()%>',10),'<%=today.getDate()%>')
		if(fd=="")
		{
			alert(plzSelFDate_A);
			return false;
		}
		
		if(td=="")
		{
			alert(plzSelTDate_A);
			return false;
		}

		fd = ConvertDate(fd,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')
		td = ConvertDate(td,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')

		var fd1 = new Date();
		var td1 = new Date();
		a = fd.split(".");
		fd1 = new Date(a[2],(a[1]-1),a[0])
		b = td.split(".");
		td1 = new Date(b[2],(b[1]-1),b[0])
		


		if(fd1<curDate)
		{
			alert(FDateGTCurr_L);
			document.myForm.FromDate.focus();
			return false;

		}

		if(fd1>td1)
		{
			alert(fDateLessTDate_A);
			document.myForm.FromDate.focus();
			return false;
		}	
		return true;
	}
	function ezGetCurrent()
	{
			
		toDate = new Date();
		today = <%= cDate%>;
		thismonth = <%= cMonth%>;
		thisyear = <%= cYear%>;
		if(today < 10)
			today = "0"+today;
		if(thismonth < 12)
			thismonth =parseInt(thismonth)+1;
		if(thismonth < 10)
			thismonth = "0" + thismonth;
		if(thismonth < 4)
			fyear=(new Date().getYear()-1);
		else
			fyear=(new Date().getYear());
		if(parseInt(fyear)<1900)
			fyear=parseInt(fyear)+1900;

	
<%
		if (("".equals(fromDate))&&("".equals(toDate)))
		{
%>
			document.myForm.FromDate.value = thismonth+"/"+today+"/"+thisyear;
			document.myForm.ToDate.value = thismonth+"/"+today+"/"+thisyear;	
<%
		}
%>
	}

	function ezSubmit()
	{
		y = chkDates();
		if(y)
		{
			document.myForm.action = "ezListToBeDelivered.jsp?FromDate="+document.myForm.FromDate.value+"&ToDate="+document.myForm.ToDate.value;
			document.myForm.submit();
		}	
	}
	</script>
</head>

<body scroll=no onLoad='doOnLoad()'>
<form name=myForm>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<%@ include file="../Misc/ezSelectDate.jsp"%>
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
</form>
</body>
</html>
