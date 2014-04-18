<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%
	String fromDate	=	request.getParameter("FromDate");
	String toDate	=	request.getParameter("ToDate");
	//String dcno 		= request.getParameter("DCNO");
	String PurchaseOrder 	= request.getParameter("PurchaseOrder");
	boolean isShowDates = true;
%>
<%@ include file="../../../Includes/JSPs/Purorder/iListPO.jsp"%>
<%
	
	String orderTypes	= request.getParameter("OrderType");
	NumberFormat nf=null;
	int rowCount=0;
	boolean isDisplay = false;
	
	FormatDate fD=new FormatDate();
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	ezc.ezbasicutil.EzSearchReturn mySearch= new ezc.ezbasicutil.EzSearchReturn();
	ezc.ezcommon.EzLog4j.log("++POSearch++"+POSearch,"I");
	
	if(!("null".equals(POSearch) || POSearch==null)){
	ezc.ezcommon.EzLog4j.log("++POSearch++"+POSearch,"I");
		String poToSearch=request.getParameter("PurchaseOrder");
		mySearch.searchLong(hdrXML,"ORDER",poToSearch);

	}
	if(orderType == null || "null".equals(orderType)) 
		orderType="";
		ezc.ezcommon.EzLog4j.log("++++"+hdrXML.getRowCount(),"I");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
