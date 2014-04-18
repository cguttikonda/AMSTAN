<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import ="ezc.ezparam.*,java.util.*" %>
<%@ page import="ezc.customer.invoice.params.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<jsp:useBean id="SalesInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iInvoicesAging_Lables.jsp" %>
<html>
<head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<title></title>
	<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="50%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>

	<script language="JavaScript">
	function gotoHome()
	{
                document.location.replace("../Misc/ezWelcome.jsp");
	}

	function pageSubmit(p1,p2,p3)
	{
		document.forms[0].custInvNo.value=p1
		document.forms[0].sapInvNo.value=p2
		document.forms[0].InvDate.value=p3
		document.forms[0].action="ezInvoiceDetails.jsp"
		document.forms[0].submit()
	}
	
</script>
</head>
<%!
	public String eliminateDecimals(String myStr)
	{
		
		if(myStr.indexOf(".")!=-1)
		{
			
			myStr 		= myStr.substring(0,myStr.indexOf("."));
		}
		return myStr;
	}
%>
<%
	String cust=(String)session.getValue("AgentCode");
	//StringTokenizer stoken=new StringTokenizer(cust,",");
	if (cust.indexOf(",") != -1)
	{
%>
		<Br><Br><br>
		<Table align="center"><Tr><Td align="center" class="displayalert">
		You can view Invoice Aging of a single Customer at a time.<br><br>To select a Customer click <a href="../Misc/ezSalesHome.jsp" target="_top">here</a>
		</Td></Tr></Table>
<%	}
	else
	{

		ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);
		String billto=(String)session.getValue("DefBillTO"); //UtilManager.getUserDefErpBillTo();
%>


<body   onLoad="scrollInit('SHOWTOT')" onresize="scrollInit('SHOWTOT')" scroll=no>
<form name="Invoices">
<input type=hidden name="custInvNo">
<input type=hidden name="sapInvNo">
<input type=hidden name="InvDate">
<%
	String display_header = "Invoice Aging Report";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>



