
<%@ page import ="ezc.ezparam.*" %>
<%@ page import="ezc.customer.invoice.params.*" %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iezClosedInvoices_Lables.jsp"%>
<jsp:useBean id="SalesInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%

	String browser = (String)session.getValue("BROWSER");
	String allignLeft="2%";
	if(browser!=null && ! ("Microsoft Internet Explorer".equals(browser))) 
		allignLeft="40%";

	ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
	String datesFlag	= request.getParameter("DatesFlag");
	datesFlag		= ((datesFlag==null) || ("null".equals(datesFlag)))?"DATES":datesFlag;
	String base 		= request.getParameter("FromForm");
 	String fd 		= request.getParameter("FromDate");
 	String td 		= request.getParameter("ToDate");
	
	Date toDay	= new Date();
 	
 	int month=0,year=0,day=0;
 	String monthStr="",yearStr="",dayStr="";
 	
 	day 	= toDay.getDate();
 	month 	= toDay.getMonth();
 	year 	= toDay.getYear();
 	
 	if(day<10)
 		dayStr 	= "0"+day;  
 	else    
 		dayStr 	= day+"";
 	monthStr= (month+1)+"";  
 	yearStr	= (1900+year)+"";  
 	
 	
 	if(fd==null || "null".equals(fd))
 	{
 		fd = "04"+"/"+"01"+"/"+"2006";//(1900+toDay.getYear());
 	}
 	if(td==null || "null".equals(td))
 	{
 		if(month+1<10)
 			td = "0"+monthStr+"/"+dayStr+"/"+yearStr; 
 		else
 			td = monthStr+"/"+dayStr+"/"+yearStr;
 	}
 	
	
 	base = "123";
 		
 	String monthOpt		= request.getParameter("ezMonths");
	int rowno		= 0;
	double total		= 0;
	String billto		= "";
	ReturnObjFromRetrieve lineItems	= null;
	ReturnObjFromRetrieve dlineItems= null;
	String forkey = (String)session.getValue("formatKey");
	if(forkey==null) forkey="/";
	
