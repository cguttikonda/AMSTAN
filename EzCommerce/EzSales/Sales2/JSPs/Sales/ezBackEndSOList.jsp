<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iBlockControl.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Lables/iBackEndSOList_Lables.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
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
	String fd 	= request.getParameter("FromDate");
	String td 	= request.getParameter("ToDate");
	String forkey 	= (String)session.getValue("formatKey");
	String browser = (String)session.getValue("BROWSER");
	String allignLeft="2%";
	if(browser!=null && ! ("Microsoft Internet Explorer".equals(browser))) 
		allignLeft="40%";	
	
	if(forkey==null) forkey ="/"; 
%>

<% 
	ezc.ezparam.ReturnObjFromRetrieve retobj = null;
	String[] customer 	= request.getParameterValues("customer");
	String[] customerDate 	= request.getParameterValues("customerDate");
	ReturnObjFromRetrieve retCustList = new ReturnObjFromRetrieve();
	String agentCode	=(String)session.getValue("AgentCode");

	String user		= Session.getUserId();
	String salesAreaCode	= (String)session.getValue("SalesAreaCode");
	
	
	int selCustCount = 0;
	String selCustStr = "";
	
	if(customer!=null){
		selCustCount = customer.length;
		
		for(int i=0;i<selCustCount;i++)
		{
			if(i==0)
				selCustStr = customer[i];
			else
			{
				selCustStr = selCustStr+"','"+customer[i];
			}
		}
	}
	
	if(customer == null){
		if(session.getValue("customers") != null){
			log4j.log("in ezBackEndSOList.jsp:customercustomercustomer22222::","W");
			customer=(String[])session.getValue("customers");
			selCustCount = customer.length;
		}else{
			if(agentCode.indexOf(",")==-1){
				log4j.log("in ezBackEndSOList.jsp:agentcode now::","W");
				customer=new String[1];
				customer[0]=agentCode;
			}
		}
	}else{
		log4j.log("in ezBackEndSOList.jsp:customer is not null::","W");
		session.putValue("customers",customer);
	}	
	
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
				alert("From date must be less than To date");
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
				}
				document.SOForm.custVal.value = custStr;					
							
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
		
		function funShowDetails(SONumber,FromDate,ToDate,SoldTo,status,pageUrl,PODATE,orderType,netValue)
		{
			document.SOForm.SONumber.value = SONumber;
			document.SOForm.FromDate.value = FromDate;
			document.SOForm.ToDate.value =  ToDate;
			document.SOForm.SoldTo.value =  SoldTo;
			document.SOForm.status.value = status;
			document.SOForm.pageUrl.value =  pageUrl;
			document.SOForm.PODATE.value =  PODATE;
			document.SOForm.orderType.value = orderType;
			document.SOForm.netValue.value = netValue;
			document.SOForm.action="ezBackWaitSalesDisplay.jsp";
			document.SOForm.submit();
					
		}
		

