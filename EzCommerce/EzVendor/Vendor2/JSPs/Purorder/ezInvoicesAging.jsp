<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import ="java.text.*" %>
<%@ include file="../../../Includes/Jsps/Purorder/iListOPENInvoices.jsp" %>
<%@ include file="../../../Includes/Jsps/Labels/iInvoicesAging_Lables.jsp" %>
<html>
<head>
	<title></title>
	<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
var tabHeadWidth=96
var tabHeight="60%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>

<script>
	function showTotal()
	{

		obj = document.getElementById("dataTable")
		obj1 = document.getElementById("Div1")
		obj2 = document.getElementById("showTot")

		if(obj!=null && obj1!=null && obj2!=null)
		{


			if(obj1.offsetHeight < obj.offsetHeight)
			{
			obj2.style.top=obj1.offsetHeight+70
			}else{
			obj2.style.top=obj.offsetHeight+70
			}
			obj2.style.visibility = "visible"
		}
	}


	function funLinkInvoice(fileName,invnum,purNum,compCode,docType,invDate,invCur,invAmount,PostDate,vendorInvNum)
	{
		document.location.href=fileName+"?invnum="+invnum+"&purNum="+purNum+"&compCode="+compCode+"&docType="+docType+"&invDate="+invDate+"&invCur="+invCur+"&invAmount="+invAmount+"&PostDate="+PostDate+"&vendorinvnum="+vendorInvNum
	}

</script>
</head>
	
