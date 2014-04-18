<%@ page import ="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="ezc.ezparam.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<%@ include file="../../../Vendor2/Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ include file="../../../Includes/Jsps/Labels/iListInv_Labels.jsp"%>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>

<html>
<head>

	<title><%=invoiceList_L%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<%
	String datesFlag=request.getParameter("DatesFlag");
	datesFlag=( (datesFlag==null) || ("null".equals(datesFlag)))?"CALENDER":datesFlag;
	String base = request.getParameter("FromForm");
	String fd = request.getParameter("FromDate");
	String td = request.getParameter("ToDate");
	String monthOpt= request.getParameter("ezMonths");
	String InvStat=request.getParameter("InvStat");
	%>
	<script>
	var tabHeadWidth=96
	var tabHeight="35%"
	</script>
	<script src="../../Library/JavaScript/ezTabScroll.js"></script>
	<script src="../../Library/JavaScript/Misc/ezHideButtons.js"></script>
	<script>
	function funLinkInvoice(fileName,invnum,purNum,compCode,docType,invDate,invCur,invAmount,PostDate,vendorInvNum)
	{
		hideButton();
		document.location.href=fileName+"?invnum="+invnum+"&purNum="+purNum+"&compCode="+compCode+"&docType="+docType+"&invDate="+invDate+"&invCur="+invCur+"&invAmount="+invAmount+"&PostDate="+PostDate+"&vendorinvnum="+vendorInvNum+"&flag=Y&InvStat=<%=InvStat%>"
	}

	function getDefaultsFromTo()
	{
<%		if(fd != null && td != null && !"null".equals(fd) && !"".equals(fd) )
		{
%>
			document.SOForm.ToDate.value = "<%=td%>"
			document.SOForm.FromDate.value = "<%=fd%>"
<%		}else{

%>
			toDate = new Date();
			today = toDate.getDate();
			thismonth = toDate.getMonth();
			nextmonth = toDate.getMonth()+1;
			thisyear = toDate.getYear();
			if(today < 10)
				today = "0"+today;
			if(nextmonth < 10)
				nextmonth = "0"+nextmonth;
			if(thismonth < 10)
				thismonth = "0" + thismonth;
			
			if(thisyear<1900)	
				thisyear = thisyear+1900
			
			document.SOForm.FromDate.value = today+"."+thismonth+"."+thisyear;
			document.SOForm.ToDate.value = today+"."+nextmonth+"."+thisyear;
			/*
			if(thismonth < 4)
				document.SOForm.FromDate.value = "01.04."+(new Date().getYear()-1);
			else
				document.SOForm.FromDate.value = "01.04."+(new Date().getYear());
			*/
<%		
		}	
%>
	}

	function chkDates()
	{
		fd = document.SOForm.FromDate.value;
		td = document.SOForm.ToDate.value;

		if(fd=="")
		{
			alert("Please Enter From Date");
			return false;
		}
		/*if(td=="")
		{
			alert("Please Enter To Date");
			return false;
		}*/

		a=fd.split(".");
		b=td.split(".");
		
		fd1=new Date(a[2],a[1]-1,a[0])
		td1=new Date(b[2],b[1],b[0])
      	nex=parseInt(a[1])+parseInt(1);
		nex1=parseInt(b[1]);
		if(nex <10)
			nex="0"+nex;

		if(nex1 <10)
			nex1="0"+nex1;
			
		document.SOForm.ToDate.value =b[0]+"."+nex1+"."+b[2];
		//td1=new Date(b[2],b[1]-1,b[0])

		/*if(fd1 > td1)
		{
			alert("From date must be less than Todate");
			document.SOForm.FromDate.focus();
			return false;
		}
		if((td1-fd1)>2678400000)
		{//2592000000
			alert("Selection between Dates can Only be One Month Difference");
			return false;
		}*/
		return true;
	}

	function formSubmit()
	{
		y = chkDates();
		if(eval(y))
		{
			document.SOForm.DatesFlag.value="MONTHS";
			document.SOForm.submit();
		}
		else
		{
	 		return false;
		}
	}
	function showDates(spanId)
	{
		if(spanId==0)
		{
			document.getElementById("ezDates1").style.display="none"
			document.getElementById("ezDates0").style.display=""
			document.SOForm.DatesFlag.value="CALENDER";
		}
		else if(spanId==1)
		{
			document.getElementById("ezDates0").style.display="none"
			document.getElementById("ezDates1").style.display=""
			document.SOForm.DatesFlag.value="MONTHS";
		}
	}
	
	function funFillDates()
	{
		if(document.SOForm.ezMonths.selectedIndex!=0)
		{
			myVal=document.SOForm.ezMonths.options[document.SOForm.ezMonths.selectedIndex].value
			<%
			
			java.util.Date pObjn =new java.util.Date();
			int curMonth=pObjn.getMonth();
			int pYear1 = pObjn.getYear()+1900;
			int pMonth1= pObjn.getMonth();
			int pDate1 = pObjn.getDate();

			pObjn =new java.util.Date();
			pObjn.setMonth(curMonth-1);
			int pYear2 = pObjn.getYear()+1900;
			int pMonth2= pObjn.getMonth();
			int pDate2 = pObjn.getDate();

			pObjn =new java.util.Date();
			pObjn.setMonth(curMonth-2);
			int pYear3 = pObjn.getYear()+1900;
			int pMonth3= pObjn.getMonth();
			int pDate3 = pObjn.getDate();

			pObjn =new java.util.Date();
			pObjn.setMonth(curMonth-5);
			int pYear6 = pObjn.getYear()+1900;
			int pMonth6= pObjn.getMonth();
			int pDate6 = pObjn.getDate();

			pObjn =new java.util.Date();
			pObjn.setMonth(pMonth1-12);
			int pYear12 = pObjn.getYear()+1900;
			int pMonth12= pObjn.getMonth()+1;
			int pDate12 = pObjn.getDate();
		%>
			if(myVal=="1")
			{
				d="<%=pDate1%>"
				m="<%=pMonth1%>"
				y="<%=pYear1%>"
			}else
				if(myVal=="2")
				{
					d="<%=pDate2%>"
					m="<%=pMonth2%>"
					y="<%=pYear2%>"
				}else
					if(myVal=="3")
					{
						d="<%=pDate3%>"
						m="<%=pMonth3%>"
						y="<%=pYear3%>"
					}else
						if(myVal=="6")
						{
							d="<%=pDate6%>"
							m="<%=pMonth6%>"
							y="<%=pYear6%>"
						}else
							if(myVal=="12")
							{
								d="<%=pDate12%>"
								m="<%=pMonth12%>"
								y="<%=pYear12%>"
							}


			if(d<10)
			{
				d="0"+d;
			}
			if(m<10)
			{
				m="0"+m;
			}
		    document.SOForm.FromDate.value=d + "." + m + "." + y

			//alert(document.SOForm.FromDate.value)
			document.SOForm.submit();
		}
		else
		{
			alert("Please Select the months");
		}
	}

	function selMonthVal()
	{

		for(p=0;p<document.SOForm.ezMonths.options.length;p++)
		{

			if(document.SOForm.ezMonths.options[p].value=="<%=monthOpt%>")
			{
				document.SOForm.ezMonths.selectedIndex=p;
				break;
			}
		}
	}
	
	function showTotal()
	{
		var showTot=document.getElementById("showTot");
		var Inner=document.getElementById("InnerBox1Div")
		var Outer=document.getElementById("OuterBox1Div")

		if (!((Inner == null)&&(Outer == null)))
		{
			if(showTot!=null)
			{
				if(getposition())
				{
					showTot.style.visibility="hidden"
				}else
				{
					tHeight = document.getElementById("theads").offsetHeight
					myTotHeight = document.getElementById("InnerBox1Div").offsetHeight
					myTotHeight = myTotHeight+tHeight+80
					//showTot.style.top=myTotHeight
					showTot.style.visibility="visible"
				}
			}
		}
	}
	</script>
