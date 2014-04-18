<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Sales/iSOPaymentDetails.jsp"%>
<%
	String fromDate = request.getParameter("FromDate");  // don't delete
	String toDate = request.getParameter("ToDate");
	String newFilter = request.getParameter("newFilter");
%>
<%@ include file="../../../Includes/JSPs/Lables/iSOPaymentDetails1_Lables.jsp"%>
<html>
	<head>
	<title>Invoice Payment Details</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<script language="javascript">

		function chkBrowser()
		{
			var bversion;
			x=window.navigator.userAgent;
			if(window.navigator.appName =="Microsoft Internet Explorer")
			{
				bversion=x.substring(  (x.indexOf("MSIE ")+4), x.indexOf(";",(x.indexOf(";")+1)) );
			}
	
		}
		function fun(invNo)
		{
                     if(document.forms[0].onceSubmit.value!=1){
   			document.forms[0].onceSubmit.value=1
			document.body.style.cursor="wait"
			document.forms[0].custInvNo.value=invNo;
			document.forms[0].action="ezCustInvoiceDetails.jsp";
			document.forms[0].submit();
                     }
		}
		function ezBack(obj)
		{
<%
			String status = request.getParameter("status");	
%>
			if(obj=="getdel")
			{
				document.forms[0].action="../DeliverySchedules/ezGetDeliveryBySO.jsp?SalesOrder=<%=salesDocNo%>&status=<%=status%>";
			}
			else
			{
				document.forms[0].action="ezBackEndSODetails.jsp?SONumber=<%=salesDocNo%>&status=<%=status%>"
			}
                        if(document.forms[0].onceSubmit.value!=1)
                        {
				document.forms[0].onceSubmit.value=1
				document.body.style.cursor="wait"
				document.forms[0].submit();
                        }
		}
		</script>
	</head>

<body  onLoad="chkBrowser()"> 
<form name="InvPayDtls" method="post">
<input type="hidden" name="FromForm" value="ClosedOrderList">
<input type="hidden" name="FromDate" value="<%=fromDate%>">
<input type="hidden" name="ToDate" value="<%=toDate%>">	
<input type=hidden name="newFilter"  value="<%=newFilter%>">
<input type=hidden name="salesDocNo" value="<%=salesDocNo%>">
<input type=hidden name="custInvNo">
<input type=hidden name="status" value="<%=status%>">	
<%
	String temp = "";	
	try
	{
		temp=Integer.parseInt(salesDocNo)+"";
	}
	catch(Exception e)
	{
		temp=salesDocNo;
	}	
	String display_header = "Billing Information for SO No :"+temp;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

	<br>
<%
	String from = request.getParameter("from");
	ezc.ezutil.FormatDate fd  = new ezc.ezutil.FormatDate();
	ezc.ezbasicutil.EzCurrencyFormat curFrm  = new ezc.ezbasicutil.EzCurrencyFormat();
	ArrayList unqInv = new ArrayList();
	//billHeaders.toEzcString();
	if(billHeaders .getRowCount()!=0)
	{
%>
		<table id="Table1" width="60%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<tr>
		<%--	<th width="20%" align="center"><%=billDocNo_L%></th>--%>	
		<%--	<th width="20%" align="center"><%=sapInvNo_L%></th>--%>
		<%--	<th width="20%" align="center"><%=invdate_L%></th>--%>
			<th width="20%" align="center">SAP Invoice No</th>
			<th width="15%" align="center"><%=curr_L%></th>
			<th width="25%" align="center"><%=amount_L%></th>
		</tr>
<%
		// THE FOLLOWING for-LOOP IS FOR FINDING UNIQUE ENTRIS IN THE INVOICES LIST.
		for(int i=0;i<billHeaders .getRowCount();i++)
		{
			if(billHeaders .getFieldValueString(i,"SdDocCat").equals("M"))
			{
				if(!unqInv.contains(billHeaders.getFieldValueString(i,"Billingdoc")))
				{
					String billdoc = billHeaders.getFieldValueString(i,"Billingdoc");
%>
					<tr>
					<td align="left" width="20%">
					<a href='JavaScript:fun("<%=billdoc%>")' <%=statusbar%> ><%try{out.println(Long.parseLong(billdoc));}catch(Exception e){out.println(billdoc);}%></a>
					</td>
					<%--
					<td align="left" width="20%">
<%
					try
					{
						out.println(Long.parseLong(billHeaders.getFieldValueString(i,"Ext1")));
					}
					catch(Exception e)
					{
						out.println(billHeaders.getFieldValueString(i,"Ext1"));
					}
%>
					&nbsp;</td>
					<td align="left" width="20%">
<%
						String date=billHeaders.getFieldValueString(i,"Ext2");
						if(date != null && !"null".equals(date) && date.trim().length() !=0)
						{
							String dd=date.substring(6);
							String mm=date.substring(4,6);
							String yy=date.substring(0,4);
							out.println(dd+"."+mm+"."+yy);
						}
						else
						{
							out.println("");
						}
%>
					</td>--%>
					<td align="left" width="15%">
					<%=billHeaders.getFieldValueString(i,"Currency")%>
					</td>
					<td align="right" width="25%">
					<%=curFrm.getCurrencyString(billHeaders.getFieldValue(i,"NetValue"))%>
					</td>
					</tr>	
<%
					unqInv.add(billHeaders.getFieldValueString(i,"Billingdoc"));
				}
			}
		}
%>
		</table>
<%
	}
	else
	{
		String noDataStatement = billInfo_L;
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp"%>
<%
	}

	if((unqInv.size()==0) && (billHeaders.getRowCount()>0))
	{
		String noDataStatement = billInfo_L;
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp"%>
<%
	}
%>
	<div id='div2' style='position:absolute;top:90%;width:100%' align=center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	if("ezGetDeliveryBySO".equals(from))
	{
		buttonName.add("Back");
		buttonMethod.add("ezBack(\"getdel\")");
	}
	else
	{
		buttonName.add("Back");
		buttonMethod.add("ezBack(\"salesorder\")");
	}	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
	</div>
<input type="hidden" name="onceSubmit" value=0>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