<%
	String display_header = "";
	if (SeqInv.getRowCount()==0)
	{
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>

			<br><br><br>
			<TABLE width=50% align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			<tr align="center">
			<th align=center><%=noOpenInvExist_L%>.</th>
			</tr>
			</table>


<%	}
	else
	{
		display_header = inAgRep_L;
%>


	<body bgcolor='#FFFFFF' onLoad="scrollInit('SHOWTOT')" onResize="scrollInit('SHOWTOT')" scroll=no>
	<form name="myForm">
	<%@ include file="../Misc/ezDisplayHeader.jsp"%>
	<div id="theads">
	<table id="tabHead"width="96%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<tr>
		<Th width="12%" rowspan=2><%=invoice_L%></Th>
		<Th width="12%" rowspan=2><%=sapInvNum_L%></Th>
		<Th width="70%" colspan=5><%=amount_L%>[<%=SeqInv.getFieldValueString(0,"INVOICECURRENCY")%>]</Th>
		<Th width="6%" rowspan=2><%=outSta_L%><br><%=days_L%></Th>
	</Tr>
	<Tr>
		<Th width="14%"><%=current_L%></Th>
		<Th width="14%">0-30 <%=days_L%></Th>
		<Th width="14%">31-60 <%=days_L%></Th>
		<Th width="14%">61-90 <%=days_L%></Th>
		<Th width="14%">90+ <%=days_L%></Th>
	</Tr>
	</Table>
</div>
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
	<Table id="InnerBox1Tab" align=center width=100%  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >

<%


	Vector types = new Vector();
	types.addElement("currency");
	types.addElement("date");
	types.addElement("date");
	EzGlobal.setColTypes(types);

	Vector names = new Vector();
	names.addElement("AMOUNT");
	names.addElement("INVOICEDATE");
	names.addElement("PAYMENTDATE");
	EzGlobal.setColNames(names);


	ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(SeqInv);


	FormatDate formatDate = new FormatDate();
	Date dd=new Date();
	Calendar cal= new GregorianCalendar();
	Calendar cal1= new GregorianCalendar();

	cal.setTime(dd);
	long today=cal.getTime().getTime();

	//ezc.drl.util.EzCurrencyFormat myFormat = new ezc.drl.util.EzCurrencyFormat("Rs",false,false);
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));

	String invAm = null;
	double total=0;
	double tot0=0.0;		double tot30=0.0;
	double tot60=0.0;		double tot90=0.0;		double totmore=0.0;

	for (int i= 0; i<SeqInv.getRowCount(); i++)
	{
		invAm = SeqInv.getFieldValueString(i,"AMOUNT");
		Date invDate = (Date) SeqInv.getFieldValue(i,"INVOICEDATE");
		Date payDate = (Date) SeqInv.getFieldValue(i,"PAYMENTDATE");
		String poNum = SeqInv.getFieldValueString(i,"PURCHASEORDER");
		String invNum = SeqInv.getFieldValueString(i,"INVOICENUMBER");
		String compCode=SeqInv.getFieldValueString(i,"COMPCODE");

		cal1.setTime(payDate);	//Invoice Due Date
		long curr=cal1.getTime().getTime();
		double days=  (today-curr)/(1000*60*60*24);
		%>
		<Tr>
			<td align="center" width="12%">
			<%=ret.getFieldValueString(i,"INVOICEDATE")%>
			</td>
			<td align="left" width="12%">
			<a href="JavaScript:funLinkInvoice('ezInvoiceDetails.jsp','<%=invNum%>','<%=poNum%>','<%=compCode%>','<%=SeqInv.getFieldValue(i,"DOCTYPE")%>','<%=formatDate.getStringFromDate(invDate,".",FormatDate.DDMMYYYY)%>','<%=SeqInv.getFieldValue(i,"INVOICECURRENCY")%>','<%=SeqInv.getFieldValue(i,"AMOUNT")%>','<%=formatDate.getStringFromDate((Date)SeqInv.getFieldValue(i,"POSTINGDATE"),".",FormatDate.DDMMYYYY)%>','<%=SeqInv.getFieldValueString(i,"REFDOC")%>')" onMouseover="window.status='Click To View Details '; return true" onMouseout="window.status=' '; return true">
			<%try{
				out.println(Long.parseLong(invNum));
			}catch(Exception e){
				out.println(invNum);
			}
			%></a>
			</Td>
			<td width="14%" align="right">
			<%if (days < 0){
				out.println(myFormat.getCurrencyString(invAm));
				tot0+=Double.parseDouble(invAm);
			}
			%>
			&nbsp;</td>
			<td width="14%" align="right">
			<%
			if ((days >= 0)&&(days <= 30)) {
				out.println(myFormat.getCurrencyString(invAm));
				tot30+=Double.parseDouble(invAm);
			}
			%>
			&nbsp;</td>
			<td width="14%" align="right">
			<%
			if ((days > 30)&&(days<= 60))	{
				out.println(myFormat.getCurrencyString(invAm));
				tot60+=Double.parseDouble(invAm);
			}
			%>
			&nbsp;</td>
			<td width="14%" align="right">
			<%
			if ((days >60)&&(days <= 90))
			{
				out.println(myFormat.getCurrencyString(invAm));
				tot90+=Double.parseDouble(invAm);
			}
			%>
			&nbsp;</td>
			<td width="14%"  align="right">
			<%if (days > 90)
			{
				out.println(myFormat.getCurrencyString(invAm));
				totmore+=Double.parseDouble(invAm);
			}
			%>
			&nbsp;</td>
			<td width="6%" align="right">
			<% if (days >0)
				out.println(days);
			%>
			&nbsp;</td>
			</tr>
	<%
			total=total+Double.parseDouble(invAm);
	}
	%>
	</table>
</div>

	<Div id="showTot" style="position:absolutevisibility:hidden">
	<Table width=100% align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<Tr>
	<Td class=blankcell width="12%">&nbsp;</Td>
	<Td class=blankcell width="88%">
	<Table align=center width=100% border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=1 >
	<Tr>
	<Th width="12%" align=center>
		<Table align=center width=100% border=0 cellPadding=0 cellSpacing=1 width="100%">
		<tr>
		<th align="left"><img src="../../Images/arrow.gif" width="30" height="20"></th>
		<th align="left"><b><%=tot_L%></b></th>
		</tr>
		</table>
	</Th>
	<th width="14%" align="right"><%=myFormat.getCurrencyString(tot0)%>&nbsp;</th>
	<th width="14%" align="right"><%=myFormat.getCurrencyString(tot30)%>&nbsp;</th>
	<th width="14%" align="right"><%=myFormat.getCurrencyString(tot60)%>&nbsp;</th>
	<th width="14%" align="right"><%=myFormat.getCurrencyString(tot90)%>&nbsp;</th>
	<th width="14%" align="right"><%=myFormat.getCurrencyString(totmore)%>&nbsp;</th>
	<Th width="6%" >&nbsp;</Th>
	</Tr>
	</Table>
	</td>
	</Tr>
	</Table>
	</div>
	<%
	}
	%>


</form>
<Div id="MenuSol"></Div>
</body>
</html>