</head>

<body bgcolor='#FFFFFF' onLoad="scrollInit('SHOWTOT');getDefaultsFromTo();selMonthVal();" onResize="scrollInit('SHOWTOT')"   scroll=no>
<form method="post" name="SOForm" action="ezListClosedInv.jsp">
	<input type="hidden" name="FromForm" value="InvoiceList">
	<input type="hidden"  name="DatesFlag" value="CALENDER">
	<input type="hidden"  name="InvStat" value="<%=InvStat%>">
	
<%
	String display_header = "";
	if(InvStat.equals("A"))
	{
		display_header = " Invoice List";
	}
	if(InvStat.equals("C")) 
	{
		 display_header = "Closed Invoice List";
	}	 
	
%>

	<%@ include file="../Misc/ezDisplayHeader.jsp"%>

	<Div id="ezClosedDates" style="position:absolute;width:100%">
	<%
	if("CALENDER".equals(datesFlag))
	{
	%>
		<span id="ezDates0" style="position:absolute;width:100%;">
	<%
	}
	else
	{
	%>
		<span id="ezDates0" style="position:absolute;width:100%;display:none">
	<%
	}
	%>
	<Table  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >

	<Tr>	<Th>Select Months</Th>
	<Td>
	<div id="ListBoxDiv2" >
	<select name=ezMonths >
	<option value=''>--Select--</option>
	<option value=1>Last One Month</option>
	<option value=2>Last 2 Months</option>
	<%--
	<option value=3>Last 3 Months</option>
	<option value=6>Last 6 Months</option>
	<option value=12>Last One Year</option>
	--%>
	</select>
	</div>
      <td class="TDCommandBarBorder">
        <table border="0" cellspacing="3" cellpadding="5">
        <tr>
           <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:funFillDates()" >
                <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Go&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
           </td>
        </tr>
        </table>
    </td>
	</Td>
	<Td class=blankcell><a href="JavaScript:showDates(1)" Style="text-decoration:none"><b>For Dates Click here</b></a></Td>
	</Tr>
	</Table>
	</span>
	<%
	if("CALENDER".equals(datesFlag))
	{
	%>
		<span id="ezDates1" style="position:absolute;width:100%;display:none">
	<%
	}
	else
	{
	%>
		<span id="ezDates1" style="position:absolute;width:100%;">
	<%
	}
	%>

	<Table  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<Tr>
	<Th colspan="4" width="45%">From Date  </Th>
	<Td colspan="3" class="TDCommandBarBorder" align="center">
    <input type=text name="FromDate" class=InputBox value="<%=fd%>"  size=15 maxlength="10" readonly><img src="../../Images/calender.gif" height="20" onClick=showCal("document.SOForm.FromDate",50,250,"<%= cDate%>","<%= cMonth%>","<%= cYear%>") style="cursor:hand" alt="Calendar">
	<input type=hidden name="ToDate" value="<%=td%>">
  </Td>

	<%--
	<Th>To Date</Th>
	<Td>
	<input type=text name="ToDate" class=InputBox value="<%=td%>"  size=10 maxlength="10" readonly><img src="../../Images/calender.gif" height="20" onClick=showCal("document.SOForm.ToDate",50,250,"<%= cDate%>","<%= cMonth%>","<%= cYear%>")  style="cursor:hand" alt="Calendar">
	</Td>
	--%>
	    <Td class="TDCommandBarBorder" align="center">
        <table border="0" cellspacing="3" cellpadding="5">
        <tr>
           <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:formSubmit()" >
                <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Go&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
           </td>
        </tr>
        </table>
	</Td>
	</Tr>
	<Tr border=0>
	<Td colspan=8 align=center class="blankcell">* You Can get Invoices Of a month to this date.<a href="JavaScript:showDates(0)" Style="text-decoration:none"><b>For Months Click here</b></a></Td>
	</Tr>
	</Table>
	</span>
	</div>

	<%
	///out.println("base"+base);
	if(base!=null && !"null".equals(base) && !"".equals(base))
	{
	%>
		<%@ include file="../../../Includes/Jsps/Purorder/iListCLOSEDInvoices.jsp"%>
	<%
		String dbcrInd = null;
		if (rowno==0)
		{
		%>
			<br><br><br><br><br><br>
			<TABLE width="50%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			<tr align="center">
			<th align=center>NO <%=display_header%></th>
			</tr></table>
		<%
		}
		else
		{
		%>
			<input type="hidden" name="chkField">
			<br><br><br><br>
			<DIV id="theads" >
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

			<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:35%;left:2%">
			<TABLE  id="InnerBox1Tab"  width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			<%
			FormatDate formatDate = new FormatDate();
			String sortItems[] = {"INVOICENUMBER"};
			String invNumber = new String();
			double invConAmt = 0;

			/// IN	V LIST CONSOLIDATION STARTS HERE
			Hashtable invAmtHT = new Hashtable();
			Hashtable invDateHT = new Hashtable();

			//   java.math.BigDecimal totValue=new java.math.BigDecimal("0");

			for(int i=0;i<rowno;i++)
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
					if("H".equals(SeqInv.getFieldValueString(i,"DBCRINDICATOR")))
						dbcrInd = "";
					else if("S".equals(SeqInv.getFieldValueString(i,"DBCRINDICATOR")))
						dbcrInd = "-";

					Date invDate = (Date) SeqInv.getFieldValue(i,"INVOICEDATE");
					Date payDate = (Date) SeqInv.getFieldValue(i,"PAYMENTDATE");

					//out.println(SeqInv.getFieldValue(i,"PAYMENTDATE"));
					String temp=ret.getFieldValueString(i,"PAYMENTDATE");
					if("null".equals(temp)||temp==null )
					  	temp="";

                                	String venRef = SeqInv.getFieldValueString(i,"REFDOC");
					String poNum = SeqInv.getFieldValueString(i,"PURCHASEORDER");
					String invNum = SeqInv.getFieldValueString(i,"INVOICENUMBER");
					String compCode=SeqInv.getFieldValueString(i,"COMPCODE");

					poNum=poNum.trim();
					if(!"0.00".equals(myFormat.getCurrencyString(amt)))
					{
						out.println("<tr>");
%>						<td align="left" width="18%"><%=SeqInv.getFieldValueString(i,"REFDOC")%>&nbsp;</td>
						<td align="left" width="14%">
						<a href="JavaScript:funLinkInvoice('ezInvoiceDetails.jsp','<%=invNum%>','<%=poNum%>','<%=compCode%>','<%=SeqInv.getFieldValue(i,"DOCTYPE")%>','<%=formatDate.getStringFromDate(invDate,".",FormatDate.DDMMYYYY)%>','<%=SeqInv.getFieldValue(i,"INVOICECURRENCY")%>','<%=SeqInv.getFieldValue(i,"AMOUNT")%>','<%=formatDate.getStringFromDate((Date)SeqInv.getFieldValue(i,"POSTINGDATE"),".",FormatDate.DDMMYYYY)%>','<%=SeqInv.getFieldValueString(i,"REFDOC")%>')" onMouseover="window.status='Click To View Details '; return true" onMouseout="window.status=' '; return true">
						<%try{
							out.println(Long.parseLong(invNum));
						}catch(Exception e){
							out.println(invNum);
						}
						%>
						</a>
						</td>
						<td align="center" width="13%"><%=ret.getFieldValueString(i,"INVOICEDATE")%></td>
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
							out.println(dbcrInd +" "+ret.getFieldValueString(i,"AMOUNT"));

							try{
								if("S".equals(SeqInv.getFieldValueString(i,"DBCRINDICATOR")) )
								{
									totValue=totValue.subtract(new java.math.BigDecimal(SeqInv.getFieldValueString(i,"AMOUNT")));
								}else
								{
									totValue=totValue.add(new java.math.BigDecimal(SeqInv.getFieldValueString(i,"AMOUNT")));
								}

							}catch(Exception e){
								System.out.println(">>>"+e);
							}
						%></td>
						<%
						out.println("</tr>");
					}
					//}
				}
			}
		%>
	</table>
	</div>
<%--
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
	--%>
	
	<%
	}
	}else{%>
	<br><br><br><br><br><br>
	<Table width="50%" border=0 align="center" borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
	<Tr>
	<Th align="center">Please Select Months(s)</Th>
	</Tr>
	</Table>
<%}%>
</form>
<Div align=center style="position:absolute;top:91%;visibility:visible;width:100%">
<span id="EzButtonsSpan" >
</span>
		<span id="EzButtonsMsgSpan" style="display:none">
		<Table align=center>
			<Tr>
				<Td class="labelcell">Your request is being processed... Please wait</Td>
			</Tr>
		</Table>
</span>
</Div>
<Div id="MenuSol"></Div>
</body>
</html>
