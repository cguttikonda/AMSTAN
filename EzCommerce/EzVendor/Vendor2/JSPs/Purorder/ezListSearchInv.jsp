<%@ page import ="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="ezc.ezparam.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>

<%@ include file="../../../Vendor2/Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ include file="../../../Includes/Jsps/Labels/iListInv_Labels.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>

<%
	java.math.BigDecimal totValue=new java.math.BigDecimal("0");
	NumberFormat nf=null;
	String Str="";

	ezc.ezparam.EzInvoice SeqInv = new ezc.ezparam.EzInvoice();

	String searchField = request.getParameter("searchField");
	String base = request.getParameter("base");
	String invoiceFlag = request.getParameter("InvStat");

	if ( invoiceFlag == null ) invoiceFlag="A";
		String purnum = "";


	
		ezc.ezshipment.client.EzShipmentManager manager = new ezc.ezshipment.client.EzShipmentManager();
		String vendor=(String)session.getValue("SOLDTO");
		EzcParams ezcParams=new EzcParams(true);

		ezc.ezshipment.params.EziSearchInputStructure inStruct=new ezc.ezshipment.params.EziSearchInputStructure();
	
		inStruct.setVendor(vendor);
		if("VendorInvoiceNumber".equals(base))
		{			
			inStruct.setBase("DCIN");
			inStruct.setDocnum(searchField);
		}
		else if("Invoice".equals(base))
		{
			inStruct.setBase("ININ");
			inStruct.setDocnum(searchField);
		}
		else if("PurchaseOrder".equals(base))
		{
			inStruct.setBase("POIN");
			inStruct.setDocnum(searchField);
		}

		ezcParams.setObject(inStruct);
		Session.prepareParams(ezcParams);
%>
<html>
<head>

<title><%=invoiceList_L%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
var tabHeadWidth=96
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>

<script>
function funLinkInvoice(fileName,invnum,purNum,compCode,docType,invDate,invCur,invAmount,PostDate,vendorInvNum)
{
	document.location.href=fileName+"?invnum="+invnum+"&purNum="+purNum+"&compCode="+compCode+"&docType="+docType+"&invDate="+invDate+"&invCur="+invCur+"&invAmount="+invAmount+"&PostDate="+PostDate+"&vendorinvnum="+vendorInvNum
}
</script>

