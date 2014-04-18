<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iBackEndSOList_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<html>
<head>
	<Title>List of Sales Orders-Powered by EzCommerce Inc</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

<Script>
		  var tabHeadWidth=85
		  var tabHeight="45%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<%
		String UserRole = (String)session.getValue("UserRole");
		String fd = request.getParameter("FromDate");
		String td = request.getParameter("ToDate");
		String forkey = (String)session.getValue("formatKey");
		if(forkey==null) forkey ="/";
%>

<%

String[] customer 	= request.getParameterValues("customer");
ReturnObjFromRetrieve retCustList = new ReturnObjFromRetrieve();
String agentCode	=(String)session.getValue("AgentCode");


int custcount=retCustList.getRowCount();
if(customer == null)
{
	if(session.getValue("customers") != null)
	{
		customer=(String[])session.getValue("customers");
	}else
	{
		if(agentCode.indexOf(",")==-1)
		{
			customer=new String[1];
			customer[0]=agentCode;
		}
	}
}else
{
	session.putValue("customers",customer);
}
%>


<Script>
	function movetoHome()
	{
		document.location.href="../Misc/ezWelcome.jsp";
	}
	function funShowEdit(SoNo,SoldTo)
	{
             if(document.SOForm.onceSubmit.value!=1){
		document.SOForm.onceSubmit.value=1
		document.SOForm.Back.value=SoNo
		document.SOForm.SoldTo.value=SoldTo
		document.SOForm.pageUrl.value="EditBackOrder"
		document.SOForm.status.value="O"
		document.SOForm.target = "main"
		document.SOForm.action="../Sales/ezBackWaitSalesDisplay.jsp"
		document.body.style.cursor="wait"
		document.SOForm.submit();
	       }
	}
	
	function funShowEdit1(SoNo,SoldTo)
	{
	     if(document.SOForm.onceSubmit.value!=1){
		document.SOForm.onceSubmit.value=1
		document.SOForm.SONumber.value=SoNo
		document.SOForm.SoldTo.value=SoldTo
		document.SOForm.status.value="O"
		document.SOForm.pageUrl.value="BackOrder"		
		document.SOForm.target = "main"		
		document.SOForm.action="../Sales/ezBackWaitSalesDisplay.jsp"
		document.body.style.cursor="wait"
		document.SOForm.submit();
        	}
	}
	function funSubmit()
	{
		if(document.SOForm.customer.selectedIndex==-1)
		{
			alert("Please Select Stockist(s)");
		}
		else
		{
			document.SOForm.action="ezBackEndSOList.jsp"
			document.SOForm.submit();
		}
	}

		function getDefaultsFromTo()
		{
			<%if(fd != null && td != null && !"null".equals(fd) && !"".equals(fd) ){%>
				document.SOForm.ToDate.value   = "<%=td%>"
				document.SOForm.FromDate.value = "<%=fd%>"				
			<%}else{%>
				toDate = new Date();
				today = <%= cDate%>;
				thismonth = <%= cMonth%>+1;
				thisyear = <%= cYear%>;
				if(today < 10)
					today = "0"+today;
				if(thismonth < 10)
					thismonth = "0" + thismonth;
				document.SOForm.ToDate.value = thismonth+"<%=forkey%>"+today+"<%=forkey%>"+thisyear;
				if(thismonth < 4)
					fyear=(new Date().getYear()-1);
				else
					fyear=(new Date().getYear());
				if(parseInt(fyear)<1900)
					fyear=parseInt(fyear)+1900;
				document.SOForm.FromDate.value = "04<%=forkey%>01<%=forkey%>"+fyear
			<%}%>
		}
		function chkDates()
		{
			fd = document.SOForm.FromDate.value;
			td = document.SOForm.ToDate.value;
			if(fd==""){
				alert("Please Enter From Date");
				return false;
			}
			if(td==""){
				alert("Please Enter To Date");
				return false;
			}
			a=fd.split("<%=forkey%>");
			b=td.split("<%=forkey%>");
	
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
				//document.SOForm.DatesFlag.value="MONTHS";
				document.SOForm.submit();
			}
		}
	
		function funFillDates()
		{
			if(document.SOForm.ezMonths.selectedIndex!=0)
			{
				myVal=document.SOForm.ezMonths.options[document.SOForm.ezMonths.selectedIndex].value
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
				if(myVal=="1"){
					d="<%=pDate1%>"
					m="<%=pMonth1%>"
					y="<%=pYear1%>"
				}else if(myVal=="2")
				{
					d="<%=pDate2%>"
					m="<%=pMonth2%>"
					y="<%=pYear2%>"
				}else if(myVal=="3")
				{
					d="<%=pDate3%>"
					m="<%=pMonth3%>"
					y="<%=pYear3%>"
				}else if(myVal=="6")
				{
					d="<%=pDate6%>"
					m="<%=pMonth6%>"
					y="<%=pYear6%>"
				}else if(myVal=="12")
				{
					d="<%=pDate12%>"
					m="<%=pMonth12%>"
					y="<%=pYear12%>"
				}
				if(d<10){
					d="0"+d;
				}
				if(m<10){
		   			if(m=="0"){
						m="12";
						y=parseInt(y)-1
					}else{
						m="0"+m;
	    				}
				}
				document.SOForm.FromDate.value= m + "<%=forkey%>" + d + "<%=forkey%>" + y
				document.SOForm.submit();
			}else{
				alert("Please Select the months");
			}
		}
		