%>
<Html>
<Head>
<Title></Title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
	<Script>
		  var tabHeadWidth	= 95
 	   	  var tabHeight		= "35%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
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
	
	<script LANGUAGE="JavaScript">

	function printSubmit(obj)
	{
		document.Invoices.action=obj;
		document.Invoices.submit();

	}

	function gotoHome()
	{
                 document.location.replace("../Misc/ezWelcome.jsp");
	}
	function pageSubmit(p1,p2,p3)
	{
		myForm =document.forms[0];
		document.body.style.cursor="wait"
		myForm.custInvNo.value=p1
		myForm.sapInvNo.value=p2
		myForm.InvDate.value=p3
		myForm.action="ezInvoiceDetails.jsp"
		myForm.submit()
	}
	function chkDates()
	{
		myForm =document.forms[0];
		fd = myForm.FromDate.value;
		td = myForm.ToDate.value;
		if(fd=="")
		{
			alert("Please Enter From Date");
			return false;
		}
		if(td=="")
		{
			alert("Please Enter To Date");
			return false;
		}
		a=fd.split("<%=forkey %>");
		b=td.split("<%=forkey %>");
		fd1=new Date(a[2],a[0]-1,a[1])
		td1=new Date(b[2],b[0]-1,b[1])


		if(fd1 > td1)
		{
			alert("From date must be less than Todate");
			myForm.FromDate.focus();
			return false;
		}
		return true;
	}
	function formSubmit()
	{
		y = chkDates();
		if(eval(y))
		{
			document.forms[0].submit();
		}
	}
	function funFillDates()
	{
		myForm =document.forms[0]

		if(myForm.ezMonths.selectedIndex!=0)
		{
			myVal=myForm.ezMonths.options[myForm.ezMonths.selectedIndex].value
<%
			Date pObjn =new Date();
			int curMonth=pObjn.getMonth();
			int pYear1 = pObjn.getYear()+1900;
			int pMonth1= pObjn.getMonth();
			int pDate1 = pObjn.getDate();

			pObjn =new java.util.Date();
			pObjn.setMonth(curMonth-1);
			int pYear2 = pObjn.getYear()+1900;
			int pMonth2= pObjn.getMonth();
			int pDate2 = pObjn.getDate();

			pObjn =new java.util.Date();
			pObjn.setMonth(curMonth-2);
			int pYear3 = pObjn.getYear()+1900;
			int pMonth3= pObjn.getMonth();
			int pDate3 = pObjn.getDate();

			pObjn =new java.util.Date();
			pObjn.setMonth(curMonth-5);
			int pYear6 = pObjn.getYear()+1900;
			int pMonth6= pObjn.getMonth();
			int pDate6 = pObjn.getDate();

			pObjn =new java.util.Date();
			pObjn.setMonth(pMonth1-12);
			int pYear12 = pObjn.getYear()+1900;
			int pMonth12= pObjn.getMonth()+1;
			int pDate12 = pObjn.getDate();


		%>
			if(myVal=="1")
			{
				d="<%=pDate1%>"
				m="<%=pMonth1%>"
				y="<%=pYear1%>"
			}else
				if(myVal=="2")
				{
					d="<%=pDate2%>"
					m="<%=pMonth2%>"
					y="<%=pYear2%>"
				}else
					if(myVal=="3")
					{
						d="<%=pDate3%>"
						m="<%=pMonth3%>"
						y="<%=pYear3%>"
					}else
						if(myVal=="6")
						{
							d="<%=pDate6%>"
							m="<%=pMonth6%>"
							y="<%=pYear6%>"
						}else
							if(myVal=="12")
							{
								d="<%=pDate12%>"
								m="<%=pMonth12%>"
								y="<%=pYear12%>"
							}


			if(d<10)
			{
				d="0"+d;
			}
			if(m<10)
			{
				if(m=="0"){
					m="12";
					y=parseInt(y)-1
				}else{
					m="0"+m;
				}
			}
			myForm.FromDate.value=m + "<%=forkey%>" + d + "<%=forkey%>" + y
			myForm.submit();
		}else{
			alert("Please Select the months");
		}
	}
	function selMonthVal()
	{
		<%if("MONTHS".equals(datesFlag)){%>
			myForm =document.forms[0]
			var opLength=myForm.ezMonths.options.length;
			for(p=0;p<opLength;p++)
			{
				if(myForm.ezMonths.options[p].value == "<%=monthOpt%>"){
					myForm.ezMonths.selectedIndex=p;
					break;
				}
			}
		<%}%>
	}
	function getDefaultsFromTo()
	{
		myForm =document.forms[0]
<%		if(fd != null && td != null && !"null".equals(fd) && !"".equals(fd) ){
%>
			myForm.ToDate.value = "<%=td%>"
			myForm.FromDate.value = "<%=fd%>"
<%		}else{
%>
			toDate = new Date();
			today = <%= cDate%>;
			thismonth = <%= cMonth%>+1;
			thisyear = <%= cYear%>;
			if(today < 10)
				today = "0"+today;
			if(thismonth < 10)
				thismonth = "0" + thismonth;
				myForm.ToDate.value = thismonth+"<%=forkey%>" +today+"<%=forkey%>" +thisyear;
			if(thismonth < 4)
				fyear=(new Date().getYear()-1);
			else
				fyear=(new Date().getYear());
			if(parseInt(fyear)<1900)
				fyear=parseInt(fyear)+1900;
				myForm.FromDate.value = "04<%=forkey%>01<%=forkey%>"+fyear
				
<%
		}
%>
	}
	
		function doOnLoad()
		{
<%
			if(base!=null && !"null".equals(base) && !"".equals(base))
			{
%>					
					/*
					mygrid = new dhtmlXGridObject('gridbox');
					mygrid.imgURL = "../../Images/Grid/";
					mygrid.setHeader("Invoice No,Clearing Date,Invoice Date,Inv. Value[USD]");
					mygrid.setNoHeader(false)
					mygrid.setInitWidthsP("25,25,25,25")
					mygrid.setColAlign("left,center,center,right")
					mygrid.setColTypes("ro,ro,ro,ro");
					mygrid.setColSorting("int,str,str,int")
					mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
					mygrid.enableBuffering(250);
					mygrid.init();
					mygrid.loadXML("ezGridClosedInvoicesXML.jsp");
					*/
					mygrid = new dhtmlXGridObject('gridbox');
					mygrid.setImagePath("../../Images/Grid_2.5BA/");
					mygrid.setHeader("Invoice No,Clearing Date,Invoice Date,Invoice Value[USD]");
					mygrid.setNoHeader(false)
					mygrid.setInitWidthsP("25,25,25,25")
					mygrid.setColAlign("left,center,center,right")
					mygrid.setColTypes("ro,ro,ro,ro");
					mygrid.setColSorting("int,str,str,int")
					//mygrid.setColumnColor(",#D5F1FF,,,,")
					mygrid.setStyle('background-Color:#227A7A;font-weight:600;',"","","")
					mygrid.setSkin("dhx_skyblue");
					//mygrid.enableBuffering(250);
					mygrid.init();
					mygrid.loadXML("ezGridClosedInvoicesXML.jsp");
<%
			}
%>
				
		}

		function doOnUnLoad()
		{
<%
			if(base!=null && !"null".equals(base) && !"".equals(base))
			{
%>
					if (mygrid)
						mygrid=mygrid.destructor();
<%
			}
%>
		
		}
	
