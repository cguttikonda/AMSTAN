
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import ="ezc.ezparam.*" %>
<%@ page import="ezc.customer.invoice.params.*" %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<jsp:useBean id="SalesInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iInvoiceDetails_Lables.jsp" %>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />

<%
	String base = request.getParameter("FromForm");
	String fd   = request.getParameter("FromDate");
	String td   = request.getParameter("ToDate");
	
	String browser = (String)session.getValue("BROWSER");
	String allignLeft="2%";
	if(browser!=null && ! ("Microsoft Internet Explorer".equals(browser)))
		allignLeft="40%";	
%>
<%@include file="../../../Includes/JSPs/SelfService/iOpenInvoicesList.jsp"%> 
<html>
<head>
	<Title>Open Invoices-Powered by Answerthink Ind Ltd.</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%> 
	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>   

<Script>
	  var tabHeadWidth=85
	  var tabHeight="45%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>  
</Script>

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
			if(getDefaultsFromTo()) 
			{
<%
			
				if(base!=null && !"null".equals(base) && !"".equals(base))
				{
%>
					/*
					mygrid = new dhtmlXGridObject('gridbox');
					mygrid.imgURL = "../../Images/Grid/";
					mygrid.setHeader("Invoice No,Delv. Doc. No,Cust PO No,Invoice Date,Due Date,Inv. Value[USD]");
					mygrid.setNoHeader(false)
					mygrid.setInitWidthsP("15,15,20,15,15,20")
					mygrid.setColAlign("left,left,left,center,center,right")
					mygrid.setColTypes("ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,str,str,str,int")
					mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
					mygrid.enableBuffering(150);
					mygrid.init();
					mygrid.loadXML("ezGridOpenInvoicesXML.jsp"); 
					*/
					
					mygrid = new dhtmlXGridObject('gridbox');
					mygrid.setImagePath("../../Images/Grid_2.5BA/");
					mygrid.setHeader("Invoice No,Delivery Document No,Customer PO No,Invoice Date,Due Date,Invoice Value[USD]");
					mygrid.setNoHeader(false)
					mygrid.setInitWidthsP("15,15,20,15,15,20")
					mygrid.setColAlign("left,left,left,center,center,right")
					mygrid.setColTypes("ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,str,str,str,int")
					//mygrid.setColumnColor(",#D5F1FF,,,,")
					mygrid.setStyle('background-Color:#227A7A;font-weight:600;',"","","")
					mygrid.setSkin("dhx_skyblue");
					//mygrid.enableBuffering(250);
					mygrid.init();
					mygrid.loadXML("ezGridOpenInvoicesXML.jsp"); 
					
<%			
				}
%>
			}
		}	
		function doOnUnLoad() 
		{
<%			if(base!=null && !"null".equals(base) && !"".equals(base))
			{
%>				if(mygrid)
					mygrid=mygrid.destructor();
<%			}
%>		}
		function printSubmit(obj)
		{
			document.Invoices.action=obj;
			document.Invoices.submit(); 

		}
		function gotoHome()
		{
			document.location.replace("../Misc/ezWelcome.jsp");  
		}
		function getDefaultsFromTo()
		{
<%			if(fd != null && td != null && !"null".equals(fd) && !"".equals(fd) )
			{
%>				document.Invoices.FromDate.value = "<%=fd%>"
				document.Invoices.ToDate.value = "<%=td%>"
<%			}
			else
			{
%>				toDate    = new Date();
				today     = <%=cDate%>;
				thismonth = <%=cMonth%>+1;
				thisyear  = <%=cYear%>;
				if(today < 10)
					today = "0"+today;
				if(thismonth < 10)
					thismonth = "0" + thismonth;
				document.Invoices.ToDate.value = thismonth+"/"+today+"/"+thisyear;
				if(thismonth < 4)
					fyear=(new Date().getYear()-1);
				else
					fyear=(new Date().getYear());
				if(parseInt(fyear)<1900)
					fyear=parseInt(fyear)+1900;
				document.Invoices.FromDate.value = "04/01/"+fyear
<%
			}
			
%>
			return true;
		}
		function chkDates()
		{
			fd = document.Invoices.FromDate.value;
			td = document.Invoices.ToDate.value;
			if(fd==""){
				alert("Please Enter From Date");
				return false;
			}
			if(td==""){
				alert("Please Enter To Date");
				return false;
			}
			a=fd.split("/");
			b=td.split("/");
			fd1=new Date(a[2],a[0]-1,a[1])
			td1=new Date(b[2],b[0]-1,b[1])
			if(fd1 > td1)
			{
				alert("From date must be less than Todate");
				document.SOForm.FromDate.focus();
				return false;
			}
			return true;
		}
		function formSubmit()
		{
			y = chkDates();
			if(eval(y))
			{
				document.Invoices.submit();
			}
		}
			
			

	</Script>
</head>
<body onLoad="getDefaultsFromTo();doOnLoad();" onUnLoad="doOnUnLoad();" scroll=no >
<form name="Invoices" method="post">
<input type='hidden' name="FromDate" 	value=''> 
<input type='hidden' name="ToDate" 	value=''> 
<input type="hidden" name="checkBrow" value="">
<%
	String display_header = opinvli_L;
	
	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>  
<input type=hidden name="FromForm" value="OpenInvoiceList">
<%
	if(fd==null || "null".equals(fd) || td==null || "null".equals(td)){
		fd="";td="";
	}
%>
<%--
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<Tr align="center">
	<Th>From Date</Th>
	<Td><input type="hidden"  name="DatesFlag" value="DATES">
        	<input type=text name="FromDate" class=InputBox value="<%=fd%>"  size=12 maxlength="10" readonly><%=getDateImage("FromDate")%>
	</Td>
	<Th>To Date</Th>
	<Td>
		<input type=text name="ToDate" class=InputBox value="<%=td%>"  size=12 maxlength="10" readonly><%=getDateImage("ToDate")%>
	</Td>
	<Td class="blankcell">
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Go");
		buttonMethod.add("formSubmit()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
	</Td>
</Tr>
</Table>
--%>
<%
		
		
if(base!=null && !"null".equals(base) && !"".equals(base))
{
	String noDataStatement= "No Open Invoices to list";

%>

<%@ include file="../Misc/ezDisplayGrid.jsp"%>

<div id="buttonDiv" align=center style="position:absolute;top:90%;width:100%;">
<%
	buttonName 	= new java.util.ArrayList();
	buttonMethod 	= new java.util.ArrayList();
//	if(dlineItems!=null && dlineItems.getRowCount()>0)
//	{
//		buttonName.add("Download Excel Sheet");
//		buttonMethod.add("printSubmit(\"ezInvoiceExSheet.jsp\")");
//	}	
	//buttonName.add("Back");
	//buttonMethod.add("gotoHome()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
<%
}
%>

<input type="hidden" name="onceSubmit" value=0>
<input type=hidden name="fname" value="OpenInvoicesList">
</form>
<Div id="MenuSol"></Div>
</body>
</html>