</Script>
	<link rel="STYLESHEET" type="text/css" href="../../Library/Styles/dhtmlXGrid.css">
	<Script src="../../Library/JavaScript/Grid/dhtmlXCommon.js"></Script>
	<script src="../../Library/JavaScript/Grid/dhtmlXGrid.js"></script>		
	<script src="../../Library/JavaScript/Grid/dhtmlXGridCell.js"></script>
	

	<Script>		
		function doOnLoad()
		{			
			var fromDate = document.SOForm.FromDate.value;
			var toDate = document.SOForm.ToDate.value;
			
			mygrid = new dhtmlXGridObject('gridbox');			
			mygrid.imgURL = "../../Images/Grid/";	
			mygrid.setHeader("Sales Order No,Order Date,PO No,PO Date,Customer");
			mygrid.setNoHeader(false)
			mygrid.setInitWidthsP("15,15,15,15,40")
			mygrid.setColAlign("center,center,left,center,left")
			mygrid.setColTypes("ro,ro,ro,ro,ro");
			mygrid.setColSorting("str,date,str,date,str")
			mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
			mygrid.enableBuffering(1000);
			mygrid.init();
			mygrid.loadXML("ezAcceptedOrdersXML.jsp?RefDocType=P&FromDate="+fromDate+"&ToDate="+toDate);			
		}

		function doOnUnLoad()
		{
			if (mygrid) 
				mygrid=mygrid.destructor();
		}
		
	</Script>
	
</head>
<body onLoad="getDefaultsFromTo();doOnLoad();" onUnLoad="doOnUnLoad();" scroll=no >
<form name="SOForm" method="post">
<input type="hidden" name="Back">
<input type="hidden" name="status">
<input type="hidden" name="pageUrl">
<input type="hidden" name="SONumber">
<input type="hidden" name="SoldTo">
<input type="hidden" name="PODATE">
<input type="hidden" name="netValue">
<input type="hidden" name="orderType" value="Open">
<input type="hidden" name="onceSubmit" value=0>

<%
	String display_header = accepSaleOrdLi_L;
	String noDataStatement= "No Accepted Orders to list";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%	
	if(custcount >1)
	{
%>		<Table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
		<Tr align="center">
			<Th class="displayheader">Select Stockist(s)</th>
			<Td class="displayheader">
				<div id="ListBoxDiv1">
				<select name="customer" size="3" multiple>
<%
				for(int i=0;i<custcount;i++)
				{
					String selected1="";
					String erpCode = retCustList.getFieldValueString(i,"EC_ERP_CUST_NO");
					if(customer != null)
					{
						for(int j=0;j<customer.length;j++)
						{
							if(customer[j].equals(erpCode))
							{
								selected1="selected";
								break;
							}
						}
					}
					out.println("<option value='"+erpCode+"'" +selected1+">"+retCustList.getFieldValueString(i,"ECA_NAME")+"</option>");
				}
%>
				</select>
				</div>
			</Td>
			<Td>
<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				buttonName.add("Go");
				buttonMethod.add("funSubmit()");
				out.println(getButtonStr(buttonName,buttonMethod));
%>
			</Td>
		 </Tr>
		</Table>
<%	}
	else if(custcount == 1)
	{
		out.println("<input type=hidden name=customer value="+retCustList.getFieldValueString(0,"EC_ERP_CUST_NO")+" >");
	}

%>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<Tr align="center">
		<Th>From Date</Th>
		<Td><input type="hidden"  name="DatesFlag" value="DATES">
	        	<input type=text name="FromDate" class=InputBox value="<%=fd%>"  size=12 maxlength="10" readonly><%=getDateImage("FromDate")%></Td>
		<Th>To Date</Th>
		<Td>
			<input type=text name="ToDate" class=InputBox value="<%=td%>"  size=12 maxlength="10" readonly><%=getDateImage("ToDate")%></Td>
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

<%@ include file="../Misc/ezDisplayGrid.jsp"%>

<Div id="buttonDiv"  align="center" style="position:absolute;top:90%;width:100%">
<%	
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		buttonMethod.add("movetoHome()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
</Div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