</script>
</Head>
<%
String cust	= (String)session.getValue("AgentCode");
if (cust.indexOf(",") != -1)
{
%>
	<Body scroll=no >
	<Table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
		<Tr>
			<td height="35" class="displayheaderback" width="100%">&nbsp;</Td>
		</Tr>
	</Table>
	<Br><Br><Br><Br>
	<Table align="center">
		<Tr>
			<Td align="center" class="displayalert">
				<%=uCanViewClosedInv_L%>.<Br><Br><%=toSelCust_L%> <a href="../Misc/ezSalesHome.jsp" target="_top"><%=here_L%></a>
			</Td>
		</Tr>
	</Table>
<%
}else{

	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	billto=(String)session.getValue("DefBillTO"); //UtilManager.getUserDefErpBillTo();

%>
	<Body onLoad="getDefaultsFromTo();selMonthVal();scrollInit('SHOWTOT');doOnLoad()" topmargin=0 onresize="scrollInit('SHOWTOT')" scroll=no>
	<Form name="Invoices" action="../SelfService/ezGridClosedInvoices.jsp">
	<%
		String display_header = closedInvLi_L;             

	%>
	<%@ include file="../Misc/ezDisplayHeader.jsp"%>

	<input type=hidden	name="custInvNo">
	<input type=hidden 	name="sapInvNo">
	<input type=hidden 	name="InvDate">
	<input type=hidden 	name="InvFlag" value="C">
	<input type=hidden 	name="urlPage" value="ezCP">
	<input type=hidden 	name="FromForm" value="ClosedInvoiceList">
	
<%
	if(fd==null || "null".equals(fd) || td==null || "null".equals(td)){
		fd="";
		td="";
	}

		
	String selectLable="";
	if("MONTHS".equals(datesFlag)){
		selectLable="Please Select Month(s). Click on Go.";
%>
		<input type="hidden"  name="DatesFlag" value="MONTHS">
		<input type=hidden name="FromDate" class=InputBox value="<%=fd%>">
		<input type=hidden name="ToDate" class=InputBox value="<%=td%>" >
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr align="center">
			<Th><%= selMonths_L %></Th>
			<Td>
				<select name=ezMonths id=listBoxDiv>
					<option value=''>--Select--</option>
					<option value=1>Last Month</option>
					<option value=2>Last 2 Months</option>
					<option value=3>Last 3 Months</option>
					<option value=6>Last 6 Months</option>
					<option value=12>Last Year</option>
				</select>
			</td>
			<td>
<%		
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				buttonName.add("Go");
				buttonMethod.add("funFillDates()");
				out.println(getButtonStr(buttonName,buttonMethod));
%>	
			</Td>
		</Tr>
	</Table>
<%
	}else if("DATES".equals(datesFlag)){
		selectLable="Please Select Date(s). Click on Go.";
	
	
 
	
%>

<Div id='inputDiv' style='position:relative;align:center;width:100%;'>
<Table width="50%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
	<Tr>
		<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
		<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
		<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
	</Tr>

	<Tr>
		<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
		<Td style="background-color:'DDEEFF'" valign=middle>
		
		<input type="hidden"  name="DatesFlag" value="DATES">
		<Table  align="center" border="0" valign=middle width="100%" cellPadding=0 cellSpacing=0 >
			<Tr align="center">
				<Th><%= fromDate_L %></Th>

				<Td><input type=text name="FromDate" id="FromDate" class=InputBox value="<%=fd%>"  size=12 maxlength="10" readonly><%=getDateImage("FromDate")%>
				</Td>
				<Th><%= toDate_L %></Th>
				<Td><input type=text name="ToDate" id="ToDate" class=InputBox value="<%=td%>"  size=12 maxlength="10" readonly><%=getDateImage("ToDate")%>
				<Td>
<%		
					buttonName = new java.util.ArrayList();
					buttonMethod = new java.util.ArrayList();
					buttonName.add("Go");
					buttonMethod.add("formSubmit()");
					out.println(getButtonStr(buttonName,buttonMethod));
%>	
				</td>
			</Tr>
		</Table>
		</td>	
		<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"></Td>
	</Tr>
	<Tr>
		<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
		<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
		<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
	</Tr>
</Table>
</Div>		

<%
	}
%>
	<%@ include file="../../../Includes/JSPs/SelfService/iGridClosedInvoice.jsp"%>
<%
}
%>
<input type=hidden name="fname" value="ClosedInvoicesList">
<%
if(base!=null && !"null".equals(base) && !"".equals(base))
{
	String noDataStatement= "No Closed Invoices to list";


%>

<%@ include file="../Misc/ezDisplayGrid.jsp"%>
<Div id="buttonDiv" align=center style="position:absolute;top:90%;width:100%">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
//	if(dlineItems!=null && dlineItems.getRowCount()>0)
//	{
//		buttonName.add("Download Excel Sheet");
//		buttonMethod.add("printSubmit(\"ezInvoiceExSheet.jsp\")");
//	}		
	//buttonName.add("Back");
	//buttonMethod.add("gotoHome()");
	out.println(getButtonStr(buttonName,buttonMethod));
}		
%>
</Div>
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