</Script>

	<link rel="STYLESHEET" type="text/css" href="../../Library/Styles/dhtmlXGrid.css"> 
	<Script src="../../Library/JavaScript/Grid_2.5BA/dhtmlxcommon.js"></Script>
	<Script src="../../Library/JavaScript/Grid_2.5BA/dhtmlxgrid.js"></Script>
	<Script src="../../Library/JavaScript/Grid_2.5BA/dhtmlxgridcell.js"></Script>		
	

	<Script>		
		function doOnLoad()
		{	
			if(document.SOForm.customer.selectedIndex!=-1)
			{
				var fromDate 	= document.SOForm.FromDate.value;
				var toDate 	= document.SOForm.ToDate.value;
				
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
							
						custStr = custStr.replace('&','@'); 							
						count++;	
					}	
				}
				gridDiv = document.getElementById("gridBase");
								
				if(gridDiv!=null)
				{
				<%
					String role	=(String)session.getValue("UserRole");
					if("CU".equals(role))
					{
				
				%>
					/*mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.imgURL = "../../Images/Grid/";	
					mygrid.setHeader("Sales Order No,Order Date,PO No,PO Date,Amount");
					mygrid.setNoHeader(false)
					mygrid.setInitWidthsP("20,20,20,20,20")
					mygrid.setColAlign("center,center,left,center,right")
					mygrid.setColTypes("ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,date,str,date,str")
					mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
					mygrid.enableBuffering(1000);
					mygrid.init();
					mygrid.loadXML("ezAcceptedOrdersXML.jsp?RefDocType=P&FromDate="+fromDate+"&ToDate="+toDate+"&custStr="+custStr);*/
					
				   
					
					mygrid = new dhtmlXGridObject('gridbox');
					mygrid.setImagePath("../../Images/Grid_2.5BA/");
					mygrid.setHeader("Sales Order No,Order Date,PO No,PO Date,Amount");
					mygrid.setNoHeader(false)
					mygrid.setInitWidthsP("20,20,20,20,20")
					mygrid.setColAlign("center,center,left,center,right")
					mygrid.setColTypes("ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,date,str,date,str")
					//mygrid.setColumnColor(",#D5F1FF,,,,")
					//mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
					mygrid.setSkin("dhx_black");
					//mygrid.enableBuffering(250);
					mygrid.init();
					mygrid.loadXML("ezAcceptedOrdersXML.jsp?RefDocType=P&FromDate="+fromDate+"&ToDate="+toDate+"&custStr="+custStr);				
					
					<%
					}else{
					%>
						/*mygrid = new dhtmlXGridObject('gridbox');	
						mygrid.imgURL = "../../Images/Grid/";	
						mygrid.setHeader("Sales Order No,Order Date,PO No,PO Date,Amount,Customer");
						mygrid.setNoHeader(false)
						mygrid.setInitWidthsP("15,15,15,15,15,25")
						mygrid.setColAlign("center,center,left,center,right,left")
						mygrid.setColTypes("ro,ro,ro,ro,ro,ro");
						mygrid.setColSorting("str,date,str,date,str,str")
						mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
						mygrid.enableBuffering(1000);
						mygrid.init();
						mygrid.loadXML("ezAcceptedOrdersXML.jsp?RefDocType=P&FromDate="+fromDate+"&ToDate="+toDate+"&custStr="+custStr);*/
						
						mygrid = new dhtmlXGridObject('gridbox');
						mygrid.setImagePath("../../Images/Grid_2.5BA/");
						mygrid.setHeader("Sales Order No,Order Date,PO No,PO Date,Amount,Customer");
						mygrid.setNoHeader(false)
						mygrid.setInitWidthsP("15,15,15,15,15,25")
						mygrid.setColAlign("center,center,left,center,right,left")
						mygrid.setColTypes("ro,ro,ro,ro,ro,ro");
						mygrid.setColSorting("str,date,str,date,str,str")
						//mygrid.setColumnColor(",#D5F1FF,,,,")
						mygrid.setStyle('background-Color:#227A7A;font-weight:600;',"","","")
						mygrid.setSkin("dhx_green"); 
						//mygrid.enableBuffering(250);
						mygrid.init();
						mygrid.loadXML("ezAcceptedOrdersXML.jsp?RefDocType=P&FromDate="+fromDate+"&ToDate="+toDate+"&custStr="+custStr);
						
					<%
					}
					%> 
					

				}	
				
			}	
		}

		function doOnUnLoad()
		{
			gridDiv = document.getElementById("gridBase");
				
			if(gridDiv!=null)
			{		
				if (mygrid) 
				{
					mygrid=mygrid.destructor();
				}	
			}	
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
<input type="hidden" name="custVal" >
<input type="hidden" name="AgentCode" value="<%=agentCode%>">



<input type="hidden" name="myHiddenField" value="myHiddenFieldValue">

<%
	String display_header = "Open Sales Order List";
	String noDataStatement= "No Accepted Orders to list";
	
%>
<%@ include file="../../../Includes/JSPs/Sales/iGetGroupCustomers.jsp"%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%	
	int custcount=retCustList.getRowCount();
	
	if(!"CU".equals(UserRole.trim()))
	{
		
%>		

<Div id='inputDiv' style='position:relative;align:center;width:100%;'>
<Table width="80%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
	<Tr>
		<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
		<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
		<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
	</Tr>

	<Tr>
		<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
		<Td style="background-color:'DDEEFF'" valign=middle>

		<Table align=center border=0 valign=middle width="100%" cellPadding=0 cellSpacing=0>
		<Tr align="center">
			<Th class="displayheader" >Select Customer(s)</th>
			<Td class="displayheader" >
				<div id="ListBoxDiv1">
				<select name="customer" size="3" multiple  id=listBoxDiv>
<%
				String str[]={"ECA_NAME"};
				boolean b=retCustList.sort(str,true);
				
				String selected1="",erpCode="";
				for(int i=0;i<custcount;i++)
				{
					selected1="";
					erpCode = retCustList.getFieldValueString(i,"EC_ERP_CUST_NO");
					if(customer != null)
					{
						for(int j=0;j<customer.length;j++)
						{
							if(customer[j].equals(erpCode))
							{
								log4j.log("erpCodeerpCodeerpCode111::"+erpCode+"-->"+customer[j],"W");
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
				<Th >From Date</Th>
				<Td ><input type="hidden"  name="DatesFlag" value="DATES">
					<input type=text name="FromDate" id="FromDate" class=InputBox value="<%=fd%>"  size=12 maxlength="10" readonly><%=getDateImage("FromDate")%></Td>
				<Th >To Date</Th>
				<Td >
					<input type=text name="ToDate" id="ToDate" class=InputBox value="<%=td%>"  size=12 maxlength="10" readonly><%=getDateImage("ToDate")%></Td>
			<Td >
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
		if(selCustCount==0)
		{
%>
			<br><br><br><br>
			<table  align=center border=0>
			<tr>
				<td class=displayalert align ="center" colspan ="4">Please select Customer(s), dates and click on 'GO' Button.</td>
			</tr>
			</table >
			
			
<%
		}	
	}
	else 
	{
		custcount = 1; 
		out.println("<input type=hidden name='customer' value="+retCustList.getFieldValueString(0,"EC_ERP_CUST_NO")+" >");
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

				<Table align=center border=0 valign=middle width="100%" cellPadding=0 cellSpacing=0>
				<Tr align="center">
					<Th >From Date</Th>
					<Td ><input type="hidden"  name="DatesFlag" value="DATES">
						<input type=text name="FromDate" id="FromDate" class=InputBox value="<%=fd%>"  size=12 maxlength="10" readonly><%=getDateImage("FromDate")%></Td>
					<Th >To Date</Th>
					<Td >
						<input type=text name="ToDate" id="ToDate" class=InputBox value="<%=td%>"  size=12 maxlength="10" readonly><%=getDateImage("ToDate")%>
					</Td>
					<Td >
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
		if(selCustCount==0)
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

	}
	
	log4j.log("selCustCountselCustCount::"+selCustCount,"W");
	if(selCustCount>0)
	{
		
	
		log4j.log("count is greater than 0::","W");
%>
		<Div id="gridBase">
			<Div align=center style="width:100%;">
			<br>
				<Div  id="GridBoxDiv" align=center style="background-color:whitesmoke;width:95%;border:1px solid;border-color:lightgrey;padding:2px;">
					<Div id="gridbox" height="300px" width="100%" style="overflow:hidden;visibility:hidden;"></Div>	
				</Div>		
				<Div id="dataRetrieve" width="100%" height="40px" style="overflow:hidden;visibility:visible;position:absolute;top:40%;left:<%=allignLeft%>">
					<Table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
						<Tr>
							<Td style="background:transparent" align='center'><br><b>Loading data, please wait...</b><br><br><img src="../../Images/ImagesGrid/loading.gif"/></Td>
						</Tr>
					</Table>
				</Div>   
				<Div id="NoData" width="100%" height="40px" style="overflow:hidden;visibility:hidden;position:absolute;top:40%;left:<%=allignLeft%>">
					<Table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
						<Tr>
							<Td style="background:transparent" align='center'><br><b><%=noDataStatement%></b></Td>
						</Tr>
					</Table>
				</Div> 
				<Div id="ServerBusy" width="100%" height="40px" style="overflow:hidden;visibility:hidden;position:absolute;top:35%;left:<%=allignLeft%>">
					<Table align=center height="100%" border="0" cellpadding="0" cellspacing="0" width="100%">
						<Tr>
							<Td style="background:transparent" align='right'><img border=0 src="../../Images/sbusy.gif" ></Td>
							<Td style="background:transparent" align='center'><font color="CC0000"><b>System Error.<BR> Please try again but if the error message reappears then contact us.</b></font></Td>
						</Tr>
					</Table>
				</Div> 
			</Div>
		</Div>

			<Div id="buttonDiv" align="center" style="position:absolute;top:92%;width:100%">
<%	
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			//buttonName.add("Back");
			//buttonMethod.add("movetoHome()");
			out.println(getButtonStr(buttonName,buttonMethod));
%>			
			</Div>
<%			
	}
	%>
</form>
</body>
<Div id="MenuSol"></Div>
</html>
