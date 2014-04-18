<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iBackEndSOList_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />

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
	String rem = request.getParameter("RefDocType");
	String datesFlag=request.getParameter("DatesFlag");
	ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
	String forkey = (String)session.getValue("formatKey");
	if(forkey==null) forkey ="/";

	String base = request.getParameter("FromForm");
	String fd = request.getParameter("FromDate");
	String td = request.getParameter("ToDate");
	
	String monthOpt= request.getParameter("ezMonths");
	int p = 0;
	datesFlag=( (datesFlag==null) || ("null".equals(datesFlag)))?"DATES":datesFlag;
	datesFlag=(((monthOpt==null) || ("null".equals(monthOpt))) && (!("MONTHS".equals(datesFlag))))?"DATES":"MONTHS";

	if("P".equals(rem))
	{
		if(session.getValue("customers")!= null);
			session.removeValue("customers");
	}

	String UserRole = (String)session.getValue("UserRole");
	ReturnObjFromRetrieve retCustList = new ReturnObjFromRetrieve();
	String salesAreaCode=(String)session.getValue("SalesAreaCode");
%>
<%@ include file="../../../Includes/JSPs/Sales/iGetGroupCustomers.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iGetProductGroups.jsp"%>
<%

int custcount=retCustList.getRowCount();
String agentCode=(String)session.getValue("AgentCode");
String[] customer=request.getParameterValues("customer");
String[] customerDate =request.getParameterValues("customerDate");
if(customer == null){
	if(session.getValue("customers") != null){
		customer=(String[])session.getValue("customers");
	}else{
		if(agentCode.indexOf(",")==-1){
			customer=new String[1];
			customer[0]=agentCode;
		}
	}
}else{
	session.putValue("customers",customer);
}
	int customerLen = 0;
	if(customer!=null)
		customerLen = customer.length; 

//added by kp for two between date
if(customerDate == null){
	if(session.getValue("customersdate") != null){
		customerDate=(String[])session.getValue("customersdate");
	}else{
		if(agentCode.indexOf(",")==-1){
			customerDate=new String[1];
			customerDate[0]=agentCode;
		}
	}
}else{
	session.putValue("customersdate",customerDate);
}
//Finished
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
				//alert(document.SOForm.FromDate.value)
				document.SOForm.submit();
			}else{
				alert("Please Select the months");
			}
		}
		function selMonthVal()
		{
			<%if("MONTHS".equals(datesFlag)){%>
				for(p=0;p<document.SOForm.ezMonths.options.length;p++){
					if(document.SOForm.ezMonths.options[p].value=="<%=monthOpt%>"){
						document.SOForm.ezMonths.selectedIndex=p;
						break;
					}
				}
			<%}%>
		}
		

</Script>
	<link rel="STYLESHEET" type="text/css" href="../../Library/Styles/dhtmlXGrid.css">
	<Script src="../../Library/JavaScript/Grid/dhtmlXCommon.js"></Script>
	<script src="../../Library/JavaScript/Grid/dhtmlXGrid.js"></script>		
	<script src="../../Library/JavaScript/Grid/dhtmlXGridCell.js"></script>
	

	<Script>		
		function doOnLoad()
		{			
			
<%
			if(base!=null && !"null".equals(base) && !"".equals(base))
			{
%>	
		
			var myVal;
			var custVal;
			if(document.SOForm.ezMonths!=null)
			{								
				myVal=document.SOForm.ezMonths.options[document.SOForm.ezMonths.selectedIndex].value
			}
			if(document.SOForm.customer==undefined)
			{								
				custVal="";
			}
			else
			{
				if(document.SOForm.customer!=null)
				{
					/*custVal=document.SOForm.customer.options[document.SOForm.customer.selectedIndex].value
					
					
					var len 	= document.SOForm.customer.length;
					var custStr	= '';
					var count	= 0;
				
					for(i=0;i<len;i++)
					{
						if(document.SOForm.customer.options[i].selected)
						{
							if(count==0)
								custStr	= document.SOForm.customer.options[i].value;
							else	
								custStr	= custStr+','+document.SOForm.customer.options[i].value
							count++;	
						}	
					}*/
				}	
			}
				
			
			
			var fromDate = document.SOForm.FromDate.value;
			var toDate = document.SOForm.ToDate.value;
			
			mygrid = new dhtmlXGridObject('gridbox');			
			mygrid.imgURL = "../../Images/Grid/";
			
			<%
			String role	=(String)session.getValue("UserRole");
			if("CU".equals(role))
			{
							
			%>
			mygrid.setHeader("Contract No,Contract Date,PO No,PO Date,Amount");
			mygrid.setNoHeader(false)
			mygrid.setInitWidthsP("20,20,20,20,20")
			mygrid.setColAlign("center,center,left,center,right")
			mygrid.setColTypes("ro,ro,ro,ro,ro");
			mygrid.setColSorting("str,date,str,date,str")
			<%
			}else{
			%>
			mygrid.setHeader("Contract No,Contract Date,PO No,PO Date,Amount,Customer");
			mygrid.setNoHeader(false)
			mygrid.setInitWidthsP("15,15,15,15,15,25")
			mygrid.setColAlign("center,center,left,center,right,left")
			mygrid.setColTypes("ro,ro,ro,ro,ro,ro");
			mygrid.setColSorting("str,date,str,date,str,str")
			
			<%
			}
			%>
			mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
			mygrid.enableBuffering(250);
			mygrid.init();
			
			<%if(monthOpt!=null){%>
			if(custVal=="")
			{
				mygrid.loadXML("ezContractXML.jsp?RefDocType=P&FromDate="+fromDate+"&ToDate="+toDate+"&ezMonths="+myVal);			
			}
			else
			{
				mygrid.loadXML("ezContractXML.jsp?RefDocType=P&FromDate="+fromDate+"&ToDate="+toDate+"&customer="+custVal+"&ezMonths="+myVal+"&custStr="+custStr);			
			}
			<%}else{%>
			if(custVal=="")
			{
				mygrid.loadXML("ezContractXML.jsp?RefDocType=P&FromDate="+fromDate+"&ToDate="+toDate);	
			}
			else
			{
				mygrid.loadXML("ezContractXML.jsp?RefDocType=P&FromDate="+fromDate+"&ToDate="+toDate+"&customer=C6100&custStr=C6100");	
			}
			
			<%}%>
<%}%>			
			
		}

		function doOnUnLoad()
		{
			if (mygrid) 
				mygrid=mygrid.destructor();
		}
		
	</Script>
	
