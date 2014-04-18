<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/SelfService/iInvoiceDetails.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iInvoiceDetails_Lables.jsp"%>

<html>
<head>
	<title>Invoice Details</title>

	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
		<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="45%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>


	<script language="javascript">
	
	function ezPrint()
	{
		document.InvDetails.action="ezPrint.jsp";
		document.InvDetails.submit();
	}
	function paymentDetails(){
		if(document.forms[0].onceSubmit.value!=1){
		 document.forms[0].onceSubmit.value=1
		 document.body.style.cursor="wait"
		 document.forms[0].action="ezPaymentDetails.jsp";
		 document.forms[0].submit();
		}
	}
	function setBack()
	{
		document.body.style.cursor="wait"
		document.forms[0].action="ezGridOpenInvoices.jsp";
		document.forms[0].submit();
	}
	
	</script>
</head>

	<%
	ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
	String curr =billHeaders.getFieldValueString(0,"Currency");
	curr = (curr == null || "null".equals(curr) )?"": curr;
	%>

<body  onLoad="scrollInit('SHOWTOT')" onresize="scrollInit('SHOWTOT')" scroll=no>
<form name="InvDetails" method="post">
<input type="hidden" name="onceSubmit" value=0>
<input type="hidden" name="sapInvNo"   value="<%=sapInvNo%>">
<input type="hidden" name="custInvNo"  value="<%=custInvNo%>">
<input type="hidden" name="InvDate"    value="<%=InvDate%>">
<input type="hidden" name="DatesFlag"  value="<%=datesFlag%>">
<input type="hidden" name="FromForm"   value="<%=base%>">
<input type="hidden" name="ToDate"     value="<%=td%>">
<input type="hidden" name="FromDate"   value="<%=fd%>">
<input type="hidden" name="ezMonths"   value="<%=monthOpt%>">
<input type=hidden name="InvFlag" value="<%=request.getParameter("InvFlag")%>">
<%
	String temp = "";	
	try
	{
		temp=Integer.parseInt(custInvNo)+"";
	}
	catch(Exception e)
	{
		temp=custInvNo;
	}	
	String display_header = invDetInvNo_L+" :"+temp;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
int count = 0;
if(billItems.getRowCount() > 0)
{
%>

<span id="divdisplay" display="block">
	<Div id="theads">
	<Table width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
		<th width="6%">Line #</th>
		<th width="18%"><%=prodNo_L%></th>
		<th width="40%"><%=prod_Desc_L%></th>
		<!--<th width="8%"><%=uom_L%></th>
		<th width="8%"><%=batch_L%></th>-->
		<th width="12%"><%=qty_L%></th>
		<%if (curr == null || "null".equals(curr)){%>
		<th width="12%"><%=price_L%></th>
		<th width="12%"><%=value_L%></th>
		<%}else{%>
		<th width="12%"><%=price_L%>[<%= curr %>]</th>
		<th width="12%"><%=value_L%>[<%= curr %>]</th>
		<%}%>
	</tr>
	</Table>
	</Div>
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:45%;left:2%">
	<Table align=center id='InnerBox1Tab'   border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
	<%


		for(int i=0;i<billItems.getRowCount();i++)
		{
			if(Double.parseDouble(billItems.getFieldValueString(i,"Quantity")) != 0)
			{
				count += 1;
		%>		<tr>
				<td width="6%" align="center"><%=count%>.</td>
				<td width="18%" align="left"><%try{%><%=Integer.parseInt(billItems.getFieldValueString(i,"Matno"))%><%}catch(Exception e){%><%=billItems.getFieldValueString(i,"Matno")%><%}%></td>
				<td width="40%"><%=billItems.getFieldValueString(i,"MatText")%></td>
				<!--<td width="8%" align="center"><%=billItems.getFieldValueString(i,"Salesunit")%></td>
				<td width="8%" align="center"><%=billItems.getFieldValueString(i,"Ext2")%>&nbsp;</td>-->
				<%
				double qty=Double.parseDouble(billItems.getFieldValueString(i,"Quantity"));
				double val=Double.parseDouble(billItems.getFieldValueString(i,"NetValue"));
				double prs=val/qty;
				String tQty = billItems.getFieldValueString(i,"Quantity");
				try
				{
					tQty = tQty.substring(0,tQty.indexOf('.'));
				}
				catch(Exception e){}
				%>
				<td width="12%" align="right"><%=tQty%></td>
				<td width="12%" align="right"><%=myFormat.getCurrencyString(String.valueOf(prs))%></td>
				<td width="12%" align="right"><%=myFormat.getCurrencyString(billItems.getFieldValueString(i,"NetValue"))%></td>
				</tr>
		<%	}
		}
		%>

		</Table>
		</Div>
		<Div id="showTot" style="position:absolute;top:60%;width:100%;visibility:hidden" align=right>

			<Table align=right  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
			<Tr>
			<Td colspan=4 class=blankcell>&nbsp;</Td>
			<Td width=44% class=blankcell>
				<Table width=100%  align=right border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
					<Tr>
					<Th align="right" width="28%"><b>Taxes </b></Th>
					<Td align="right" width="16%"><%=myFormat.getCurrencyString(billHeaders.getFieldValueString(0,"TaxValue"))%></Td>
					</Tr>
					<Tr>
					<Th align="right" width="28%"><b><%=totVal_L%></b></Th>
					<Td align="right" width="16%">
					<%
					try{
						double d=Double.parseDouble(billHeaders.getFieldValueString(0,"NetValue"))+Double.parseDouble(billHeaders.getFieldValueString(0,"TaxValue"));
						out.println(myFormat.getCurrencyString(String.valueOf(d)));
					}catch(Exception e){
						out.println(billHeaders.getFieldValueString(0,"NetValue"));
					}
					%>
					</Td>
					</Tr>
				</Table>
			</td>
			</Tr>
		</Table>
		</div>
		</span>

	<%

}
else
{
	%>
		<br><br><br><br>
		<Table align=center  border=0 >
		<Tr><td class=displayalert align="center">Details Not Available</td></Tr>
		</Table>
<%}
	%>

<%
	if(count == 0)
	{
%>
		<script>
			if(document.getElementById("divdisplay") != null)
			{
				document.getElementById("divdisplay").style.display="None"
				document.write("<br><br><br><Table align=center><Tr><td class=displayalert align=center>Details Not Available</td></tr></table>");
			}
		</script>

<%
	}
%>


	<div id="buttonDiv" align=center style='position:absolute;top:90%;width:100%'>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Payment Details");
	buttonMethod.add("paymentDetails()");
	buttonName.add("Print");
	buttonMethod.add("ezPrint()");
	buttonName.add("Back");
	buttonMethod.add("history.go(-1)");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
