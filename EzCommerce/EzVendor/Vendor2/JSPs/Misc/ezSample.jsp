<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iMultiVendorDetails.jsp" %>
<%@ include file="../../../Includes/Lib/ezGetDateFormat.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iSbuPlantAddress.jsp"%>
<%@ include file="ezPODocTypes.jsp"%>
<%
	int dateRange = 90;
	String fromDate		= request.getParameter("FromDate");
	String toDate		= request.getParameter("ToDate");
%>
<%@ include file="../Misc/ezGetDefaultFromToDates.jsp"%>
<%@ include file="../../../Includes/Jsps/Purorder/iListPO.jsp" %>

<%
	String backFlg 		= request.getParameter("backFlg");
	String PurchaseOrder 	= request.getParameter("PurchaseOrder");
	String defCatArea  	= (String)session.getValue("SYSKEY");
	
	String dcno = "";
	
%>
<html>
<head>

<html>
<head>    
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<%@ include file="../Misc/ezJQueryScript.jsp" %>

<Script>
	
	function funLinkOpen(fileName,PurchaseOrder,NetAmount,Currency,orderType,poVendor)
	{
		document.location.href=fileName+"?PurchaseOrder="+PurchaseOrder+"&NetAmount="+NetAmount+"&Currency="+Currency+"&orderType="+orderType+"&listBack=Y&FromDate="+document.myForm.FromDate.value+"&ToDate="+document.myForm.ToDate.value+"&SearchFlag=<%=searchFlag%>&POSearch=<%=POSearch%>&MaterialNumber=<%=materialNumber%>&DCNO=<%=dcno%>&posearchno=<%=PurchaseOrder%>&poVendor="+poVendor;
	}

	function funLinkNew(fileName,PurchaseOrder,NetAmount,Currency,orderType,poVendor)
	{
		document.location.href=fileName+"?PurchaseOrder="+PurchaseOrder+"&NetAmount="+NetAmount+"&Currency="+Currency+"&orderType="+orderType+"&sysKey=<%=defCatArea%>&soldTo="+poVendor+"&listBack=Y&FromDate="+document.myForm.FromDate.value+"&ToDate="+document.myForm.ToDate.value+"&SearchFlag=<%=searchFlag%>&POSearch=<%=POSearch%>&MaterialNumber=<%=materialNumber%>&DCNO=<%=dcno%>&posearchno=<%=PurchaseOrder%>&poVendor="+poVendor;
		
	}
	/* FOR DATE SELECTION AND TO LOAD DEFAULT DATES */
	
	function ezSubmit(){
		if(document.myForm.showGrid!=null)
			document.myForm.showGrid.value = "Y";
		
		document.myForm.action = "ezListPOs.jsp?OrderType=<%=orderType%>";
		document.myForm.submit();
	}
	
	/* END */
</Script>

</head>

<body>
<form name="myForm" method="post" >
<input type="hidden" name="chkField">
<input type="hidden" name ="chkbox">
<input type="hidden" name=selAllImg value="0">

<%	
	if(orderType == null) 
		orderType="";
		
	String clickString = "onclick='ezSubmit()'";
	
	String display_header  = "";
	
	if("Open".equals(orderType))
		display_header	= "Open Purchase Orders";
	if("Closed".equals(orderType))
		display_header	= "Closed Purchase Orders";	
	if("All".equals(orderType))
		display_header	= "All Purchase Orders";	
	
%>		
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
	<%@ include file="../Misc/ezSelectDate.jsp"%>		

<%
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
	

	if(orderType == null || "null".equals(orderType)) 
		orderType="";
	
%>


<%
	String chkLink 	= "";
	String hypLink 	= "";
	String poNumber = "";
	String ordDate	= "";
	String earlyDate= "";
	String shipdate = "";
	String latDate	= "";
	String curr 	= "";s
	String val   	= "";
	String status   ="";
	
	String startDate= "";
	String endDate= "";
	String purGrpName= "";
	String plant= "";
	String poDocType="";
	String poVendor="";
	
	
	String[] sortKey = {ORDER};
	hdrXML.sort( sortKey, false );//false for descending	
	java.math.BigDecimal totValue=new java.math.BigDecimal("0");
	int hdrCount=hdrXML.getRowCount();
	
	String color = "";
