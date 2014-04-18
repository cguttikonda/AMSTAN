<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iInvoiceDetails_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Purorder/iInvoiceDetails.jsp"%> 
<%

	int rowno = SeqInv.getRowCount();
	//out.println("----->"+SeqInv.toEzcString());
	SeqInv.toEzcString();
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	String invoiceDateStr = "";
	if(invDate != null)
	{
		invoiceDateStr = new ezc.ezutil.FormatDate().getStringFromDate(dt,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));  
		
	}
	else
	{
		invoiceDateStr = new ezc.ezutil.FormatDate().getStringFromDate((Date)SeqInv.getFieldValue(0,"INVOICEDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		
		
		
	}  
	
	String poNumberStr = "";
	if ((poNum!=null)&&(! "".equals(poNum)))
	{
		try
		{
			poNumberStr = Long.parseLong(poNum)+"";
		}catch(Exception numFmtEx)
		{
			poNumberStr = poNum;
		}
	}
	else
	{
		poNumberStr = "Not Available";
	}
%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import = "java.util.*"%>
<html>
<head> 
	<title>Invoice Details</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
var tabHeadWidth=96
var tabHeight="50%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>

	<script>
	function formSubmit()
	{
		setMessageVisible();
		document.InvDtlsForm.action="ezInvPaymentDetails.jsp";
		document.InvDtlsForm.submit();
	}
	function formEvents(formEv)
	{
		
		document.InvDtlsForm.action=formEv;
		document.InvDtlsForm.submit();
	}
	
	
	</script>
</head>
<body bgcolor="#FFFFF7"  onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<%
	String display_header = invoiceDetail_L; 
%>
<form method="post" name="InvDtlsForm" >
<input type="hidden" name="invnum" value="<%=invnum%>">
<input type="hidden" name="invDate" value="<%=invDate%>">
<input type="hidden" name="invAmount1" value="<%=invAmount%>">
<input type="hidden" name="compCode" value="<%=compCode%>">
<input type="hidden" name="invCur" value="<%=invCur%>">
<input type="hidden" name="docType" value="<%=docType%>">
<input type="hidden" name="PostDate" value="<%=postDate%>">
<input type="hidden" name="purNum" value="<%=poNum%>">
<%@ include file="../Misc/ezDisplayHeader.jsp" %>


<Div id='inputDiv' style='position:relative;align:center;top:2%;width:100%;'>
<Table width="80%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'F3F3F3'" valign=middle>
		<Table border="0" align="center" valign=middle width="100%" class=welcomecell>
			<Tr>
				<Td style="background-color:'F3F3F3';" align='left'>
					<font size=2><B><%=sapInvNo_L%>&nbsp;:&nbsp;</B><%=Long.parseLong(invnum)%></font>
				</Td>
				<Td style="background-color:'F3F3F3';" align='center'>
					<font size=2><B><%=invoiceDate_L%>&nbsp;:&nbsp;</B><%=invoiceDateStr%></font>
				</Td>
				<Td style="background-color:'F3F3F3';" align='right'>
					<font size=2><B><%=poNum_L%>&nbsp;:&nbsp;</B><%=poNumberStr%></font>
				</Td>
			</Tr>
		</Table>
	</Td>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>
<BR>
	<DIV id="theads">
	<table id="tabHead" width="96%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr align="center">
	<th width="5%"><%=line_L%></th>
	<th width="14%"><%=material_L%></th>
	<th width="35%"><%=description_L%></th>
	<th width="6%"><%=uom_L%></th>
	<th width="12%"><%=qty_L%></th>
	<th width="13%"><%=price_L%> [<%=(String)SeqInv2.getFieldValue(0,"INVOICECURRENCY")%>]</th>
     	<th width="15%"><%=netAmount_L%>[<%=(String)SeqInv2.getFieldValue(0,"INVOICECURRENCY")%>]</th>
    	</tr>
	</Table>
	</DIV>


	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<%
	double grandTotal = 0;
	Vector ponos = new Vector();
	Vector indexes = new Vector();
	boolean flag=true;
	//out.println(SeqInv.toEzcString());
	for(int i=0;i<SeqInv.getRowCount();i++)
	{
		pono = (String)SeqInv.getFieldValue(i,"POSITIONNUMBER");
		if(!ponos.contains(pono))
		{
			ponos.addElement(pono);
			indexes.addElement(new Integer(i));

		}
	}
	
	//out.println(ponos);

	double qty1=0;
	double price= 0;
	double netAmt = 0;

	double tqty=0;
	double tprice= 0;
	double tnetAmt = 0;

	boolean dispflag =true;
	String curElement = new String();

	int index = 0;


	Vector vInvDocTypes = new Vector();
	/*
	vInvDocTypes.addElement("AB");
	vInvDocTypes.addElement("KD");
	
	vInvDocTypes.addElement("KR");
	vInvDocTypes.addElement("OV");
	*/
	vInvDocTypes.addElement("RC");
	vInvDocTypes.addElement("RE");
	vInvDocTypes.addElement("RI");
	vInvDocTypes.addElement("RJ");
	vInvDocTypes.addElement("RS");
	//vInvDocTypes.addElement("KG");


	if(docType.equals("KR"))
	{
		dispflag=false;
	%>
		<tr>
		<td colspan=6 align="center">Invoice Amount --> Expense</td>
		<td align="right" width="15%"><%=myFormat.getCurrencyString(invAmount)%>&nbsp;&nbsp;</td>
		</tr>
	<%}
	else if(docType.equals("OV"))
	{
		dispflag=false;
	%>
		<tr>
		<td colspan=6 align="center">Invoice Amount --> Carry forward from last fiscal</td>
		<td align="right" width="15%"><%=myFormat.getCurrencyString(invAmount)%>&nbsp;&nbsp;</td>
		</tr>
	<%}
	else if(docType.equals("AB"))
	{
		dispflag=false;
	%>
		<tr>
		<td colspan=6 align="center">Invoice Amount --> Internal Clearing Document</td>
		<td align="right" width="15%"><%=myFormat.getCurrencyString(invAmount)%>&nbsp;&nbsp;</td>
		</tr>
	<%
	}
	else if(vInvDocTypes.contains(docType))
	{
		dispflag=false;
		for(int i=0;i<ponos.size();i++)
		{
			tqty = 0;
			tprice = 0;
			tnetAmt = 0;
			flag = false;
			curElement = ponos.elementAt(i).toString();
			int tempCurElement = 0;
			if(curElement != null && !"null".equals(curElement))
				tempCurElement = Integer.parseInt(curElement);
			if(tempCurElement == 0)
				flag = true;
			else 
				flag = false;
			for( int j=0;j<SeqInv.getRowCount();j++)
			{
				try
				{
					qty1 = Double.parseDouble(SeqInv.getFieldValueString(j,"INVOICEDQUANTITY"));
					netAmt = Double.parseDouble(SeqInv.getFieldValueString(j,"INVOICEDAMOUNT"));
					if(qty1 != 0)
						price = netAmt/qty1;
				}catch(Exception e)
				{}

				if(curElement.equals((String)SeqInv.getFieldValue(j,"POSITIONNUMBER")))
				{
					if(flag)
					{

					}
					else
					{
						if(tqty == 0)   /// THIS MANIPULATION WE ARE DOING BECAUSE WE SHOULD NOT ADD QTYs
							tqty = tqty + qty1;
						tprice = tprice+price;
						tnetAmt = tnetAmt+netAmt;
					}
				}
			}

			if(!flag)
			{
				index = ((Integer)indexes.elementAt(i)).intValue();
			%>
				<tr>
				<td width="5%" align="center"><%=curElement%></td>
				<td width="14%">
				<%
				try{
					out.println(Long.parseLong(SeqInv.getFieldValueString(index,"ITEM")));
				}catch(Exception e)
				{
					out.println(SeqInv.getFieldValueString(index,"ITEM"));
				}
				%>&nbsp;
				</td>
				<td width="35%">&nbsp;<%=SeqInv.getFieldValueString(index,"DESCRIPTION")%></td>
				<td width="6%" align="center"><%=SeqInv.getFieldValueString(index,"PURCHASEUNIT")%>&nbsp</td>
				<td width="12%" align="right"><%=getNumberFormat(tqty+"",0)%></td>
				<td width="13%" align="right">
				<%
				double qty2 = 0;
				try{
					qty2 = Double.parseDouble((String)SeqInv.getFieldValue(index,"INVOICEDQUANTITY"));
				}catch(Exception e)
				{}
				if(tqty != 0)
				{
					out.println(myFormat.getCurrencyString(tnetAmt/tqty));
				}
				else
				{
					out.println("0.00");
				}
				
				out.println("&nbsp;</td>");
				grandTotal += tnetAmt;
				%>
			 	<td width="15%" align="right"><%=myFormat.getCurrencyString(tnetAmt)%>&nbsp;</td></tr>
				<%
			}
		}
		double totZeroLnAmount =0;
		for(int i=1;i<SeqInv.getRowCount();i++)
		{
			if(SeqInv.getFieldValueString(i,"POSITIONNUMBER").equals("0"))
			{
				try
				{
					totZeroLnAmount += Double.parseDouble(SeqInv.getFieldValueString(i,"INVOICEDAMOUNT"));
				}catch(Exception numFmtEx)
				{
					totZeroLnAmount += 0;
				}
			}
		}

		grandTotal += totZeroLnAmount;
		%>
		<tr>
		<td align='right' colspan=6 width="85%"><b><%=taxDutyLevi_L%>&nbsp;&nbsp;</b></td>
		<td align='right'><%=myFormat.getCurrencyString(totZeroLnAmount)%>&nbsp;</td>
		</tr>
		<tr>
		<td align='right' colspan=6 width="85%"><b><%=totalAmount_L%>&nbsp;</b></td>
		<td align='right'><b><%=myFormat.getCurrencyString(grandTotal)%>&nbsp;</b></td>
		</tr>
<%
	}
%>	
	</TABLE>
	</div>

<%
	if (dispflag)
	{
		String noDataStatement = noInvDetAvl_L;
%>
		</Table>
		</Div>
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
		<Script>
			document.getElementById("theads").style.visibility="hidden"
			document.getElementById("InnerBox1Div").style.visibility="hidden"
		</Script>
<%
	}
%>
	<input type="hidden" name="invAmount" value="<%=grandTotal%>">
	
	
	<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
	<center>
	<%
			
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			
			buttonName.add("Back");
			if("Y".equals(listBack))
			{
				buttonMethod.add("formEvents(\"ezListInv.jsp\")");
			}
			else
			{
				buttonMethod.add("history.go(-1)");
			}	
			if (!dispflag)
			{
				buttonName.add("Payment Details");
				buttonMethod.add("formSubmit()");
			}	
			out.println(getButtonStr(buttonName,buttonMethod));
        %>
	</center>
	</DIV>
	  <%@ include file="../Misc/AddMessage.jsp" %>
	  
<input type="hidden" name="backFlg" value="Y">
<input type="hidden" name="FromDate" value="<%=fromDate%>">
<input type="hidden" name="ToDate" value="<%=toDate%>">
<input type="hidden" name="InvStat" value="<%=InvStat%>">
<input type="hidden" name="searchField" value="<%=searchField%>">


</form>


<Div id="MenuSol"></Div>
</body>
</html>
