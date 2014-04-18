<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import ="ezc.ezparam.*" %>
<%@ page import="ezc.customer.invoice.params.*" %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<jsp:useBean id="SalesInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iInvoiceDetails_Lables.jsp" %>

<html>
<head>

	<title></title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="55%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js">


	</Script><script src="../../Library/JavaScript/Misc/ezTrim.js"></script>

	<script LANGUAGE="JavaScript">
	function printSubmit(obj)
	{
		document.Invoices.action=obj;
		document.Invoices.submit();

	}

	function gotoHome()
	{
                document.location.replace("../Misc/ezWelcome.jsp");
	}
	function pageSubmit(p1,p2,p3)
	{

   		document.body.style.cursor="wait"
		document.forms[0].custInvNo.value=p1
		document.forms[0].sapInvNo.value=p2
		document.forms[0].InvDate.value=p3
		document.forms[0].action="ezInvoiceDetails.jsp"
		document.forms[0].submit()

	}
	function displayDetails(delno)
	{
		document.forms[0].DeliveryNo.value=delno
		document.forms[0].action="../DeliverySchedules/ezViewReceivedDel.jsp"
		document.forms[0].submit();
	}
	function viewDetails(delno){

   		
   		document.body.style.cursor="wait"
		document.forms[0].DeliveryNo.value=delno
		document.forms[0].action="../DeliverySchedules/ezViewDeliveryDetails.jsp"
		document.forms[0].submit();

	}
