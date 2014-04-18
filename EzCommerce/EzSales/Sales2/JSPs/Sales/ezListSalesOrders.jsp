<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iListSalesOrder_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>

<Script>
	  var tabHeadWidth=85
	  var tabHeight="45%"
</Script>
<%

	String browser = (String)session.getValue("BROWSER");
	String allignLeft="2%";
	if(browser!=null && ! ("Microsoft Internet Explorer".equals(browser)))
		allignLeft="44%";	

	String fd = request.getParameter("FromDate");
	String td = request.getParameter("ToDate");
	String forkey = (String)session.getValue("formatKey");
	if(forkey==null) forkey ="/";
	
	String orderStatus=request.getParameter("orderStatus");
	String orderByMaterial=request.getParameter("orderByMaterial");
	String newFilter=request.getParameter("newFilter");
	String searchType=request.getParameter("SearchType");
	String refDocType = request.getParameter("RefDocType");
	String horderStatus = orderStatus;
%>
<html>
<head>
	<Title>List of Sales Orders-Powered by EzCommerce Inc</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%> 
	<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="60%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script> 
	<script>
		var selIds;
		function selStatus()
		{

			for(i=0;i<document.statusForm.orderStatus.options.length;i++)
			{
				if(document.statusForm.orderStatus.options[i].value.toUpperCase()=="<%=orderStatus.toUpperCase()%>")
				{	document.statusForm.orderStatus.selectedIndex=i;
					break;
				}
			}
		}

		function fun1()
		{
			document.body.style.cursor="wait"
			document.SOForm.submit();
		}
		function callConfirm()
		{
			document.body.style.cursor="wait"
			document.SOForm.action="../Sales/ezCreditDSS.jsp";
			document.SOForm.submit();
		}

		var status=null;
		var orderType=null;
		function setBack()
		{
			//document.location.href="../Misc/ezWelcome.jsp";
			document.SOForm.action="../SelfService/ezQuickSearch.jsp";
			document.SOForm.submit();			
			
		}
		
		function setWelcome()
		{
			
			document.SOForm.action="../Misc/ezWelcome.jsp";
			document.SOForm.submit();			
					
		}

		function chkDelSumbit(obj)
		{
			
				
			var chkbox = selIds.length;
			
			
			chkCount=0
			if(isNaN(chkbox))
			{				
				chkCount++;				
			}
			else
			{
				for(a=0;a<chkbox;a++)
				{
					chkCount++;						
				}
			}
			
			if(chkCount == 0)
			{
				if(obj=="Edit")
				{
					alert("<%=plzChkOrderEdit_A%>");
				}else
				{
					alert("<%=plzChkOrderDel_A%>");
				}
				return false;
			}else if(chkCount > 1)
			{
				if(obj=="Edit")
				{
					alert("Please check only one order to Edit");
					return false;
				}
			}


			return true;
		}

		function ezOrderDel()
		{

			if(chkDelSumbit("Del"))
			{
				 document.SOForm.onceSubmit.value=1
				 document.body.style.cursor="wait"
				 document.SOForm.action="ezEditSales.jsp"
				 document.SOForm.submit();
                                 
			}
		}

		function ezOrderEdit(type)
		{
			if(chkDelSumbit("Edit"))
			{
				var chkbox = selIds.length;
				// document.SOForm.chk2.value = selIds[0];
				
				if(chkbox>0)
				{
					
					for(a=0;a<chkbox;a++)
					{
						aa1=selIds[0].split(",");
						funShowEdit(aa1[0],aa1[1],aa1[2])
						
					}
				
				}	

			}

		}