<%

	FormatDate formatDate = new FormatDate();
	ReturnObjFromRetrieve SeqInv = null;
	EzCustomerParams ioparams = new EzCustomerParams();

	ezc.customer.invoice.params.EzcCustomerInvoiceParams newParams=new  ezc.customer.invoice.params.EzcCustomerInvoiceParams();
	EziCustomerInvoiceParams ecip = new EziCustomerInvoiceParams();
	ecip.setSelection(billto);
	ecip.setKeyDate(new Date());
	ecip.setInvFlag("O");

	newParams.createContainer();
	newParams.setObject(ioparams);
	newParams.setObject(ecip);
	Session.prepareParams(newParams);
	ReturnObjFromRetrieve lineItems =null;
	SeqInv = (ReturnObjFromRetrieve) SalesInvManager.getCustomerInvoices(newParams);
	lineItems = (ReturnObjFromRetrieve)SeqInv.getFieldValue("LINEITEMS");
	

	if (lineItems!=null)
	{
		int rowno = lineItems.getRowCount();
		int invcount = 0;
		for (int i= 0; i<rowno ; i++)
		{
			//if("RV".equals(lineItems.getFieldValueString(i,"DocType")) && lineItems.getFieldValueString(i,"BusArea").startsWith("B"))
				invcount++;
		}

	if (invcount > 0)
	{
	%>
	<Div id="theads">
	<table width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<tr>
		<Th width="10%" rowspan=2>Invoice Date</Th>
		<Th width="10%" rowspan=2>Invoice #</Th>
		<Th width="10%" rowspan=2>Customer PO #</Th>
		<Th width="10%" rowspan=2><%= curr_L %></Th>
		<Th width="50%" colspan=5><%= invAmt_L %> </Th>
		<!--<Th width="10%" rowspan=2><%= outSta_L %><br> <%= days_L %></Th>-->
		<Th width="10%" rowspan=2>Out Standing<br> <%= days_L %></Th>
	</Tr>
	<Tr>
		<Th width="10%"><%= current_L %></Th>
		<Th width="10%">0-30 <%= days_L %></Th>
		<Th width="10%">31-60 <%= days_L %></Th>
		<Th width="10%">61-90 <%= days_L %></Th>
		<Th width="10%">90+ <%= days_L %></Th>
	</Tr>
	</Table>
	</Div>
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:50%;left:2%">
	<Table align=center id='InnerBox1Tab'    border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
	<%

		Date dd=new Date();
		Calendar cal= new GregorianCalendar();
		Calendar cal1= new GregorianCalendar();

		cal.setTime(dd);
		long today=cal.getTime().getTime(); 

		ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
		String invNum = null;
		String custInvNum = null;
		String custbillNum = null;
		String invAm = null;
		double total=0;
		double tot0=0.0;		double tot30=0.0;
		double tot60=0.0;		double tot90=0.0;		double totmore=0.0;
		String formatkey = (String)session.getValue("formatKey");
		//for (int i= 0; i<rowno ; i++)
		for (int i= rowno-1; i>=0 ; i--)
		{
			//if("RV".equals(lineItems.getFieldValueString(i,"DocType")) && lineItems.getFieldValueString(i,"BusArea").startsWith("B"))

			{
				Date postingDate=(Date)lineItems.getFieldValue(i,"PstngDate");
				Date blineDate=(Date)lineItems.getFieldValue(i,"BlineDate");
				invNum = lineItems.getFieldValueString(i,"DocNo");
				custInvNum = lineItems.getFieldValueString(i,"AllocNmbr").trim();
				custbillNum =  lineItems.getFieldValueString(i,"RefDoc").trim();
				//invAm =  lineItems.getFieldValueString(i,"LcAmount");
				invAm =  lineItems.getFieldValueString(i,"Amount");

				cal1.setTime(blineDate);	//Invoice Due Date
				long curr=cal1.getTime().getTime();
				double days=  (today-curr)/(1000*60*60*24);
	%>
			<Tr>
				<td align="center" width="10%">
					<%=formatDate.getStringFromDate(postingDate,formatkey,FormatDate.MMDDYYYY)%>&nbsp;
				</td>
				<td align="center" width="10%">
<%
				try{
					out.println(Integer.parseInt(custbillNum));
				}catch(Exception e){
					out.println(custbillNum);
				}
%>
				
				</td>
				<td align="left" width="10%">
								

				<a href='JavaScript:pageSubmit("<%=custbillNum%>","<%=invNum%>","<%=FormatDate.getStringFromDate(postingDate,formatkey,FormatDate.MMDDYYYY)%>")' <%=statusbar%>>
				<%
				      if (	(custInvNum==null)||("".equals(custInvNum.trim()))||("null".equalsIgnoreCase(custInvNum.trim())) )
				      {
				      	try{
						out.println(Integer.parseInt(custbillNum));
					}catch(Exception e){
						out.println(custbillNum);
					}
				      }
				      else
				      {
				      	try{
						out.println(Integer.parseInt(custInvNum));
					}catch(Exception e){
						out.println(custInvNum);
					}
				      }
				%></a>&nbsp;</td>
				<td width="10%" align="center"><%= lineItems.getFieldValueString(i,"Currency")%></td>
				<td width="10%" align="right">
				<%	if (days < 0){
						out.println(myFormat.getCurrencyString(invAm));
						tot0+=Double.parseDouble(invAm);
					}
				%>
				&nbsp;</td>
				<td width="10%" align="right">
				<%
					if ((days >= 0)&&(days <= 30)) {
						out.println(myFormat.getCurrencyString(invAm));
						tot30+=Double.parseDouble(invAm);
					}
				%>
				&nbsp;</td>
				<td width="10%" align="right">
				<%
					if ((days > 30)&&(days<= 60))	{
						 out.println(myFormat.getCurrencyString(invAm));
						tot60+=Double.parseDouble(invAm);
					}
				%>
				&nbsp;</td>
				<td width="10%" align="right">
				<%
					if ((days >60)&&(days <= 90))
					{
						out.println(myFormat.getCurrencyString(invAm));
						tot90+=Double.parseDouble(invAm);
					}
				%>
				&nbsp;</td>
				<td width="10%"  align="right">
				<%	if (days > 90)
					{
						out.println(myFormat.getCurrencyString(invAm));
						totmore+=Double.parseDouble(invAm);
					}
				%>
				&nbsp;</td>
				<td width="10%" align="right">
				<% if (days >0)
					out.println(eliminateDecimals(days+""));
				%>
				&nbsp;</td>
			</tr>
	<%
			total=total+Double.parseDouble(invAm);
			}
		}
	%>
	</table>
	</Div>
		<Div id="showTot" style="visibility:hidden">

		<Table  align=center width=100% >
		<tr>
		<td  class=blankcell  width=10%>&nbsp;</td>
		<td  class=blankcell  width=10%>&nbsp;</td>
		<td width=80%>

				<Table  align=center  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width=100% >
						<Tr>

						<Th width="10%" align=center>Total</Th>
						<Td width="10%">&nbsp;</Td>
						<Td width="10%" align="right"><%=myFormat.getCurrencyString(tot0)%></Td>
						<Td width="10%" align="right"><%=myFormat.getCurrencyString(tot30)%></Td>
						<Td width="10%" align="right"><%=myFormat.getCurrencyString(tot60)%></Td>
						<Td width="10%" align="right"><%=myFormat.getCurrencyString(tot90)%></Td>
						<Td width="10%" align="right"><%=myFormat.getCurrencyString(totmore)%></Td>
						<Td width="10%" align="right"><b><%=myFormat.getCurrencyString(tot0+tot30+tot60+tot90+totmore)%></b></Td>
						</Tr>
				</Table>
		</td>
		
		</tr>
		</table>
		</div>

	<%
	}
	else
	{
	%>

		<br><br><br><table align="center">
		<tr>
		<td class="displayalert" align="center"> Invoice Aging Report not available.</Td>
		</Tr></Table>
	<%}
	}
	}
%>
<div id="buttonDiv" align=center style="position:absolute;top:92%;width=100%">

<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	//buttonName.add("Back");
	//buttonMethod.add("gotoHome()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
<Div id="MenuSol"></Div>
</form>
</body>
</html>