%>
	<div style="position:absolute;top:18%;width:100%;left:0%;overflow:auto;height:328px">
	<table class="data-table" id="example" width='100%' border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
	<thead>
		<Tr>
			<th align="center" width="8%">PO Number</th>
			<th align="center" width="12%">Doc. Type</th>
			<th align="center" width="8%">Order Date</th>
			<th align="center" width="12%">Pur Grp Name</th>
			<th align="center" width="8%">Start Date</th>
			<th align="center" width="8%">End Date</th>
			<th align="center" width="8%">Delivery Date</th>
			<th align="center" width="8%">Due Date</th>
			<th align="center" width="12%">Plant</th>
			<th align="center" width="8%">Currency</th>
			<th align="center" width="8%">Value<Valueth>

		</tr>
	</thead>
	
	<Tbody>	
<%
	String plantAddr = "",poPlantCode = "";		
	for(int i=0; i< hdrCount; i++)
	{
		if(hdrXML.getFieldValueString(i,"PLANT")==null || "null".equals(hdrXML.getFieldValueString(i,"PLANT")) || "".equals(hdrXML.getFieldValueString(i,"PLANT")))
			continue;
	
		poNumber = hdrXML.getFieldValueString(i, ORDER);
		poVendor = hdrXML.getFieldValueString(i,"VENDOR_NUMBER");
		isDisplay = false;
		chkLink = "";
		if(orderType.equals("CDate") && v.contains(poNumber)){
			rowCount = rowCount+1;
			isDisplay=true;

			hypLink = "<a href=JavaScript:funLinkNew('ezAddComittedDate.jsp','"+poNumber+"','"+hdrXML.getFieldValueString(i,"NETAMOUNT")+"','"+hdrXML.getFieldValueString(i,"CURRENCY")+"','"+orderType+"','"+sysKey+"','"+soldTo+"')>"+poNumber+"</a>";

		}
		else if(orderType.equals("Open") && !v.contains(poNumber)){
			rowCount = rowCount+1;
			isDisplay=true;
			//poVendor = hdrXML.getFieldValueString(i,"VENDOR_NUMBER");
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

			hypLink = "<a href=JavaScript:funLinkNew('ezOpenPoLineitems.jsp','"+poNumber+"','"+hdrXML.getFieldValueString(i,"NETAMOUNT")+"','"+hdrXML.getFieldValueString(i,"CURRENCY")+"','"+orderType+"','"+poVendor+"','"+poVendor+"')>"+poNumber+"</a>";
		}
		else if(orderType.equals("Closed")){
			rowCount = rowCount+1;
			isDisplay=true;

			hypLink = "<a href=JavaScript:funLinkNew('ezPoLineitems.jsp','"+poNumber+"','"+hdrXML.getFieldValueString(i,"NETAMOUNT")+"','"+hdrXML.getFieldValueString(i,"CURRENCY")+"','"+orderType+"','"+poVendor+"','"+poVendor+"')>"+poNumber+"</a>";
		}
		else if(orderType.equals("All") && !v.contains(poNumber)){
			rowCount = rowCount+1;
			isDisplay=true;

			hypLink = "<a href=JavaScript:funLinkNew('ezPoLineitems.jsp','"+poNumber+"','"+hdrXML.getFieldValueString(i,"NETAMOUNT")+"','"+hdrXML.getFieldValueString(i,"CURRENCY")+"','"+orderType+"','"+poVendor+"','"+poVendor+"')>"+poNumber+"</a>";

		}
		else if ((orderType==null)||(orderType.trim().length()==0)){
			rowCount = rowCount+1;
			isDisplay=true;

			hypLink = "<a href=JavaScript:funLinkNew('ezPoLineitems.jsp','"+poNumber+"','"+hdrXML.getFieldValueString(i,"NETAMOUNT")+"','"+hdrXML.getFieldValueString(i,"CURRENCY")+"','"+orderType+"','"+poVendor+"','"+poVendor+"')>"+poNumber+"</a>";
		}
		
		if(isDisplay)
		{
			poPlantCode = hdrXML.getFieldValueString(i,"PLANT");
											
			if(poPlantCode==null || "null".equals(poPlantCode) || "".equals(poPlantCode) || "1330".equals(poPlantCode) || "1350".equals(poPlantCode))
				continue;
		
			ordDate	 = getDateForDateObj((java.util.Date)hdrXML.getFieldValue(i, ORDERDATE));
			earlyDate = getDateForDateObj((java.util.Date)hdrXML.getFieldValue(i,DELIVERYDATE));
			latDate	 = getDateForDateObj((java.util.Date)hdrXML.getFieldValue(i,"CONFIRMDELIVERYDATE"));
			shipdate = getDateForDateObj((java.util.Date)hdrXML.getFieldValue(i,"SHIPDATE"));

			startDate =  getDateForDateObj((java.util.Date)hdrXML.getFieldValue(i,"START_DATE"));
			endDate =  getDateForDateObj((java.util.Date)hdrXML.getFieldValue(i,"END_DATE"));
			purGrpName =  hdrXML.getFieldValueString(i,"PURGRP_NAME");

			java.util.Date compEndDate  = (java.util.Date)hdrXML.getFieldValue(i,"END_DATE");
			java.util.Date compCurrDate = new java.util.Date();
			if(compEndDate.compareTo(compCurrDate)<0)
				continue;
			
			
			if(purGrpName!=null)
				purGrpName = purGrpName.replaceAll("&","and");

			purGrpName = purGrpName +"["+hdrXML.getFieldValueString(i,"PURGRP")+"]";
			
			plantAddr = (String)plantAddrHT.get(hdrXML.getFieldValueString(i,"PLANT"));

			if(plantAddr==null || "null".equals(plantAddr))
				plantAddr = "";


			plant =  plantAddr+"["+hdrXML.getFieldValueString(i,"PLANT")+"]";

			if(plant == null || "null".equals(plant) || "".equals(plant))
				plant = hdrXML.getFieldValueString(i,"PLANT");

			poDocType = (String)poDocTypesHT.get(hdrXML.getFieldValueString(i,"ORDERTYPE"))+"["+hdrXML.getFieldValueString(i,"ORDERTYPE")+"]";




			curr 	 = hdrXML.getFieldValueString(i,"CURRENCY");
			if(shipdate==null || "null".equals(shipdate))
				shipdate = "";
			val   	 = myFormat.getCurrencyString(hdrXML.getFieldValueString(i,"NETAMOUNT"));
			try{
				totValue=totValue.add(new java.math.BigDecimal(hdrXML.getFieldValueString(i,"NETAMOUNT")));
			}
			catch(Exception e){
				//out.println(">>>"+e);
			}

			chkLink = poNumber+"";
			
			color = "";
			if(i%2==0) {color = "style='background-color:#c9e0ff'";}
%>
			<Tr>
				<td align="center" width="8%" <%=color%>><%=hypLink%></td>
				<td align="center" width="12%" <%=color%>><%=poDocType%></td>
				<td align="center" width="8%" <%=color%>><%=ordDate%></td>
				<td align="center" width="12%" <%=color%>><%=purGrpName%></td>
				<td align="center" width="8%" <%=color%>><%=startDate%></td>
				<td align="center" width="8%" <%=color%>><%=endDate%></td>
				<td align="center" width="8%" <%=color%>><%=earlyDate%></td>
				<td align="center" width="8%" <%=color%>><%=latDate%></td>
				<td align="center" width="12%" <%=color%>><%=plant%></td>
				<td align="center" width="8%" <%=color%>><%=curr%></td>
				<td align="right" width="8%" <%=color%>><%=val%>&nbsp;</td>
			</tr>		
<%
		}

	}
%>
</Tbody>
	</table>
	
</form>

<Div id="MenuSol"></Div>
</body>
</html>
