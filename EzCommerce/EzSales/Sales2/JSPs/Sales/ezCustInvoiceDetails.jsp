<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/JSPs/Sales/iCustInvoiceDetails.jsp"%>
<%!
	public String eliminateDecimals(String myStr)
	{
		String remainder = "";
		if(myStr.indexOf(".")!=-1)
		{
			remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
			myStr = myStr.substring(0,myStr.indexOf("."));
		}
		return myStr;
	}
%>
<%
 	String Status = request.getParameter("status");
 		
	 String fromDate = request.getParameter("FromDate");  // don't delete
	 String toDate = request.getParameter("ToDate");				

%>

<%@ include file="../../../Includes/JSPs/Lables/iCustInvoiceDetails_Lables.jsp"%>
<html>
<head>
	<title>Customer Invoice Details</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<script>
	function LocalDetails(dlvno)
	{ 
               if(document.forms[0].onceSubmit.value!=1){
  		document.forms[0].onceSubmit.value=1
		document.forms[0].DeliveryNo.value=dlvno
		document.forms[0].action="../DeliverySchedules/ezViewReceivedDel.jsp?status=<%=Status%>"
		document.forms[0].submit();
		}
	}

	function SAPDetails(delno){
		if(document.forms[0].onceSubmit.value!=1){
   		document.forms[0].onceSubmit.value=1
		document.forms[0].DeliveryNo.value=delno
		document.forms[0].action="../DeliverySchedules/ezViewDeliveryDetails.jsp?status=<%=Status%>"
		document.forms[0].submit();
                }
	}

	function chkBrowser()
	{
		var bversion;
		x=window.navigator.userAgent;
		if(window.navigator.appName =="Microsoft Internet Explorer")
			bversion=x.substring(  (x.indexOf("MSIE ")+4), x.indexOf(";",(x.indexOf(";")+1)) );
		obj1=document.getElementById("Div1");
		if (parseFloat(bversion)<5.5){
			if (obj1!=null)		
				obj1.style.width="96%";
		}
	}
	function ezBack()
	{
		document.forms[0].action="ezSOPaymentDetails.jsp?SalesOrder=<%=salesDocNo%>&status=<%=Status%>"
		document.forms[0].submit();	
	}
	function ezPrint(file)
	{
      	    document.InvDetails.action=file;
	    document.InvDetails.submit();
	}
	</script>
</head>

<%
	
	ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
	String temp = "";	
	try
	{
		temp=Integer.parseInt(custInvNo)+"";
	}
	catch(Exception e)
	{
		temp=custInvNo;
	}	
	String display_header = "Billing Details for Bill No :"+temp;
	
%>
<body onLoad="chkBrowser()">
<form name="InvDetails" method="post">
<input type="hidden" name="FromForm" value="ClosedOrderList">
<input type="hidden" name="FromDate" value="<%=fromDate%>">
<input type="hidden" name="ToDate" value="<%=toDate%>">	
	<input type=hidden name ="soNo" value="<%=salesDocNo%>">
	<input type=hidden name ="DeliveryNo">
	<input type=hidden name ="soldTo">
	<input type=hidden name ="from" value="ezCustInvoiceDetails">
	<input type=hidden name ="custInvNo" value="<%=custInvNo%>">
	<input type=hidden name ="urlFlag" value="CUSTINV">

<%@ include file="../Misc/ezDisplayHeader.jsp"%>	

	<br>
	<table width="55%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<tr>
<!-- 	<th align="left"><%=sNo_L%></th> -->
 	<th align="left">Sales Order No</th>
	<td >
	<%try{%><%=Integer.parseInt(salesDocNo)%><%}catch(Exception e){%><%=salesDocNo%><%}%>
	</td>
	<th align="left"><%=grVal_L%>[<%= billHeaders.getFieldValueString(0,"Currency")%>]</th>
	<td>
	<%
	try{
		double d=Double.parseDouble(billHeaders.getFieldValueString(0,"NetValue"))+Double.parseDouble(billHeaders.getFieldValueString(0,"TaxValue"));
		out.println(myFormat.getCurrencyString(String.valueOf(d)));
	}catch(Exception e)
	{
		out.println(billHeaders.getFieldValueString(0,"NetValue"));	
	}	
	%>
	</td>
	</tr>
	</table>
	<br>
	<table id='Table1' width="94%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<tr>
		<th width="5%"><%=slno_L%></th>