</head>
<%



       Vector types = new Vector();
       types.addElement("date");
       types.addElement("date");
       types.addElement("date");
       types.addElement("currency");
       EzGlobal.setColTypes(types);

       Vector names = new Vector();
       names.addElement("INVOICEDATE");
       names.addElement("PAYMENTDATE");
       names.addElement("POSTINGDATE");
       names.addElement("AMOUNT");
       EzGlobal.setColNames(names);


       ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(SeqInv);

	//ezc.drl.util.EzCurrencyFormat myFormat = new ezc.drl.util.EzCurrencyFormat((String)session.getValue("CURRENCY"),((Boolean)session.getValue("CPOSITION")).booleanValue(),((Boolean)session.getValue("SREQUIRED")).booleanValue());
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));


	//ezc.drl.util.EzSearchReturn mySearch= new ezc.drl.util.EzSearchReturn();
	ezc.ezbasicutil.EzSearchReturn mySearch= new ezc.ezbasicutil.EzSearchReturn();

	String display_header = "";	
	if (SeqInv.getRowCount()==0)
	{
		
%>	
<body>

		<%@ include file="../Misc/ezDisplayHeader.jsp"%>

			<br><br><br>
			<TABLE width="50%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			<tr align="center">
			<th align=center>
			<%if(invoiceFlag.equals("A")){%> <%=noInvExist_L%>.
			<% }else if(invoiceFlag.equals("C")) {%> <%=noCloseInvExist_L%>.
			<% }else if(invoiceFlag.equals("O")) {%><%=noOpenInvExist_L%>.
			<% }else {%><%=noInvExist_L%>.
			<%}%>
			</th>
			</tr></table>
		<%
	}
	else
	{
	
		if (invoiceFlag.equals("A"))
			display_header = invoiceList_L;
		else 
		if (invoiceFlag.equals("C"))
			display_header = closeInv_L;
		else 
		if (invoiceFlag.equals("O"))
			display_header = openInv_L;
		else 
		if (invoiceFlag.equals("P"))
			display_header = invoiceList_L;
%>
<body bgcolor='#FFFFFF' onLoad="scrollInit('SHOWTOT')" onResize="scrollInit('SHOWTOT')"   scroll=no>

<form method="post" name="myForm">

	<%@ include file="../Misc/ezDisplayHeader.jsp"%>

<input type="hidden" name="chkField">
<DIV id="theads">
<table id="tabHead" width="96%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
    <tr align="center">
      <th rowspan="2" width="18%"><%=vendorInvNum_L%></th>
      <th rowspan="2" width="14%"><%=sapInvNum_L%></th>
      <th rowspan="2" width="13%"><%=invDate_L%></th>
      <th rowspan="2" width="13%"><%=payDueDate_L%></th>
      <th rowspan="2" width="14%"><%=poAgreeNum_L%></th>

      <th colspan="2" width="28%"><%=invoice_L%></th>
    </tr>
	<tr><th width="10%"><%=cur_L%></th><th width="18%"><%=amount_L%></th></tr>
</Table>
</DIV>

<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
<TABLE   id="InnerBox1Tab"  width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
<%
FormatDate formatDate = new FormatDate();

int rowno = SeqInv.getRowCount();

if (rowno > 0)
{
	String sortItems[] = {"INVOICENUMBER"};
	//SeqInv.sort(sortItems,true);





	String invNumber = new String();
	double invConAmt = 0;

/// INV LIST CONSOLIDATION STARTS HERE
	Hashtable invAmtHT = new Hashtable();
	Hashtable invDateHT = new Hashtable();

//   java.math.BigDecimal totValue=new java.math.BigDecimal("0");

	for(int i=0;i<SeqInv.getRowCount();i++)
	{

		if(SeqInv.getFieldValue(i,"DOCTYPE").equals("AB") && SeqInv.getFieldValueString(i,"DBCRINDICATOR").equals("H"))
				continue;
		if(SeqInv.getFieldValue(i,"DOCTYPE").equals("OV") && SeqInv.getFieldValueString(i,"DBCRINDICATOR").equals("S"))
				continue;
		if((!invAmtHT.containsKey(SeqInv.getFieldValueString(i,"INVOICENUMBER")))||(!invDateHT.containsKey(SeqInv.getFieldValueString(i,"POSTINGDATE"))))
		{
			invAmtHT.put(SeqInv.getFieldValueString(i,"INVOICENUMBER"),SeqInv.getFieldValueString(i,"AMOUNT"));
                         invDateHT.put(SeqInv.getFieldValueString(i,"INVOICENUMBER"),SeqInv.getFieldValueString(i,"POSTINGDATE"));
			//out.println(SeqInv.getFieldValueString(i,"AMOUNT"));
		}
		else
		{
			invNumber = SeqInv.getFieldValueString(i,"INVOICENUMBER");
			try{
				invConAmt = Double.parseDouble(SeqInv.getFieldValueString(i,"AMOUNT"))+Double.parseDouble(invAmtHT.get(invNumber).toString());
			}catch(Exception numFmtEx)
			{
				System.out.println(" <<<<<<<<<< Exception Occured at :: "+i+" while consolidating InvList with Invoice Number :: "+invNumber+" >>>>>>>>>> "+numFmtEx.getMessage());
				invConAmt = Double.parseDouble((String)invAmtHT.get(invNumber));
			}

			invAmtHT.put(invNumber,new Double(invConAmt).toString());
		}

	}
/// INV LIST CONSOLIDATION ENDS HERE

	String amt = null;
	for (int i= 0; i<rowno; i++)
	{
		if(true)// (invAmtHT.containsKey(SeqInv.getFieldValueString(i,"INVOICENUMBER")))
		{


			try{
			 	amt = (String)invAmtHT.get(SeqInv.getFieldValueString(i,"INVOICENUMBER"));
				//invAmtHT.remove(SeqInv.getFieldValueString(i,"INVOICENUMBER"));
			}
			catch(Exception ae){
				amt = "0";
			}


			/*if(SeqInv.getFieldValue(i,"DOCTYPE").equals("AB") && SeqInv.getFieldValueString(i,"DBCRINDICATOR").equals("H"))
				continue;
			if(SeqInv.getFieldValue(i,"DOCTYPE").equals("OV") && SeqInv.getFieldValueString(i,"DBCRINDICATOR").equals("S"))
				continue;
			if(SeqInv.getFieldValueString(i,"INVOICENUMBER").equals(invNoHT))
			{*/
				Date invDate = (Date) SeqInv.getFieldValue(i,"INVOICEDATE");

				Date payDate = (Date) SeqInv.getFieldValue(i,"PAYMENTDATE");

				//out.println(SeqInv.getFieldValue(i,"PAYMENTDATE"));
				String temp=ret.getFieldValueString(i,"PAYMENTDATE");
				if("null".equals(temp)||temp==null )
				  temp="";

                                String venRef = SeqInv.getFieldValueString(i,"REFDOC");


				String poNum = SeqInv.getFieldValueString(i,"PURCHASEORDER");
				String invNum = SeqInv.getFieldValueString(i,"INVOICENUMBER");
				String compCode="1000";//SeqInv.getFieldValueString(i,"COMPCODE");


				poNum=poNum.trim();
				if(!"0.00".equals(myFormat.getCurrencyString(amt)))
				{
					out.println("<tr>");
%>					<td align="left" width="18%"><%=SeqInv.getFieldValueString(i,"REFDOC")%>&nbsp;</td>
					<td align="left" width="14%">
					<a href="JavaScript:funLinkInvoice('ezInvoiceDetails.jsp','<%=invNum%>','<%=poNum%>','<%=compCode%>','<%=SeqInv.getFieldValue(i,"DOCTYPE")%>','<%=formatDate.getStringFromDate((Date)SeqInv.getFieldValue(i,"POSTINGDATE"),".",FormatDate.DDMMYYYY)%>','<%=SeqInv.getFieldValue(i,"INVOICECURRENCY")%>','<%=SeqInv.getFieldValue(i,"AMOUNT")%>','<%=formatDate.getStringFromDate((Date)SeqInv.getFieldValue(i,"POSTINGDATE"),".",FormatDate.DDMMYYYY)%>','<%=SeqInv.getFieldValueString(i,"REFDOC")%>')" onMouseover="window.status='Click To View Details '; return true" onMouseout="window.status=' '; return true">
					<%try{
						out.println(Long.parseLong(invNum));
					}catch(Exception e){
						out.println(invNum);
					}
					%>
					</a>
					</td>
					<td align="center" width="13%"><%=ret.getFieldValueString(i,"POSTINGDATE")%></td>
					<td align="center" width="13%"><%=temp%>&nbsp;</td>
					<td width="14%">
					<%
						try{
						out.println(Long.parseLong(SeqInv.getFieldValueString(i,"PURCHASEORDER")));
						}catch(Exception numFmtEx)
						{
						out.println(SeqInv.getFieldValueString(i,"PURCHASEORDER"));
						}
					if(SeqInv.getFieldValueString(i,"PURCHASEORDER")==null ||"".equals(SeqInv.getFieldValueString(i,"PURCHASEORDER")))
						out.println("&nbsp;&nbsp;");
					%></td>
					<td align="center" width="10%"><%=SeqInv.getFieldValue(i,"INVOICECURRENCY")%></td>
					<td align="right" width="18%">
					<%
						//out.println(ret.getFieldValueString(i,"AMOUNT"));
						//out.println(myFormat.getCurrencyString(amt));



						out.println(ret.getFieldValueString(i,"AMOUNT"));


		try{

			totValue=totValue.add(new java.math.BigDecimal(SeqInv.getFieldValueString(i,"AMOUNT")));


		}catch(Exception e){
			out.println(">>>"+e);
		}



					%></td>
				<!--
					<td><%=SeqInv.getFieldValueString(i,"INVOICECURRENCY")%></td>
					<td width="12%"><%=formatDate.getStringFromDate(payDate,".",FormatDate.DDMMYYYY)%></td>
					<td width="12%"><%=SeqInv.getFieldValueString(i,"PAIDAMOUNT")%></td>
					<td width="12%"><%=SeqInv.getFieldValueString(i,"CHEQUENUMBER")%></td>
					<td width="12%"><%=SeqInv.getFieldValueString(i,"BANKNAME")%></td>
				-->
		<%			out.println("</tr>");
				}
			//}
		}
	}
}
else
{
%><td colspan = "6" align="center"><%=noInvoiceFound_L%></td>
<%}
%>
</table>
</div>
<Div id="showTot" style="position:absolutevisibility:hidden">

<Table align=right  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 width="100%">
<Tr>
	<Td width=71% class=blankcell>&nbsp;</Td>
	<Td width=29% class=blankcell>
	<Table align=center width=100% border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=1>
	<Tr>
	<Th width="35%" align=left>
	<Table align=center width=100% border=0 cellPadding=0 cellSpacing=1 width="100%">
	<tr>
	<th align="left"><img src="../../Images/arrow.gif" width="30" height="20"></th>
	<th align="left"><b><%=tot_L%></b></th>
	</tr>
	</table>
	</Th>
	<Th width="65%" align=right>
<%
		nf = NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		out.println(nf.format(totValue.doubleValue()));
%>
	</Th></Tr>
	</Table>
</td>
</Tr>
</Table>
</div>





<%}%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
<%

%>
