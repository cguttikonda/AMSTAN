<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iListSalesOrder_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>

<%
	String fd = request.getParameter("FromDate");
	String td = request.getParameter("ToDate");
	String forkey = (String)session.getValue("formatKey");
	if(forkey==null) forkey ="/";
	
	String orderStatus=request.getParameter("orderStatus");
	String searchType=request.getParameter("SearchType");
	String refDocType = request.getParameter("RefDocType");
	String UserRole		= (String)session.getValue("UserRole");
	String isSubUser = (String)session.getValue("IsSubUser");
	
	String browser = (String)session.getValue("BROWSER");
	String allignLeft="2%";
	if(browser!=null && ! ("Microsoft Internet Explorer".equals(browser)))
		allignLeft="40%"; 	
%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="60%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	<Script>
		var selIds;

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
				if(typetemp=="NEW" || typetemp=="NEGOTIATED")
					ezOrderEdit("NEW")
				else
					ezOrderDel()
			}	
			else
				alert("Please select atleast one Order")							
		}
		
		function ezOrderDel()
		{
			if(chkDelSumbit("Del"))
			{
				if(confirm("Are you sure you want to delete the Order(s) permanently. "))
				{
					if(document.SOForm.onceSubmit.value!=1)
					{
						document.SOForm.onceSubmit.value=1
						document.body.style.cursor="wait"
						document.SOForm.action="../Sales/ezDeleteSalesPer.jsp" 
						document.SOForm.submit();
				       	}
				}
			}
		}
		function ezOrderEdit(type)
		{
			if(chkDelSumbit("Edit"))
			{
				var chkbox = selIds.length;
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

		function funShowEdit(webOrNo,soldTo,sysKey)
		{			
  			 document.body.style.cursor="wait"
			 document.SOForm.webOrNo.value=webOrNo
			 document.SOForm.soldTo.value=soldTo
			 document.SOForm.sysKey.value=sysKey
			 document.SOForm.action="ezEditSaveOrder.jsp";
			 document.body.style.cursor="wait"
			 document.SOForm.submit();		
		}
		
		function getDefaultsFromTo()
			{
		<%		if(fd != null && td != null && !"null".equals(fd) && !"".equals(fd) )
				{
		%>			document.SOForm.ToDate.value   = "<%=td%>"
					document.SOForm.FromDate.value = "<%=fd%>"				
		<%		}
				else
				{
		%>			toDate = new Date();
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
		<%		}
		%>	}
	
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
		/*mygrid = new dhtmlXGridObject('gridbox');			
		mygrid.imgURL = "../../Images/Grid/";	
		mygrid.setHeader("&nbsp,Web Order No,Web Order Date,PO No,Created By,Customer");
		mygrid.setNoHeader(false)
		mygrid.setInitWidthsP("5,15,15,15,15,35")
		mygrid.setColAlign("center,center,center,left,center,left")
		mygrid.setColTypes("ch,ro,ro,ro,ro,ro");
		mygrid.setColSorting("str,str,date,str,str,str")
		mygrid.setColumnColor(",#D5F1FF,,,,")
		mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
		mygrid.enableBuffering(250);
		mygrid.init();	
		//alert("ezSavedOrdersXML.jsp?orderStatus=<%=orderStatus%>&SearchType=<%=searchType%>&searchPatern=<%=request.getParameter("searchPatern")%>&sortOn=<%=request.getParameter("sortOn")%>&sortOrder=<%=request.getParameter("sortOrder")%>&FDate="+document.SOForm.FromDate.value+"&TDate="+document.SOForm.ToDate.value)
		mygrid.loadXML("ezSavedOrdersXML.jsp?orderStatus=<%=orderStatus%>&SearchType=<%=searchType%>&searchPatern=<%=request.getParameter("searchPatern")%>&sortOn=<%=request.getParameter("sortOn")%>&sortOrder=<%=request.getParameter("sortOrder")%>&FDATE="+document.SOForm.FromDate.value+"&TDATE="+document.SOForm.ToDate.value);*/
		
		
		mygrid = new dhtmlXGridObject('gridbox');
		mygrid.setImagePath("../../Images/Grid_2.5BA/");
		mygrid.setHeader("&nbsp,Web Order No,Web Order Date,PO No,Created By,Customer,ModifiedOn");
		mygrid.setNoHeader(false)
		mygrid.setInitWidthsP("5,15,15,15,15,20,15")
		mygrid.setColAlign("center,center,center,left,center,left,center")
		mygrid.setColTypes("ch,ro,ro,ro,ro,ro,ro");
		mygrid.setColSorting("str,str,date,str,str,str,date")
		//mygrid.setColumnColor(",#D5F1FF,,,,")
		//mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
		mygrid.setSkin("dhx_skyblue");
		//mygrid.enableBuffering(250);
		mygrid.init();
		mygrid.loadXML("ezSavedOrdersXML.jsp?orderStatus=<%=orderStatus%>&SearchType=<%=searchType%>&searchPatern=<%=request.getParameter("searchPatern")%>&sortOn=<%=request.getParameter("sortOn")%>&sortOrder=<%=request.getParameter("sortOrder")%>&FDATE="+document.SOForm.FromDate.value+"&TDATE="+document.SOForm.ToDate.value);		
		//document.SOForm.action="ezSavedOrdersXML.jsp?orderStatus=<%=orderStatus%>&SearchType=<%=searchType%>&searchPatern=<%=request.getParameter("searchPatern")%>&sortOn=<%=request.getParameter("sortOn")%>&sortOrder=<%=request.getParameter("sortOrder")%>&FDATE="+document.SOForm.FromDate.value+"&TDATE="+document.SOForm.ToDate.value;
		//document.SOForm.submit();
		 
	}
	function doOnUnLoad()
	{
		if (mygrid) 
			mygrid=mygrid.destructor();
	}
	
	
	function chkDates()
	{
		fd = document.SOForm.FromDate.value;
		td = document.SOForm.ToDate.value;
		if(fd=="")
		{
			alert("Please Select From Date");
			return false;
		}
		if(td=="")
		{
			alert("Please Select To Date");
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
			document.SOForm.submit();
		}
	}
	function setBack()
	{
		document.location.href="../Misc/ezWelcome.jsp";
	}
</Script>
</head>
<body onLoad="getDefaultsFromTo();doOnLoad();" onUnLoad="doOnUnLoad();" scroll=no>
<form name=SOForm method="post" action="../Sales/ezSavedOrdersList.jsp">

<input type="hidden" name="soldTo">
<input type="hidden" name="webOrNo">
<input type="hidden" name="sysKey">
<input type="hidden" name ="chk2">
<input type="hidden" name="ordType" value="<%=orderStatus%>">
<input type="hidden" name="orderStatus" value="<%=orderStatus%>">
<input type="hidden" name="onceSubmit" value=0>

<%
	String display_header = "Orders In Review";
	if("'NEW'".equals(orderStatus))
		display_header = "Saved "+salordli_L;
	String noDataStatement= "No Saved Orders to list";

%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

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
		
		<Table border="0" align="center" valign=middle width="100%" cellpadding=0 cellspacing=0 >
			<Tr align="center">
				<Th >From Date</Th>
					<Td><input type="hidden"  name="DatesFlag" value="DATES">
					<input type=text name="FromDate" id="FromDate" class=InputBox value="<%=fd%>"  size=12 maxlength="10" readonly><%=getDateImage("FromDate")%></Td>
				<Th>To Date</Th>
					<Td><input type=text name="ToDate" id="ToDate" class=InputBox value="<%=td%>"  size=12 maxlength="10" readonly><%=getDateImage("ToDate")%></Td>
					<Td>
<%
						buttonName = new java.util.ArrayList();
						buttonMethod = new java.util.ArrayList();
						buttonName.add("Go");
						buttonMethod.add("formSubmit()");
						out.println(getButtonStr(buttonName,buttonMethod));
%>				
					</Td>
			</Tr>
		</table>
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

<%@ include file="../Misc/ezDisplayGrid.jsp"%>

<div id="buttonDiv" align=center style="position:absolute;left:0%;width:100%;top:92%">		
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	
	buttonName.add("View");
	if("'NEW'".equals(orderStatus))
		buttonMethod.add("prepareOrder(\"NEW\");");
	else
		buttonMethod.add("prepareOrder(\"NEGOTIATED\");");
	if("CU".equals(UserRole.toUpperCase()) && !"Y".equals(isSubUser))
	{
		buttonName.add("Withdraw Order");
		buttonMethod.add("prepareOrder(\" \")");
	}
	//buttonName.add("Back");
	//buttonMethod.add("setBack()");
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
</form>
<Div id="MenuSol"></Div>     
</body>
</html>