<script src="../../Library/JavaScript/ezConvertDates.js"></script>

	<script>

	function toggle(source)
	{ 
	    checkboxes = document.getElementsByName('chk1'); 
	    for(i=0;i<checkboxes.length;i++)
	    checkboxes[i].checked = source.checked;
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
	function getDefaultsFromTo(){
	
	<%
			if(isShowDates){
			if(fromDate!= null && toDate != null && !("null").equals(fromDate) && !("null").equals(toDate)){
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
				//alert(ConvertDateFormat(today+'.'+thismonth+'.'+thisyear,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>','<%=(String)session.getValue("DATESEPERATOR")%>'))
<%
	
			}
			}	
%>
	}
	function ezSubmit(){
			document.myForm.action = "ezListPOs.jsp";
			document.myForm.submit();
		}

	</script>
	<%@include file="../Misc/ezDataTableScript.jsp"%>
</head>
<body id="dt_example" scroll=no onLoad="getDefaultsFromTo()">
<form name="myForm">	
<input type="hidden" name="OrderType" value="<%=orderTypes%>">
<%
	String display_header = "";
	if("Open".equals(orderTypes))
	{
		display_header = "Open Purchase Orders";
	}
	else if("Closed".equals(orderTypes))
	{
		display_header = "Closed Purchase Orders";
	}
	else 
	{
		display_header = "All Purchase Orders";
	}
%>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<%
	String clickString = "onclick='ezSubmit()'";
	if(isShowDates){
%>

		<%@ include file="../Misc/ezSelectDate.jsp"%>		
<%
	}
%>

	<div id="container">	
	<div id="demo">
	<table class="display" id="example">
	<thead>
<%
	
		if(orderType.equals("Open"))
		{
%>
			<tr>
				<th><input type="checkbox" name="checkAll"  onClick="javascript :toggle(this)"></th>
				<th>PO Number</th>
				<th>Order Date</th>
				<th>Delivery Date</th>
				<th>Due Date</th>
				<th>Ship Date</th>
				<th>Currency</th>
				<th>Value</th>
			</tr>
<%	
		}
		else
		{
%>
			<tr>
				<th><input type="checkbox" name="checkAll"  onClick="javascript :toggle(this)"></th>
				<th>PO Number</th>
				<th>Order Date</th>
				<th>Delivery Date</th>
				<th>Due Date</th>
				<th>Ship Date</th>
				<th>Currency</th>
				<th>Value</th>
			</tr>
<%
		}
%>
	</thead>
	<tbody>
<%
		String chkLink 	= "";
		String hypLink 	= "";
		String poNumber = "";
		String ordDate	= "";
		String earlyDate= "";
		String shipdate = "";
		String latDate	= "";
		String curr 	= "";
		String val   	= "";
		String status   ="";
		String netAmount = "";
		if(hdrxmlCnt>0){ 
			
			String[] sortKey = {ORDER};
			hdrXML.sort( sortKey, false );//false for descending	
			java.math.BigDecimal totValue=new java.math.BigDecimal("0");
		int hdrCount=hdrXML.getRowCount();
		for(int i=0; i< hdrCount; i++)
		{
			poNumber = hdrXML.getFieldValueString(i, ORDER);
			isDisplay = false;
			chkLink = "";
			netAmount = hdrXML.getFieldValueString(i,"NETAMOUNT");
			
			if (netAmount==null)
				netAmount = new String("0");
			else
				netAmount = (Double.parseDouble(netAmount)*100.0)+"";
			
			if(orderType.equals("CDate") && v.contains(poNumber))
			{
				rowCount = rowCount+1;
				isDisplay=true;
				
				hypLink = "<a href=JavaScript:funLinkNew('ezAddComittedDate.jsp','"+poNumber+"','"+netAmount+"','"+hdrXML.getFieldValueString(i,"CURRENCY")+"','"+orderType+"','"+sysKey+"','"+soldTo+"')>"+Long.parseLong(poNumber)+"</a>";
				
			}
			else if(orderType.equals("Open") && !v.contains(poNumber))
			{
				rowCount = rowCount+1;
				isDisplay=true;
				if(orderType.equals("Open") && !userType.equals("3"))
				{
					if(blockedPOs.containsKey(poNumber))
					{
						status =(String)blockedPOs.get(poNumber);
						if(!status.equals("B"))
						{   	
							chkLink = poNumber+"#"+status;
						}
					}
					else
					{
						chkLink = poNumber+"#-";
					}
				}

			        hypLink = "<a href=JavaScript:funLinkNew('ezOpenPoLineitems.jsp','"+poNumber+"','"+netAmount+"','"+hdrXML.getFieldValueString(i,"CURRENCY")+"','"+orderType+"')>"+Long.parseLong(poNumber)+"</a>";
			}
			else if(orderType.equals("Closed"))
			{
				rowCount = rowCount+1;
				isDisplay=true;
				
				hypLink = "<a href=JavaScript:funLinkNew('ezPoLineitems.jsp','"+poNumber+"','"+netAmount+"','"+hdrXML.getFieldValueString(i,"CURRENCY")+"','"+orderType+"')>"+Long.parseLong(poNumber)+"</a>";
			}
			else if(orderType.equals("All") && !v.contains(poNumber))
			{
				rowCount = rowCount+1;
				isDisplay=true;
				
				hypLink = "<a href=JavaScript:funLinkNew('ezPoLineitems.jsp','"+poNumber+"','"+netAmount+"','"+hdrXML.getFieldValueString(i,"CURRENCY")+"','"+orderType+"')>"+Long.parseLong(poNumber)+"</a>";

			}
			else if ((orderType==null)||(orderType.trim().length()==0))
			{
				rowCount = rowCount+1;
				isDisplay=true;
				
				hypLink = "<a href=JavaScript:funLinkNew('ezPoLineitems.jsp','"+poNumber+"','"+netAmount+"','"+hdrXML.getFieldValueString(i,"CURRENCY")+"','"+orderType+"')>"+Long.parseLong(poNumber)+"</a>";
			}
			if(isDisplay)
			{
					ordDate	 = fD.getStringFromDate((java.util.Date)hdrXML.getFieldValue(i, ORDERDATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					earlyDate = fD.getStringFromDate((java.util.Date)hdrXML.getFieldValue(i,DELIVERYDATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					latDate	 = fD.getStringFromDate((java.util.Date)hdrXML.getFieldValue(i,"CONFIRMDELIVERYDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));		
					shipdate = fD.getStringFromDate((java.util.Date)hdrXML.getFieldValue(i,"SHIPDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					curr 	 = hdrXML.getFieldValueString(i,"CURRENCY");
					if(shipdate==null || "null".equals(shipdate))
						shipdate = "";
					val   	 = myFormat.getCurrencyString(netAmount);
					try{
						totValue=totValue.add(new java.math.BigDecimal(netAmount));
					}
					catch(Exception e){
						//out.println(">>>"+e);
					}
					
				if("".equals(chkLink))
				{
					chkLink = poNumber+"";
					//out.println("<row id='"+chkLink+"'><cell><![CDATA[<nobr>"+hypLink+"</nobr>]]></cell><cell>"+ordDate+"</cell><cell>"+earlyDate+"</cell><cell>"+latDate+"</cell><cell>"+shipdate+"</cell><cell>"+curr+"</cell><cell>"+val+"</cell></row>");
%>
					<tr>
						<td><input type="checkbox" name="chk1"></td>
						<td><%=hypLink%></td>
						<td><%=ordDate%></td>
						<td><%=earlyDate%></td>
						<td><%=latDate%></td>
						<td><%=shipdate%></td>
						<td><%=curr%></td>
						<td><%=val%></td>
					</tr>
<%
				}
				else
				{
					String disabled = "";
					if(chkLink.endsWith("#-"))
						disabled = "disabled";
					//out.println("<row id='"+chkLink+"'><cell><![CDATA[<nobr><input type=checkbox name=chk1 value="+chkLink+" "+disabled+"></nobr>]]></cell><cell><![CDATA[<nobr>"+hypLink+"</nobr>]]></cell><cell>"+ordDate+"</cell><cell>"+earlyDate+"</cell><cell>"+latDate+"</cell><cell>"+shipdate+"</cell><cell>"+curr+"</cell><cell>"+val+"</cell></row>");		
%>
					<tr>
						<td><input type="checkbox" name="chk1"></td>
						<td><%=hypLink%></td>
						<td><%=ordDate%></td>
						<td><%=earlyDate%></td>
						<td><%=latDate%></td>
						<td><%=shipdate%></td>
						<td><%=curr%></td>
						<td><%=val%></td>
					</tr>
<%
				}
			}
		}
	}
%>
		</tbody>

	</table>
</div> 
	<div class="spacer"></div>
</div>
<Div id="MenuSol"></Div>
</form>

</body>
</html>