</head>
<%@ include file="../../../Includes/JSPs/Sales/iBackEndClosedSOList.jsp"%>

<body onLoad="getDefaultsFromTo();selMonthVal();doOnLoad();" scroll=no >
<form name="SOForm" method="post">
<input type="hidden" name="Back">
<input type="hidden" name="pageUrl">
<input type="hidden" name="status">
<input type="hidden" name="SONumber">
<input type="hidden" name="SoldTo">
<input type="hidden" name="PODATE">
<input type="hidden" name="netValue">
<input type=hidden name=orderType value="Open">
<input type="hidden" name="FromForm" value="ClosedOrderList">
<%
	String display_header = "Contracts List";
	String noDataStatement= "No Contracts to list";

%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
	
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<Tr align="center">
<%
if(custcount >1){
%>
	<Th class="displayheader">Select Customer(s)</th>
	<Td class="displayheader">
			<select name="customer" size="3" multiple id=listBoxDiv>
<%
			String str[]={"ECA_NAME"};
			boolean b=retCustList.sort(str,true);

			for(int i=0;i<custcount;i++)
			{
				String selected1="";
				String erpCode = retCustList.getFieldValueString(i,"EC_ERP_CUST_NO");
				if(customer != null){
					for(int j=0;j<customer.length;j++){
						if(customer[j].equals(erpCode)){
							selected1="selected";
							break;
						}
					}
				}
%>
				<option value='<%=erpCode%>' <%=selected1%>><%=retCustList.getFieldValueString(i,"ECA_NAME")%></option>
<%
			}
%>			</select>

	</Td>

<%
}else{
	if(custcount == 1)
	{
%>
		<input type=hidden name=customer value="<%=retCustList.getFieldValueString(0,"EC_ERP_CUST_NO")%>" >
<%
	}
}
if(fd==null || "null".equals(fd) || td==null || "null".equals(td)){
	fd="";
	td="";
}

String selectLable="";
if("MONTHS".equals(datesFlag)){
	selectLable = "Please Select Month(s).Click on Go.";
%>
	<Th><%= selMonths_L %></Th>
	<Td><input type="hidden"  name="DatesFlag" value="MONTHS">
	<input type=hidden name="FromDate" value="<%=fd%>">
	<input type=hidden name="ToDate" value="<%=td%>">

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
<%
}else{
	if("DATES".equals(datesFlag)){
	selectLable="Please Select Dates(s).Click on Go.";
%>
		<Th><%= fromDate_L %></Th>
		<Td><input type="hidden"  name="DatesFlag" value="DATES">
	        	<input type=text name="FromDate" class=InputBox value="<%=fd%>"  size=12 maxlength="10" readonly><%=getDateImage("FromDate")%>
		</Td>
		<Th><%= toDate_L %></Th>
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
<%
	}
}
%>
</Tr>
</Table>
<%
	if(base==null || "null".equals(base))
	{
%>
		<br><br><br><br>
		<table  align=center border=0>
		<tr>
			<td class=displayalert align ="center" colspan ="4">Please select dates and click on 'GO' Button.</td>
		</tr>
		</table >
<%
	}	
%>		
<%if(base!=null && !"null".equals(base) && !"".equals(base))
{
%>
<%@ include file="../Misc/ezDisplayGrid.jsp"%>
<%}%>
<Div id="buttonDiv"  align="center" style="position:absolute;top:92%;width:100%">
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