//********************************************************************




		function funShowEdit(webOrNo,soldTo,sysKey)
		{
			
  			 document.body.style.cursor="wait"
			 document.SOForm.webOrNo.value=webOrNo
			 document.SOForm.soldTo.value=soldTo
			 document.SOForm.sysKey.value=sysKey
			 document.SOForm.pageUrl.value="EditOrder"
			 //document.SOForm.target = "_parent"
			 document.SOForm.action="ezEditSales.jsp" ;
			 document.body.style.cursor="wait"
			 document.SOForm.submit();

		}
		function checkBrowser()
		{
			var browserName=navigator.appName;
			if(browserName!="")
			{
				document.SOForm.checkBrow.value=browserName
			}	

		}				
				
		function prepareOrder(typetemp)
		{
			var gridCount = mygrid.getRowsNum();
			var selectedIds = "";
			for(var i=0;i<gridCount;i++)
			{
				if(mygrid.cells(mygrid.getRowId(i),'0').isChecked())	
				{
					if(selectedIds!="")
						selectedIds = selectedIds+"#"+mygrid.getRowId(i);				
					else
						selectedIds = mygrid.getRowId(i);				
				}		
			}	
			document.SOForm.chk2.value=selectedIds
			if(selectedIds!="")
			{
				selIds = selectedIds.split("#");
				if(typetemp=="NEW")
					ezOrderEdit("NEW")
				else
					ezOrderDel()
			}	
			else
				alert("Please select one order")
							
		}
		
		function funShowDetails(webOrNo,soldTo,sysKey)
		{			
			 document.body.style.cursor="wait"
			 document.SOForm.webOrNo.value=webOrNo
			 document.SOForm.soldTo.value=soldTo
			 document.SOForm.sysKey.value=sysKey
			 document.SOForm.action="ezShowDetails.jsp" ;
			 document.body.style.cursor="wait"
			 document.SOForm.submit();		
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
			mygrid = new dhtmlXGridObject('gridbox');			
			mygrid.setImagePath("../../Images/Grid_2.5BA/");	
			var sType = '<%=searchType%>'
			if(sType == "null")
			{
				/*mygrid.setHeader("&nbsp,Web Order No,Web Order Date,PO No,Created By,Customer");
				mygrid.setNoHeader(false)
				mygrid.setInitWidthsP("5,15,15,15,15,35")
				mygrid.setColAlign("center,center,center,left,left,center")
				mygrid.setColTypes("ch,ro,ro,ro,ro,ro");
				mygrid.setColSorting("str,str,date,str,str,str")*/
				
				
				mygrid.setHeader("&nbsp,Web Order No,Web Order Date,PO No,Created By,Customer");
				mygrid.setNoHeader(false)
				mygrid.setInitWidthsP("5,15,15,15,15,35")
				mygrid.setColAlign("center,center,center,left,left,center")
				mygrid.setColTypes("ch,ro,ro,ro,ro,ro");
				mygrid.setColSorting("str,str,date,str,str,str")
				mygrid.setSkin("dhx_skyblue");
				
				
			}				
			else
			{
				/*mygrid.setHeader("Web Order No,Web Order Date,Po No,Created By,SAP Order No,Status");
				mygrid.setNoHeader(false)
				mygrid.setInitWidthsP("15,15,15,15,15,25")
				mygrid.setColAlign("center,center,left,left,center,center")
				mygrid.setColTypes("ro,ro,ro,ro,ro,ro");
				mygrid.setColSorting("str,str,str,str,str,str")*/
				
				mygrid.setHeader("Sales Order No,Order Date,Po No,Created By,Status");
				mygrid.setNoHeader(false)
				mygrid.setInitWidthsP("20,20,20,20,20")
				mygrid.setColAlign("center,center,left,left,center")
				mygrid.setColTypes("ro,ro,ro,ro,ro");
				mygrid.setColSorting("str,str,str,str,str")
				mygrid.setSkin("dhx_skyblue");				

			}

			mygrid.setStyle('background-Color:#227A7A;font-weight:600;',"","","")
			//mygrid.enableBuffering(250);
			mygrid.init();	      	
			mygrid.loadXML("ezSavedOrdersXML.jsp?orderStatus=<%=orderStatus%>&RefDocType=<%=refDocType%>&SearchType=<%=searchType%>&searchPatern=<%=request.getParameter("searchPatern")%>&sortOn=<%=request.getParameter("sortOn")%>&sortOrder=<%=request.getParameter("sortOrder")%>&newFilter=<%=newFilter%>"); 

		}

		function doOnUnLoad()
		{
			if (mygrid) 
				mygrid=mygrid.destructor();  
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
	</head>

<%
if(searchType ==null || "null".equals(searchType))
{
	
%>
<body onLoad="doOnLoad();getDefaultsFromTo();" onUnLoad="doOnUnLoad();" scroll=no>
<%}%>

<body onLoad="doOnLoad();checkBrowser()" onUnLoad="doOnUnLoad();" scroll=no>

<form name=SOForm method="post" action="../Sales/ezListSalesOrders.jsp">
<input type=hidden name="newFilter"  value="<%=newFilter%>">
<input type="hidden" name="SONumber" >
<input type="hidden" name="soldTo" >
<input type="hidden" name="poDate" >
<input type="hidden" name="sysKey" >
<input type="hidden" name="Back">
<input type="hidden" name="srType" value='<%=request.getParameter("srType")%>'>
<input type="hidden" name ="chk2">
<input type="hidden" name ="SearchType" value="<%=request.getParameter("SearchType")%>">
<input type="hidden" name ="searchPatern" value="<%=request.getParameter("searchPatern")%>">
<input type="hidden" name ="sortOn" value="<%=request.getParameter("sortOn")%>">
<input type="hidden" name ="sortOrder" value="<%=request.getParameter("sortOrder")%>">
<input type="hidden" name ="RefDocType" value="P">
<input type="hidden" name="onceSubmit" value=0>

<%
String nData = "";
String display_header ="";

	
if(searchType==null || "null".equals(searchType))
{
	display_header ="Saved &nbsp;"+salordli_L;                    
	nData = "No Saved Orders To List";
	
}	
else
{
	display_header = salordli_L;
	nData = "No Sales Orders To List";
}	
%>
<%@ include file="../../../Sales2/JSPs/Misc/ezDisplayHeader.jsp"%>


<%
if(searchType ==null || "null".equals(searchType))
{
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
<%}%>
<br><br>
<Div id="gridBase" align=center style="width:100%;">
				<Div  id="GridBoxDiv" align=center style="background-color:whitesmoke;width:80%;border:1px solid;border-color:lightgrey;padding:2px;">
					<Div id="gridbox" height="300px" width="100%" style="overflow:hidden;visibility:hidden;"></Div>	
				</Div>		
				<Div id="dataRetrieve" width="100%" height="40px" style="overflow:hidden;visibility:visible;position:absolute;top:40%;left:<%=allignLeft%>">
					<Table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
						<Tr>
							<Td style="background:transparent" align='center'><br><b>Loading data, please wait...</b><br><br><img src="../../Images/ImagesGrid/loading.gif"/></Td>
						</Tr>
					</Table>
				</Div> 
				<Div id="NoData" width="100%" height="40px" style="overflow:hidden;visibility:hidden;position:absolute;top:30%;left:<%=allignLeft%>">
					<Table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
						<Tr>
							<Td style="background:transparent" align='center'><br><b><%=nData%></b></Td>
						</Tr>
					</Table>
				</Div> 
				<Div id="ServerBusy" width="100%" height="40px" style="overflow:hidden;visibility:hidden;position:absolute;top:35%;left:<%=allignLeft%>">
					<Table align=center height="100%" border="0" cellpadding="0" cellspacing="0" width="100%">
						<Tr>
							<Td style="background:transparent" align='right'><img border=0 src="../../Images/sbusy.gif" ></Td>
							<Td style="background:transparent" align='center'><font color="CC0000"><b>Server is Busy,Please try after some time</b></font></Td>
						</Tr>
					</Table>
				</Div> 
			</Div>
			
<div id="buttonDiv" align=center style="position:absolute;left:0%;width:100%;top:92%">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	//out.println("searchType  "+searchType);
	if(searchType==null || "null".equals(searchType))
	{
		buttonName.add("Edit");
		buttonMethod.add("prepareOrder(\"NEW\");");
		buttonName.add("Delete");
		buttonMethod.add("prepareOrder(\" \")");
		buttonName.add("Back");
		buttonMethod.add("history.back()");
	}
	/*else if("'RETNEW'".toUpperCase().equals(orderStatus.toUpperCase()) && retobj.getRowCount() >0)
	{
		buttonName.add("Edit");
		buttonMethod.add("ezOrderEdit(\"RET\")");
		buttonName.add("Delete");
		buttonMethod.add("prepareOrder(\"DEL\")");
		
	}*/
	else if(searchType!=null || !"null".equals(searchType))
	{
		String wel = request.getParameter("welcome");
		if(wel!=null && !"null".equals(wel) && "Y".equals(wel))
		{
			buttonName.add("Back");
			buttonMethod.add("setWelcome()");		
		}
		else
		{
			buttonName.add("Back");
			buttonMethod.add("setBack()");
		}
		
	}
	
	
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
	<input type="hidden" name="welcome" value="<%=request.getParameter("welcome")%>">
	<input type="hidden" name="SearchType" value="<%=searchType%>">
	<input type="hidden" name="ordType" value="<%=orderStatus%>">
	<input type="hidden" name="horderStatus" value="<%=horderStatus%>">
	<input type="hidden" name="refDocType" value="<%=refDocType%>">
	<input type="hidden" name="webOrNo" >
	<input type="hidden" name="pageUrl">

</form>
<form name=statusForm method="post" action="ezListSalesOrders.jsp">
	<input type="hidden" name="refDocType" value="<%=refDocType%>">
	<Div id="MenuSol"></Div>
</form>
</body>
</html>