<!--
		<th width="12%"><%=mat_L%></th>
		<th width="20%"><%=desc_L%></th>
-->

         	<th width="10%">Product Code</th>
		<th width="25%">Product Desc</th>

		<!--<th width="5%"><%=uom_L%></th>-->
		<th width="15%"><%=qty_L%></th>
		<th width="15%"><%=pri_L%>[<%= billHeaders.getFieldValueString(0,"Currency")%>]</th>
		<th width="15%"><%=value_L%>[<%= billHeaders.getFieldValueString(0,"Currency")%>]</th>
		<!--<th width="11%"><%=delDocNo_L%></th>-->
		<th width="15%">Delivery Document No</th>
	</tr>
	<%
	if(billItems.getRowCount() >7)
	{
	%>
		</table>
		<div id='Div1' align='center' STYLE='overflow:auto;Position:Absolute;Left=3%;width:96%;height:52%'>
		<table width=100% align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<%
	}
	if(billItems.getRowCount() != 0)
	{
		int count = 0;
		for(int i=0;i<billItems.getRowCount();i++)
		{
			if(Double.parseDouble(billItems.getFieldValueString(i,"Quantity")) != 0)
			{
				count += 1;
		%>		<tr>
				<td width="5%" align="center"><%=count%>.</td>     
				<!--<td width="8%" align="left"><%=billItems.getFieldValueString(i,"BillDocIt")%></td>-->
				<td width="10%" align="left"><%try{%><%=Integer.parseInt(billItems.getFieldValueString(i,"Matno"))%><%}catch(Exception e){%><%=billItems.getFieldValueString(i,"Matno")%><%}%></td>
				<td width="25%" title="<%=billItems.getFieldValueString(i,"MatText")%>"><input type=text class=tx size="50" value="<%=billItems.getFieldValueString(i,"MatText")%>"></td>
				<!--<td width="5%" align="center"><%=billItems.getFieldValueString(i,"Salesunit")%></td>-->
				<%
				double qty=Double.parseDouble(billItems.getFieldValueString(i,"Quantity"));	
				double val=Double.parseDouble(billItems.getFieldValueString(i,"NetValue"));	
				double prs=val/qty;
				%>	
				<td width="15%" align="right"><%=eliminateDecimals(billItems.getFieldValueString(i,"Quantity"))%></td>
				<td width="15%" align="right"><%=myFormat.getCurrencyString(String.valueOf(prs))%></td>
				<td width="15%" align="right"><%=myFormat.getCurrencyString(billItems.getFieldValueString(i,"NetValue"))%></td>
				<td width="15%" align="center">
				<%
				String billDoc=billItems.getFieldValueString(i,"DelDoc");
				if (LocDels.contains(billDoc))
				{%>
					<a href='JavaScript:LocalDetails("<%=billDoc%>")'   onClick=''><%try{out.println(Long.parseLong(billDoc));}catch(Exception e){out.println(billDoc);}%></a>
				<%}else{%>
					<a href='JavaScript:SAPDetails("<%=billDoc%>")'  ><%try{out.println(Long.parseLong(billDoc));}catch(Exception e){out.println(billDoc);}%></a>								
				<%}%>
				</td></tr>
			<%}
		}
		%>
		<Tr>						
		<Td colspan=6 align="right"><b><%=taxDutLev_L%> </b></Td>
		<Td align="right"><%=myFormat.getCurrencyString(billHeaders.getFieldValueString(0,"TaxValue"))%></Td>
		<Td class=blankcell></td>
		</Tr>
		<%
	}
	else
	{
	%>		<td colspan=8 align="center"><%=cusInvDetEnt_L%>.</td>
	<%}
	if(billItems.getRowCount() >7)
	{%>
		</table>
		</div>
	<%}else{%>
		</Table>
	<%}%>

	<div id='div2' style='position:absolute;top:90%;width:100%' align="center">
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		//buttonName.add("Print");
		//buttonMethod.add("ezPrint(\"ezBillingPrint.jsp\")");
		buttonName.add("Back");
		buttonMethod.add("ezBack()");
		out.println(getButtonStr(buttonName,buttonMethod));
		
%>
	</div>
	<input type="hidden" name="onceSubmit" value=0>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