</script>
</head>
<%
	int invcount = 0;
	ReturnObjFromRetrieve lineItems =null;
	ReturnObjFromRetrieve dlineItems =null;
	String cust=(String)session.getValue("AgentCode");

	//StringTokenizer stoken=new StringTokenizer(cust,",");
	if (cust.indexOf(",") != -1)
	{
%>
		<Br><Br><br>
		<Table align="center"><Tr><Td align="center"  class=displayalert >
		<%=uCanOpenInv_L%>.<br><br><%=toSelCust_L%> <a href="../Misc/ezSalesHome.jsp" target="_top"><%=here_L%></a>
		</Td></Tr></Table>
<%	}
	else
	{

	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
	String billto=(String)session.getValue("DefBillTO");///UtilManager.getUserDefErpBillTo();

%>



<body   onLoad="scrollInit('SHOWTOT')" onresize="scrollInit('SHOWTOT')" scroll=no>
<form name="Invoices" >
<input type=hidden name="custInvNo">
<input type=hidden name="sapInvNo">
<input type=hidden name="InvDate">
<input type=hidden name ="soNo">
<input type=hidden name ="DeliveryNo">
<%

	FormatDate formatDate = new FormatDate();

	ReturnObjFromRetrieve SeqInv = null;
	EzCustomerParams ioparams = new EzCustomerParams();


	ezc.customer.invoice.params.EzcCustomerInvoiceParams newParams=new ezc.customer.invoice.params.EzcCustomerInvoiceParams();
	EziCustomerInvoiceParams ecip = new EziCustomerInvoiceParams();

	ecip.setKeyDate(new Date());
	ecip.setInvFlag("O");
	ecip.setSelection(billto);//payer

	newParams.createContainer();
	newParams.setObject(ioparams);
	newParams.setObject(ecip);
	Session.prepareParams(newParams);

	
	SeqInv = (ReturnObjFromRetrieve) SalesInvManager.getCustomerInvoices(newParams);
	lineItems = (ReturnObjFromRetrieve)SeqInv.getFieldValue("LINEITEMS");
	
	try{
		lineItems.sort(new String[]{"postingDate"},true);
	}catch(Exception e){}


	if (lineItems!=null)
	{
		int rowno = lineItems.getRowCount();
		for (int i= 0; i<rowno ; i++)
		{
			if("RV".equals(lineItems.getFieldValueString(i,"DocType")) )
					invcount++;
		}

		if (invcount > 0)
		{
	
			dlineItems=new ReturnObjFromRetrieve();
			String objColumns[]={"BILLINGDOCUMENTNO","SAPINVOICENO","DELIVERYDOCUMENTNO","INVOICEDATE","DUEDATE","INVOICEVALUE"};						
			dlineItems.addColumns(objColumns);

	%>


<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
   <td height="35" class="displayheaderback" align=center width="100%"><%=opinvli_L%></td>
</tr>
</table>
	<Div id="theads">
	<table width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<tr>
		<th width="16%"><%= billDocNo_L %></th>
		<th width="16%"><%=sapinvno_L%></th>
		<th width="16%"><%=deliDoc_L%></th>
		<th width="16%"><%=invdate_L%></th>
		<th width="16%"><%=dueDt_L%></th>
		<th width="20%"><%=invVal_L%>[<%= lineItems.getFieldValueString(0,"Currency")%>]</th>

	</Tr>
	</Table>
	</Div>
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:55%;left:2%">
	<Table align=center   id="InnerBox1Tab"  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
	<%

		ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
		String invNum = null;
		String custInvNum = null;
		String custbillNum=null;
		String invAm = null;
		String delDocNo=null;
		double total=0;
		for (int i= 0; i<rowno ; i++)
		{
			if("RV".equals(lineItems.getFieldValueString(i,"DocType")) )
			{
				Date postingDate=(Date)lineItems.getFieldValue(i,"PstngDate");
				Date blineDate=(Date)lineItems.getFieldValue(i,"BlineDate");
				invNum = lineItems.getFieldValueString(i,"DocNo");
				//custInvNum = lineItems.getFieldValueString(i,"AllocNmbr").trim();
				custbillNum =  lineItems.getFieldValueString(i,"RefDoc").trim();
				delDocNo =lineItems.getFieldValueString(i,"RefKey1").trim();

				invAm = lineItems.getFieldValueString(i,"Amount");

				String  formatkey=(String)session.getValue("formatKey");
				
				dlineItems.setFieldValue("BILLINGDOCUMENTNO",custbillNum);
				dlineItems.setFieldValue("SAPINVOICENO",invNum);
				dlineItems.setFieldValue("DELIVERYDOCUMENTNO",delDocNo);
				dlineItems.setFieldValue("INVOICEDATE",FormatDate.getStringFromDate(postingDate,formatkey,FormatDate.MMDDYYYY));
				dlineItems.setFieldValue("DUEDATE",formatDate.getStringFromDate(blineDate,formatkey,FormatDate.MMDDYYYY));
				dlineItems.setFieldValue("INVOICEVALUE",invAm);
				dlineItems.addRow();


	%>			<tr>
				<td align="left" width="16%">
				<a href='JavaScript:pageSubmit("<%=custbillNum%>","<%=invNum%>","<%=FormatDate.getStringFromDate(postingDate,formatkey,FormatDate.MMDDYYYY)%>")' <%=statusbar%> >
					<%try{
					%>	<%=Integer.parseInt(custbillNum)%>
					<%}catch(Exception e){%>
						<%=custbillNum %>
					<%}%>

				</a>
				&nbsp;</td>
				<td align="left" width="16%">
					<%try{
					%>	<%=Integer.parseInt(invNum)%>
					<%}catch(Exception e){%>
						<%=invNum%>
					<%}%>&nbsp;&nbsp;
				</td>
				<td align="center" width="16%">
					<a href='JavaScript:viewDetails("<%=delDocNo%>")' <%=statusbar%> >

					<%try{
					%>	<%=Integer.parseInt(delDocNo)%>
					<%}catch(Exception e){%>
						<%=delDocNo%>
					<%}%>
					</a>&nbsp;
				</td>

				<td align="center" width="16%">
					<%
					String pd =formatDate.getStringFromDate(postingDate,formatkey,FormatDate.MMDDYYYY);
						if(pd.length() == 10)
							out.println(pd);
					%>
				&nbsp;
				</td>
				<td align="center" width="16%">
					<%
						String bd =formatDate.getStringFromDate(blineDate,formatkey,FormatDate.MMDDYYYY);
						if(bd.length() == 10)
							out.println(bd);
					%>
				&nbsp;
				</td>
				<td width="20%" align="right">
					<%=myFormat.getCurrencyString(invAm)%>&nbsp;
				</td>
				</tr>
	<%
			total=total+Double.parseDouble(invAm);
			}
		}
	%>
	<Tr>
	</table>
	</Div>
	<Div id="showTot" style="position:absolute;visibility:hidden">
			<Table align=center  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
			<Tr>
			<Td colspan=4 class=blankcell>&nbsp;</Td>
			<Td width=36% class=blankcell>
				<Table align=center width=100% border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="90%">
				<Tr>
				<Th width="16%" align=center><%=tot_L%></Th>
				<Td width="20%" align=right><%=myFormat.getCurrencyString(total)%>&nbsp;</Td>
				</Tr>
				</Table>
			</td>
			</Tr>
		</Table>

	</div>
	<%}
	else
	{%>

<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback"  width="100%">&nbsp;</td>
</tr>
</table>

		<br><br><br><Table align=center  border=0 >
		<tr>
		<td class=displayalert  align="center"><%=noinvfou_L%>.</td>
		</Tr></Table>
	<%}
	}

}%>
<div id="buttonDiv" align=center style="position:absolute;top:90%;width:100%;">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	if(dlineItems!=null && invcount>0)
	{
		session.putValue("InvoiceReturnObject",dlineItems);
		buttonName.add("Download Excel Sheet");
		buttonMethod.add("printSubmit(\"ezInvoiceExSheet.jsp\")");
	}		
	buttonName.add("Back");
	buttonMethod.add("gotoHome()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
<input type="hidden" name="onceSubmit" value=0>
<input type=hidden name="fname" value="OpenInvoicesList">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
